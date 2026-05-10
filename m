Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F320CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E578010E43A;
	Sun, 10 May 2026 22:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iXSnPFFg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911BC10E43A
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3FzBQqlvmae/EF2i8djaQHT3ekHuNg6J5S+OW7g+6a8=; b=iXSnPFFg5lWJ7ysqIiP2otUM3A
 VHmkfS3ovvP8tqq1QI3IyKA6Jb9hgPgHUttAJ5MgGfFgffiQ+dPhXQYsUks5/NdlrKZsW3N5cmUBw
 PodUNc52LB1+YhAAFWltuNa7mFlQsqtjE05p5oXhVop25lhu2DDSnkDFU6WG84hTlbcd6R1ygQ2Yz
 ugx27fWtV0ACVocSrKhgQy/5SmDpDH4aC5WGOeE99cbzBi9ypLI9Fyky0dHtS9d5GvzTjJfashrJa
 a1tegNCndi72/G0R8JwowcNLY4p9UEJK4h1mM4bdZQIS1AcC8iJtk9ZXYT6av/Z7cDyOF8CZxlLk1
 ohCYA4YQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCO1-008k1J-7y; Mon, 11 May 2026 00:12:32 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:02 -0300
Subject: [PATCH v2 05/14] drm/v3d: Extract v3d_job_add_syncobjs() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-5-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=M27jUN+Ep+tBh83MxTeN6CYJ+oydlhA9W7AtvABRsLY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0O0UfhaH9OpWY2iK8WDFBB5OrYcB7ZZr2/
 w4xstqSglWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qp8NB/9tgBhrt+SF1RovFeFQmYmUCrTOLkNZGAS/2rkNyjOZrAX581CV/UwNpAGGXp/uFqmQaYl
 yUPykoNLgnrpKYIO5Ai30obdmdmTuAA6kYGMtZhE0/J+M+plGvT47kSOOlQ1OTfh16hYN8vbVRV
 oSTrUP4ZYbYP6iJoBzTFzqmtuXqwB6X0LzFrnHyHnbExK0mhVAnYvW0BdEmYAU62nP6NN3p+yma
 CXXLjj1vxuUvgmTj8W5YQbm19SvNXnBf7EkSuGRzJ930ECYerSd1mojdyIhiDa6cfz+Er6pgPK3
 Ash7AYp/BR98D9RqwGTY/75gwF5HOa7pIYgdyu4c8dOPuY9N
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

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 71 ++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index d0f949a49dd2..f9231a87b963 100644
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
2.54.0

