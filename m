Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B43EF34C5C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7877E10E4BC;
	Mon, 13 Apr 2026 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S1Iia3Vg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CED10E4BC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cZkXQOqtnn1thtKZuXMHHG0DG303nuxGs6n8tbRtYlo=; b=S1Iia3Vgxnbvc9c1Gf7RVF9wYo
 mFOQZIlzqiY+q+8Ca8c7DbstjKZXW/V9/Jwu/9zFlqV8SL5iwXthyU7S+K5d1VFgwwV4/R9cjvEDJ
 0myK+oDv7WfR/q9ykqHWPImBpOQ8HfDAzwlOHF3nmJXrl+HCA4i52mgW86q02wmmLa1XwgkA8/g55
 Qbsxd8JY/WVzWul9LgPkvYiukyaaTDei+ClBo/3pJt6m3NyNgKB0ete8AI34Yofwyruk0aFHszGAo
 LPt4OgnBMq5LuyG2uuTQCiBF52VwqxX+2Lq3Hgu7etNwTMgQrZgdAQ/NuwM6eveifgtXIX51kBZVK
 jKlNOcqw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIrB-00FSq1-CM; Mon, 13 Apr 2026 17:05:45 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:20 -0300
Subject: [PATCH 05/10] drm/v3d: Extract v3d_job_add_syncobjs() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-5-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=jWHwRQ8AMZCH6MIULF6Ha6m/rbTAKBlg+10hgNsHcw4=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtxpJEWMg1gtdKwDnvQsixan2v0p4Tnxgcs
 nPcdp8DkTOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qtjEB/9iarjI2i8iD7iB9D6X7GUNVnYcIy9Ro2jUuRapQK2nmOEfYhPrk78BOQZ9dF3fUR2Bkgd
 4ihuQboS0iRbJc3w31l5Jft4QfY3UX0G8xGlnVLl2Q02Fb48a3rqQtIyYfZqFTt5zNiiAsA6xVP
 /s6sG2pQQDsvAhRusuqYr10TTJSDrdh4H8tywD/7/yd5kjcO1KEpTdfNhqycKcDJgLfwvWF0aHx
 bXTEl/L1myaBUvtEWhAe0UML7pi4nV9yd6OqJ6cc6p9ZuYy3VNiVfEQntABzDiZxxhDwVjEtmP0
 2dXfCXRouy87DIzcYR09bsibR+LhgprKMOnB1K3DY6z8pYTv
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
v3d_job_add_syncobjs() helper. No functional change.

This prepares for the next commit which changes the error handling, and
for a later consolidation that separates job allocation from syncobj
attachment.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 71 ++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index f75da2e3533e..054367ba533d 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -162,14 +162,52 @@ v3d_job_deallocate(void **container)
 	*container = NULL;
 }
 
+static int
+v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
+		     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
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
+	if (se->in_sync_count && se->wait_stage == queue) {
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
@@ -180,32 +218,9 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
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
+	ret = v3d_job_add_syncobjs(job, file_priv, in_sync, se, queue);
+	if (ret)
+		goto fail_job_init;
 
 	/* CPU jobs don't require hardware resources */
 	if (queue != V3D_CPU) {

-- 
2.53.0

