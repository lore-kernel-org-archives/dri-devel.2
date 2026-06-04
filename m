Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC2CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1836B1128F0;
	Thu,  4 Jun 2026 17:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="R6yTnxE8";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5081710E3BA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594578; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WGmmvKISPfzhj81F5E5sGRS7BmM+pRzy00R4A6NQ+5BtxWuIeV+ByUNeXP5hLvO3hHujLwKS+cxDM2mU7c0UwtmPNpwDNYA9pVtbKZxC9HTiFLOD9u2QHSbpwC75woD4prJSS1XCkYtEH4cSHmutK/G0+MnlFNN1w13f4FbeU3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594578;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4u+t/C8H9x/aY+ZDOhqE29VEMGRhkLvLihuswVI+BME=; 
 b=HFiA2l3VE8M8Wya3ki+VIGYGMWILqllMAhPz+udGwNMX9DytFUq09f1SOIrSduXu0VPG87cJ71gmJA0TbhNKPYZmbv7Vsr/fdAJmEklUe5U7rI30TF2kt6qfRj4F1qESQCCEJotwvTX+zZvks0KRIzdjiviXSb+xyv9D3Yjcdn8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594578; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=4u+t/C8H9x/aY+ZDOhqE29VEMGRhkLvLihuswVI+BME=;
 b=R6yTnxE8Y7L8U/D9YiYuMEZNFCTcVV2k1HCp+NqceE/JWz2haXYuU10UjimEs9pn
 4Vgj+UJ/RA4YkyGAQi33f9z8aR/lF7m6ocmXs2UxMUVrLJUMkWkjly/F/AUiDccdT9G
 A7FSx3Z3EYDbiz0S4Adj+4WuPBp2lMweBKAIKksc=
Received: by mx.zohomail.com with SMTPS id 1780594577655702.1261648486782;
 Thu, 4 Jun 2026 10:36:17 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:23 +0100
Subject: [PATCH v2 4/7] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=jDTN3KPXW5GgyiXtSuso4KxYEzTJHTIqTdytBXUJh3s=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8wDXgYJGEsn0JD+YxBWGWWzOze1DVPwGjD
 ctxIwj10qSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PTSDC/9sL6DxcKKPZnVI7pgw7rhShwg0i2M3gc4N7vY3iq+ZyJHC7sViGiCyNXYRSHTBNU+VmSF
 9iTRHNxXkELTlE/hLo4icEPUSCSGjOO0kAjSRLjwLb03U98+qXVkLtKoKLcUA3+9JWZctCBy6h4
 iLPq1DJ2bLNOGFWBJ9W9PEqOC2kyYxwR0+1FEs6BMrIM7INYd/S26K9l3MjGOZCRz7dMGEj4kqT
 tDL40MTEJ+tDBzfkzFjYLyFUqJ3yWnjWJGngeCPlMIuelGM7OW1AxDT+m3VQiS3eO8weLYUWVcn
 OWTxgk3AIiihvjELX1KTVME+s0uGZ1XoYpo19jAGMkILDKvCSgtxcwHLlp+m1OvyGzIq7LGrXNI
 SiZ7xbYC73iZjOWxgVoMHy2Z78Xkfgm+eMlBhwaU4nEOd/VuEnhvUwlOuvnOR21g3ThapuwG/DV
 eclFRe+J38f1bX6LMAiN6bUZbnToKt0YCJrbzT6uZpi416OLYHM4k7FG3/oAWWy/D1dWI=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Just for the sake of avoiding repetition.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 31 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 7020c0192e18..ad1156678e91 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -35,6 +35,16 @@ struct panfrost_perfcnt {
 	struct completion dump_comp;
 };
 
+static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
+{
+	gpu_write(pfdev, GPU_PERFCNT_CFG,
+		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
+	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+}
+
 void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 {
 	complete(&pfdev->perfcnt->dump_comp);
@@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	if (user != perfcnt->user)
 		return -EINVAL;
 
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
+	panfrost_perfcnt_gpu_disable(pfdev);
 
 	perfcnt->user = NULL;
 	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
@@ -327,12 +332,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
 	perfcnt->bosize = size;
 
 	/* Start with everything disabled. */
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+	panfrost_perfcnt_gpu_disable(pfdev);
 
 	init_completion(&perfcnt->dump_comp);
 	mutex_init(&perfcnt->lock);
@@ -344,10 +344,5 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
 void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 {
 	/* Disable everything before leaving. */
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+	panfrost_perfcnt_gpu_disable(pfdev);
 }

-- 
2.53.0

