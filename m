Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71943C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5F110E499;
	Sun, 12 Jul 2026 15:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="P5LAczCK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A6710E499
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4kN9l8rXBpMTDDkNT7zTfmoLxSOis9Nv0uyNfjFa4w=; b=P5LAczCK7Tj+c6/Ol/9PR/0bmF
 yu684Mx72D8bO2ERg/zOGsUwJrZ0JjkMAPn/hhYbkRfER36ZPHll6FgUMpaiTe9j31NWJHgqE+jPZ
 OPAGo/s92tY8HtUB7EYjonMl07rXHEkx1hsw/ruSeKbHlDTXDuaVgakJiaC0h2pSFqoefzQ9f0SBE
 KvGWNIk4FN3BFDLmbQ4/eLyYjzH6lkJmkgo5tZvOwpbWQNv4GwKt3ySPXCsPFbfPrG0/RG9PaKWAB
 lsRfU3di4clubJKa7CqVtMQD/DJWJhc5lUh1loVh5zD0PJPsiZoT6AaaFfy13m+HNB6nDk/90vCRa
 +mG09aVw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wivtZ-00DnB6-V9; Sun, 12 Jul 2026 17:15:06 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 12 Jul 2026 12:14:38 -0300
Subject: [PATCH v3 5/8] drm/vc4: Refcount vc4_file for safe access by jobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260712-vc4-drm-scheduler-v3-5-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2863; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=6Y0VrpFfg7sCykJHeN4AH0CpPNqQbd1/ZbHHoiPoxes=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFnB6xPM9zySbXZlVP7tmHtQTax7k//ef7lvTma/NJp7J
 7jIILO1k9GYhYGRi0FWTJHlx5PYWkaxcnbNZeUXYQaxMoFMYeDiFICJsMey/9PukU2yu/Mquv+I
 XIfSLM6kh7qZrBqZz5af6l4ReE2lpFpzm1zChru2lTME5abNmKsR+7/FqvdVT9/acB0BieBDVge
 Wnl2gJ38meNtikz/bnI1Tn6f0MjAGMpW0L/qgxhjfe9v8ok/783KG00eiHk7szxAXyP7GJl17f6
 ZP7vMLnjKZDs/+zwuSyVffe1TmX9jRGVwTs1sYD2ur3yzvdzU8/C/fy5f5QnXQrFO2XnHLp3DNm
 yVtae38XPjSH2u7l8pV30+cP8zzIEpwsYV47x3Gf6rnXvQfVmXke5Rv0/h80TPmjtbCVY7yOoI/
 3c8t6pm7oktUekZRv9CtwpMG6kLaUnGCm5xWtPdnzT8IAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

This is a preparation commit for per-file descriptor seqno tracking,
which will require the struct vc4_render_job to store a pointer to
vc4_file. Since the scheduler's free_job callback runs asynchronously,
it can execute after vc4_close() has already freed the vc4_file, causing
a use-after-free.

Add kref-based reference counting to vc4_file so that jobs can safely
take a reference at submit time via vc4_file_get() and drop it in their
free callback via vc4_file_put().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 12 ++++++++++--
 drivers/gpu/drm/vc4/vc4_drv.h | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index cacd4cb94259..6c49304301c9 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -167,6 +167,7 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 			goto err_sched;
 	}
 
+	kref_init(&vc4file->refcount);
 	vc4_perfmon_open_file(vc4file);
 	file->driver_priv = vc4file;
 
@@ -180,6 +181,14 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 
 }
 
+void vc4_file_release(struct kref *ref)
+{
+	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
+
+	vc4_perfmon_close_file(vc4file);
+	kfree(vc4file);
+}
+
 static void vc4_close(struct drm_device *dev, struct drm_file *file)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -195,8 +204,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
 	for (q = 0; q < VC4_MAX_QUEUES; q++)
 		drm_sched_entity_destroy(&vc4file->sched_entity[q]);
 
-	vc4_perfmon_close_file(vc4file);
-	kfree(vc4file);
+	vc4_file_put(vc4file);
 }
 
 DEFINE_DRM_GEM_FOPS(vc4_drm_fops);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 255a95f55586..4f452ea3b4a6 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -905,6 +905,8 @@ struct vc4_exec_info {
 struct vc4_file {
 	struct vc4_dev *dev;
 
+	struct kref refcount;
+
 	struct xarray perfmons;
 
 	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
@@ -1092,6 +1094,21 @@ static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
 /* vc4_drv.c */
 void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
 int vc4_dumb_fixup_args(struct drm_mode_create_dumb *args);
+void vc4_file_release(struct kref *ref);
+
+static inline
+struct vc4_file *vc4_file_get(struct vc4_file *vc4file)
+{
+	kref_get(&vc4file->refcount);
+	return vc4file;
+}
+
+static inline
+void vc4_file_put(struct vc4_file *vc4file)
+{
+	kref_put(&vc4file->refcount, vc4_file_release);
+}
+
 
 /* vc4_dpi.c */
 extern struct platform_driver vc4_dpi_driver;

-- 
2.54.0

