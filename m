Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A956F8A157
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B8810E841;
	Thu, 16 Apr 2026 11:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="EobvhG8W";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260A010E830;
 Thu, 16 Apr 2026 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776337518; x=1776596718;
 bh=6Y9wyShBEbuRDWcowqrU45jNU6QCKVTF+X7+oewA8Vw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=EobvhG8WEyxwFtMn8Dc/w3qwIr8RRglpeLRKVLo4kMPn8ayHwm81C0Or/RoMtGGiU
 5pxJGqchOD69G8OiQJOvhND1eidDeFbr4L2K0pjluaJiy7FIfv3gxAEp6+U2ajGL7c
 29e4rLfSQsc3Leav4EDHC5fWCQT2ad5i/0v96Fwa6M2PrxJd92AejUrHhe5SwDwcJl
 0lKP4cmCcTqtq/jKYULPPE62u4zDWhl8/shUEfzPdpdA1MNELjor6sccPmpSrKAvwp
 p1A8K5EmvkmIn9codA5Y9sV6DNB3XMbY5LIhCm46nY3GRR/penSsi00o9ybOIHwHHH
 kmcMWFydT/npw==
Date: Thu, 16 Apr 2026 11:05:12 +0000
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH RFC v4 3/7] drm/msm/adreno: rename llc_mmio to cx_misc_mmio
Message-ID: <20260416-adreno-810-v4-3-61676e073f8a@pm.me>
In-Reply-To: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 40693c907428f35884df200bdffd6158d6aa9351
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

This region is used for more than just LLCC, it also provides access to
software fuse values (raytracing, etc).

Rename relevant symbols from _llc to _cx_misc for use in a follow up
change that decouples this from LLCC.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  8 ++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 14 +++++++-------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/ad=
reno/a6xx_gmu.c
index b7166a883b01..6a369682bb80 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -947,7 +947,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsi=
gned int state)
=20
 =09/* Turn on TCM (Tightly Coupled Memory) retention */
 =09if (adreno_is_a7xx(adreno_gpu))
-=09=09a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL, 1);
+=09=09a6xx_cx_misc_write(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL, 1);
 =09else if (!adreno_is_a8xx(adreno_gpu))
 =09=09gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
=20
@@ -1215,7 +1215,7 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx=
_gpu)
 =09=09if (!qcom_scm_is_available()) {
 =09=09=09dev_warn_once(gpu->dev->dev,
 =09=09=09=09"SCM is not available, poking fuse register\n");
-=09=09=09a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
+=09=09=09a6xx_cx_misc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
 =09=09=09=09A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
 =09=09=09=09A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
 =09=09=09=09A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
@@ -1236,7 +1236,7 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx=
_gpu)
 =09=09 * firmware, find out whether that's the case. The scm call
 =09=09 * above sets the fuse register.
 =09=09 */
-=09=09fuse_val =3D a6xx_llc_read(a6xx_gpu,
+=09=09fuse_val =3D a6xx_cx_misc_read(a6xx_gpu,
 =09=09=09=09=09 REG_A7XX_CX_MISC_SW_FUSE_VALUE);
 =09=09adreno_gpu->has_ray_tracing =3D
 =09=09=09!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
@@ -1343,7 +1343,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
=20
 =09/* Check to see if we are doing a cold or warm boot */
 =09if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
-=09=09status =3D a6xx_llc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) =
=3D=3D 1 ?
+=09=09status =3D a6xx_cx_misc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL=
) =3D=3D 1 ?
 =09=09=09GMU_WARM_BOOT : GMU_COLD_BOOT;
 =09} else if (gmu->legacy) {
 =09=09status =3D gmu_read(gmu, REG_A6XX_GMU_GENERAL_7) =3D=3D 1 ?
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/ad=
reno/a6xx_gpu.c
index d5aba072f44c..4275c1d726b2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2039,7 +2039,7 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_g=
pu)
 =09struct msm_gpu *gpu =3D &adreno_gpu->base;
 =09u32 cntl1_regval =3D 0;
=20
-=09if (IS_ERR(a6xx_gpu->llc_mmio))
+=09if (IS_ERR(a6xx_gpu->cx_misc_mmio))
 =09=09return;
=20
 =09if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
