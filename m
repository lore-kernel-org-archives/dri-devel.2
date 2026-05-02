Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B8CD3424
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 08:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA9710E11B;
	Sat,  2 May 2026 08:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="jpGenxEi";
	dkim-atps=neutral
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B8310E11B
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1777709306; x=1777968506;
 bh=wpiHLX1zWOUy8hBTDFwvSmMkzZNlxTZRLe+LwVa3mZQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=jpGenxEis4n63OIjgN/3mDSUGmMOEXAEq0C608LWBH1muDPew1CR83mRCDahL/KgJ
 BFPD2lvr3j7oBLCxrmshwTLqK3xOc+VavcJNooNeZ0S3Duu8MRdcPBxOtby2a6ijlU
 4l35iKSlAfnnvSpbVk1+3ADw/KRLV9BctqigG90632xVPukQ/v5L84g9k+KcYdMnUL
 jkiqRD3FYWVOxOk3L8sNsf527KFpX8ttAB7ayXnccFiEV1FiL/MWAZubS4AMXA0qu2
 lXNf7PpYyA1k5mVFh23GuvJ4m4hbD5jBWfXLe2OG3LXltGKOBylLnnmyGhVdsjM3jf
 4M2o1Z6JaFBHw==
Date: Sat, 02 May 2026 08:08:21 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH RFC v5 5/7] drm/msm/a8xx: use pipe protect slot 15 for
 last-span-unbound feature
Message-ID: <20260502-adreno-810-v5-5-bc9fd2bb788d@pm.me>
In-Reply-To: <20260502-adreno-810-v5-0-bc9fd2bb788d@pm.me>
References: <20260502-adreno-810-v5-0-bc9fd2bb788d@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 325815eec18b78703018c77bdfe495e0e3130c98
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

A8XX GPUs have two sets of protect registers: 64 global slots and 16
pipe specific slots. The last-span-unbound feature is only available
on pipe protect registers, and should always target pipe slot 15.

This matches the downstream driver which hardcodes pipe slot 15 for
all A8XX GPUs (GRAPHICS.LA.15.0.r1) and resolves protect errors on
A810.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/ad=
reno/a8xx_gpu.c
index d519a29573a1..74802f330ae9 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -265,8 +265,8 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
 =09 * Last span feature is only supported on PIPE specific register.
 =09 * So update those here
 =09 */
-=09a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(protect->count_m=
ax), final_cfg);
-=09a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(protect->count_m=
ax), final_cfg);
+=09a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
+=09a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
=20
 =09a8xx_aperture_clear(gpu);
 }

--=20
2.53.0


