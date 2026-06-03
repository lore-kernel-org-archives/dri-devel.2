Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3ECD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC9D11242A;
	Wed,  3 Jun 2026 22:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="R+vpq9x4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC7B11242A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hSLRoeWMd8QUSEN6ELIFAhZCc1EKlM0XdpG7MvuOI/Y=; b=R+vpq9x4tnLV1OIxD2UVMqdeS4
 cTFZMNrXSpLGFuYNree+/NFtXqwDGcLYwYRVeoxR0rOLZIzJDzMmfdZjBB/CMZHTwKpEqZ9ptZZQ3
 MkT2LfJ6anTrcEVYesHdmPSN74HtjBBB233pFPyFe99v+pnvFCANpar/MvBZElZbFcT99kaHV/c5P
 xpIHe/M8RgVMe56d2MmwLqq6IGvK8ZqFV4O8SuTvWr+x7WLIHt4GlOJZO6kNDS2oW2VYElELALRuB
 8Dvf4Th7bdFt8NfYbUoW7EZlcm5+a/hiS2BnAaiJm2kAiV4QOrSHrwHqqt1DlMyPgOYrlfHsLiv/a
 +yRNIRDQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu1n-00CNgx-Kv; Thu, 04 Jun 2026 00:25:35 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:07 -0300
Subject: [PATCH v3 05/14] drm/v3d: Extract v3d_job_add_syncobjs() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-5-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Xro9MxvK9pmA3Io6rgxz6O3bch0tmHwTyc5RBQzPszQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnGbXUd6FBQfrdYXniQTbR/zjLiNJSl/Ipni
 6PYFWgCtWSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxgAKCRA/8w6Kdoj6
 qmjpCAC3GQ6cCkPNBQc3eE+x1VBSzKavL2z8VGFNhh/uJKsY+hzLolUesuxFitTAjWenMhWNC3D
 k0TIp5XUKa/jTJgjGfYA3fc8FrpsZiBYyid3+KW2zhJpxv3CeTJaAiOstmroXb9582oBjrZG4Ug
 VeEnU8got/sgAq2YepvxCCS0bQ6xvgQ4JCqnB55ZLy5fh7g+1ZXaGAW4zKaSMIv1Xzh7uNgXWwc
 tgUnJlN2oMnEvJHhBykRlM2v5Jsxh9fA7o8MEIAhciUJiMElT5viEGpM7jQt9JqT5Ul/E9NW60M
 0jsO6IBW+DLTfv/2K54yjsv4SEe5/V7nKEqq4bHhoFr2K6+8
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

Move the syncobj dependency setup out of v3d_job_init() into its own
v3d_job_add_syncobjs() helper and make the queue that the job was
submitted a variable in struct v3d_job, so that v3d_job_add_syncobjs()
can use it. No functional change.

This prepares for the next commit which changes the error handling, and
for a later consolidation that separates job allocation from syncobj
attachment.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  3 ++
 drivers/gpu/drm/v3d/v3d_submit.c | 72 ++++++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 5a0b9da2c3aa..79672abef70d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -294,6 +294,9 @@ struct v3d_job {
 
 	struct v3d_dev *v3d;
 
+	/* The queue that the job was submitted on. */
+	enum v3d_queue queue;
+
 	/* This is the array of BOs that were looked up at the start
 	 * of submission.
 	 */
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 1db43c6a078d..8250376d104c 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -180,17 +180,56 @@ v3d_job_deallocate(void **container)
 	*container = NULL;
 }
 
+static int
+v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
+		     u32 in_sync, struct v3d_submit_ext *se)
+{
+	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
+	struct v3d_dev *v3d = job->v3d;
+	int ret = 0;
+
+	if (!has_multisync) {
+		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
+							   in_sync, 0);
+		// TODO: Investigate why this was filtered out for the IOCTL.
+		if (ret && ret != -ENOENT)
+			return ret;
+		return 0;
+	}
+
+	if (se->in_sync_count && se->wait_stage == job->queue) {
+		struct drm_v3d_sem __user *handle = u64_to_user_ptr(se->in_syncs);
+
+		for (int i = 0; i < se->in_sync_count; i++) {
+			struct drm_v3d_sem in;
+
+			if (copy_from_user(&in, handle++, sizeof(in))) {
+				drm_dbg(&v3d->drm, "Failed to copy wait dep handle.\n");
+				return -EFAULT;
+			}
+
+			ret = drm_sched_job_add_syncobj_dependency(&job->base,
+								   file_priv, in.handle, 0);
+			// TODO: Investigate why this was filtered out for the IOCTL.
+			if (ret && ret != -ENOENT)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int
 v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	     struct v3d_job *job, void (*free)(struct kref *ref),
 	     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
-	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
-	int ret, i;
+	int ret;
 
 	job->v3d = v3d;
 	job->free = free;
+	job->queue = queue;
 	job->file_priv = v3d_priv;
 
 	ret = drm_sched_job_init(&job->base, &v3d_priv->sched_entity[queue],
@@ -198,32 +237,9 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	if (ret)
 		return ret;
 
-	if (has_multisync) {
-		if (se->in_sync_count && se->wait_stage == queue) {
-			struct drm_v3d_sem __user *handle = u64_to_user_ptr(se->in_syncs);
-
-			for (i = 0; i < se->in_sync_count; i++) {
-				struct drm_v3d_sem in;
-
-				if (copy_from_user(&in, handle++, sizeof(in))) {
-					ret = -EFAULT;
-					drm_dbg(&v3d->drm, "Failed to copy wait dep handle.\n");
-					goto fail_job_init;
-				}
-				ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, in.handle, 0);
-
-				// TODO: Investigate why this was filtered out for the IOCTL.
-				if (ret && ret != -ENOENT)
-					goto fail_job_init;
-			}
-		}
-	} else {
-		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, in_sync, 0);
-
-		// TODO: Investigate why this was filtered out for the IOCTL.
-		if (ret && ret != -ENOENT)
-			goto fail_job_init;
-	}
+	ret = v3d_job_add_syncobjs(job, file_priv, in_sync, se);
+	if (ret)
+		goto fail_job_init;
 
 	/* CPU jobs don't require hardware resources */
 	if (queue != V3D_CPU) {

-- 
2.54.0

