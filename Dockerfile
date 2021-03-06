# Copyright (c) 2017 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM python:3.4.6

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD . /cmk
WORKDIR /cmk

RUN chmod +x /cmk/cmk.py

RUN tox -e lint
RUN tox -e unit
RUN tox -e integration
RUN tox -e coverage

RUN /cmk/cmk.py --help && echo ""

ENTRYPOINT [ "/cmk/cmk.py" ]
