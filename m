Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446DCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DB510E4CB;
	Fri,  9 Oct 2026 07:56:05 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D9810E4CB
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:56:02 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791532521tcc01530a
X-QQ-Originating-IP: UWuX76hIPH1r9oQg3By8mO++236onaSHj0Sgf6QQ3jg=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 15:55:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7057571656101032469
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v2 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Fri, 09 Oct 2026 15:55:05 +0800
Message-Id: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPy26EMAwF0F9BWddVcCYhsOp/VLPIw3RSdXgkA
 VGN+PcGpotKXV7p2j5+sEQxUGJd9WCR1pDCOJSALxVzNzN8EARfMkOOire8hllb8DmBEaZ3sm+
 ttshKe4rUh+3c9H595rTYT3L5GP9tRJqXciI/a8yaRODG+z3kriLBFSqNwly4alA6wta6Rjqry
 V1U4wXVJFCxv7QiPWCSN5CcRs23CeZlgikMLscvkMZqU5AkZN+tyA7ZLaQ8xu/z5bU+If++W2v
 g0HjiVplGeK7fovGbeS1Ydt33/QfMOlXPOAEAAA==
X-Change-ID: 20260901-q8b-dts-a3afc5f9b8b2
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=sophon@radxa.com;
 h=from:subject:message-id; bh=zDhMVNDbNx3vkG4egCOIH6uOAFDS34JQCEN3kVWtccE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j4KNmmaZa/x7MGbJzl/juhuWZzie1jvyP7IvQvTm
 t5yXVps0lHKwiDGxSArpsiiEM8wl70y99pTsVI9mDmsTCBDGLg4BWAiDZsY/nB1mDFcFzoz+WN7
 uGh94M+uLY5fnD/LbBdurRS+2+BvxsXwz/ynTUDMrG1Pnip+7z5+ZMbiSqnY7veeiXcvXq+WusP
 1nhcA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MRw/zKT/0BpPisBx+JCcUx/B+Le2462CbHmBNTUe9ASJ/ME/RM/qkDev
 ZPa2lWy0nF9VDx7Vip85lWrv/J56ygaa+ICIMUmoy66tlrBNyvYncZPN4y0gnnPS5Hif0qr
 ztce852GlU3xs0JR6Ohtax/5kMgbLB6W8fL50+631Uehbd9+ao0ABg2WmbBPIB4qUfu2bXA
 qN90mhxg0BJJ1mX7GuEd4Liej+oLcTOYY2429/7JsdR79bFbA/duH8sOp5C+5Cndrjip86p
 22ux9xMEYHZFnrUf6V2lINoNlXnkGE7Y0oQ+sYJqLQ8oLgj9jSTXtjYKbhBwyzujMasKNRu
 zmU2fXbEbipGUpC7Y/50kcPK3Zoavw5tAKUvKaECBNJqhU1VaPPo2Noe1AaUskuG55ECfbV
 kQLW+CvNHgiqsfrOT53nAaU5aid/dPxX3eRvM1yGfwzXvFG2k5xskvrmTAAYvDAuE1eYLvx
 v8b8a5pg6JinvSgcCo6OfbOkDRF5yVeN3CZGyYHxrGix8vlbs+gGUBWtZBGiKYQ3aPSOIkb
 cOKT8LLVoU6dGc9lGm2y6GPh+k/me0D+RnqLwxEYTtA03dIzI2/5/46wu+lxsdelX9fhNo0
 jPGWbjvDzqE9tKqVyEFskK9cfWhVQrteKpAfbvSuNfN3A+JpRYppzzT5kWRVMUeItksNaOv
 S073n4KWpMZxtvCgL44Vb8CONOEZz65AXs6UtAajMhIJxc6UDkMqsWYNuJWEYaK6eQspWk9
 HLtfriZsX8QHorGIkuu6F73B5tFRcZBZxL1y/h3ql6rze4N0aJ5l+wQNMiFN85zqEgCUMRA
 kmHMrjfwD2IjgjsFEFjkfNBOpqMe8Mn30OdZAm/E+99UGFqVbtGXFlq5OPmay6vmB8AcfYl
 ZyhOelw9klyogFglNhBAFZTaqrCDyCb1x/OlwuUYeuCcJgvz4E7CZeSYUgRwX0WSIEAzSLp
 Cw2nmMMzj69trBdhd8Z97YZ65yGEBfXKZf1v4T1vR7KMVEavP/Z0Jy5T4R9H8Wqa9QjhhBe
 xxLKWyIpYbl25ERAUbMAwWu7pCiJaBatbSuByTWIwX2KcQ7YtiiYUQfGdzzgTmGA3OetIHI
 nUGyqdxQheO
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
Snapdragon 8cx Gen 3 (SC8280XP) platform.

The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
a 40-pin expansion header.

This series adds the initial device tree support for the board. It
describes the regulators, storage, PCIe topology, USB and display outputs,
audio, remote processors, thermal sensors, RTC, EEPROM and expansion
header. Build targets for both the regular and EL2 device trees are
included.

The TC9563 power-control driver powers off external downstream ports whose
device tree nodes have status = "disabled". On the Dragon Q8B,
config-space reads to these powered-off port functions raise an Arm SError
instead of returning an all-ones PCI error response, preventing the board
from completing boot.

The PCI OF change to skip config-space reads for unavailable DT-described
bridge functions has been split out into a separate two-patch series for
the PCI tree. Disabled endpoint functions remain discoverable so PCI
fixups can still be applied, while driver binding continues to be
suppressed later.

The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
flash and requires no host-side configuration, so the series documents it
and adds it to the simple bridge driver.

The series also documents the board compatible. The SC8280XP TLMM binding
change allowing gpio-line-names has already been applied and is no longer
included in this series.

The PCI change is required before applying the board DTS patch; otherwise
the disabled TC9563 downstream ports cause a boot-time SError. The display
binding and driver patches can otherwise be applied independently through
the DRM tree.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v2:
- Describe the TC9563 embedded GPIO controller and use its GPIOs 2 and 3
  for the external downstream port PERST# reset lines.
- Drop "PCI: of: Avoid config reads for disabled bridge nodes"; split it
  into a separate two-patch PCI series, including the kernel-doc fix.
- Drop "dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names"
  because it has already been applied.
- Link to v1: https://patch.msgid.link/20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Xilin Wu (4):
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A
      dt-bindings: arm: qcom: document Radxa Dragon Q8B
      arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/display/bridge/simple-bridge.yaml     |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2102 ++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |    5 +
 5 files changed, 2111 insertions(+)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v2
prerequisite-patch-id: 1060ddda6f3ff07b36691a0dd7d783a5be2cc993

Best regards,
--  
Xilin Wu <sophon@radxa.com>

