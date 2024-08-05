#
# ##########
# BASE IMAGE
# ##########
#

FROM registry.ans.co.at/templates/mmdocs/mmdocs:latest

#
# #################
# IMAGE INFORMATION
# #################
#

ARG IMAGE_VERSION=0.0.2
ARG IMAGE_BUILD_DATE=0000000000

ENV MKPDF_VERSION="V${IMAGE_VERSION}"
ENV MKPDF_BUILD_DATE="B${IMAGE_BUILD_DATE}"
ENV MKPDF_IMAGE_MAINTAINER='Norbert EHART (norbert@ehart.net)'

#
# ##############
# CONTAINER USER
# ##############
#

USER 0:0

#
# ########
# TEMPLATE
# ########
#

COPY mkbase.yml /usr/local/share/mmdocs-tmpl/mkbase.yml
COPY mkdocs.yml /usr/local/share/mmdocs-tmpl/mkdocs.yml

COPY .gitignore /usr/local/share/mmdocs-tmpl/.gitignore

RUN rm -rf /usr/local/share/mmdocs-tmpl/.gitlab-ci.yml
RUN rm -rf /usr/local/share/mmdocs-tmpl/mkpdf.yml

COPY env.conf /usr/local/share/mmdocs-tmpl/env.conf

COPY pages/index.md /usr/local/share/mmdocs-tmpl/pages/index.md
COPY pages/cover.png /usr/local/share/mmdocs-tmpl/pages/cover.png
COPY pages/favicon.png /usr/local/share/mmdocs-tmpl/pages/favicon.png
COPY pages/logo.svg /usr/local/share/mmdocs-tmpl/pages/logo.svg

COPY pages/IntroMain.md /usr/local/share/mmdocs-tmpl/pages/IntroMain.md
COPY pages/MPLS001Intro.md /usr/local/share/mmdocs-tmpl/pages/MPLS001Intro.md
COPY pages/MPLS002MPLSLabelStack.md /usr/local/share/mmdocs-tmpl/pages/MPLS002MPLSLabelStack.md
COPY pages/MPLS003EntropyLabelHashLabel.md /usr/local/share/mmdocs-tmpl/pages/MPLS003EntropyLabelHashLabel.md
COPY pages/MPLS004LSR.md /usr/local/share/mmdocs-tmpl/pages/MPLS004LSR.md
COPY pages/MPLS005BiDir.md /usr/local/share/mmdocs-tmpl/pages/MPLS005BiDir.md
COPY pages/MPLS006MPLSFrr.md /usr/local/share/mmdocs-tmpl/pages/MPLS006MPLSFrr.md
COPY pages/EVPN001Intro.md /usr/local/share/mmdocs-tmpl/pages/EVPN001Intro.md
COPY pages/EVPN002Rest.md /usr/local/share/mmdocs-tmpl/pages/EVPN002Rest.md
COPY pages/EVPN003Evol.md /usr/local/share/mmdocs-tmpl/pages/EVPN003Evol.md
COPY pages/EVPN004Fund.md /usr/local/share/mmdocs-tmpl/pages/EVPN004Fund.md
COPY pages/EVPN005Config.md /usr/local/share/mmdocs-tmpl/pages/EVPN005Config.md

RUN /usr/local/share/mmdocs-tmpl/pages/IntroMain.md | sed -e '/div style/d' | sed -e '$d' | sponge /usr/local/share/mmdocs-tmpl/pages/IntroMain.md

COPY overrides/cover.scss /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/styles/cover.scss
COPY overrides/fonts.scss /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/styles/_fonts.scss
COPY overrides/heading.scss /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/styles/_heading.scss
COPY overrides/paging.scss /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/styles/_paging.scss
COPY overrides/toc.scss /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/styles/_toc.scss

COPY overrides/cover.html.j2 /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/templates/default_cover.html.j2
COPY overrides/back_cover.html.j2 /usr/local/lib/python3.12/site-packages/mkdocs_with_pdf/templates/default_back_cover.html.j2

#
# ################
# ENTRYPOINT & CMD
# ################
#

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD [""]

#
# #######
# WORKDIR
# #######
#

WORKDIR /mnt/