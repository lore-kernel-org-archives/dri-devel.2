Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF859606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+X4GT4X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C937D1128CD;
	Fri, 20 Nov 2026 10:40:47 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54741128BF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:38 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so6111235e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171237; x=1795776037; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=el1LyCfnrClGpym+h6i1skzP/uh1fnaEtmw/z/26iV4=;
 b=p+X4GT4XzMUR3EWF9lzHh0/l7sabMtEZd+ROYbbDEciwasHvmb9hK+S1iorJ1N8eKg
 3SJNif/f78vN+kmWk/ODua074P3HigPhR5pAM422cYrpjIo2ARMnd0RaHk+4OQGPOTdm
 ZwOH/juaVY2W64kE9sqcBmoWDh6WMt5377P1aaXKqzRKXLdbqJgn59kR8WdRwzaUGoPn
 qGtwkuJJ2MKEaTt2lVC1wZno24mDgBGwV5V5evtRy/2TWRsKzMblOBDY4afFVEGFhvc8
 XRjrmzmPV7SskB3eRxcfp/yQOTqKSB54noA6fOyesynBubhFh7CCtkvKu5pzhl3R2J1s
 zIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171237; x=1795776037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=el1LyCfnrClGpym+h6i1skzP/uh1fnaEtmw/z/26iV4=;
 b=s9tQ7krXABIuOhIbrgMPy+d+0SvaZWnNRTFNMvdfH+ax7yFFoOsoYEi/O4a8kgdGLt
 jU/mdWIuxhdg3TJPBpQE5rTlTcUTbHgpJsZzjh692cNcoDqE+yiKQU3+nat0wsv4onQT
 4gnqplfO96jgAP/T32zqxVQwrxrkRuKNqxCiEfeKeNNhI3Xyu/6u7EMBXT28hZ/PBEmX
 LTlh66dmwMjP9lL7foh5HV/8ORfsQH53tRLg22OdDIVdcFTV63pFAj8Ccvo221vZQSu/
 K+PxeuwQani/V7DoU5LlviStcnpsiovPgwBQ+l1ATIERhSlkVIdXrRdJLdJ8PcSnX9qC
 CPPg==
X-Forwarded-Encrypted: i=1;
 AL+hErHUAy2yKPWwX3PWEiSxhVxPdYx9arNODgjiEsmsIwK7bW+uPWfMxQRxTbXWDoa/MXZzAKemCBgHnRQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8AHEIvgryF2qV4+0O7TBztFUwod5TiWBUw3keG1/ZCs0dahr90
 Nc9aickpAWMl2jVS8vwyI5xVOXFsld2TEuK9vePeb1yJ4JRUQvIRGh9K
X-Gm-Gg: AYBFou14bSVRkYAtpuYCZrA21HQ03DvJS156D/D60wSTn5SKmbGmbiKVIra7y+yKP09
 eC3agOHK/VYLLRwFr5CC4i7Jf5hCKKOXohYXN0+9w3dcXKPejPyE9ZneMZNM2kpV+rJUfS2iwrS
 HFcRRNDScPs1olQVlpnMPAcHe+D3XapA8nw3yivhh1ALYSkgvUg0ZZjlJ84v9wS0iBxIvebhCBn
 p54qPGzx60U2WOdFyMN6SDebGYb///md6LgmT5IozsLN6HkE1Ci3+TEr9UED+5j0C49osu2dGgT
 h26tB/1XmDyHzL/Sw3Aw738VKsKPxmsEzcqeNzsIOG1Erf9OsU+V+aB0ryD2BDe29cZ1jwgVvG8
 J9s9GeR+h12brB53lL5dBq/atLBB8Qdmo2mXzbfc8DgOg/XZf1yr6ES6gc//qIx5+g/0sxXXZek
 8UatIMoN1cdJcMEEKhoZAhmZCLOlSWzf1R6heHLNJybZEmkQkzdY4QBrVIuKYhdfRPL8/qIVyQ1
 x7zrqypoju9pVFJfkpDuTDbfOo+UWfxQFU9KQkW21szKDdGpjCvyOwtFhoJAjcasaLc5WTosoDN
 AIHAa+Oh6msAyueIFuSFDPSyrQ1H09WQ6fmeig5YafO0st3PdlZLgy9a8P3adryjZsb6rudL0bF
 kIGIBq5vQBN2+a9+e0S6dYCpjf9NRUGIoIwxtOYB2kD4lRHxzyDo=
X-Received: by 2002:a05:600c:848d:b0:4bb:6b6b:fbaa with SMTP id
 5b1f17b1804b1-4bb8880fd0amr55521205e9.16.1795171237076; 
 Fri, 20 Nov 2026 02:40:37 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:36 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:28 +0100
Subject: [PATCH 2/7] drm/etnaviv: Register the cooling device last and
 unregister it first
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-2-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

etnaviv_gpu_bind(..) registers the cooling device before the workqueue,
the scheduler and the clocks are set up, and etnaviv_gpu_unbind(..)
unregisters it after they are gone. So a cooling request can come in
while the GPU is not set up yet or already torn down.

With CONFIG_PM the GPU is runtime suspended at these points and the
request only stores the new state. Without CONFIG_PM
pm_runtime_suspended(..) always returns false and the request accesses
a GPU whose clocks are off.

Register the cooling device as the last step of bind and unregister it
as the first step of unbind. A following patch makes cooling requests
wait for the queued jobs and needs this order too.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 42 ++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 2a15ae6135f5..2a56bdf2510a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1808,19 +1808,9 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 	int ret;
 
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
-								  dev_name(dev),
-								  gpu, &cooling_ops);
-		if (IS_ERR(gpu->cooling))
-			return PTR_ERR(gpu->cooling);
-	}
-
 	gpu->wq = alloc_ordered_workqueue(dev_name(dev), 0);
-	if (!gpu->wq) {
-		ret = -ENOMEM;
-		goto out_thermal;
-	}
+	if (!gpu->wq)
+		return -ENOMEM;
 
 	ret = etnaviv_sched_init(gpu);
 	if (ret)
@@ -1840,20 +1830,32 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	INIT_WORK(&gpu->sync_point_work, sync_point_worker);
 	init_waitqueue_head(&gpu->fence_event);
 
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
+								  dev_name(dev),
+								  gpu, &cooling_ops);
+		if (IS_ERR(gpu->cooling)) {
+			ret = PTR_ERR(gpu->cooling);
+			gpu->cooling = NULL;
+			goto out_clk;
+		}
+	}
+
 	priv->gpu[priv->num_gpus++] = gpu;
 
 	return 0;
 
+out_clk:
+	gpu->drm = NULL;
+	if (!IS_ENABLED(CONFIG_PM))
+		etnaviv_gpu_clk_disable(gpu);
+
 out_sched:
 	etnaviv_sched_fini(gpu);
 
 out_workqueue:
 	destroy_workqueue(gpu->wq);
 
-out_thermal:
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
-		thermal_cooling_device_unregister(gpu->cooling);
-
 	return ret;
 }
 
@@ -1864,6 +1866,10 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 
 	DBG("%s", dev_name(gpu->dev));
 
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+		thermal_cooling_device_unregister(gpu->cooling);
+	gpu->cooling = NULL;
+
 	destroy_workqueue(gpu->wq);
 
 	etnaviv_sched_fini(gpu);
@@ -1887,10 +1893,6 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 
 	gpu->drm = NULL;
 	xa_destroy(&gpu->user_fences);
-
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
-		thermal_cooling_device_unregister(gpu->cooling);
-	gpu->cooling = NULL;
 }
 
 static const struct component_ops gpu_ops = {

-- 
2.56.0

