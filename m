Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17760CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 05:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7773410F3D6;
	Fri, 15 May 2026 05:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="mmSf61i2";
	dkim-atps=neutral
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA1E10F3D6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1778821750; x=1779080950;
 bh=Tpnj9uF4ZKfxDszPrsQeXalLh7hFaXn6bvO+xHvviac=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mmSf61i2FA4rJVGVdOSLhpmdvwsyI3z54zwAv5aagWgvpbzwQ8jEJTAObvM1vNRIk
 gqyfKW9QhHNIjGmhCNUo29wX27CqUbhdYoCi5reSLT/CjcOnM9Cvzl8dwK4l0V/Jvd
 0ZQpEoXMI5YQ04k97gGAbU8jmQcpeiJWcwbZFTDzyymvXmOLH8q1vxHJDur2vQ7uuS
 XNhcGXajsdA0+qAaZAFO0403dGFvdwquEgqYKD/CgO5AulXlRimZUR3lvAPpNHnakA
 NYsvSJPsQ4R/rSyQX1q3qIJhKJZKQ6reYorVsg23wmCo0MkOTa9xLbnwclQ/CZZvaX
 2QpxCMReWEiaw==
Date: Fri, 15 May 2026 05:08:56 +0000
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
Subject: [PATCH RFC v6 4/7] drm/msm/adreno: set cx_misc_mmio regardless of if
 platform has LLCC
Message-ID: <20260515-adreno-810-v6-4-fbe04c7203e1@pm.me>
In-Reply-To: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: f8a9fe4628bf3206e3a6fa5585c2375f2a5560a0
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

Platforms without a LLCC (e.g. milos) still need to be able to read and
write to the cx_mem region. Previously if LLCC slices were unavailable
the cx_misc_mmio mapping was overwritten with ERR_PTR, causing a crash
when the GMU later accessed cx_mem.

Move the cx_misc_mmio mapping out of a6xx_llc_slices_init() into
a6xx_gpu_init() so that cx_mem mapping is independent of LLCC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 ++++++++++++++++---------------=
----
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/ad=
reno/a6xx_gpu.c
index 4275c1d726b2..533272e11111 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2039,7 +2039,7 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_g=
pu)
 =09struct msm_gpu *gpu =3D &adreno_gpu->base;
 =09u32 cntl1_regval =3D 0;
=20
-=09if (IS_ERR(a6xx_gpu->cx_misc_mmio))
+=09if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw=
_llc_slice))
 =09=09return;
=20
 =09if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
@@ -2098,7 +2098,7 @@ static void a7xx_llc_activate(struct a6xx_gpu *a6xx_g=
pu)
 =09struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
 =09struct msm_gpu *gpu =3D &adreno_gpu->base;
=20
-=09if (IS_ERR(a6xx_gpu->cx_misc_mmio))
+=09if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw=
_llc_slice))
 =09=09return;
=20
 =09if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
@@ -2135,31 +2135,12 @@ static void a6xx_llc_slices_destroy(struct a6xx_gpu=
 *a6xx_gpu)
 static void a6xx_llc_slices_init(struct platform_device *pdev,
 =09=09struct a6xx_gpu *a6xx_gpu, bool is_a7xx)
 {
-=09struct device_node *phandle;
-
 =09/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
 =09if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
 =09=09return;
=20
-=09/*
-=09 * There is a different programming path for A6xx targets with an
-=09 * mmu500 attached, so detect if that is the case
-=09 */
-=09phandle =3D of_parse_phandle(pdev->dev.of_node, "iommus", 0);
-=09a6xx_gpu->have_mmu500 =3D (phandle &&
-=09=09of_device_is_compatible(phandle, "arm,mmu-500"));
-=09of_node_put(phandle);
-
-=09if (is_a7xx || !a6xx_gpu->have_mmu500)
-=09=09a6xx_gpu->cx_misc_mmio =3D msm_ioremap(pdev, "cx_mem");
-=09else
-=09=09a6xx_gpu->cx_misc_mmio =3D NULL;
-
 =09a6xx_gpu->llc_slice =3D llcc_slice_getd(LLCC_GPU);
 =09a6xx_gpu->htw_llc_slice =3D llcc_slice_getd(LLCC_GPUHTW);
-
-=09if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw=
_llc_slice))
-=09=09a6xx_gpu->cx_misc_mmio =3D ERR_PTR(-EINVAL);
 }
=20
 #define GBIF_CLIENT_HALT_MASK=09=09BIT(0)
@@ -2621,6 +2602,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_devic=
e *dev)
 =09struct platform_device *pdev =3D priv->gpu_pdev;
 =09struct adreno_platform_config *config =3D pdev->dev.platform_data;
 =09const struct adreno_info *info =3D config->info;
+=09struct device_node *phandle;
 =09struct device_node *node;
 =09struct a6xx_gpu *a6xx_gpu;
 =09struct adreno_gpu *adreno_gpu;
@@ -2657,6 +2639,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_devi=
ce *dev)
=20
 =09a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
=20
+=09/*
+=09 * There is a different programming path for A6xx targets with an
+=09 * mmu500 attached, so detect if that is the case
+=09 */
+=09phandle =3D of_parse_phandle(pdev->dev.of_node, "iommus", 0);
+=09a6xx_gpu->have_mmu500 =3D (phandle &&
+=09=09of_device_is_compatible(phandle, "arm,mmu-500"));
+=09of_node_put(phandle);
+
+=09if (is_a7xx || !a6xx_gpu->have_mmu500)
+=09=09a6xx_gpu->cx_misc_mmio =3D msm_ioremap(pdev, "cx_mem");
+=09else
+=09=09a6xx_gpu->cx_misc_mmio =3D NULL;
+
 =09ret =3D a6xx_set_supported_hw(&pdev->dev, a6xx_gpu, info);
 =09if (ret) {
 =09=09a6xx_llc_slices_destroy(a6xx_gpu);

--=20
2.53.0


