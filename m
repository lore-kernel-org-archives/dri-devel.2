Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45007C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84AF10EA4F;
	Wed, 29 Jul 2026 02:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fIPmPzgQ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BB910EA4F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293705; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lh80LjnU0HlaUxC/93bRp1SHYIrHpUupfO/p/5dS9M87PWLLVcDV+Ge2cSHCINlfQSyhG22+r3toWslE8+cmcB272wXQynYhgdUJ8COl3OZszzMSTvMxebkKRz3PQahwdT7gaiZzD6E/CM/1MsDlMYljMnspv3Mq2Z7jFJKV8Ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293705;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3qgDQ3rUjvL+eb8I8XqukOtYvP/7VixYHtbf1CqS7dw=; 
 b=D312AZKO9BFWiKTAQXAWpptmksEGGy10h0g4xfg3FYAJrrlEPV9VyoXaoU5do6fF0Guzl//OOIuVoSEWQajqVv9Ad8Yh17G1Y7dIkSzMh/AkE/bunI13KppMmXH01baeuW6yb6htDUelskxMmxlnSAI9hQyN6CYocjwpyh3FXaw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293705; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=3qgDQ3rUjvL+eb8I8XqukOtYvP/7VixYHtbf1CqS7dw=;
 b=fIPmPzgQIi8/WRi8rcgYELzVR1omFOhUdxLCLEjroGZKUDCWvMcAWYcDTxGdVZ8P
 w09crDk9MNUZoK0uerzDFR8SendrIfvLIDyjL8aM1bP7/2/hyXGVpRG2ek15oaX+NKz
 QTRHNSNEzXjeSJMJQ43ndlDT4Krgz3JoQx80JuXk=
Received: by mx.zohomail.com with SMTPS id 1785293703305223.904484387485;
 Tue, 28 Jul 2026 19:55:03 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:20 +0100
Subject: [PATCH v4 08/13] drm/panfrost: Rewire reset sequence to avoid
 concurrent attempts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-8-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=EOBTYehPZP710M/xi1UXjadKS0g0JvyEZbZf3MSq+lQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtXQoZW+u1WMJRSfvxmK/c2SNjVN/Al3Nye7
 Th+PajF8z+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 PezLC/0TdqAardxYoauuQreof5sGx8AKWrzieJ9vhVTvBlFlrWHQruMBcuxM2lVVePD4WVRB9Fr
 zwFknCHYQ0oKsuzSex8lO4zc7JqcFuxdKjztiMGPSeYmY3e/e69ZACmby8qstE5j4TkFHJcAOE8
 ypq5GxIDlqh3w8Sr/UTCLNnIZbihtb/lX9msvVi9McuRVcw3RuieWrwAEdhXzB/13pXvuF+uYxZ
 rpotS61pZDzKw1gUKBXEOus5JvvhV6X/nRLJrhs/uAQiiWXOQuCkPoZpHMOhUbIY9Gs8BR5vmSP
 kyq86yjfXTHpaRQS5Jda0XioPIHBLDstG0ytiXbdRozUcP8JD2mL5qYY0pFMt9lIaYwHzPrCyFI
 2xDAUBiXD9Mt/G3zzDaXWsXVrTOmoYultqr58mYhSldkQD+uts5kyD1RdArzEykueSybzyrkx5j
 QUAsBhh2Wfa080fqzAKh1UYkx3Pj3JCBjYgyWVa60c7l7mgq9P8FNh3z9R89YjnwKFk7k=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

This way, and in imitation of Panthor, only a single reset thread can
progress at a time, and other threads wanting to trigger it just wait
on the ongoing one to finish and wake them up.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 +
 drivers/gpu/drm/panfrost/panfrost_device.h | 5 +++--
 drivers/gpu/drm/panfrost/panfrost_job.c    | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index a9d29d9ee22b..a51f1ef8563c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/wait.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index eeca57efcbec..f0acfc634cd4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -167,6 +167,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		wait_queue_head_t wait;
 		atomic_t pending;
 	} reset;
 
@@ -341,8 +342,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 static inline void
 panfrost_device_schedule_reset(struct panfrost_device *pfdev)
 {
-	atomic_set(&pfdev->reset.pending, 1);
-	queue_work(pfdev->reset.wq, &pfdev->reset.work);
+	if (!atomic_cmpxchg(&pfdev->reset.pending, 0, 1))
+		queue_work(pfdev->reset.wq, &pfdev->reset.work);
 }
 
 static inline bool
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index bda1494eb430..ed8a1fabd47b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -499,10 +499,8 @@ static void panfrost_job_handle_err(struct panfrost_device *pfdev,
 
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 
-	if (panfrost_exception_needs_reset(pfdev, js_status)) {
-		atomic_set(&pfdev->reset.pending, 1);
+	if (panfrost_exception_needs_reset(pfdev, js_status))
 		drm_sched_fault(&pfdev->js->queue[js].sched);
-	}
 }
 
 static void panfrost_jm_handle_done(struct panfrost_device *pfdev,
@@ -757,6 +755,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	panfrost_jm_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
+
+	wake_up_all(&pfdev->reset.wait);
 }
 
 static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
@@ -893,6 +893,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	if (!pfdev->reset.wq)
 		return -ENOMEM;
 	args.timeout_wq = pfdev->reset.wq;
+	init_waitqueue_head(&pfdev->reset.wait);
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);

-- 
2.55.0

