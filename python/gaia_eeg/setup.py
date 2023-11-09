from setuptools import setup, find_packages

setup(
    name='gaia_eeg_audio',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        # Add any other dependencies your package needs
    ],
    entry_points={
        # If you want to create any command-line scripts
    },
    author='Mike Ricos',
    author_email='mike.ricos@gmail.com',
    description='A package for recording realtime audio.',
    keywords='book parser json',
    url='http://gaia.lenan.net/docs', 
)
