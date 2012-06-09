
import os
import shutil
import tempfile
import subprocess

desmume_binary = 'desmume-cli'

def main():
    base_path = os.path.dirname(os.path.abspath(__file__))
    data_path = os.path.join(base_path, 'data')
    script_path = os.path.join(base_path, 'scripts')
    work_base = os.path.join(base_path, 'work')
    work_path = tempfile.mkdtemp(dir=work_base)
    try:
        os.chdir(work_path)
        rom_path = os.path.join(work_path, 'rom.nds')
        os.symlink(os.path.join(data_path, 'rom.nds'), rom_path)
        desmume_conf_path = os.path.join(work_path, '.config', 'desmume')
        os.makedirs(desmume_conf_path)
        shutil.copyfile(os.path.join(data_path, 'rom.dsv'),
            os.path.join(desmume_conf_path, 'rom.dsv'))
        shutil.copyfile(os.path.join(data_path, 'rom.ds1'),
            os.path.join(desmume_conf_path, 'rom.ds1'))
        shutil.copytree(script_path, os.path.join(work_path, 'scripts'))

        for i in range(1, 7):
            for prefix in ['', 'e']:
                pkm_path = os.path.join(work_path, 'scripts', '%s%s.pkm' % (prefix, i))
                with open(pkm_path, 'w') as f:
                    f.write('\0' * 220)

        env = dict(os.environ)
        env['HOME'] = work_path
        env['XDG_CONFIG_HOME'] = os.path.join(work_path, '.config')
        emulator = subprocess.Popen([desmume_binary,
                '--disable-sound',
                '--disable-limiter',
                #'--frameskip=50',
                '--opengl-2d=0',
                '--num-cores=4',
                '--load-slot=1',
                '--lua-script', os.path.abspath('scripts/importteams.lua'),
                rom_path],
                env=env)
        emulator.communicate()
    finally:
        shutil.rmtree(work_path)


if __name__ == '__main__':
    main()
