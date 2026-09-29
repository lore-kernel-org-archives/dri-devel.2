Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF2AC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432B610EC86;
	Tue, 29 Sep 2026 03:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="T7E5BTpp";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA3210EC85
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653572; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pig2Di1MtBAsHRYtkRI5wBrfOBIRWgI8Rk2tYWTzMdz9MPbifxUnlSI8bItnmu5ke6Qe4MPLnU1dWgwOp8u4D+EmKRscSjONlHOoLLx8tQAdpAnXZ3owUPNqSM6QknPvFtANeooHjc9Ya8RWhFlZHcsP01dB5d3gtcon1vyYjz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653572;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PGYC1+RAA1t3WoR/Q9JkVn0r7cZa44wIWzONmz89MXo=; 
 b=ZlQhdL8YFpKiUTvrAZP/IhPKgzmtSyBE2BkL1oV2mjfOIbnWs9PFNTkTGT8JSFsZMCL6Zgq9h4VgXviotNihLK4T8veQJhNl3dUuHqSTzkeQb+eXqdmITw9Z83zoInaCxkZw6puurgjmRXKMiaDSAxSforEDveZ83SzYNF4ThQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653572; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=PGYC1+RAA1t3WoR/Q9JkVn0r7cZa44wIWzONmz89MXo=;
 b=T7E5BTppK491IaSEa7NOwwURzVEPekbwkWQydgx7SxYDbRj4A1U1Pn1RWbH4Iahf
 tgkcEmyD1Q6LGwSgxYVgHSTVMF5KJFKSNFk4pm4Ix5SO2QArLxBkxzeLt7+OsB1aU3o
 P+S4WX6p3p5HjHhfLO0z7M0rAK0+41hzJ6WfkCC8=
Received: by smtp.zohomail.com with SMTPS id 1790653572038847.5483224327797;
 Mon, 28 Sep 2026 20:46:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:48 +0100
Subject: [PATCH v12 14/15] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-14-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=KZALWi/C4HH7TdOr6TLMixyrUMu1e01/ALtKYhFOl0A=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQuxMfb0mXyUlMAw7bufElnTkKQP0evlJhr3
 k/JlVz931CJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LgAKCRAOJn5M7lND
 PQRiDACcE369A5GpLVTp3KXrAC9c3YqpQqujDSzOWMYDWbDYTtmsfsGjljXBXQ1TUxHCvUHqrya
 DDa/dhk1lTE5mQtOzjOo7QV4ZGovhsWfDKroLgQJ5AinK6MGM298Yn/K6UQrUim8JO/kCP6IgAA
 /GTwm/cjuKvWco5GeUMsmMpnhD1P6rwBK/4VEEeNdR8DUkQL+WqEDv8EypH9ni4XZ7pD0U+gtu8
 VzsLwK06yHi7RXuGVa5RHhc9pL/FnJsLZTSqiguYRIDWMZyOMYQWc24gsHL3CMR8QmW1L7mAUcb
 Kfhs1DRimOnuPO5eeabhgeMckXkw8WITpYKiGbnAOBlwIBD51R0pSxDnTXIGX5JXGE5eCl01SHg
 D0wQTBTkW/jpQNXBmiQW5KPNtVGAQPSpv5SlIUNRbBZugy3Jtb1zpv97ocdJrc0+/2VD66kj3xG
 e0KKVcBKTsqG7YyGzmIddmdM0KhPESbeSHSuRfblsYXqDihGM4anZq2A5ZrCo5jYQ4DKc=
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 94d2de341838..80d8f6aed090 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -481,6 +481,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
+	guard(rwsem_write)(&pfdev->reset.lock);
+
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index a0b9a2145fc9..63452febb1cf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -165,6 +165,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		struct rw_semaphore lock;
 		atomic_t pending;
 	} reset;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index f77780c72a1a..571a26b84126 100644
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
index ab65786bf63b..4ddf4b722ddf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -877,6 +877,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
 	mutex_init(&pfdev->sched_lock);
+	init_rwsem(&pfdev->reset.lock);
 
 	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
 	if (js->irq < 0)

-- 
2.55.0

