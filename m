Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AD6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAAD10F83B;
	Fri, 10 Jul 2026 09:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YYUX1FYA";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C4910E162
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:00:55 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso385879f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783674054; x=1784278854; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d88mOIKGx152JzuQ0UteO0AFL78iVyam0iMSZwLmwFs=;
 b=YYUX1FYApUXmvHeCuJDQ5mymhehd+P1y+SHbGYz1Azu4RVEl21+hBMNptz5Y4QWMzs
 0LP3Lzao8vKfG2wIwGChEpJcVO/BPyxAiFiY9MV1Bvl0WOgc/5po8rFLjQkGjNp7YtJD
 y+7twBEI8GLP8Qj70mcFbwXu3jDm8yhUGdxebs+iUBAZDondiymr0VTakuO9DF8pkk6r
 3EnMKWLJJAMhufDOgZaV6NPdmRjj1upJy6jjifd+d5R5l0J8XWH0GDAAVhvzOiENF33P
 4h4P5k7I5QtPECa5IX31Gn7rcijNU1OrVLFBh0qnaKuy22ojtimxZvT8W1vu/YtNmQfL
 FLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783674054; x=1784278854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d88mOIKGx152JzuQ0UteO0AFL78iVyam0iMSZwLmwFs=;
 b=THJ/03IBPl9H0hCJM1Yle41TplsVCwSCwpoerulzKx1uG0/Ta6wU4fQI/p531IHfVG
 ufHoiiUQxE4MUJh1TqvnwS9GedIXd687I57MmhIg/fc5eaWi06XEu5uMsnUYdFZHiLyX
 LYZFUGkZCBl+fzk3Eq0hMJJ2JOwchmPIBawALDe7dvQ9vb4kEO86Eogl9G1cLlUVJpJ/
 d4QFJSyJCYqGvdIQsIcxzIaJQgRAWmr/Kc5lZ5zgvIALUZOFZItXZqrCV0ZhH1+8g+US
 w7b5OArGKhP99km7an4LEmzEspB8P6PB3evkd+rnKr0Id7BL60+oWgHYsIQaTvSCH9FQ
 e9rw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc5cP1cnSZuS85f/cqQKWyN1cSa3tMBgPTl3X968ZlSlAXX0BhiILP5VV/uh9Z+cT1Za60Zm4o58A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ5GF1cpQtztABZrMjj1f18vjiJFZvcPCrynL4Wm+a7GkdSl6r
 Lz+bHOKt80TWfNa/T5qhZJ7tyLN+SuzMtejNV7z/RpPmUZ+h3/B05q1XVRD9FFEe
X-Gm-Gg: AfdE7cmHlhqMvXxgUlQ4i1IoNl67yXS+Fs7S9j2czSJJloeh5IjQck6ERJesb1Ysvqj
 iKXyo9mYf6gY48Uv0Us0sUXIdkUVuQotvCR08m6tOBPrze48MeLowZdqjUgf/S8jIUm5ebs8enw
 A1HLG/HjHS/qwB1mXU3o77LwiSJoZVwI0kRyZ9EsgPi/vImWhKV4LCcTctLVfA48tibnDEsRuBY
 kYt+uMB4le1milH/bgVafxoCjvVqIpBhLNLfm0wRyl97M/S9jTx6WfUjdsronSBpVW6nNVfCuDz
 0wLBZTeNh9qPwgn7iH2nVEI3Bd+6yWdwJXHKjWijGI29zQ01A2RKK9+af1Xvn8bUt1HExhAkvYJ
 Zt1KhsHqo0rWlO07XvYbSv3t1tzRZMx4J6N/LeZ4JEqSWLUzn4wBGUEATajyb+1EErBzCOC4/8K
 v9ICGbNyEUav6vlG8sf0Gu3lbr8QD1f+sPwGbxYNA0LUiGvwYQmeR7yAZLI+Gtv6NInGTgAI4Ia
 CcfXN6/wEcOyOzcZAy8U1DSiW5pUx1hGg==
X-Received: by 2002:a5d:5f89:0:b0:475:e3fe:8ac3 with SMTP id
 ffacd0b85a97d-47df07a9573mr10109183f8f.8.1783674053704; 
 Fri, 10 Jul 2026 02:00:53 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm59386076f8f.22.2026.07.10.02.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 02:00:52 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 10 Jul 2026 11:00:47 +0200
Subject: [PATCH v2 2/2] drm/etnaviv: Add GPU reset counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-etnaviv-reset-notification-v2-2-90cfebcf22a2@igalia.com>
References: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
In-Reply-To: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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

From: Christian Gmeiner <cgmeiner@igalia.com>

The OpenGL and Vulkan robustness extensions let an application detect a
GPU reset and check if its own context caused it, so the application can
drop the broken context and build a new one. The kernel knows both
facts, but etnaviv has no way to report them to userspace.

Add two counters and a RESET_QUERY ioctl that returns both in one call:
a per-GPU counter that counts every reset of that GPU, and a per-context
counter that only counts the resets this context was guilty of.
Userspace compares the counters with saved values: if the context
counter moved the context was guilty, if only the GPU counter moved the
context was an innocent victim.

The GPU counter is per GPU core and not per device, so a hang on one
pipe does not look like an innocent reset to contexts that only use
another pipe.

