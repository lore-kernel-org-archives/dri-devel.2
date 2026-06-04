Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F2DCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAAF11A0D2;
	Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJKEdKxE";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BBD11A0CF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:03 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so412903f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581181; x=1781185981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peByEg9qkw/NuaYmCEAUEFnpiWasS3prWUS+hf7e7ys=;
 b=LJKEdKxEZogg+mOdxV4Y35/Mo2b25gEd6X4UW6UCp242+NBEjBFq/72dZDn+KEVebD
 m7yKzRKq/OyIRV7CspxC1mNbDWNeD0I+nutzoGoHz5BIn+Xn+02Flc6uzeJfIrGnSHce
 9pNy6zhWnNGODjHoPd3FjoizE5qUQpCj7v6f6kawsyK9YaizFR9RbtHuzx2pebsriRqT
 YoRcAWs+fmdokso3E4BWXb7zAcOXZ6H7eSmPWlzdm3/0gdG5WtWw6W9U9i6fQ07cgm7c
 sqmIxmxyGmOsmyNyNgmosmrsKU+e8DFluDM1rFjY99d8iMmVfBgG5lF3ZEDIh3589S2Z
 6U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581181; x=1781185981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=peByEg9qkw/NuaYmCEAUEFnpiWasS3prWUS+hf7e7ys=;
 b=jNYH9sgMyn2HQoQtdcoL3luwKlu9Fh4Gm18QpuiGghfXcOexSJZhS2jzFOhc4Z5ylt
 OR9KCd48MMvLmSTBv7EohJk1S5MG4Fk4riFuLhvBnVcI2uP2dni01x8h1QUilMp14pLG
 7KQ4Fkp9FUkv3iEwR5CCE/PG6kqF4lzd+hWYHWuTjr6PbdfjWAWYuEljbFX30OdUxH5R
 oJpgE1UjpeRF5YLkc6A2D6NF/7LEQCny1vn2g4PYyvyAc5JY/hXoteUavp4biVvj12b8
 ae0rUaV1VO1ce24Zsjfwk9co4GKA0Z+a/h7caOqQ4bCDYQ6U82KaR20Ou0XIYo1u4gSq
 1PBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7O6Lct8XEj9zmbv7HFiGCMILf+zAObS7WSoGqPiGdA1+JEmxuEu1NOwwXCxnhf5FQ20j5ImCr04Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2JS51/6okYWM/Un+tnhX9TiUMEahN0SzLEoNlyx2vO9EJyE5R
 E5f4SQaRZQVt/Y8T+W4n2LWtqgQPROqRJLkNWcQp6/5LS+7WHZ5oLvLM
X-Gm-Gg: Acq92OHGC342M5e3E/gWRpFkFX2HrihyjL9iiMtFlFeyy+p3UN9fQZTvyw+sLn+67f4
 CS0/y1DLpmNrSNao1EmO0mI3bELo/7k/fLkdrb2hzK+pNYfuIBXBPlD/OjQXsZgmgIZZNTzEuLT
 wSSeRpL7WVe2jC+0m4n2hN+SHeKOoV/CAM9lfxaJQXO7Kd628d/HQE7iktgIfiCMj6Xe9A65eFF
 9XqfGad0Zfeto8JgqCoFLCR/Z+2kL0PHlQNRklFORVJ9ci+Sma16FZ7J1itOxmCR/krPMFlEf6Y
 ENSCFWCQ5O+NYH3uSldWENBZ76FlNiyQIAlnjdoXvxDGUd4bsB9OZDmYh4HbsCm+dIZEUyka3yN
 YjF1kMmShq049bRfY45ZVytF13vUz7D6HpHXetgNDdVFHRrnXbjUHF3s+Gt/BxQaHEqQ+W+Oosw
 d+TqC37E8jKgT0UV6Z2W54yl7e6eiJkhjTlhjRIKMVaUaZoBtm2b9jxpDr0ydXMPY=
X-Received: by 2002:a5d:44d2:0:b0:45e:9431:ee3c with SMTP id
 ffacd0b85a97d-46021792538mr9334388f8f.10.1780581181471; 
 Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/9] accel: rocket: Keep the IOMMU domain attached
 across jobs
Date: Thu,  4 Jun 2026 13:52:51 +0000
Message-Id: <20260604135255.62682-6-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

rocket attached the job's IOMMU domain in rocket_job_run() and
detached it again on every completion and reset. Each attach/detach
toggles the rk_iommu stall/force-reset/paging handshake, and on
RK3568 the NPU MMU is idle between jobs, so that handshake times out
and logs a burst of "stall/paging request timed out" errors for
every job.

Attach the per-context domain once and keep it: track the attached
domain in the core, swap it only when a job from a different context
runs, and detach it at core teardown. A reference on the attached
domain is held so it outlives the job that first attached it and is
released on swap/teardown.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  6 ++++++
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_job.c  | 27 +++++++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index a8de876365873..634f78dfe2887 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include "rocket_core.h"
+#include "rocket_drv.h"
 #include "rocket_job.h"
 
 int rocket_core_init(struct rocket_core *core)
@@ -112,6 +113,11 @@ void rocket_core_fini(struct rocket_core *core)
 {
 	pm_runtime_dont_use_autosuspend(core->dev);
 	pm_runtime_disable(core->dev);
+	if (core->attached_domain) {
+		iommu_detach_group(NULL, core->iommu_group);
+		rocket_iommu_domain_put(core->attached_domain);
+		core->attached_domain = NULL;
+	}
 	iommu_group_put(core->iommu_group);
 	core->iommu_group = NULL;
 	rocket_job_fini(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 66d138a8ed773..05a197a9c0113 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -42,6 +42,8 @@ struct rocket_soc_data {
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+struct rocket_iommu_domain;
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
@@ -56,6 +58,7 @@ struct rocket_core {
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
+	struct rocket_iommu_domain *attached_domain;
 
 	struct mutex job_lock;
 	struct rocket_job *in_flight_job;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e25234261536b..b248371be8a1e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -9,6 +9,7 @@
 #include <drm/rocket_accel.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/kref.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -314,9 +315,26 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	if (ret < 0)
 		return fence;
 
-	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
-		return fence;
+	/*
+	 * Attach the job's IOMMU domain only when it differs from the one
+	 * already attached. Re-attaching per job toggles the rk_iommu
+	 * stall/reset handshake on an idle NPU MMU, which is slow and
+	 * noisy; keep the domain attached across jobs instead.
+	 */
+	if (core->attached_domain != job->domain) {
+		if (core->attached_domain) {
+			iommu_detach_group(NULL, core->iommu_group);
+			rocket_iommu_domain_put(core->attached_domain);
+			core->attached_domain = NULL;
+		}
+
+		ret = iommu_attach_group(job->domain->domain, core->iommu_group);
+		if (ret < 0)
+			return fence;
+
+		kref_get(&job->domain->kref);
+		core->attached_domain = job->domain;
+	}
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
@@ -340,7 +358,6 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 				return;
 			}
 
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
 			dma_fence_signal(core->in_flight_job->done_fence);
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
@@ -376,8 +393,6 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	 */
 	rocket_core_reset(core);
 
-	iommu_detach_group(NULL, core->iommu_group);
-
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

