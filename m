Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73FC98307
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F1510E925;
	Tue, 22 Sep 2026 08:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZCPk1n4";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0010E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:32 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cfbdac7a1so1756295e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064091; x=1790668891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pp6BX0mvVT2CZt7W5iAnQc+T8SkoWRi5DiwXWjU82F8=;
 b=HZCPk1n4arvU3t8IvaCOn0CXttH3JNFsLMOIhscCp6+vMGs+1OVOhBVRL5RsqlNcxv
 FdoLh7r++gWg9CKDVb4Yqr8500yft1iLRnZ1c7j+Fiva2RXEMczw7Bi2oJXIEDnzD3NS
 WtlSAKg+YkCcfuI5hZ/cTgTV3nfIsPZtRiJ/Cm2sR/Myij1o6aiB9p+xD8TtX/z0zBHO
 kq0jbg9wTvE+e6VKS+PbuDq6XCN7icH6wHNDNh8pFRy4LM3jvkTMicVUDV/FFIT1zuNk
 Pqql/YtI46TLam1rTEgWeT6+MKqJUeBn3Pa9J08Xyg2h8YW3pVIr9po1RCddbxQzcMIk
 Ga8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064091; x=1790668891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pp6BX0mvVT2CZt7W5iAnQc+T8SkoWRi5DiwXWjU82F8=;
 b=hZk+itomRPDH7bVX/IGMAyyH5gvyYenZYulAdooVAnaxjmZOggcanGqInbFdlxZmgn
 cFLb20z4NEumVY3B+MjxOWH5ekBzJIg7doRgeth5notDV6WhSDxFCvsdbTzl5DR/XIRA
 uNpNjQvGodCLmw4D4M+q8Yjb895wMTngMBMLKU/kFg0i0Zlozx8hyT71NoM29mUWsXY3
 0PhffxeUsM/Ti9Du2+Z9VYn7OyHF6Y2KT24GYIa3sMUyVFyOqv+aSuESXdZXkqW9Xtuy
 +s63yyECbn8dytY2e+uNI6Jffw7kIrwnio93kurj6BoN4OYUUWDUk8t1sok96pBL8v9d
 vqJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFFR61dFxkT9CGua1cul9qrmjShFT72+Jn1CJiie4YXE1HOjYvQSTZnpLh9ZJtJKDJt3pVvyG1OiI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nzsmIuciD7BLhpB6C+wQNcKlc0SQt84mI5d1ooZg3oTd4ByvDa
 QjHlZ4O4GnfxQhwh4mWyJLfR3jlA3zTe3TqOW+dIRjoEx5ddBZ+Lt3Ho
X-Gm-Gg: AYBFou1zZ6fG9oFv/nLtgXSvngPLhGEflPkKPdPd8Lbcjcr/pw0DPoxh92tFNzlswKu
 9n6mPW1CntKqXoYCE1be/6qv4ArQhlG7yrPfZzfSG1Nq8LkglPdPCjOquoX1oR0r7g3QZrajq48
 mKBQD2FHVCaMURsAUqyXNQIslMUHkdHKR52d3Cf3zjYRZ3pFri54XglROp8nP9Hipgi3zO9RJAr
 rpng5L8RJ6wgwTxSo6UETK98YRWpgejk7rCegBxHdm3jMFQLFkgR0SqP4n1qgBv6h4dCuqtZqds
 h+S31o3kLuZ9cOzEmxIHdCGGN6IBexYow3olyUox+y7y0x+auiQh7RCU1JzJTn/ywILKPsA2xKv
 0aDd8kmBBo8tqGxlpWocpIdRGS7KKlFHGNZSadJWBOn/CvJobDdPrWyTHmLFUICe0MGiTgyEGgs
 y6S9BjuzysGaDVF/e3xRVI8dg1KZ9Bn4kvgrnHYAMqz42AF3HZNBOUZgRhXxaEOur4Bmqrp43Sx
 rQHo9zBViQ5qZhXOVQpXMgLfs1T6K2R8b4BwKO0YGzWvGO8Xd/fypdiRRm1oGm5yXYt3dfoZDxp
 oBNHAbnJZbqxYmo=
X-Received: by 2002:a05:600c:6992:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49fc7b7a756mr226927785e9.0.1790064090983; 
 Tue, 22 Sep 2026 01:01:30 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:30 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 04/11] accel/rocket: keep core slots stable across unbind
 and rebind
