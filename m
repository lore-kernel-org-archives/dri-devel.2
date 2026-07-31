Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E4C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5070910F16C;
	Fri, 31 Jul 2026 06:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QORjj3b4";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA6F10F16C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:50:00 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f706438c3so35923f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785480599; x=1786085399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=894kL84WjsJ4NuY8JNzhxDjW08BYyE5HOdttjtE66tc=;
 b=QORjj3b4uuajpqu86mSVGrT2TmHUb6ZbbmXjdwyJDtaAo0ofa0ceGirqDwXBuUYib/
 RBJDyGA78eSWyUm7NQjsD+dBaa5iyTswTVKGxpxGx7IYZr/8vdMdfCQHkFYu8ajZ5VpQ
 blRQy231YlJgb4am2HCq/jug8lR0TYFR6n1OQ1vvLZ7B2JrVwe1y5JAe1vGVEJEMfLTN
 jAGw1OECu3UwvXUHDHI0LGZYeDa5KIe0qDe+vrbB92oIjxgUvNKudN3zr9Jl4MUa8QVp
 Fer56uW5XCoQET2q8hRF8t1B7TWAm39TTQQeOJQ8s7UjdSna5OuswbSv6Fu3MKXks0xb
 NB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480599; x=1786085399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=894kL84WjsJ4NuY8JNzhxDjW08BYyE5HOdttjtE66tc=;
 b=ZtNUamy/2kNCgbYRcOCxLYGoQlOkaLZOumGt5iYa6okd+IAqkWlQGF535XzbG8owJn
 ppfHHZqyMjYO8VkZD/t/pKCar2hZHyuqVO5l4UJbhAFpSd4KirLm8nYdnryoGepPSBXB
 dBcbflD9zbT/QKCwc4XiL2GqsPllX1SVku8unQlhtnYDSDlyMdHtWmVdn20FCkLsO74Y
 2cl3lEXo+IkirRDyjOApj1sqEs93ne2BPicI2muDZdI8beZWlIWh5sJjd23cglrIIF86
 TosM8FvYKI+bcDjp2A7zUmxlcMhEzcwilVpdBsW3KWz9Q7o1yTJCiyyhhZhjhs7mcaAg
 OHBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9cAXU0yP6yx7B31hZEL8DbpnggSGako/CZRkPhXkDgjvhgIcMLGuWU324rWXZobR3ks8xwBOK8DM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLZXjDtnMSESC9xwm1h3sj82PkDdp1LcxfOc3wokXAC4iwY60Z
 0HkFh0UcErsljFh517mzZgYHYkzFGvEIi4bs2zUqFOJHwvHKuRTjIn7H
X-Gm-Gg: AR+sD11Z0/m0w7ag6s6jQm0rOt68+d/6SSLRrtE9MJMWAvKMaRFhoakVs6Qf36hvnPd
 RxUWzAhGTvADxQbTmwWgAQDK7B2qsYzCTbzamK3dOy6Sh9NYq9jHkMlTxEl/b3lCUAFNQ2FkrOE
 ccogPuvQRQquWEvODRayp0meLsxX+ypttqr+yV0ItPfNcE5DrzPCKt90dhf7HOYO87gxPsNKXL6
 3pNnLGm9aOyHQGSImr94ytOOLgwvFdY7NN1QdNSfBqA1KpSssQbGLkU7sqAiVrvRfMlo/mY1qMe
 cCTWvcobUNa9TjJgs5NytgoCRsT3EtWtLWceIGsb0f+hSHep040Un5O44u+fbnceweeN3DiDs9R
 uyzhTWV/T6DKRO1nYHuzgCyMkuG3M43VtmJVlFbqJX/1iMYq5AzbPeqvXXVwdyZSUw6n8yQbcHW
 GN/dRNSxR670Bxea2FWWbBkZYdnmSpDtQJrCWwi0O6VUo4wcZw1It/mgwU7yfCv8zeqcZIAGsnM
 BRZyRwPpHNqqKhdhwV4vRpfWqkCgdW/5/TVCmouDPR7OQbAgrKhpc7+2K66IfBAc9Fm2A2e4YBr
 JhFW
X-Received: by 2002:a05:6000:41f8:b0:47f:946b:d3fc with SMTP id
 ffacd0b85a97d-47fd2b35e88mr2250807f8f.2.1785480598679; 
 Thu, 30 Jul 2026 23:49:58 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B8B0053881A2C61CA978D.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:8b00:5388:1a2c:61ca:978d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm1212753f8f.9.2026.07.30.23.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:49:58 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 2/2] accel/rocket: keep core slots stable across unbind and
 rebind
