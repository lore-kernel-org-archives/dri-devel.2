Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F9AD6AAF7
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4B810F28E;
	Thu,  2 Apr 2026 18:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Qp4MqG3r";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7927F10F28E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/soLfJn3u6dtVuaY/t14yHRGMHkRnZh8mdErGzNmEI4=; b=Qp4MqG3rCQTCaAa/yniWMjo3/m
 eQzaxYV5+3nSCgq2Plufbf37npM68lC4LiXtfnGAltNn3DP7L2qtLS/0GqkelBC9tbmjXja0z3IG/
 qdPvA6i600uZlp84HvLpXgG3+VUqk9BGYBRGEs8VtLeXLSL84PXqCqbp4DxN01xaQ811K+KB7C3Da
 lcvG9SXqHnNVTWmQNUTL6c+u1OWI99fdywOuH2AfS1B5hRQs9EejpXgMAP3qiXN57ysLKKKQ88u/M
 F45k8iaR3ebyncSynaWLMRjwg4WddkIBaq5tT3ZE3Q/BJ5rITGNEqHAHiovgaLbaAMlXiSz8Ef/Gv
 e2NEnCMw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8Mts-00AaZZ-LO; Thu, 02 Apr 2026 20:36:16 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 02 Apr 2026 15:36:01 -0300
Subject: [PATCH v2 1/7] drm/vc4: Move vc4_wait_bo_ioctl() to vc4_bo.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-vc4-drm-scheduler-v2-1-d84afd35c602@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=MWc60WoQzIM58RbMvOdMq66qIvNONArtn10VambGsSw=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDJnntktU9x0KCjfbfHiXhttB4QuiKw1m5k6ZukYn4b1yk
 NZ1yXzLTkZjFgZGLgZZMUWWH09iaxnFytk1l5VfhBnEygQyhYGLUwAmUijLwbBrVfPpjWkabXoM
 va8XvW/4psCtttM7g8UlycGbk6NO+N3HoMMfFq49oVtTZzvNs2XRqRXLKiL7Dbw2HZTaXhM58eF
 fc7MF/Lp5fXcXFQmUPWUvvzXVTEVS+VDNRCOLWBlTTS2NII/H65WMNi79PVXIR5llv0j3A465Tz
 UuTbTQE5C/bKg73Sor0pRp6wzF8Ctqs7Y1ZVftXvUpp+PBhhaOT+z3r10QUU/dHsWobdq121OPX
 VyPhXd+ldJpj5U5u80sDx5wCHy67euta2m5PQV7pk+q/zfzUTxDcbl1RQmjWa5sXe/D9M98agnl
 7WIzLx9zfNDtVeZ9bb2Y/HXGgPsS+sFPC1Y+2XagT/0PAA==
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
index 355c26581a4167b1ef33970a1fa32d7361719b74..f7a5e4aa71c5d916e66de257ab4d27c8bbe0f411 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -828,6 +828,39 @@ int vc4_mmap_bo_ioctl(struct drm_device *dev, void *data,
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
index dbcc83b7df004519c9c74a618b81877a14796d36..0f2fb035fef177dd446ff8322da2413c861ecfd3 100644
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
index c01cba3acf42d485da2fe8ce7147573687abd4ce..614a2db245636c39855bc10727b62c00a6374f45 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -959,39 +959,6 @@ vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
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
2.53.0

