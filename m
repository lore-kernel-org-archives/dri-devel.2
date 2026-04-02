Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41F8D6AAF7
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343D110F30D;
	Thu,  2 Apr 2026 18:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XANPlTbn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DA210F30D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g0st7UYbaUtdK/G4dB96SgNyg5nprNhYX1rr12OXraY=; b=XANPlTbnFGKOWq+3s/hmmIwN30
 ldwQ0HebBVcrEborNqFtkV2MoPvQRYaGpTyxEN0diuOt670U77kFfFhS14xunI83+1V2d8FQT8bYy
 Y7R2K4KySDBqqVrkz8lVSjNbKEWJVLJ4ukR/O97UtrvioCzQ/ngWiih62tvEinLzSQaCku9QAUJfC
 uQ9RERpcSUPrVsU0Qe9OvLmH38jUHECtgYYZcpr+0uMrBCbb3rjBUBepC423yddphi3Pd8EzAt4gT
 CfUINe5RRav3d9Cr86SQfc5rdM2n5qMsng9M9PiKEFGblX5VELBLFflCtxMgWHsl2UWIjS+Anf5pF
 VjxaE3mg==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8Mu4-00AaZZ-3x; Thu, 02 Apr 2026 20:36:28 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 02 Apr 2026 15:36:04 -0300
Subject: [PATCH v2 4/7] drm/vc4: Refcount vc4_file for safe access by jobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-vc4-drm-scheduler-v2-4-d84afd35c602@igalia.com>
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=PkmrDNrSXIjesAewcLBissNyA/uj6miHukVr7JiOHJg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpzrcZeG9zgs3TPap42mhzwlVME2WxGAGg2Mkme
 Vd/myZiJYGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCac63GQAKCRA/8w6Kdoj6
 qsTmCADWg8sW+3n/Jr7tnb03STwlJMVXsEtz9sXLEtBPzMdI0CqTjm8Hy+cA8vSMUeqZKc82fyo
 btJnU3fDwm+jNMVY04MfdXDXGfFZygjBH3UuZuH7tCqZxdcA8LQsOvHtr7qBZkUGKTVHHct1CXP
 wyaTuLiYc/w9AZjWWw8YBGvjPlryckHQcILiEY51puBWwrlt4EEevw8Qwr6Vl3SmO0NxUaVmg7k
 9nrGvUmJX6r/jyz5s4snfBaJUtPWr8ftyoa4DhuYBEWV0KwWkiRBpbjJoOhKHP77mbhl0q38zNk
 bqYktnDtwYcDPKq7mS3m7RexiViBXdNfKFDvY9Rz9JYbMFJ7
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
 drivers/gpu/drm/vc4/vc4_drv.c | 23 +++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_drv.h |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index cacd4cb942593b44f2210b7738bd964ebc34522d..d0e515c900af6e7400a96e42a9141dab5d5bca2d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -167,6 +167,7 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 			goto err_sched;
 	}
 
+	kref_init(&vc4file->refcount);
 	vc4_perfmon_open_file(vc4file);
 	file->driver_priv = vc4file;
 
@@ -180,6 +181,25 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 
 }
 
+static void vc4_file_release(struct kref *ref)
+{
+	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
+
+	vc4_perfmon_close_file(vc4file);
+	kfree(vc4file);
+}
+
+struct vc4_file *vc4_file_get(struct vc4_file *vc4file)
+{
+	kref_get(&vc4file->refcount);
+	return vc4file;
+}
+
+void vc4_file_put(struct vc4_file *vc4file)
+{
+	kref_put(&vc4file->refcount, vc4_file_release);
+}
+
 static void vc4_close(struct drm_device *dev, struct drm_file *file)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -195,8 +215,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
 	for (q = 0; q < VC4_MAX_QUEUES; q++)
 		drm_sched_entity_destroy(&vc4file->sched_entity[q]);
 
-	vc4_perfmon_close_file(vc4file);
-	kfree(vc4file);
+	vc4_file_put(vc4file);
 }
 
 DEFINE_DRM_GEM_FOPS(vc4_drm_fops);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index b828c56f98965944b94a330e6c4e5ff95c9ab8f8..2a331dd053cab1e55476cb028f399a5d25eb4309 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -898,6 +898,8 @@ struct vc4_exec_info {
 struct vc4_file {
 	struct vc4_dev *dev;
 
+	struct kref refcount;
+
 	struct xarray perfmons;
 
 	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
@@ -1083,6 +1085,8 @@ static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
 #endif
 
 /* vc4_drv.c */
+struct vc4_file *vc4_file_get(struct vc4_file *vc4file);
+void vc4_file_put(struct vc4_file *vc4file);
 void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
 int vc4_dumb_fixup_args(struct drm_mode_create_dumb *args);
 

-- 
2.53.0

