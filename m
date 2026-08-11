Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6285C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F9710EDA1;
	Tue, 11 Aug 2026 21:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="N6GYxQkD";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB91C10EDA1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484589; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fxYmux7KDKo0JelvGsoUZhF08iFyjB0meWrszr1xWSoFepltsUQmil+UAKuIXBqHZbfCxJuVy+YkX4NxDrXFAHLyz1Biyl4hVABVfXszQbsbhYKmjC33looAboBCTpCRBdqeK+e31LwH0HiN7wq92/51oilEKsCut/usV98Lu7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484589;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BhoYIx6OxWdB580Z5qcbi/sQQupdEao2wwujd/LBUAk=; 
 b=iYC+v2hv4Q2EJY8gRXYhm+HDw7BOmtIof8pEyD2XzMgN4znlEDpUBMHp6O5aHZC8+QJewWKLscbmIIDwm+C0OQ8SVYbHRMvikwayngwp5+zwlfjBNqOmVeBRdh83wNOE9RjUmqgQoYuuMcFhHXbg96cyBFSDq/CSN6ttq1jq1+I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484589; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=BhoYIx6OxWdB580Z5qcbi/sQQupdEao2wwujd/LBUAk=;
 b=N6GYxQkDxPWPYxjDsIrAAUG75caNWQpULog8/ZTGwp79IryljN5hMwytknajiTXy
 X62p48zDteNbnKD7kumYpxHxjv/avGl2m5yPRSWo0/Z2R8NqRT9YyrwnRy9rONlBnMZ
 w5Wr9dX9C9S66wu6FJGX74HiiTcoCIah82ZVS7jg=
Received: by mx.zohomail.com with SMTPS id 1786484588194430.315618178503;
 Tue, 11 Aug 2026 14:43:08 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:18 +0100
Subject: [PATCH v5 09/11] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rKhFjLvayP2FIib1Snq96DiehUFdNZVjiraV8+mKivE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czTWX/lic3z1D1NJjyyBzDjAccZcc1cWjAS
 P2RC8/1CByJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PbCjC/90xecD8pLqsd16lmBZpbdIWSffxZg1Scavl74filGbG/XImyChZMq6zN1pdVWDfXp1P4Q
 izqopsEAnA81nfokwoP2uXeuDCFmYxadbK34CcyFJUYPsE6MtDkq3bhsNVWMFjSZ0FJEsjms0i1
 zsF9b4uLML985TQFyEWogcDFOdbzR7hMc1vzb5G37k5KJUKY+2OPVvmb2Y55nnqTZyjPFyo7L0P
 SCBinShYON8CM5mGoCnazp3AUfyRyywI6joVcGlb9ufhF263ylFXWWEoSvNOuRVXborGirFm87p
 1vwQcQL3Sz1RPqot0DV/NqM+8/700ihJg44gPvRpHEvPLfDBTA+k/tmXHdABcLGJsNo3VumUaPc
 np03ie0zdz2B4eQ5C3V01Vj2MLPkEAO5UPhiF0wVEQTvg1YDvyDmVmflSma+C8h+B1+MZqPL/t3
 OTGM1baHOL5xBcXq4hUpv+LreTX9RF2z9zrXSZYKJdXRJhMmyj4iloJtMqvfQynSEQnzs=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 5b66173c75b9..e0390b6c0d22 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -602,6 +602,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
+	guard(rwsem_read)(&pfdev->reset.lock);
+
 	panfrost_gpu_soft_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 4bbaaaf827a5..a2a68e042225 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -166,6 +166,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		struct rw_semaphore lock;
 		atomic_t pending;
 	} reset;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 958f1d36ab10..ff23b1a979bb 100644
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
index c761379851da..9d7dafa29f19 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -874,6 +874,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
+	init_rwsem(&pfdev->reset.lock);
 
 	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
 	if (js->irq < 0)

-- 
2.55.0

