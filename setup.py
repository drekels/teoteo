#!/usr/bin/env python


from setuptools import setup
import os.path


req_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), "requirements.txt")
with open('requirements.txt') as f:
    required = f.read().splitlines()


import teoteo
version = teoteo.get_version()


setup(
    name='teoteo',
    version=version,
    description="UNDESCRIBED",  # TODO Enter Description
    author="Kevin Steffler",
    author_email='kevin5steffler@gmail.com',
    url='https://github.com/drekels/teoteo',
    packages=[],
    scripts=[],
    install_requires=required,
)
