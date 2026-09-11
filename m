Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B46C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A91D10F719;
	Fri, 11 Sep 2026 23:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AyPHsufY";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D25310F71C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169339; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=efPMK4quvfhbCzx0O2n9+ppnit44nj5esCP+cCzcjxut5KdUh878ZusLhKyBsqJnB4B0a1nGCb63q4QdDQOJxoDcBYASuBoIzvcRxh9PWJ57TG9oioBxqBacpXdphGkoHyq4/CLu6Ki4QxcgVsP6zkvtGS7Ex9kfcqorIrIgVig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169339;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=41ds9z6Rh7JtHM6jQPfhK3863L5musGeQLMv9a5jCE0=; 
 b=b+cRgpy5/XXibvSZFdwBcx6wJ4MDRAKik9SMicHMIVwKpvg3b7COJqJRy3qH7bLirIt5hGLpoKOVdTH7fQhp5+wUY9NY889cuzg484r1JsXP70YslxJuXTcHEkmrMrnH2F7KGPVNGLrEhgARat6VK0inzxU7v4KJHBJ8i+4FW8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169339; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=41ds9z6Rh7JtHM6jQPfhK3863L5musGeQLMv9a5jCE0=;
 b=AyPHsufYaOqPqlMt+c/jYiJwy2Ui8z1uY/4vibLbQtmKW93v2e5ghFE0YcyZBfle
 +kw6OjA8dxVZD82FRrty5MXc69/I+BQgT8xJYGGeQdRy+Do6kJq6Xv5O9D5/xRb8CdG
 TV7E4ICV76ewU5aZdfEfk/7vf4204/UIFnqB3TA4=
Received: by mx.zohomail.com with SMTPS id 1789169339761719.0250863890261;
 Fri, 11 Sep 2026 16:28:59 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:11 +0100
Subject: [PATCH v9 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-10-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=hcCH1dUFIcWdgiK2n6o4P3fKlgwCx3OuIk7x9WnwwYE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6DerKG9p30du1LfAACMFlmyrqfXZ69gSrIt
 TkvlCYkmqCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOgwAKCRAOJn5M7lND
 PWhuC/9+IFlUqggMzcN3ZAfXz2W0aju5muI9FfQVhytV2kp9hWe09YUtrdBzdxuhExfPBP0Tgg+
 b0bYT0paoJqQiM7lGVQfMur+yF5SuKwpNpvcmHRwE2D7A9zZs+6A8pX8RRzt5AAsLYdnevjCrTi
 rToTG5uS5IUGhR+jNcw6CXQhfGTchtyHvBH5vO/WYQ7XjsFI7Xoc2g3OEj/8dVxDgATcwgmmxc8
 nOuGRWBllmq7uSnK7TUynVeii+69uZHqn/zzfcUyjoYs1TfuGKEVa0BULrZCS4dZVY/XE2S5Pgj
 0PljRBpz4BcQxBIdQpwHOSe9jKg0upWVKSqwgZzIhYALpshDvBrry988CUGrmXwC1+SJMYCgdH/
 up282zG6qpyhVSXlNV3O+09qRMUErCKz3HoW5856ftlK+V2wn/Y0ghF9n/U5HUCY/ugNcpGRTfB
 ijuU6MSZddmch+xj5+XcWKmgBy0rARZJvrxEG2L15zOdFxpZR4Nf4yy1dRe5e9VmEGtP8=
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

This will be of great help when testing potential races between the GPU
reset sequence and other parts of the code accessing HW registers.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index d75566a45392..0aee1d87a7ab 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -583,9 +584,45 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
 };
 
 #ifdef CONFIG_DEBUG_FS
+static int reset_get(void *data, u64 *val)
+{
+	struct panfrost_device *pfdev =
+		container_of(data, struct panfrost_device, base);
+
+	*val = atomic_read(&pfdev->reset.pending);
+	return 0;
+}
+
+static int reset_set(void *data, u64 val)
+{
+	struct panfrost_device *pfdev =
+		container_of(data, struct panfrost_device, base);
+	int ret = pm_runtime_get_if_active(pfdev->base.dev);
+
+	if (ret) {
+		panfrost_device_schedule_reset(pfdev);
+		flush_work(&pfdev->reset.work);
+		if (ret > 0)
+			pm_runtime_put(pfdev->base.dev);
+	}
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
+			 reset_get, reset_set,
+			 "0x%08llx\n");
+
+static void panfrost_reset_debugfs_init(struct drm_minor *minor)
+{
+	debugfs_create_file("reset", 0600, minor->debugfs_root,
+			    minor->dev, &panfrost_reset_debugfs_fops);
+}
+
 void panfrost_device_debugfs_init(struct drm_minor *minor)
 {
 	panfrost_gem_debugfs_init(minor);
 	panfrost_sched_debugfs_init(minor);
+	panfrost_reset_debugfs_init(minor);
 }
 #endif // CONFIG_DEBUG_FS

-- 
2.55.0

