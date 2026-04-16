Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ADF8A157
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D239010E1BD;
	Thu, 16 Apr 2026 11:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="Moijb+2p";
	dkim-atps=neutral
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9D110E1BD;
 Thu, 16 Apr 2026 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776337484; x=1776596684;
 bh=ND45yB22FWjIji9RmDjY8g6tzsg5Y5+t9sZmH4XvSKU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Moijb+2pzfp8N/wXiwy0bwgPqgVdkJhMePsB+FlxuG1uwUPrPdeBbQYc0ECTTGOrT
 Ja+ruK/Mab3a7h2o74GGBRE0HX5xKs1hxoJzmoXqMQ1btDOvADD/69RZG1IOu6GDkh
 Ese1Fqb0qcV43l+bifDkT4nstPml/LWbXjasOR05CT05M+LPCS518qFzjIzpoSz/9t
 EefaZcK/DbS8myFgpV6S6Lcmi5vkqRPAKvLVTzGQ3xR3LFEgUydJkVvrVFRGai6Xwm
 /cm/ZhW6RDJcisnkHJ3pMOKzHzfiVuHb0LLx+RIeyK7ZeMhWmtbo2kZ7aYIR8B3Wue
 u1E2MC5Dn/ZZQ==
Date: Thu, 16 Apr 2026 11:04:36 +0000
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
 Alexander Koskovich <akoskovich@pm.me>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH RFC v4 0/7] Add support for Adreno 810 GPU
Message-ID: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 9198165a4acde663ff75ac413a75938d5f73a19c
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

This series is marked as RFC because it depends on a few other in review
series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2] and the GXCLKC=
TL
block for Milos [3].

Also depends on A8x batch 2 but it looks like that made it into linux-next.

[1]: https://lore.kernel.org/linux-arm-msm/20260407-gfx-clk-fixes-v1-0-4bb5=
583a5054@oss.qualcomm.com
[2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017=
cc642db@pm.me
[3]: https://lore.kernel.org/linux-arm-msm/20260403-milos-gxclkctl-v2-0-95e=
b94a7d0a4@fairphone.com

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Changes in v4:
- Add 1150MHz speedbin
- Rebase on next-20260415
- Add dep on efuse patchset
- Link to v3: https://lore.kernel.org/r/20260407-adreno-810-v3-0-30cb7f196e=
d4@pm.me

Changes in v3:
- Drop DEMET from GMU clocks (not required on A810)
- Document qcom,adreno-44010000 compatible (regex is gone in 7.0+)
- Drop zeroed out CP_PROTECT_REG[46, 62] range, not required
- Add a810_protect to __build_asserts
- Add UCHE_CCHE_TRAP_BASE_[LO|HI] and UCHE_CCHE_WRITE_THRU_BASE_[LO|HI] to =
a810_pwrup_reglist_regs
- Move TPL1 registers to a810_pwrup_reglist_regs
- Include all protect registers in a810_ifpc_reglist_regs
- Revert pipe reg comment, just copied it from downstream but original also=
 works
- Link to v2: https://lore.kernel.org/r/20260402-adreno-810-v2-0-ce337ca87a=
9e@pm.me

Changes in v2:
- Mark as RFC due to dependency on in-review changes
- Explain in DTS commit why qcom,kaanapali-gxclkctl.h and not qcom,milos-gx=
clkctl.h
- cx_mmio -> cx_misc_mmio
- Sync a810_nonctxt_regs with GRAPHICS.LA.14.0.r5-03100-lanai.0
- Link to v1: https://lore.kernel.org/r/20260331-adreno-810-v1-0-725801dbb1=
2b@pm.me

---
Alexander Koskovich (7):
      dt-bindings: display/msm/gmu: Document Adreno 810 GMU
      dt-bindings: display/msm/gpu: Document A810 GPU
      drm/msm/adreno: rename llc_mmio to cx_misc_mmio
      drm/msm/adreno: set cx_misc_mmio regardless of if platform has LLCC
      drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
      drm/msm/adreno: add Adreno 810 GPU support
      arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU nodes

 .../devicetree/bindings/display/msm/gmu.yaml       |  30 +++
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 arch/arm64/boot/dts/qcom/milos.dtsi                | 166 ++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 296 +++++++++++++++++=
++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   8 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  44 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  14 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 9 files changed, 532 insertions(+), 38 deletions(-)
---
base-commit: 5fe4fcc47bbe1ee4474e743378c1b296a0b40e4c
change-id: 20260330-adreno-810-5a47525522cd

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


