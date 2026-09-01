Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7F7C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF3A10EBDD;
	Tue,  1 Sep 2026 08:49:11 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC13610E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:49:09 +0000 (UTC)
X-QQ-mid: zesmtpip4t1788252487t74d85662
X-QQ-Originating-IP: 6/M5hO7GM94hyD+cP78f4MtHvhzmO/aswBYiw39aBq8=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 16:48:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16767261653343235957
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 0/6] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Tue, 01 Sep 2026 16:47:53 +0800
Message-Id: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OzY7CMAwGX6XyGUupQ9K0r7LikLguZLWUNkkRE
 uLdN/wcOI40/jx3yJKiZBiaOyS5xhwvc4V21wCf/HwUjGNlIEVW9arF1QUcS0av/cRm6oMLBNV
 ekkzx9lr6Obw5b+FXuDzPP0aSdasvyluD4LMgX87nWIZGtLJkHWm/V7Yjw0J94M5wcMJ7241aW
 tFk4TttaF5hRnWY2ZFTtwXXbcElzlzSHxofnK+Ros00XAkOj8c/XJgeTPMAAAA=
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
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UYGerCvtrg1gf7Fe6mKZZbNkuqt5Oi9rbPIybdcPxmo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjp/X7S1/uXBtY3yvGWyJy54GitMrP3+9jVf2Py1Y
 Y9Cb9okdJSyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjICmeG/+UvUwWLwtrvbb3n
 wscqmuD3m0uslP8P6zLJEJkfjvVmjxh+s8V8/cVVwsFU+3Dtu7n/nvzyblm/NiicO2XDrXdLhCT
 e8QAA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NZHsAGQQAOobpI27KhvUjcMaxXuL0Daihx1QfwIHWabxnuz2lRSiDDvB
 3u48n4BnhVK10mavOgn7+4Wo4dIvEGcKy6bH5p5C0iTVfNrccbJRO2+qoZvsdEySsHfYUl6
 imIFpOQIxEmJXGGOF/K4t37p3amZpJpdn16GnFxcrawcbUjr5YtQ1rRsorDhrANEFsu0mw7
 u6n01Mp0uAMrenxKYLD/jJAFWQiIleE83OKU3uoUI9YXzqwAb7Imc9dlXQTWpIfAEbv4l50
 TRnVk/F4Kxsai9hZuVuiGpgqGP/WS/AlvaMhSSsc6XKtrIvqXUKNdZBy73rAAY9lYB7kTMZ
 d+38ooYW+OoQAlbzuqP+63rznXzRaZ2PZXXFlGSrZJ47sjb9Io4OE33YWqC9K3yIW9pprrW
 7jVObiwsm+5O6PC0C2be+atiFlYkV/JrI2TFy7gy4HcjLMCMjfTXeNSnBrfa9J+DOTbbIB6
 EM28PABdk4nKjlrMgYc5Jv/BokqnelffFCVJ4hdX3bKsO5TTpd+9a+gcuI40YssjNEbLqvb
 nHEEikoJ33fXP8azxrfXWhSwrUjViNzyBeA7u4m4H7ZEroeTEGeh3Wa0yWhSSDv8iZTaD57
 fc7ns243Y/zOPH8lfhf2dwQUJVf69kXXy0WwFLjlZD/E32iyavxdjoAK+SymSzX0m+VwUoj
 LoZUCCPMqZAx8j1uF6HwxZM2NyAWYJWQuTymD4qsB8kpFgB3v4w3V/pqlOVQ2dBnRxPeSM5
 Mw6ZrVKZUOqL8XTMjvI/c8gixSdoU0b+kAqfZLY9ax///ao5BjnkkfJ3HSZ4Gw4x+U+zn/3
 WqcYOj9wBJwfPHd/b3qBCzXb6a5uXBKom14r4sKi7EYcnCHgRepfxUK+eo5zZpRCQDH5KyY
 i1LYzIne55Uar/sUTtLiYT2OqCJ+bugKXn/P0UByS2FZHo0vKY8ZkH2M0eHkVKr4hF5Qy0N
 IwGdoJlTB3RhWHcWlVXJjEQngEpcH28kCgfFHWy+VXoZ2Lnr4lUeC0GyrHyjdSBQsAxU2vD
 PpXUObCLXMbgbVBTcnDz0ylOnaFrdoPltDJVV7uAIjIQu65cskxgfQ+etNgko=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

The first patch therefore makes PCI OF enumeration skip config-space reads
for unavailable DT-described bridge functions. Disabled endpoint functions
remain discoverable so PCI fixups can still be applied, while driver
binding continues to be suppressed later.

The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
flash and requires no host-side configuration, so the series documents it
and adds it to the simple bridge driver.

The series also documents the board compatible and allows gpio-line-names
in the SC8280XP TLMM binding.

The PCI change is required before applying the board DTS patch; otherwise
the disabled TC9563 downstream ports cause a boot-time SError. The display
binding and driver patches can otherwise be applied independently through
the DRM tree.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (6):
      PCI: of: Avoid config reads for disabled bridge nodes
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A
      dt-bindings: arm: qcom: document Radxa Dragon Q8B
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names
      arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/display/bridge/simple-bridge.yaml     |    1 +
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |    3 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2097 ++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |    5 +
 drivers/pci/of.c                                   |   27 +-
 drivers/pci/pci.h                                  |    5 +
 drivers/pci/probe.c                                |    5 +
 9 files changed, 2144 insertions(+), 2 deletions(-)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v2
prerequisite-patch-id: 1060ddda6f3ff07b36691a0dd7d783a5be2cc993

Best regards,
--  
Xilin Wu <sophon@radxa.com>