Bump the driver minor version so userspace can detect the feature.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c   | 27 ++++++++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h   |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  2 ++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |  3 +++
 include/uapi/drm/etnaviv_drm.h          | 19 ++++++++++++++++++-
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index a27ed014fb4e..a48698463fc1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -296,6 +296,30 @@ static int etnaviv_ioctl_get_param(struct drm_device *dev, void *data,
 	return etnaviv_gpu_get_param(gpu, args->param, &args->value);
 }
 
+static int etnaviv_ioctl_reset_query(struct drm_device *dev, void *data,
+		struct drm_file *file)
+{
+	struct etnaviv_drm_private *priv = dev->dev_private;
+	struct etnaviv_file_private *ctx = file->driver_priv;
+	struct drm_etnaviv_reset_query *args = data;
+	struct etnaviv_gpu *gpu;
+
+	if (args->flags)
+		return -EINVAL;
+
+	if (args->pipe >= ETNA_MAX_PIPES)
+		return -EINVAL;
+
+	gpu = priv->gpu[args->pipe];
+	if (!gpu)
+		return -ENXIO;
+
+	args->global_reset_counter = gpu->reset_counter;
+	args->context_reset_counter = ctx->reset_counter;
+
+	return 0;
+}
+
 static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -502,6 +526,7 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 	ETNA_IOCTL(GEM_WAIT,     gem_wait,     DRM_RENDER_ALLOW),
 	ETNA_IOCTL(PM_QUERY_DOM, pm_query_dom, DRM_RENDER_ALLOW),
 	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
+	ETNA_IOCTL(RESET_QUERY,  reset_query,  DRM_RENDER_ALLOW),
 };
 
 static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *file)
@@ -530,7 +555,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.name               = "etnaviv",
 	.desc               = "etnaviv DRM",
 	.major              = 1,
-	.minor              = 4,
+	.minor              = 5,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index cba4323ae589..9c348aa7f8d3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -34,6 +34,7 @@ struct etnaviv_file_private {
 	int id;
 	struct etnaviv_iommu_context	*mmu;
 	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
+	u32 reset_counter;
 };
 
 struct etnaviv_drm_private {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 5cb46c84e03a..a97780131426 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -148,6 +148,8 @@ struct etnaviv_gpu {
 	u32 hangcheck_primid;
 	u32 hangcheck_fence;
 
+	u32 reset_counter;
+
 	void __iomem *mmio;
 	int irq;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 139e6e38784b..bd1335a17f46 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -79,6 +79,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 	if(sched_job)
 		drm_sched_increase_karma(sched_job);
 
+	gpu->reset_counter++;
+	submit->ctx->reset_counter++;
+
 	/* get the GPU back into the init state */
 	etnaviv_core_dump(submit);
 	etnaviv_gpu_recover_hang(submit);
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..b50a3a0799e6 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -265,6 +265,21 @@ struct drm_etnaviv_pm_signal {
 	char  name[64];   /* out, name of domain */
 };
 
+/*
+ * Reset status query:
+ *
+ * Both counters start at zero and only ever increase. Userspace saves
+ * both values and compares them on a later query: if the context
+ * counter moved this context caused a reset, if only the global
+ * counter moved the GPU was reset on behalf of another context.
+ */
+struct drm_etnaviv_reset_query {
+	__u32 pipe;			/* in */
+	__u32 flags;			/* in, must be 0 */
+	__u32 global_reset_counter;	/* out, all resets of this GPU core */
+	__u32 context_reset_counter;	/* out, resets caused by this context */
+};
+
 #define DRM_ETNAVIV_GET_PARAM          0x00
 /* placeholder:
 #define DRM_ETNAVIV_SET_PARAM          0x01
@@ -279,7 +294,8 @@ struct drm_etnaviv_pm_signal {
 #define DRM_ETNAVIV_GEM_WAIT           0x09
 #define DRM_ETNAVIV_PM_QUERY_DOM       0x0a
 #define DRM_ETNAVIV_PM_QUERY_SIG       0x0b
-#define DRM_ETNAVIV_NUM_IOCTLS         0x0c
+#define DRM_ETNAVIV_RESET_QUERY        0x0c
+#define DRM_ETNAVIV_NUM_IOCTLS         0x0d
 
 #define DRM_IOCTL_ETNAVIV_GET_PARAM    DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_GET_PARAM, struct drm_etnaviv_param)
 #define DRM_IOCTL_ETNAVIV_GEM_NEW      DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_GEM_NEW, struct drm_etnaviv_gem_new)
@@ -292,6 +308,7 @@ struct drm_etnaviv_pm_signal {
 #define DRM_IOCTL_ETNAVIV_GEM_WAIT     DRM_IOW(DRM_COMMAND_BASE + DRM_ETNAVIV_GEM_WAIT, struct drm_etnaviv_gem_wait)
 #define DRM_IOCTL_ETNAVIV_PM_QUERY_DOM DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_PM_QUERY_DOM, struct drm_etnaviv_pm_domain)
 #define DRM_IOCTL_ETNAVIV_PM_QUERY_SIG DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_PM_QUERY_SIG, struct drm_etnaviv_pm_signal)
+#define DRM_IOCTL_ETNAVIV_RESET_QUERY  DRM_IOWR(DRM_COMMAND_BASE + DRM_ETNAVIV_RESET_QUERY, struct drm_etnaviv_reset_query)
 
 #if defined(__cplusplus)
 }

-- 
2.54.0