Date: Tue, 22 Sep 2026 10:01:07 +0200
Message-ID: <20260922080114.44662-5-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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

rocket_probe() inserts a new core at slot num_cores, and
rocket_remove() only decrements that counter without clearing the
slot. That falls apart as soon as one core is unbound while its
siblings stay bound:

 - the next bind reuses the slot of a still-live core and overwrites
   it while its IRQ handler (dev_id points into cores[]) and its
   DRM scheduler are still active;

 - rocket_open() unconditionally uses cores[0].dev, which after an
   unbind of core 0 is a stale pointer to an unbound device.

On an RK3588 with three cores, unbinding the first one and binding it
again puts it on top of the third:

  rocket fdab0000.npu: drm_sched_init: scheduler already initialized!

One device now sits in two slots and the third core in none. The next
unbind of the first core finds its stale slot, torn down already, and
finishes the same scheduler a second time:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : drm_sched_fini+0x4c/0x1e0 [gpu_sched]
  Call trace:
   drm_sched_fini+0x4c/0x1e0 [gpu_sched] (P)
   rocket_job_fini+0x28/0x60 [rocket]
   rocket_core_fini+0x4c/0x78 [rocket]
   rocket_remove+0x78/0x110 [rocket]
   platform_remove+0x2c/0x68
   device_remove+0x58/0xc0
   device_release_driver_internal+0x214/0x2e0
   device_driver_detach+0x24/0x50
   unbind_store+0xd8/0xe8

Make .dev the slot-liveness marker: probe takes the first free slot
and clears it again if core init fails, remove clears .dev after
rocket_core_fini() and warns if the core cannot be found, lookups skip
empty slots, and rocket_open() and rocket_job_open() use only live
slots. num_cores keeps counting bound cores for the last-core teardown
check. A missing core is no reason to refuse a new file: the device is
one core short, not gone, and any bound core will do for the IOMMU
domain, which is attached to the group of whichever core runs a job.
With a single core live the scheduler list that drm_sched_entity_init()
does not keep is freed at once, as rocket_job_close() only frees what
the entity kept.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v3, now in this series:
 - rebased onto the three fixes before it: "accel/rocket: search
   every core slot when a core is removed", which provides max_cores,
   "accel/rocket: number the cores by devicetree position, not bind
   order", so a slot no longer doubles as the hardware number, and
   "accel/rocket: search every core slot when looking up a scheduler"
 - the crash above: this is what the devfreq patches ran into when
   tested on a kernel without this one
 - free the scheduler list when a single core is live
 - Cc: stable
v2: https://lore.kernel.org/r/20260731064933.12548-3-royalnet026@gmail.com
 - also clear the slot's .dev when rocket_core_init() fails (Jiaxing Hu)
 - check .dev in sched_to_core() (Jiaxing Hu)
 - document the synchronous-probe assumption at the slot scan
v1: https://lore.kernel.org/dri-devel/20260730080355.177422-3-royalnet026@gmail.com/

Unbinding a core that still has jobs in flight, or that an open file
already holds the scheduler of, has further pre-existing issues that
are out of scope for this bookkeeping fix. One of them, a use-after-free
under KASAN, is described in the cover letter. The driver does not
serialize probe and remove against open; this does not change that.
For stable, this goes with the three patches before it.

Verified on RK3588 (Orange Pi 5 Plus), 7.3.0-rc2 drm-misc-next plus
this series, in-tree rocket, all three cores enabled: 25 rounds of
unbinding and rebinding all three cores; 4 rounds of unbinding a single
core (twice the devicetree-first core, twice the second one), each with
an inference run while the core was absent and one more after all four;
5 rmmod/modprobe rounds; 3 unbind/rebind rounds and 1 rmmod with the
clock raised to the 1 GHz OPP (CRU selector on the PVTPLL before
each). No "scheduler already initialized" message and no
oops; the regulator user count returns to its boot value after every
round. Without this patch the same single-core round oopses in
drm_sched_fini() on the second unbind, as shown above.
The single-core, full, rmmod and raised-clock rounds were repeated
(10 full rounds and 3 rmmod rounds this time) on a KASAN and
PROVE_LOCKING build of the same tree: no report, and lockdep still
enabled afterwards.

 drivers/accel/rocket/rocket_device.h |  2 +
 drivers/accel/rocket/rocket_drv.c    | 55 +++++++++++++++++++++++-----
 drivers/accel/rocket/rocket_job.c    | 38 ++++++++++++++-----
 3 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index c62d567010696..abb88a254e569 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -18,7 +18,9 @@ struct rocket_device {
 	struct mutex sched_lock;
 
 	struct rocket_core *cores;
+	/* Number of currently bound cores. */
 	unsigned int num_cores;
+	/* Slot capacity (DT core count); slots with a NULL .dev are free. */
 	unsigned int max_cores;
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 7d927bb6b322d..b9b36c578db20 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -68,11 +68,21 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
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
 
@@ -85,8 +95,18 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 		goto err_put_mod;
 	}
 
