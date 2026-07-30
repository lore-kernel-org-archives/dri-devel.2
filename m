Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E819AC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6C710EE0E;
	Thu, 30 Jul 2026 08:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iW9t9G2s";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A37110EE0E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:04:15 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso278112f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785398654; x=1786003454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIA2ESPy6hD2IsIBmPf7dAgmgpqiiLji99VHkKcY/l0=;
 b=iW9t9G2s0nQ37A6+ffLfqiC6/HztE50B0ZMr6pSWjebD9XAxzLNyNnoIzUDWP5Ridq
 7GeTEKtGyF0kMcK7eMU7h4pvWzQ20t/D4afMyqm6EIWs8rCSEhQ4GIPO8CG2eUiDYfbp
 8Gy6UNBe59pvXZT3UEnHtxeEcOMjXIHiEs5J6w3YBbl4JqH36ZLtsxZf9OhDOZGNcaUB
 8xS+CcviVGsHouUCTf3NKdlyrNpu8PvLOyusDu+YYjg8B0NgXgbMzEe/koL0W4NFOdYB
 0RHAHTRTHttOuuvSh2tGJ08spAZRmF5PhehquqL9NkY8X1NvMIs8M4mbrr4mn2XM36QM
 zHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398654; x=1786003454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CIA2ESPy6hD2IsIBmPf7dAgmgpqiiLji99VHkKcY/l0=;
 b=pn1CPISMRW6lvlPJ6ZVsdoTVHYNpcbqQIhl/8PojK0p7hiDg96NxSwkxQPZkc4tvTy
 sIGh5y4tJGqM/PzS9Tmb6HxyqMeKorTmkt1aiuaTXGp8v28HB4aHBUYddmP7xXQOtFO7
 doLQRAaSSa6hVqF0GUWvskAdCS1kyYWQlqQdvup1c8BEr0PZy58OAq/Vvsnd7pSd6M44
 pxAU2kPA9bnCdtFeTyIggioxa/GXL5mG+apChZYW8Uh2CJizABmojue4HHP680k5/AOj
 /sjwY8mIy4FTRooVB53uyLgjVK59OZtYKX+gMki6Hy6vV/NkO3cB3TNg9mfNIcN8JQoI
 GAIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6GZ0w2f/6zu2S5kg3UV0f/t+wFBcvXXPdXcRAuV0Ocko+XTJiPQtQSDoUS2vbf0UN4y/4sJXf4QU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu9CN3rqzWJ5ZSdpgP0eo07qxyOtn8e++/kTjXSU53t0EO8+Hs
 qFCcK8mLWN00hXW3y4nAatzfvHXF/WGdqZjWMc/OcFMPWa7BEW6YJWt+
X-Gm-Gg: AR+sD10VIhSYaL+naNN+zRY5ap00VSXQAMLASTrPcC5YZ1RMSUp21ljum3Z4/JgoI5n
 1Pfon36wS0VunZZTUN5ICrW7Fk6oRvCEGiJulSl4MmMfUm53o6BignSgFfZxHYYQYXyf8atJwKF
 snhewyHgNy/nihPduFhsjDZ816AM1dIrSj95LHWb4GvUsHRk7YnNPCxohCS4g3OzBls0v9hCJ/j
 rOneZAAMpWZYLV2w8IqrTxnEwwXwrp8nDpmT+3pWePm73IuSIBosvOsi8ba2ao8JTlKFFkAyj9x
 dlTuk6/B9jPT99IFB7hN0y9zuLHDHmX+Idor1lcI7PknzvgWgyjl7XDdD0BFyiap0PYlOkB2Go8
 bpPO6U+k/5iEOGAGdQuBStZ4zsvNEUxcJkDR3BmSP+4unw5ivhXv8jRzHxaUaOUiVojz98/+Cc1
 NfLYTN643hAU/6WYRR3L37lyZ/42NYnmP4GQv3nLYenpGTGt6wqRy2ia7UM/PDGQ/BPyKX0Kt5J
 xebZ1IQfhe/hV6hO+YtMY/x4Y69PGUQ/1X3D/LxXrnpif7fi+vh1WyPON0CM4e0mjfwoXN/1rIJ
 a3z2hQ==
X-Received: by 2002:a05:6000:2401:b0:47f:96bc:e370 with SMTP id
 ffacd0b85a97d-47fc832f362mr1869383f8f.4.1785398653062; 
 Thu, 30 Jul 2026 01:04:13 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8A5A00BF2D55A7591B4173.dsl.pool.telekom.hu.
 [2001:4c4e:1b8a:5a00:bf2d:55a7:591b:4173])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e4055sm3347685f8f.13.2026.07.30.01.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:04:12 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 2/2] accel/rocket: keep core slots stable across unbind and
 rebind
Date: Thu, 30 Jul 2026 10:03:54 +0200
Message-ID: <20260730080355.177422-3-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730080355.177422-1-royalnet026@gmail.com>
References: <20260730080355.177422-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The shared rocket_device tracks bound cores with a single counter and
uses it for three different jobs at once: find_core_for_dev() searches
[0, num_cores), rocket_probe() inserts the new core at index num_cores,
and rocket_remove() only decrements the counter without clearing the
slot.

This bookkeeping falls apart as soon as cores are unbound in any order
other than strict reverse bind order:

 - unbinding core 0 shrinks the search range, so the still-bound core
   at the highest index can no longer be found: its runtime PM
   callbacks start failing with -ENODEV and a later unbind of it is
   silently ignored, skipping rocket_core_fini() entirely;

 - a subsequent bind then reuses the index of that still-live core and
   overwrites its slot while its IRQ handler (dev_id points into
   cores[]) and its DRM scheduler are still active;

 - rocket_open() unconditionally uses cores[0].dev, which after an
   unbind of core 0 is a stale pointer to an unbound device.

