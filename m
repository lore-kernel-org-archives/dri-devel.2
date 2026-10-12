Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA8CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0872710F1C4;
	Mon, 12 Oct 2026 14:49:36 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F2110F16D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816564; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B28XMG0N6utzSHtCQjE9L/EDaZWxrzT17+qY2GuXS18BCqKzxLcERvtDeVd1YJBtCsxiJ5GliqVy8w3hCYXJJLqDkYQvkwtPW6Ak/SSnTTH+XFg4p12TryeZXP9eafiXNTqEIq7yyROZLCyf5H/QTrWvCcKsK09KcJIWoXx48bk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816564;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=A5wyoAMpxyMonqK0K1X78lmaHacA+hX6YDZR4Ynb0YY=; 
 b=YP9idSO7tJirp941/ll9R5zNh8jhfjRq3RP4Q+tY0BGC7oisTF0lqEq+9q6NHVzAjXWjY3c88HQsW+VXniLUBaPXbR46WIhmNryvn+z/VFOIkEdLXW1STbq/4T9XOdAElsAfTUPq04vE/DxDGu68rv79AgWVF9bZAcBfXAiRbOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816564; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=A5wyoAMpxyMonqK0K1X78lmaHacA+hX6YDZR4Ynb0YY=;
 b=aKIxiOSKTe5qfudCU0+MKy3l6qbbuDFU5slwAuCEY7ic7lWmSMh7d0SQJalbrSPE
 gNVK5D9WOacFPiQ/7xSoLuOxF5Ms4W3MKPosc52ruiT9o5X6jLqfeArEbDT/MgCKRlW
 N5oCQJdalXQ65h0CWuW0vnuoIyarn/KDvnuyJFmg=
Received: by smtp.zohomail.com with SMTPS id 1791816564016320.2120801123739;
 Mon, 12 Oct 2026 07:49:24 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:48:06 +0100
Subject: [PATCH v15 14/15] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-14-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Cf1r5q0nDCBQw5k8kELolo3xi5/jIRp3reOvG17DeHI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMbSyXdvEhZDZjiexQtKVqltdRWu+LR3FqDP
 0HxDWcIfw6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGwAKCRAOJn5M7lND
 PYbEC/4lU3jShNSVQUgV9bHKQK/ax3fBZJTnbrUjAKflUlBXkBrsVRNUGYUgimgZ2/7YFKGV8aM
 clLkVb6K1juElEGtrWcDUcuxAJD2UGlZlaaqOb3UDcuAbC8mGZSLalHxZHX/+TLIMFE7jSn8CBn
 9AWEig7wwp4/aKd2yj3xEu/xKeZyfxK6zVCQBP/hAFxhARp304thIzWgMMafhWvQRHJ74WKGmlN
 JJHMRDUHPRsO1SX3My91hegEnlhKrBnQdVZ1N+0FCt01gE40CeXgICawPbynoJkyaeDI9g7JC6n
 WV+syWe4vgtNbBmPBz613rVpnYDC1S3WvWlDXu4gw3kNsdm2zsE0sg3RcYUIGSMKIMPTsbYRjaU
 rCCD7hXNYntwaiJdqi+CEcRA9JfP/ZHaTvrVyQEo8J2gMBN1KSSypfypWNzKjoU/LXoepfIAb9G
 6s5RKNg6KPPAvXZ/QEMTzSNi5xoIz8+/UMyU0eKH1LAI33RKrgiXM/n6xKKeNXYarpp/Q=
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

In order to avoid accessing HW register while a reset is ongoing, a
read/write semaphore that envelopes the reset sequence will help driver
entry points avoid racing with it. For now, the only such racy entry
point is the ioctl that returns the current GPU timestamp.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b3dae6ce3eb0..5718e8185427 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -509,6 +509,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
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
index da10eee85ca2..a141a41e224b 100644
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

