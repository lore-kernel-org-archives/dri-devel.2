Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37584C982FB
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D6E10E491;
	Mon, 21 Sep 2026 18:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cExF5tZq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E7510E392;
 Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A70B60008;
 Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037BBC2BCFA;
 Mon, 21 Sep 2026 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790014752;
 bh=BpRcOMKg3LS8V8DqNarIsVgSnibco3n89MGgkueN2dc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=cExF5tZqDDGIWkrqVOUJS1uzg/RBkCnHzxT6HcXgoDtmN1LAJbnTTv6oGPJqVQxAl
 k18J2I6fmd8xuZbx3LY8px3h0AkJZLwFSEdVEtrTTD60vFI4lPtkrYm9CFWKnDETHI
 CG8a0JmNb1Oj3febBeqMvVUek5StYiMlQhsHNoRAoxNjroHt+11lxxSrCO9u8xPY47
 BEwpPejlaWUL2kojHyZuxNLPUuKKXdKPawgMAcjCTfhVoPpo92KoZopXADc7XW2K9E
 HaQTtJ8prLX+WqGmQ7iA17VDJOhk1rw8HR9NCQIEgTLf5O+PaF3wpDjR3zw3U14ClY
 +QGoKqhWOcxKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BCB63C982EE;
 Mon, 21 Sep 2026 18:19:11 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay
 <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
Date: Mon, 21 Sep 2026 21:18:51 +0300
Message-Id: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6CMBAF0KuQrq1pRwrUlfcwLiqMMAm0pMVGQ
 7i7hbgwMSz/5P83MwvoCQM7ZzPzGCmQsymcDhmrO2Nb5NSkzEBAIbTQfAhDpRVwsjSR6Xl4jqP
 zEy+EEUrXgFIhS+vR44Nem3y9pdxRmJx/b4+iXK9fU8KuGSUXXGCZgyqru4L8MhiyfarZ9uh8y
 1Y4wi9W7GOQsFJXdepB06D8w5Zl+QAMNnZ2EAEAAA==
X-Change-ID: 20260909-msm8952-initial-support-60a059c2e15e
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, 
 linux-input@vger.kernel.org, Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=5337;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=BpRcOMKg3LS8V8DqNarIsVgSnibco3n89MGgkueN2dc=;
 b=6d13bf2rcAw9hZjgCqRhx3KaAyNMRl7pBSwIaYokFdaChqCK+NJqUuNKUp/H2hb89vl9tkXXB
 OZwD9zD3YBTDzCAbk2QST9OKaOBjHsbOO67kWdLyO/DWCgGUyfG7Vul
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
Reply-To: muzafferkadir@mainlining.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.

Ported without uart connection. ramoops and usb
mainly used to debug.
USB is not enabled in this series because it
depends on the not yet upstreamed (and not developed by me)
pmi8950_smbcharger.

General Mobile shamrock display panel driver
is generated using MSM8916's mdss dsi panel
driver generator and tested with it. I didn't
include it.

The GCC and DTS files are derived from existing
Qualcomm source files. Original copyright notices
are retained.

GCC is based on msm8939's gcc file.
SoC device tree is based on MSM8937 file.

in some downstreams MSM8952 GCC is merged with
MSM8917 and MSM8937's. But upstreamed MSM8917 is
based on different GCC and different pll structure.
I have no way to verify MSM8952 pll so I am not sure
about how correct pll structure is.

Pinctrl driver was submitted and merged here:
https://lore.kernel.org/all/20260907-msm8952-pinctrl-v5-0-9a2d8d72ffdb@mainlining.org/

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
Changes in v3:
- Improved GCC driver, also rewrote resets part
- Rewrote the dt-binding side of gcc
- Reformatted Device tree files with dt-check-style tool
- Added reset to sdhci1 and sdhci2
- Added cx regulator to gcc
- Added gcc commit messages that it is a derived driver
- Dropped adsp_mem, renamed lpass_mem to adsp_mem
- Changed tusb320 interrupt from rising to falling as downstream uses
- Link to v2: https://patch.msgid.link/20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org

Changes in v2:
- Changed device dts file as David's and Konrad's suggestions
- Removed accidental duplicated clock assigments and fixed wrong gcc gp1,gp2
  and gp3 parent_maps
- Updated commit messages to make it wrapped at 72 character.
- Fixed spi1 tlmm node naming
- Added remaining spi and i2c nodes
- Wired up mpm
- Add mmio-sram to rpm_msg_ram
- Reformatted msm8952.dtsi
- Removed rpmcc-msm8952 driver entry and replaced it with rpmcc-msm8976
- Merged sdhci tlmm pins to single nodes, now it is similar to existing SoCs
- Rebased to latest linux-next, now storage works
- Removed polling-delay properties from tsens
- Link to v1: https://lore.kernel.org/r/20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org

---
Muzaffer Kadir (19):
      dt-bindings: clock: qcom: Add MSM8952 global clock controller
      clk: qcom: Add global clock controller driver for MSM8952
      dt-bindings: nvmem: Add compatible for MSM8952
      dt-bindings: power: rpmpd: Add MSM8952 power domains
      dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
      dt-bindings: vendor-prefixes: Add General Mobile
      dt-bindings: arm: qcom: Document MSM8952 SoC binding
      dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
      dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
      dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
      dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
      drm: msm: mdp5: Add MDP5 configuration for MSM8952
      soc: qcom: ubwc: Add UBWC config for MSM8952
      dt-bindings: thermal: tsens: Add MSM8952
      thermal: qcom: tsens: Add support for MSM8952 tsens
      arm64: dts: qcom: Add initial support for MSM8952
      dt-bindings: input: touchscreen: goodix: Add binding for GT970
      arm64: dts: qcom: generalmobile-shamrock: new device

 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../bindings/clock/qcom,gcc-msm8952.yaml           |   65 +
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |    5 +
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 .../bindings/input/touchscreen/goodix.yaml         |   35 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    |  435 +++
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2696 +++++++++++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-msm8952.c                     | 3548 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   81 +
 drivers/soc/qcom/ubwc_config.c                     |    1 +
 drivers/thermal/qcom/tsens-v1.c                    |   44 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 include/dt-bindings/clock/qcom,gcc-msm8952.h       |  215 ++
 25 files changed, 7144 insertions(+), 16 deletions(-)
---
base-commit: e657a464aba873f5eaf3ca821b6e4016674492d6
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
--  
Muzaffer Kadir <muzafferkadir@mainlining.org>


