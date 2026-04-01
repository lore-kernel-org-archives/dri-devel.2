Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AFE10F92EC
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 02:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492F910E321;
	Wed,  1 Apr 2026 02:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="YYGqvT9w";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B3B10E328
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1775009808; x=1775269008;
 bh=SeCXN0HCQAjNDaLVtc9fbRmlTrKrp+B7ZCgRsHWfT24=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YYGqvT9wwd+I91SnhuWE++2gA/3Q9Xt/LlJ1VfM5eMwABgaBrhDhPxdUAp2cWcGC4
 +tU5Zaboe8tLzyqE7JQxwF8lRGc1zwSl98CU8cEyNyjR1FfVscNMKf7+AVn140hIMT
 mVAjQlzEc/3WVV2zTqT1x8CO7MyQ8Ut89n2Bc/Vc21Lnm/TOr5ZUjoT2F0yqm9lBB8
 mxSQJUHATXfcEcSR+ojaTt6pMGYySWUZVRAHGlGRvznNymseWwDaJQH+xk/53lcwiy
 Wn3vS5DEF6wpEVuFQUCwkJ7Ceto99d+bwjxhkittSik0xfx5kuO5+sHgJv1hYGfAU0
 aIQMNksL1bsrQ==
Date: Wed, 01 Apr 2026 02:16:41 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 0/6] Add support for Adreno 810 GPU
Message-ID: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 9af0edf84c980cb4ebb4587014a5335b2774aa7e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Adreno 810 is present in the Milos SoC and is the first GPU to be released =
in
the A8x family.

Note that the OPP table is limited to 1050MHz to start with as the only Mil=
os
device I have is limited to that speed in GPU_CC_FREQ_LIMIT_VAL.

This series depends on a couple other in review series, batch 2 for A8x [1]=
 and
the GXCLKCTL block for Milos [2].

There is also currently an issue on Milos with gx_clkctl_gx_gdsc being stuc=
k on
during runtime PM [3]. The proper fix is to only toggle the GX GDSC during =
GMU
recovery, as the firmware manages it in all other cases. This is the same i=
ssue
seen on SM8750 and is being worked on by Qualcomm. Right now I am just work=
ing
around this locally by not collapsing the GX GDSC during runtime suspend.

[1]: https://lore.kernel.org/linux-arm-msm/20260327-a8xx-gpu-batch2-v2-0-2b=
53c38d2101@oss.qualcomm.com
[2]: https://lore.kernel.org/linux-arm-msm/20260306-milos-gxclkctl-v1-0-00b=
09ee159a7@fairphone.com
[3]: https://lore.kernel.org/linux-arm-msm/5409e13e-280c-47b6-a29f-351cb609=
bc6f@oss.qualcomm.com

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Alexander Koskovich (6):
      dt-bindings: display/msm/gmu: Document Adreno 810 GMU
      drm/msm/adreno: rename llc_mmio to cx_mmio
      drm/msm/adreno: set cx_mmio regardless of if platform has LLCC
      drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
      drm/msm/adreno: add Adreno 810 GPU support
      arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU nodes

 .../devicetree/bindings/display/msm/gmu.yaml       |  32 +++
 arch/arm64/boot/dts/qcom/milos.dtsi                | 148 +++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 271 +++++++++++++++++=
++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   8 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  44 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  14 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  11 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 8 files changed, 493 insertions(+), 40 deletions(-)
---
base-commit: 128d2eccd20bd74fd104b412d949d869aa48f108
change-id: 20260330-adreno-810-5a47525522cd

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


