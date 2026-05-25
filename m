Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DACD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458B910E380;
	Mon, 25 May 2026 23:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="WQueOBcv";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109C910E380
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779750238; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SQi6buz5FVmGcs9wqGc4KawUzKJTEIcrY2R9gGqU5un2dHR8+jg0U1ttcTms5QsW1giprO83vbQDQHqfUInzWeTLxDF3QlCAdr+VyM8BXd1ahXkhPvVLDrRLWWgQJ4vzMZDPWBcu0c+zGQtzTS9OAVV8hfi/0OGJ5ph53CP1ooI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779750238;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cE0WAZETd4bXQP6F1gEItawSuCDE/IK7BkdH9mtvDLE=; 
 b=jCz462ZGQ/vOiCZRsY2XJws0LZjLfqIQEipSXxewlYAIEE4j38XimlXK8odQSZ1orNFKYB0y/ug9dee7Me8UQKuR7i4XjLc1kkD/SMvo8Vdy6z0ZoQMEKI37caVF2J2gR4CxI8TgvsHbIVXN51OXsVAdII4CMBSS4411LSfZ2ew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779750238; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=cE0WAZETd4bXQP6F1gEItawSuCDE/IK7BkdH9mtvDLE=;
 b=WQueOBcvf09ruMduuDQwDEaHjCRa+cov1TfDH+Ywx54WKagxSK8stEU6W4sqjVPP
 26PRIna3xQoOD7akVcLRgigwkff4NVCQKmEjG9h3YZJoR7EPLxx3KoFlPC0bga+fs5a
 YKP6LOuKw5LktoaazloXCecs2GzNhF3W2b/Q6MVw=
Received: by mx.zohomail.com with SMTPS id 1779750236263626.1047340932973;
 Mon, 25 May 2026 16:03:56 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 26 May 2026 00:03:36 +0100
Subject: [PATCH 2/4] drm/panfrost: Make reset sequence deal with an active
 HWPerf session
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260526-claude-fixes-v1-2-16e92eaa4949@collabora.com>
References: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
In-Reply-To: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5960;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=8r5vOGvj18w3GEXNY0DJX4f83gteHWkpGVKL0p6ej0c=;
 b=kA0DAAoBDiZ+TO5TQz0ByyZiAGoU1VShCd1i5fmMIZU+yrD9Al1irlgmFP3nRGeX4m6NUpT48
 okBswQAAQoAHRYhBDJAMOjABRdd+TcHpA4mfkzuU0M9BQJqFNVUAAoJEA4mfkzuU0M9WfgL/1JX
 1mGBo9ju8aTn7MOKiSvLFv8+NHps5kX9kVBdB6jKP4SIkiRqzmbCKwXTWNAxo1+9ZGGQB7CBmWE
 qDcR7MQSllgyJkc4ECBGABBXUQf7/QHoBXaIMZZnuL7YED8nUAj1O1e3ncDukc4+T6b3cVJmAge
 hjOBNKcXFiCHMK+JcJL8+XxS+6o5FRbyzVoBEKfGdK0WWzd79Qch8AC1n8cZ/TzEfYJYoOCvQcF
 BuBiVPRN9HCMCsd5ffpkjj9WzvtoFMiQFuZpyrTcK+htIEveuvzGBUrQkn7xc3ZxUNXoYxRdt75
 JDL5pVJyQq78xS8nDReN8lT7cOk/gJFi8bEAauMCCMbrYi2NJPFFYcIZL2DLquzICwtkBpC8/io
 4j3c6Ahqu46eMCQ5VMae9mGl8gRuwJpce5Iye0582+b6MNT+Dr/spAlLpfRiIMQuYornz9VDWdy
 gztWlc6l6krCvd3ENxj6V4vKFR7WY3XNbN/aazM6SISn4SRjDBPKN+PcbB3A==
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

Right now, if there's a HW reset and an HWPerf session is active,
panfrost_mmu_reset() will reset mmu structs for all all open files to
have zero users and their HW address space assignment. Then, when
disabling hwperf, panfrost_mmu_as_put() will WARN that mmu->as_count is
less than zero.

Fix this by introducing a perfcnt HW reset path.

The choice was made to render perfcnt unusable after reset, so that a
user might have to reprogram it with a full disable/enable sequence
before requesting more perfcnt dumps.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 58 +++++++++++++++++++----------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..2a4417bc4065 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -421,6 +421,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
 
+	panfrost_perfcnt_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 7020c0192e18..d6a6fbe35578 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -33,6 +33,7 @@ struct panfrost_perfcnt {
 	struct panfrost_file_priv *user;
 	struct mutex lock;
 	struct completion dump_comp;
+	bool hw_reset_happened;
 };
 
 void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
@@ -166,6 +167,7 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
+	perfcnt->hw_reset_happened = false;
 	perfcnt->user = user;
 
 	return 0;
@@ -183,6 +185,16 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	return ret;
 }
 
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
 static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 					   struct drm_file *file_priv)
 {
@@ -193,18 +205,14 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
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
 	perfcnt->buf = NULL;
 	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
-	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
+	if (!perfcnt->hw_reset_happened)
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
 	panfrost_gem_mapping_put(perfcnt->mapping);
 	perfcnt->mapping = NULL;
 	pm_runtime_put_autosuspend(pfdev->base.dev);
@@ -258,6 +266,15 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 		goto out;
 	}
 
+	/*
+	 * A HW reset when HWPerf was active mean user should go through
+	 * a disable/enable sequence before requesting more frame dumps.
+	 */
+	if (perfcnt->hw_reset_happened) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
 	ret = panfrost_perfcnt_dump_locked(pfdev);
 	if (ret)
 		goto out;
@@ -327,12 +344,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
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
@@ -344,10 +356,18 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
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
+}
+
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+
+	mutex_lock(&perfcnt->lock);
+	if (perfcnt->user) {
+		panfrost_perfcnt_gpu_disable(pfdev);
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
+		perfcnt->hw_reset_happened = true;
+	}
+	mutex_unlock(&perfcnt->lock);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
index 8bbcf5f5fb33..8b9bc704b634 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
@@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
 int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
 
 #endif

-- 
2.53.0

