Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E41CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD411128F1;
	Thu,  4 Jun 2026 17:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="RcH9ZAs6";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF481128F1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594582; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fOGm0o6ZsQMFXoV1NSh2cHmRU2R+ZLPd/uhU1jKepAc9gkYOsA4ziYPSp5hiyTJcsBD+wjYFcoKl3a943FzawE9y3nDf26CaCoGMH6PL2cix56L/F8e6TKaS7OlCQzi35/LlATrcUtEZ//xKI6D+Y4KMpMSP/8c4/NqjOs/dcAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594582;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rurijafEhWebG8QZv5/LXjC2OxytpzPuuam2xKhLYsg=; 
 b=FrUh+0ywctz/rdFnHaJKZYDuIzRkJ0rvlHurI9Ac0r6kVyyQFVKpE6prVeUb/OD6+K93XFV0HJ8pUj9xCCASu7+CuB+t2o65GhyveXkW4R7fxs8ghvhzxFHy/8MDRV0a4LBX4mKLeqlenRCRmbB60XSPzEXsaacb4gDjk2EIWHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594582; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=rurijafEhWebG8QZv5/LXjC2OxytpzPuuam2xKhLYsg=;
 b=RcH9ZAs6Av3e2439dJSgMn7v2cRPp3BJMiEzlGv7LnN+QR5sWHvowHEz0P/YR384
 Rhqt/+5YZ4Jq1kjC0dDf4ozmJLw90AwAo8eLq1motB2UzLaVWEIkWYuWFyBHb9kGMHk
 ZVpmLyd5Q7jwhLoqwtMmbp0wVMaPkb354h6zc8P4=
Received: by mx.zohomail.com with SMTPS id 1780594581583372.39106556364345;
 Thu, 4 Jun 2026 10:36:21 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:24 +0100
Subject: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6177;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=WcThKA1a70OHaaKBKZIc8vSUJoYKCiqeinoQG/48rg4=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8sQVSjXK25sayGYU2dMmYbTGhUYmEIevjN
 TtrrmtAIyiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PQfEDACyMaEEnwSjfSeL11KLcFt1dxZI+NIHYjUDFbmxaI8ZYoGwfLR8g2+A15UntOQf0hPa3TM
 Ilof1lNGPnTJ0FZX3HrzngwUMS0W9I6Et13JQDD7ui8cRITcYUjCk9Xngn3YFVRYIi500AnK2zK
 qd8J+ih4fxIYVA1doctVU3reCHtDhGAoX8NU1nXY0MoO+TjSeMnaKsQbYUhjBUWiMWk02QtyV8x
 IJK5fh/wjhiy9ypPY/J7trIkUqAE8Nwo705ndF99bgyFzcU8C9L7D+7+3ge71HupBMNI/DnpQud
 O6crgWQShM01SZMnQFSyZ+YZ15rqfZAGtUgyzkpSKtNGND8pag4ZdsuryYfK1z3JV5UwMOLqZ+A
 LYV4Yn/hr5H6Z+wWrA2fqBHcU0hvuoWcWk0XAK6zFCa4aTr+I26no44jHON8xGnKb6gRNzDA+Vr
 Jy4d3OsjKvbal6feA4XzTCCGOFBM5pVJ+G1l9zQxqzHJOHeTvMkAbU/DdlN7FIEAjld5c=
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

Right now, if there's a HW reset and an HWPerf session is active,
panfrost_mmu_reset() will reset the AS count for every single open file's
mmu struct back to 0, and also invalidate their AS numbers. Then, when
disabling hwperf, panfrost_mmu_as_put() will WARN that mmu->as_count is
less than zero.

Fix this by introducing a perfcnt HW reset path.

The choice was made to render perfcnt unusable after reset, so that a
user might have to reprogram it with a full disable/enable sequence
before requesting more perfcnt dumps.

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
---
 drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 46 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 87b372c9e675..2805d50c1b9b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -426,6 +426,7 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
+	panfrost_perfcnt_reset(pfdev);
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ad1156678e91..c2087ea705fe 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -33,6 +33,7 @@ struct panfrost_perfcnt {
 	struct panfrost_file_priv *user;
 	struct mutex lock;
 	struct completion dump_comp;
+	atomic_t hw_reset_happened;
 };
 
 static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
@@ -57,9 +58,13 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 
 static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
 {
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
 	u64 gpuva;
 	int ret;
 
+	if (atomic_read(&perfcnt->hw_reset_happened))
+		return -EIO;
+
 	reinit_completion(&pfdev->perfcnt->dump_comp);
 	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
 	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
@@ -140,6 +145,15 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 		goto err_vunmap;
 	}
 
+	/* If a reset is ongoing, the AS we get right below will be torn
+	 * down, so rather than waiting until this becomes obvious in a
+	 * perfcnt_dump() ioctl, we ask the user to try again slightly later.
+	 */
+	if (atomic_read(&pfdev->reset.pending)) {
+		ret = -EAGAIN;
+		goto err_vunmap;
+	}
+
 	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
 	if (ret < 0)
 		goto err_vunmap;
@@ -173,6 +187,16 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
 		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
 
+	/* If a reset happened, we've no way of knowing whether it was between the time we called
+	 * panfrost_mmu_as_get() or before perfcnt_enable(), so clearing this flag and going forward
+	 * isn't possible. We must clear the flag and try again in the hopes no resets will happen
+	 * between this and the next ioctl invocation.
+	 */
+	if (atomic_cmpxchg(&perfcnt->hw_reset_happened, 1, 0)) {
+		ret = EAGAIN;
+		goto err_disable;
+	}
+
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
@@ -180,6 +204,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	return 0;
 
+err_disable:
+	panfrost_perfcnt_gpu_disable(pfdev);
 err_vunmap:
 	drm_gem_vunmap(&bo->base, &map);
 err_put_mapping:
@@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
 	perfcnt->buf = NULL;
 	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
-	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
+	if (!atomic_read(&perfcnt->hw_reset_happened))
+		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
 	panfrost_gem_mapping_put(perfcnt->mapping);
 	perfcnt->mapping = NULL;
 	pm_runtime_put_autosuspend(pfdev->base.dev);
@@ -346,3 +373,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 	/* Disable everything before leaving. */
 	panfrost_perfcnt_gpu_disable(pfdev);
 }
+
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
+{
+	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
+
+	/* Since this function will be called either from a scheduled HW reset
+	 * or a runtime resume, tearing down any perfcnt resources means we're
+	 * doomed to deadlocking with perfcnt_{enable/disable}, since we'd have
+	 * to take the perfecnt lock. On top of that, it'd also violate DMA fence
+	 * signalling rules because GFP_KERNEL allocations are made with the perfcnt
+	 * lock taken in perfcnt_enable. In light of this, the only thing we can do
+	 * is disabling perfcnt unconditionally, and notifying the perfcnt user of
+	 * the reset having happpened so that they can take recovery measures.
+	 */
+	panfrost_perfcnt_gpu_disable(pfdev);
+	atomic_set(&perfcnt->hw_reset_happened, 1);
+}
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
index 8bbcf5f5fb33..8b9bc704b634 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
@@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
 int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
+void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
 
 #endif

-- 
2.53.0

