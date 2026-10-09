Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A27CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967A6112106;
	Fri,  9 Oct 2026 12:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ANIOo3qy";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CD1112106
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549319; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UAszmpnfdylCgyYJm/TiY8w1DpZsBoytL/NN/79nbEi0TZz/Smz1mEY/gJq/w06JxzKaEi9qKfyOIbfmjf7is59Y7ORoj4hOaclcQF/fzrQA1HPwhxrNEk0u8+n6q3ZSHBGrbDU7RtMFm9iD4EV09oiRBumkO2o1vxf+qpuli/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549319;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tW7ZGdBI0CeTF9WeXr+7R/B9XC2tuQnNlaOB3VCmv/E=; 
 b=WfNL0NCS32QW+7ZqY/gIwF3V9+tDTh3AZ9OadBTiWiOiSqc+2NNwQTuCaeFogBJLXoIq8wzAHSfcUCp1u/iCzwWNmt1nEqckQkZL8tn3636JkHnPOcT0MD4cLTGfuE232zKXWRqGAymrsKgtMRHn1GuQpeSNR0t4AnDle5tdWM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549319; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=tW7ZGdBI0CeTF9WeXr+7R/B9XC2tuQnNlaOB3VCmv/E=;
 b=ANIOo3qyvJkOA33PSvAclxZLPujHMdzLtsL4zNth/j2DSoOt/CbJPyN8/UeIpLMq
 AnuOM6BKiW2GMjg5+SGkm6jvcDGg2xkcV9xuolFuyd27aVUYcOXG6elWR2p0aGzk3nh
 4p+t+awUEPvtIJTOJdQ/HZ0K+qdM5bl6cw7FaTWU=
Received: by smtp.zohomail.com with SMTPS id 1791549317570662.3179738267629;
 Fri, 9 Oct 2026 05:35:17 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:34:01 +0100
Subject: [PATCH v14 14/15] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-14-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
In-Reply-To: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
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
 bh=c7X8b74ywjqaJw1xMOJ/QyyXlM602ll9atW8Djb3EBY=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8vIOIPlICOK8nRjj6eEvBWErC+UD37KPTz+
 ZgCFD355SyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLwAKCRAOJn5M7lND
 PfmUC/0SOl0G8MM+spU8X6B/kbpvjC0NW5Woltb7jrxXO+akNPGTiKjXmX8nBYlFEcfE3kkYvjD
 +a5gs9eR60jYdUFCdHK4kz3Yrl4MOUzlPXJCTeV4Zgg28ATMS2FK1o04NhYTaNGXvWLkj4FnvBz
 kFo478wdEUteQkrZguBVfY8zQX2n+HwB0JHJ5pcT0ZbCkaoc/mcgY/TYyIvFwY0qDuUENMW0lr4
 kf77dgj03hhI6QI3y7SvvrUX4o3bqz8WBvYrhckASi7YP40hkuGASx7UDALRFMj4ZX+jdQjEaZb
 kcWqBa9ksIEFlKIYAo6gpg285UMQZBS7iQ5+1BXfdQ+XB01ah5VWZsJhlsou40DasWzg3GHnP9M
 52d/OWzlf0U3e8ZiqSsffe1SRiwKIfFQhARhyEXVAJOmtua3SfuC5PYnsIMHY9VIrmLxubibU5Z
 l3pbVv3gehVkJmNHiNdztBQzVIB9CD8YaCEXAf+OwGXoFvUG5wj5aiipi7m06vtanwtF8=
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

