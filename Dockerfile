From pytorch

COPY init /init
COPY pytorch-test.py /pytorch-test.py
RUN add-apt-repository -y ppa:deadsnakes/ppa; apt install -y python3.10-full
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN cat /etc/passwd; userdel -f jenkins||true
RUN useradd -d /home/user -u 1000 -G render,video user
RUN mkdir -p /std; chown user: /std
RUN mkdir -p /home/user; chown -R user: /home/user
RUN su - user -c 'cd /std; git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui; cd stable-diffusion-webui; python3.10 -m venv venv --system-site-packages; . venv/bin/activate; pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/rocm5.7;  python3.10 -m pip install --upgrade pip wheel; python3.10 launch.py --exit --skip-torch-cuda-test'
CMD /init