Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AB410F626;
	Thu,  9 Jul 2026 14:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EmUreBF+";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B465610F621
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:58:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso17975155e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783609080; x=1784213880; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+yIuIbKcmnvIo08VDFmWOFm6XPoaJaRYxeqX9lrp9Y=;
 b=EmUreBF+h40nCJ2rqyVD34+ThmrGGMxhjcSSO/KML0ikJdWeS4/M5UCr9riCVXK2My
 o2c80hgAyR/o69+FsiqEoyLYVNtkQeI4vnAwNqACehkCiakwtpwfOCyefNOu87YlSrTD
 1ZbyprSw4e92r0POLISW0TE026aSK7jvPgEa1pAPdOSK/eUx1kXnzJztk9RYBQ+AQI/0
 uAYiuGYoyGZrO6MJSYGrEMdUsXKldd1EMm3Sg7C5eVWWsj6bY6aNRyGyV0/2UJs1IznU
 8Zl6kIGgmTTUFPgYvHS+BFHrMD7/zaaKzAbl/4y3ggFexAwwNyRPYeH8r2MUre7lH8nf
 9zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609080; x=1784213880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+yIuIbKcmnvIo08VDFmWOFm6XPoaJaRYxeqX9lrp9Y=;
 b=LmPh0shRRkj709HV/HgWCT5S320C5h045TcPo49fzzMC+NSFUDUdb3cZDCAP1g1Kxt
 XKro59SOSHBsJzuifp7DpbXKoJoAh68oc3vzzMqPruUPsSZyJe4wXywf1RvMRGQYwNqd
 szv9qm7GqvpM7VNvBccSJRTPPfnzEajZHqvJX/MLPQpob03R4CEGwyYL4cQg9Iqmesuc
 94uwuYph4O3zYAHuUJHts0tz/duDADlf6M4WVAnL4a/tHOr6iWRrZ3tao0fn3qBOVIcF
 5EUvHVUUuEAxI8LE2YSs0dRaefXeHUgJakqoxAczK+7Zl7QQOLK1YcT0NfR/39GZZcvo
 4jjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiBJwW3PLEgxTQU7RWSznrzJ00pem9DMvn3AMLTYp62XaVA+tiB8lpgV9IdOxrInz4NbBYED+MPRU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypOOu3hB1lyLE0kJWNKmsMm15i0KauvPQ0cw4fqoH0masXo2cF
 NzBq/pJ0l6cYNhWgfKsbTS6lFgfexHXx7Sp1MGoRua31Dril/B95QvIm
X-Gm-Gg: AfdE7cmTxkae+QgdxCoaezVyYfOP7e4KV2FqG+4rDfT4Clv1wqzQtsF1S5rlPrrWFDg
 5dp9FB+iGvtoK9T2CbkQPZXjTaJS8tEozlEP+azl8DwahcWCTBlD8EJssvHP3t/4u5ugvDZ2209
 zxheLGnf3+K4YdPpeuxJrA4R7ijtWdjVewghk3MX+hIud9zp40rjSnoDFWrYlDDOZc2gByJxLJi
 Xi6ulEaXxrOFHEq+Fx1d9yILMMc12aq1mr+kP66EwAqA0KZ6qO9LMknQSsaJ4Rc7VbLvfmTGe1R
 qGNRJI5ZQS+m9v39KAo/UUl0xH6WQjwqCnFKd1lcHLaGGn18lVuFCJS+I2Ablph0FfTZP0aNr5X
 aaGWzrLVc50to3GK3i60/ZvgFmcxIkEjY7nyq1eJogw/gldnUb0A+db7OTf0PzXQshCj/mWSDE9
 YQXRrI5Cvs5EsPHGk1+0bME/tuvhIyui5JFU6ZUoDnnchyHbKi0q69hoFeXLeXtC6FD/5S55DVA
 Rcj3KXKN9rrLe0cKhtnWCXggwOHSKUemQ==
