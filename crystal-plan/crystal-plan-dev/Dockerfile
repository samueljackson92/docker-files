FROM samueljackson/crystal-plan:latest

VOLUME /CrystalPlan

CMD source activate                                                            \
        && /usr/bin/scl enable devtoolset-3 -- pip install -e .                \
        && pyinstaller -y --clean crystalplan-centos.spec                      \
        && cp docs/user_guide.pdf dist/                                        \
        && cd dist                                                             \
        && tar -zcvf crystal-plan-centos7.tar.gz crystalplan