+	/*
+	 * Any bound core will do for the domain: it is attached to the group
+	 * of whichever core runs a job, and the NPU IOMMUs are all the same.
+	 */
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
@@ -199,10 +219,21 @@ static int rocket_probe(struct platform_device *pdev)
 		}
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
 	rdev->cores[core].index = index;
@@ -210,13 +241,18 @@ static int rocket_probe(struct platform_device *pdev)
 	rdev->num_cores++;
 
 	ret = rocket_core_init(&rdev->cores[core]);
-	if (ret) {
-		rdev->num_cores--;
+	if (ret)
+		goto err_core;
 
-		if (rdev->num_cores == 0) {
-			rocket_device_fini(rdev);
-			rdev = NULL;
-		}
+	return 0;
+
+err_core:
+	rdev->cores[core].dev = NULL;
+	rdev->num_cores--;
+
+	if (rdev->num_cores == 0) {
+		rocket_device_fini(rdev);
+		rdev = NULL;
 	}
 
 	return ret;
@@ -229,10 +265,11 @@ static void rocket_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int core = find_core_for_dev(dev);
 
-	if (core < 0)
+	if (WARN_ON(core < 0))
 		return;
 
 	rocket_core_fini(&rdev->cores[core]);
+	rdev->cores[core].dev = NULL;
 	rdev->num_cores--;
 
 	if (rdev->num_cores == 0) {
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 4bc4f9c8ee403..25ee4ab172a82 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -284,7 +284,7 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 	unsigned int core;
 
 	for (core = 0; core < rdev->max_cores; core++) {
-		if (&rdev->cores[core].sched == sched)
+		if (rdev->cores[core].dev && &rdev->cores[core].sched == sched)
 			return &rdev->cores[core];
 	}
 
@@ -511,22 +511,42 @@ void rocket_job_fini(struct rocket_core *core)
 int rocket_job_open(struct rocket_file_priv *rocket_priv)
 {
 	struct rocket_device *rdev = rocket_priv->rdev;
-	struct drm_gpu_scheduler **scheds = kmalloc_objs(*scheds,
-							 rdev->num_cores);
-	unsigned int core;
+	struct drm_gpu_scheduler **scheds;
+	unsigned int core, n = 0;
 	int ret;
 
-	for (core = 0; core < rdev->num_cores; core++)
-		scheds[core] = &rdev->cores[core].sched;
+	scheds = kmalloc_objs(*scheds, rdev->max_cores);
+	if (!scheds)
+		return -ENOMEM;
+
+	/* Only the cores that are bound right now have a scheduler to offer. */
+	for (core = 0; core < rdev->max_cores; core++)
+		if (rdev->cores[core].dev)
+			scheds[n++] = &rdev->cores[core].sched;
+
+	if (!n) {
+		ret = -ENODEV;
+		goto err_free;
+	}
 
 	ret = drm_sched_entity_init(&rocket_priv->sched_entity,
 				    DRM_SCHED_PRIORITY_NORMAL,
-				    scheds,
-				    rdev->num_cores, NULL);
+				    scheds, n, NULL);
 	if (WARN_ON(ret))
-		return ret;
+		goto err_free;
+
+	/*
+	 * drm_sched_entity_init() keeps the list only when it holds more
+	 * than one scheduler, and rocket_job_close() frees what it kept.
+	 */
+	if (n < 2)
+		kfree(scheds);
 
 	return 0;
+
+err_free:
+	kfree(scheds);
+	return ret;
 }
 
 void rocket_job_close(struct rocket_file_priv *rocket_priv)
-- 
2.43.0

