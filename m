Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5DAD58B18
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B251710E560;
	Sun, 15 Mar 2026 11:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="gHtEW9mI";
	dkim-atps=neutral
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E89210E0B9
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 04:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773461695; x=1773720895;
 bh=QqEy2OdKuWkqnAs2xtgSeBFA2/O9zwNNVusCjEEVHhM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gHtEW9mIcNo3e0lgqd0++G8AlXljR6E8kYSYhwaMXK8MqRwAor64vw8p7BfcZDQgl
 N+cL/wRx9sVV0GRoWEi9TevFCHyg8+S5l4TvgUZzMW78ssjc0d2xqtehGR54IkKBm1
 +Mndx9Rm7QcdQdFPof5rb2h/9080jgcgGZeWx/Pb1LUq1PJjteGS7w7p+FoLhtdbFt
 x97HC+EcRkT/q5ovsvM4AzSuKNl4ofil/HrLNKT1lgMQmOSP1Lu9f4Dcq69LWhzNJX
 Fx40k7Z0RMyVOy5bPuhVMotBxCWChJ9Az1DB0/9sOhwshwl+inHkFrBmKhX0Ljlpe+
 x1MxYkjSvjVoA==
Date: Sat, 14 Mar 2026 04:14:50 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH] drm/msm: Fix GMEM_BASE for A650
Message-ID: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 617005a9c644ef59bbc086c9bc4f92729f6fbba4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
to family >=3D ADRENO_6XX_GEN4.

This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
an incorrect GMEM_BASE which results in severe rendering corruption.

Update check to also include ADRENO_6XX_GEN3 to fix A650.

Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/=
adreno/adreno_gpu.c
index d5fe6f6f0dec..0ac3fba5c277 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_co=
ntext *ctx,
 =09=09*value =3D adreno_gpu->info->gmem;
 =09=09return 0;
 =09case MSM_PARAM_GMEM_BASE:
-=09=09if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN4)
+=09=09if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN3)
 =09=09=09*value =3D 0;
 =09=09else
 =09=09=09*value =3D 0x100000;

---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