X-Received: by 2002:a05:600d:844e:10b0:493:c785:e0d7 with SMTP id
 5b1f17b1804b1-493e68e7612mr59863285e9.28.1783609080000; 
 Thu, 09 Jul 2026 07:58:00 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a572c3sm162226435e9.1.2026.07.09.07.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:57:58 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 09 Jul 2026 16:57:46 +0200
Subject: [PATCH 2/2] drm/etnaviv: Add GPU reset counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-etnaviv-reset-notification-v1-2-64c617496958@igalia.com>
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
In-Reply-To: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
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

Add two counters and expose them through GET_PARAM: a per-GPU counter
that counts every reset of that GPU, and a per-context counter that only
counts the resets this context was guilty of. Userspace compares the
counters with saved values: if the context counter moved the context was
guilty, if only the GPU counter moved the context was an innocent
victim.

The GPU counter is per GPU core and not per device, so a hang on one
pipe does not look like an innocent reset to contexts that only use
another pipe.

Bump the driver minor version so userspace can detect the feature.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c   |  5 +++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h   |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c   | 12 +++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  6 +++++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |  3 +++
 include/uapi/drm/etnaviv_drm.h          |  2 ++
 6 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index a27ed014fb4e..14f2fe5fb98c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -293,7 +293,8 @@ static int etnaviv_ioctl_get_param(struct drm_device *dev, void *data,
 	if (!gpu)
 		return -ENXIO;
 
-	return etnaviv_gpu_get_param(gpu, args->param, &args->value);
+	return etnaviv_gpu_get_param(gpu, file->driver_priv, args->param,
+				     &args->value);
 }
 
 static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
@@ -530,7 +531,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.name               = "etnaviv",
 	.desc               = "etnaviv DRM",
 	.major              = 1,
-	.minor              = 4,
+	.minor              = 5,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index cba4323ae589..fbbb0544130c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -34,6 +34,7 @@ struct etnaviv_file_private {
 	int id;
 	struct etnaviv_iommu_context	*mmu;
 	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
+	atomic_t reset_counter;
 };
 
 struct etnaviv_drm_private {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c314b3cb5e70..4253560caa14 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -39,7 +39,9 @@ static const struct platform_device_id gpu_ids[] = {
  * Driver functions:
  */
 
-int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
+int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu,
+			  struct etnaviv_file_private *ctx,
+			  u32 param, u64 *value)
 {
 	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
 
@@ -167,6 +169,14 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 		*value = gpu->identity.eco_id;
 		break;
 
+	case ETNAVIV_PARAM_GLOBAL_RESET_COUNTER:
+		*value = atomic_read(&gpu->reset_counter);
+		break;
+
+	case ETNAVIV_PARAM_CONTEXT_RESET_COUNTER:
+		*value = atomic_read(&ctx->reset_counter);
+		break;
+
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 5cb46c84e03a..a5d7c2158eb5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -148,6 +148,8 @@ struct etnaviv_gpu {
 	u32 hangcheck_primid;
 	u32 hangcheck_fence;
 
+	atomic_t reset_counter;
+
 	void __iomem *mmio;
 	int irq;
 
@@ -204,7 +206,9 @@ static inline u32 gpu_read_power(struct etnaviv_gpu *gpu, u32 reg)
 	return readl(gpu->mmio + gpu_fix_power_address(gpu, reg));
 }
 
-int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
+int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu,
+			  struct etnaviv_file_private *ctx,
+			  u32 param, u64 *value);
 
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 139e6e38784b..398608009924 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -79,6 +79,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 	if(sched_job)
 		drm_sched_increase_karma(sched_job);
 
+	atomic_inc(&gpu->reset_counter);
+	atomic_inc(&submit->ctx->reset_counter);
+
 	/* get the GPU back into the init state */
 	etnaviv_core_dump(submit);
 	etnaviv_gpu_recover_hang(submit);
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..977f6ae82fae 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -77,6 +77,8 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
 #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
 #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
+#define ETNAVIV_PARAM_GLOBAL_RESET_COUNTER          0x1f
+#define ETNAVIV_PARAM_CONTEXT_RESET_COUNTER         0x20
 
 #define ETNA_MAX_PIPES 4
 

-- 
2.54.0