Date: Fri, 31 Jul 2026 08:49:33 +0200
Message-ID: <20260731064933.12548-3-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731064933.12548-1-royalnet026@gmail.com>
References: <20260731064933.12548-1-royalnet026@gmail.com>
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
probe takes the first free slot and clears it again if core init
fails, remove clears .dev after rocket_core_fini() and warns if the
core cannot be found, lookups iterate the full capacity, and
rocket_open() and rocket_job_open() use only live slots. num_cores
keeps counting bound cores for the last-core teardown check.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2:
 - also clear the slot's .dev when rocket_core_init() fails: with .dev
   as the liveness marker a failed init left a half-initialised core
   visible to every lookup, and rocket_job_open()'s live-slot walk
   could write one entry past its num_cores-sized allocation
   (Jiaxing Hu)
 - check .dev in sched_to_core() so skipping never-initialised slots
   is explicit rather than implied by pointer inequality (Jiaxing Hu)
 - document the synchronous-probe assumption at the slot scan
v1: https://lore.kernel.org/dri-devel/20260730080355.177422-3-royalnet026@gmail.com/

Unbinding a core that still has jobs in flight has further
pre-existing issues (scheduler and open-file lifetime) that are out of
scope for this bookkeeping fix.

Verified on RK3588 (Orange Pi 5 Plus): out-of-order unbind/rebind
sequences (including the previously corrupting unbind of core 0 with
cores 1 and 2 still bound, followed by rebind) keep all three cores
findable and functional, with MobileNetV1 inference via the Teflon
TFLite delegate bit-identical to the stock driver. The new failure
path was exercised by forcing rocket_core_init() to fail for core 2
with cores 0 and 1 already bound: the slot is released, the device
comes up with the two remaining cores and inference passes bit-exact.

 drivers/accel/rocket/rocket_device.c |  2 ++
 drivers/accel/rocket/rocket_device.h |  3 +++
 drivers/accel/rocket/rocket_drv.c    | 37 ++++++++++++++++++++++++++++++++----
 drivers/accel/rocket/rocket_job.c    | 13 +++++++------
 4 files changed, 45 insertions(+), 10 deletions(-)

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
index d29c5ee..7d71a01 100644
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
@@ -179,10 +195,21 @@ static int rocket_probe(struct platform_device *pdev)
 		devres_close_group(&drm_dev->dev, rdev_group);
 	}
 
-	unsigned int core = rdev->num_cores;
+	unsigned int core;
 
 	dev_set_drvdata(&pdev->dev, rdev);
 
+	/*
+	 * Take the first free slot: cores can unbind and rebind in any
+	 * order. The scan-then-claim relies on platform probes running
+	 * sequentially; revisit if the driver ever enables async probe.
+	 */
+	for (core = 0; core < rdev->max_cores; core++)
+		if (!rdev->cores[core].dev)
+			break;
+	if (WARN_ON(core == rdev->max_cores))
+		return -ENXIO;
+
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
 	rdev->cores[core].index = core;
@@ -191,6 +218,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	ret = rocket_core_init(&rdev->cores[core]);
 	if (ret) {
+		rdev->cores[core].dev = NULL;
 		rdev->num_cores--;
 
 		if (rdev->num_cores == 0) {
@@ -210,10 +238,11 @@ static void rocket_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int core = find_core_for_dev(dev);
 
-	if (core < 0)
+	if (WARN_ON(core < 0))
 		return;
 
 	rocket_core_fini(&rdev->cores[core]);
+	rdev->cores[core].dev = NULL;
 	rdev->num_cores--;
 
 	if (rdev->num_cores == 0) {
@@ -234,7 +263,7 @@ static int find_core_for_dev(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
 
-	for (unsigned int core = 0; core < rdev->num_cores; core++) {
+	for (unsigned int core = 0; core < rdev->max_cores; core++) {
 		if (dev == rdev->cores[core].dev)
 			return core;
 	}
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff..0d8e69e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -276,8 +276,8 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 {
 	unsigned int core;
 
-	for (core = 0; core < rdev->num_cores; core++) {
-		if (&rdev->cores[core].sched == sched)
+	for (core = 0; core < rdev->max_cores; core++) {
+		if (rdev->cores[core].dev && &rdev->cores[core].sched == sched)
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
 
