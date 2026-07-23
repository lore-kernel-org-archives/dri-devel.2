Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DEDC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6D110E61C;
	Fri, 24 Jul 2026 00:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="aos3YuP0";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF5510E61C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851253; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UM99c8mR+8qIUgKSSZPMuEOkd0Zj3XxS/8wSDUMNb5l9OU+Bp909NR5Sc1D3/YzawJmP1KvKrzG16CQO6eMwr4l/i42erGJyHQvu20oUuy9jMRndL2q/nKWeq3mabsjMq9zTo3WY8Z0teLBUrsZLr2paNJDMSfWObchUL0e3aOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851253;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RsNYaAJ+kKhhQUSjH35LyjjXgFps7/JLT+yGcMK5JNg=; 
 b=ndiusHS6PPknarmunP9Dx2jFeM4theEtPCoylrISwu2BRcjv/0N9tAThVuEhVRNVYmfpvJXmhng4STrvpSrcLORsJBHHdqOYH8KWlSsxvhGwrYQDXQBszuIHTIOt98SALWJposLYm7IVgHsgsAA8/HKq4ksnb0KV9I1gC6+qnIs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851253; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RsNYaAJ+kKhhQUSjH35LyjjXgFps7/JLT+yGcMK5JNg=;
 b=aos3YuP0bcwxGKm04sBVUOVZCCUpvd94kESY2LeyAHdS3Elipck4AQX5PsYHhMCL
 Niaqo6S7kUd2Eue2RSpZm2usZf/xGd4OcDB3YRKgKA74Uz4XJJC+Xr7pU5oXg4w8kG7
 us5ldbrq1aS2uHFX6KdN6CAmbMP0fevqwok5yKk4=
Received: by mx.zohomail.com with SMTPS id 1784851252071770.1410402304093;
 Thu, 23 Jul 2026 17:00:52 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:04 +0100
Subject: [PATCH v3 11/13] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-11-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=T7U9edMzpRK9aAMWEZ+SiPKRkqpUPu8BX0k4Qkh2M8Y=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqrpzsCc0sBF7XwP2T4bGezhs9rQQwuTlg/Ul
 LN/8pDcv9CJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6QAKCRAOJn5M7lND
 PW/AC/4qJ7VlVWbGC5aJmjDx3lr1CpgeOsRhwH6FLOL26R4i472gDkyXFiuLkMzr9G3XjJLtkpN
 9nvEZxGF+WnIGFiy45R+rohGuikeoCG8eVeMXZjDHI14OADBRyhudJqv8w20dGXXT2ZtfQ78t5d
 4j7sk3jsTbcpeNbXifs12GcgD/QBcb4ohKJiisrxxsXYZYcXiRYELJ7UABCYRPQNRkGBk369DDp
 l96g8PR9DxPi6Nh8PfD94RMBoliVx/sjFZantHnN9Cf+6isdPMG3MoG78RWF8Vt8yWa213kqC67
 HbU9BdKa8Kqm1shUIfn4xH2PpFxRUByrAjheTjQOg70/yiKtwNfLqspK40rs0kRfI2wA2Bwpm7o
 Eofb6LcUkleXu3uuB+9xmPOH5YXCZwb2aXa+Fd3GrUFYMpXd4k83Y+3Nh9Jq6nNlrhLA32ARC5L
 QnVSHZ/qao6ltKuEchIWEkVxzRBDKy68jvLeDNuzpC8qwEosWIJL979+cVNc2VJtNAyVI=
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

So as to avoid accessing HW register while a reset is ongoing, a read/write
semaphore that envelopes the reset sequence will help driver entry points
avoid racing with it. For now, the only such racy entry point is the ioctl
that returns the current GPU timestmap.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 80746e375410..46c6e911e562 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -617,6 +617,10 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	int ret;
 
+	/* Pre-reset */
+	if (panfrost_device_is_initialized(pfdev))
+		down_write(&pfdev->reset.lock);
+
 	/* Do the actual device reset */
 	ret = panfrost_gpu_soft_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
@@ -630,6 +634,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 		panfrost_jm_reset_interrupts(pfdev);
 		if (enable_job_int)
 			panfrost_jm_enable_interrupts(pfdev);
+		up_write(&pfdev->reset.lock);
 	}
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 855ee4d0fb40..7f5202ff6469 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -167,6 +167,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		struct rw_semaphore lock;
 		wait_queue_head_t wait;
 		atomic_t pending;
 	} reset;
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 2490e9785057..e04eb416ea0f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfrost_device *pfdev,
 	if (ret)
 		return ret;
 
-	panfrost_cycle_counter_get(pfdev);
-	*arg = panfrost_timestamp_read(pfdev);
-	panfrost_cycle_counter_put(pfdev);
+	/* We should not read timestamp register while the GPU  is being reset */
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_cycle_counter_get(pfdev);
+		*arg = panfrost_timestamp_read(pfdev);
+		panfrost_cycle_counter_put(pfdev);
+	}
 
 	pm_runtime_put(pfdev->base.dev);
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index c2a1670a74e8..c1d0b111dde1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -895,7 +895,9 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	if (!pfdev->reset.wq)
 		return -ENOMEM;
 	args.timeout_wq = pfdev->reset.wq;
+
 	init_waitqueue_head(&pfdev->reset.wait);
+	init_rwsem(&pfdev->reset.lock);
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);

-- 
2.55.0