@@ -2078,14 +2078,14 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx=
_gpu)
 =09 * pagetables
 =09 */
 =09if (!a6xx_gpu->have_mmu500) {
-=09=09a6xx_llc_write(a6xx_gpu,
+=09=09a6xx_cx_misc_write(a6xx_gpu,
 =09=09=09REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
=20
 =09=09/*
 =09=09 * Program cacheability overrides to not allocate cache
 =09=09 * lines on a write miss
 =09=09 */
-=09=09a6xx_llc_rmw(a6xx_gpu,
+=09=09a6xx_cx_misc_rmw(a6xx_gpu,
 =09=09=09REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
 =09=09return;
 =09}
@@ -2098,7 +2098,7 @@ static void a7xx_llc_activate(struct a6xx_gpu *a6xx_g=
pu)
 =09struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
 =09struct msm_gpu *gpu =3D &adreno_gpu->base;
=20
-=09if (IS_ERR(a6xx_gpu->llc_mmio))
+=09if (IS_ERR(a6xx_gpu->cx_misc_mmio))
 =09=09return;
=20
 =09if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
@@ -2151,15 +2151,15 @@ static void a6xx_llc_slices_init(struct platform_de=
vice *pdev,
 =09of_node_put(phandle);
=20
 =09if (is_a7xx || !a6xx_gpu->have_mmu500)
-=09=09a6xx_gpu->llc_mmio =3D msm_ioremap(pdev, "cx_mem");
+=09=09a6xx_gpu->cx_misc_mmio =3D msm_ioremap(pdev, "cx_mem");
 =09else
-=09=09a6xx_gpu->llc_mmio =3D NULL;
+=09=09a6xx_gpu->cx_misc_mmio =3D NULL;
=20
 =09a6xx_gpu->llc_slice =3D llcc_slice_getd(LLCC_GPU);
 =09a6xx_gpu->htw_llc_slice =3D llcc_slice_getd(LLCC_GPUHTW);
=20
 =09if (IS_ERR_OR_NULL(a6xx_gpu->llc_slice) && IS_ERR_OR_NULL(a6xx_gpu->htw=
_llc_slice))
-=09=09a6xx_gpu->llc_mmio =3D ERR_PTR(-EINVAL);
+=09=09a6xx_gpu->cx_misc_mmio =3D ERR_PTR(-EINVAL);
 }
=20
 #define GBIF_CLIENT_HALT_MASK=09=09BIT(0)
@@ -2560,7 +2560,7 @@ static int a6xx_read_speedbin(struct device *dev, str=
uct a6xx_gpu *a6xx_gpu,
 =09=09return ret;
=20
 =09if (info->quirks & ADRENO_QUIRK_SOFTFUSE) {
-=09=09*speedbin =3D a6xx_llc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW_FUSE_FREQ_=
LIMIT_STATUS);
+=09=09*speedbin =3D a6xx_cx_misc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW_FUSE_F=
REQ_LIMIT_STATUS);
 =09=09*speedbin =3D A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS_FINALFREQLIMIT(=
*speedbin);
 =09=09return 0;
 =09}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/ad=
reno/a6xx_gpu.h
index eb431e5e00b1..648608c1c98e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -102,7 +102,7 @@ struct a6xx_gpu {
=20
 =09bool has_whereami;
=20
-=09void __iomem *llc_mmio;
+=09void __iomem *cx_misc_mmio;
 =09void *llc_slice;
 =09void *htw_llc_slice;
 =09bool have_mmu500;
@@ -240,19 +240,19 @@ static inline bool a6xx_has_gbif(struct adreno_gpu *g=
pu)
 =09return true;
 }
=20
-static inline void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 ma=
sk, u32 or)
+static inline void a6xx_cx_misc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u3=
2 mask, u32 or)
 {
-=09return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
+=09return msm_rmw(a6xx_gpu->cx_misc_mmio + (reg << 2), mask, or);
 }
=20
-static inline u32 a6xx_llc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
+static inline u32 a6xx_cx_misc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
 {
-=09return readl(a6xx_gpu->llc_mmio + (reg << 2));
+=09return readl(a6xx_gpu->cx_misc_mmio + (reg << 2));
 }
=20
-static inline void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 =
value)
+static inline void a6xx_cx_misc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, =
u32 value)
 {
-=09writel(value, a6xx_gpu->llc_mmio + (reg << 2));
+=09writel(value, a6xx_gpu->cx_misc_mmio + (reg << 2));
 }
=20
 #define shadowptr(_a6xx_gpu, _ring) ((_a6xx_gpu)->shadow_iova + \
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/ad=
reno/a8xx_gpu.c
index 9b99ec5ceeb5..d519a29573a1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -104,7 +104,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 =09=09return;
 =09}
=20
-=09slice_mask &=3D a6xx_llc_read(a6xx_gpu,
+=09slice_mask &=3D a6xx_cx_misc_read(a6xx_gpu,
 =09=09=09REG_A8XX_CX_MISC_SLICE_ENABLE_FINAL);
=20
 =09a6xx_gpu->slice_mask =3D slice_mask;

--=20
2.53.0