Give the array a fixed capacity (max_cores, the DT core count already
used to size the allocation) and make .dev the slot-liveness marker:
probe takes the first free slot, remove clears .dev after
rocket_core_fini() and warns if the core cannot be found, lookups
iterate the full capacity, and rocket_open() and rocket_job_open() use
only live slots. num_cores keeps counting bound cores for the
last-core teardown check.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Unbinding a core that still has jobs in flight has further
pre-existing issues (scheduler and open-file lifetime) that are out of
scope for this bookkeeping fix.

Verified on RK3588 (Orange Pi 5 Plus): out-of-order unbind/rebind
sequences (including the previously corrupting unbind of core 0 with
cores 1 and 2 still bound, followed by rebind) now keep all three
cores findable and functional, with a MobileNetV1 inference run via
the Teflon TFLite delegate bit-identical to the stock driver
afterwards.

 drivers/accel/rocket/rocket_device.c |  2 ++
 drivers/accel/rocket/rocket_device.h |  3 +++
 drivers/accel/rocket/rocket_drv.c    | 32 ++++++++++++++++++++++++++++----
 drivers/accel/rocket/rocket_job.c    | 11 ++++++-----
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1..8303f05 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -35,6 +35,8 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
 
+	rdev->max_cores = num_cores;
+
 	dma_set_max_seg_size(dev, UINT_MAX);
 
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662ab..7fb6a9d 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -18,6 +18,9 @@ struct rocket_device {
 	struct mutex sched_lock;
 
 	struct rocket_core *cores;
+	/* Slot capacity (DT core count); slots with a NULL .dev are free. */
+	unsigned int max_cores;
+	/* Number of currently bound cores. */
 	unsigned int num_cores;
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index d29c5ee..04c1e47 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -69,11 +69,21 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
 	kref_put(&domain->kref, rocket_iommu_domain_destroy);
 }
 
+static struct rocket_core *rocket_first_live_core(struct rocket_device *rdev)
+{
+	for (unsigned int core = 0; core < rdev->max_cores; core++)
+		if (rdev->cores[core].dev)
+			return &rdev->cores[core];
+
+	return NULL;
+}
+
 static int
 rocket_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct rocket_device *rdev = to_rocket_device(dev);
 	struct rocket_file_priv *rocket_priv;
+	struct rocket_core *core;
 	u64 start, end;
 	int ret;
 
@@ -86,8 +96,14 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 		goto err_put_mod;
 	}
 
+	core = rocket_first_live_core(rdev);
+	if (!core) {
+		ret = -ENODEV;
+		goto err_free;
+	}
+
 	rocket_priv->rdev = rdev;
-	rocket_priv->domain = rocket_iommu_domain_create(rdev->cores[0].dev);
+	rocket_priv->domain = rocket_iommu_domain_create(core->dev);
 	if (IS_ERR(rocket_priv->domain)) {
 		ret = PTR_ERR(rocket_priv->domain);
 		goto err_free;
@@ -179,10 +195,17 @@ static int rocket_probe(struct platform_device *pdev)
 		devres_close_group(&drm_dev->dev, rdev_group);
 	}
 
-	unsigned int core = rdev->num_cores;
+	unsigned int core;
 
 	dev_set_drvdata(&pdev->dev, rdev);
 
+	/* Take the first free slot: cores can unbind and rebind in any order. */
+	for (core = 0; core < rdev->max_cores; core++)
+		if (!rdev->cores[core].dev)
+			break;
+	if (WARN_ON(core == rdev->max_cores))
+		return -ENXIO;
+
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
 	rdev->cores[core].index = core;
@@ -210,10 +233,11 @@ static void rocket_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int core = find_core_for_dev(dev);
 
-	if (core < 0)
+	if (WARN_ON(core < 0))
 		return;
 
 	rocket_core_fini(&rdev->cores[core]);
+	rdev->cores[core].dev = NULL;
 	rdev->num_cores--;
 
 	if (rdev->num_cores == 0) {
@@ -234,7 +258,7 @@ static int find_core_for_dev(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
 
-	for (unsigned int core = 0; core < rdev->num_cores; core++) {
+	for (unsigned int core = 0; core < rdev->max_cores; core++) {
 		if (dev == rdev->cores[core].dev)
 			return core;
 	}
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff..680f943 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -276,7 +276,7 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 {
 	unsigned int core;
 
-	for (core = 0; core < rdev->num_cores; core++) {
+	for (core = 0; core < rdev->max_cores; core++) {
 		if (&rdev->cores[core].sched == sched)
 			return &rdev->cores[core];
 	}
@@ -498,16 +498,17 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 	struct rocket_device *rdev = rocket_priv->rdev;
 	struct drm_gpu_scheduler **scheds = kmalloc_objs(*scheds,
 							 rdev->num_cores);
-	unsigned int core;
+	unsigned int core, n = 0;
 	int ret;
 
-	for (core = 0; core < rdev->num_cores; core++)
-		scheds[core] = &rdev->cores[core].sched;
+	for (core = 0; core < rdev->max_cores; core++)
+		if (rdev->cores[core].dev)
+			scheds[n++] = &rdev->cores[core].sched;
 
 	ret = drm_sched_entity_init(&rocket_priv->sched_entity,
 				    DRM_SCHED_PRIORITY_NORMAL,
 				    scheds,
-				    rdev->num_cores, NULL);
+				    n, NULL);
 	if (WARN_ON(ret))
 		return ret;
 
