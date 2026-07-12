Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C78C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FCC10E485;
	Sun, 12 Jul 2026 15:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CsV7wOmc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ADF10E489
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WpJAM4RJN1qP6po/8L60z4hc5EbG7DNOg1iGCEEGJCk=; b=CsV7wOmcD7V5ujONWMdCZoGdqd
 yNfSmRVmaSSfajHe6RoVva8VPB3xdapmGteaNEw19r1f4NhxOUpbojli2RgL0KMz23k7xen5pD9Wc
 rPmv25EnDftIZHd9q5byTOATJKnEs7oPK7Lvg9JJqvmGNBPFmq7wCc5R+TVqUAiVeuXG929OXcevL
 tNJWxPKc1gFiDreoWb5nQG2iw1ay70zmJcEF9OiOCQm04LVxV+yua8u9gEQ4tHxPoT4r3476Yw6kQ
 AIXrfVzPexP0kwBlNAyVB18IbqqdTZ9qo+bVIeb65GQWmjm3Y0sHXbDLt29K1pO0Y3DDz0nvaXV8e
 +Q5cbaOg==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wivtI-00DnB6-TP; Sun, 12 Jul 2026 17:14:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 12 Jul 2026 12:14:34 -0300
Subject: [PATCH v3 1/8] drm/vc4: Move vc4_wait_bo_ioctl() to vc4_bo.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260712-vc4-drm-scheduler-v3-1-ed6dc4defa53@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4144; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=0a8T+WH6kAwlO5BzHagz5LB0U3Al0W1AD8t1Gua96Fg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqU69ffxxfVHRFmTOS03rYhXiCAEQTmItyBKPtG
 W2zYCHN4xyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalOvXwAKCRA/8w6Kdoj6
 qsUKCACu65Q6YYfVCZ284viRdke+7SaT4OUdMEMwCVzwtufJuSrRu21HPu+lmxEdIU/hbpH/HmP
 BDr+UUI4d2OnZb2f4AWgduyt4q7wVwXyjOr6qNRFqXWNIspdLMOCgctyBQxz9R5MvwhyYR7lwP+
 vwzIy85rjkJDZ2S8R3SHxKzs3HlGbkNFMn4UrCcIk7UYxYIhA7uAexez7uGGqY7AHZhC8nW9VFQ
 r9yxTJiHpgHJbajFIXRkBaIVoLzhShnSeclaz1jGG3KLuu5FA5Rr7vQWjoV7iJ/fpyp+r3GdjMy
 OGbwJC+CaDwesstApiarjtVx/0N5FS75N0mDDxou1K6fP1Iy
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

Move vc4_wait_bo_ioctl() from vc4_gem.c to vc4_bo.c, grouping it with
the other BO-related ioctls. No functional change.

Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  4 ++--
 drivers/gpu/drm/vc4/vc4_gem.c | 33 ---------------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 2161761b1f22..e2f747c92832 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -831,6 +831,39 @@ int vc4_mmap_bo_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+int
+vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
+		  struct drm_file *file_priv)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int ret;
+	struct drm_vc4_wait_bo *args = data;
+	unsigned long timeout_jiffies =
+		usecs_to_jiffies(div_u64(args->timeout_ns, 1000));
+	ktime_t start = ktime_get();
+	u64 delta_ns;
+
+	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
+		return -ENODEV;
+
+	if (args->pad != 0)
+		return -EINVAL;
+
+	ret = drm_gem_dma_resv_wait(file_priv, args->handle,
+				    true, timeout_jiffies);
+
+	/* Decrement the user's timeout, in case we got interrupted
+	 * such that the ioctl will be restarted.
+	 */
+	delta_ns = ktime_to_ns(ktime_sub(ktime_get(), start));
+	if (delta_ns < args->timeout_ns)
+		args->timeout_ns -= delta_ns;
+	else
+		args->timeout_ns = 0;
+
+	return ret;
+}
+
 int
 vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv)
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 0f5958c1e6b6..fe313027a91e 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -906,6 +906,8 @@ int vc4_bo_dumb_create(struct drm_file *file_priv,
 		       struct drm_mode_create_dumb *args);
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv);
+int vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *file_priv);
 int vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv);
 int vc4_mmap_bo_ioctl(struct drm_device *dev, void *data,
@@ -990,8 +992,6 @@ int vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv);
 int vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv);
-int vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
-		      struct drm_file *file_priv);
 void vc4_submit_next_bin_job(struct drm_device *dev);
 void vc4_submit_next_render_job(struct drm_device *dev);
 void vc4_move_job_to_render(struct drm_device *dev, struct vc4_exec_info *exec);
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index e231c906709c..f0c711f114cf 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -962,39 +962,6 @@ vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
 					       &args->timeout_ns);
 }
 
-int
-vc4_wait_bo_ioctl(struct drm_device *dev, void *data,
-		  struct drm_file *file_priv)
-{
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int ret;
-	struct drm_vc4_wait_bo *args = data;
-	unsigned long timeout_jiffies =
-		usecs_to_jiffies(div_u64(args->timeout_ns, 1000));
-	ktime_t start = ktime_get();
-	u64 delta_ns;
-
-	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
-		return -ENODEV;
-
-	if (args->pad != 0)
-		return -EINVAL;
-
-	ret = drm_gem_dma_resv_wait(file_priv, args->handle,
-				    true, timeout_jiffies);
-
-	/* Decrement the user's timeout, in case we got interrupted
-	 * such that the ioctl will be restarted.
-	 */
-	delta_ns = ktime_to_ns(ktime_sub(ktime_get(), start));
-	if (delta_ns < args->timeout_ns)
-		args->timeout_ns -= delta_ns;
-	else
-		args->timeout_ns = 0;
-
-	return ret;
-}
-
 /**
  * vc4_submit_cl_ioctl() - Submits a job (frame) to the VC4.
  * @dev: DRM device

-- 
2.54.0

