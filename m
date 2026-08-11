Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC3C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD57D10ED9B;
	Tue, 11 Aug 2026 21:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="eHdYQ9tb";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59FF10ED9B
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484579; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PEXZzW1/bmGFYFuSJYbe6xC3+zIW5EUXPP7VGlyj0mwD2WJPHfltg5nw66bQZYnehnFMm2x6/du2fTzQqFblXdA+p86OdsyIUKQGxGZiRk+jtuLYHTBjZ1yjj1nSh6k7Lrq94E/0fkoRoIvQYdtil1/9OJmo1WzTYgll1nc3c2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484579;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fqIay1Sh3Hlg2vT7TgcOQpU7d0imLC5dze4OAwvknsc=; 
 b=nKpH3rzjDi8u4StaK2ejH1fwtYdmYnuZphCcHZh1HF3Y2xxFdmY2eZxxbKZu2RYE1Mv38ioBnweq6qB983G3QwCSlcLfdOrlFH1TLoP4h8/hp1s9hwGQv67VogPUSes2ZgZ5Q65qMqpPXXNFaJOGQy5ga45ngrVuLWxsSw74mkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484579; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=fqIay1Sh3Hlg2vT7TgcOQpU7d0imLC5dze4OAwvknsc=;
 b=eHdYQ9tbBkCUpvfHawBjV9K8tB65Akqj9vlWrriOfYXIyumFinydrFK4cjnUgl9x
 P7LA0XUjFvitZZp1OyZT1hbkW3K/dUdranJcwP33rtAPhXkOsa0WmywIGQIRfdkOGeO
 xihM3h6nW9OsGlJkDGeJWwC3hY17gLeWTHtUc0n4=
Received: by mx.zohomail.com with SMTPS id 1786484576621885.5484021025918;
 Tue, 11 Aug 2026 14:42:56 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:16 +0100
Subject: [PATCH v5 07/11] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=gDNNC4oEwFRAgp5W1geDr5Ryzv+HXDM0KBvthHj2hzU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czk/1FewOY89pGpZvy18p4FxrVT3TsMuAf0
 yV7AnYnJaeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PUBOC/4+kLEMlMbdcXNh+f5Qz2RGG0QoSzlJ3G7KQb9V0VI/2WzbpK9+zvMBjrQaSkvUC69DR6f
 phX+2gIu1pmlFJgddPxM1rcF5mzN1ODFPB8SHK5Grx2HQnUI+qQEuFMzMHwaeI03T6nTGG5jERq
 aI8lJ7VLG7d9WTUoju/6+NGsvfWwLIwduwYBgPebwfC5Atgc/714KEKveIgP+cjUlb3trgZ0CnF
 uUVCNM8Ln1O6MsspcembyOMuVX/q4sHE82kCSjm0+RQHKZnKzM9mgVwNeCOjmFw9u1N5WTjoekX
 RcprALH8xfRf4pzKkUpQ6+F5At03F49q72B78YY7s83BXrcfEmiObLUayemDqsqPcXcmJkw7TGx
 fRDuOuWRdo+ig3cxffVZmpBlqapQ02K/GP485Yb7nGK67Zzj/b3LpbIXWN4M/wfK4td8d96cAXy
 HSGIYJVFcMCFQfqdUVmxoQtGWJOCgET9e0CjIBtwoeEoerCamZofCEZpuUMqn1aKXf+Zo=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 39 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 52f4b8c6a05f..5b66173c75b9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -608,3 +609,41 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
 }
+
+#ifdef CONFIG_DEBUG_FS
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
+	int ret;
+
+	ret = pm_runtime_get_if_in_use(pfdev->base.dev);
+
+	if (ret > 0) {
+		panfrost_device_schedule_reset(pfdev);
+		flush_work(&pfdev->reset.work);
+		pm_runtime_put(pfdev->base.dev);
+	}
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
+			 reset_get, reset_set,
+			 "0x%08llx\n");
+
+void panfrost_reset_debugfs_init(struct drm_minor *minor)
+{
+	debugfs_create_file("reset", 0600, minor->debugfs_root,
+			    minor->dev, &panfrost_reset_debugfs_fops);
+}
+#endif // CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 0fd33bc5b86f..4bbaaaf827a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -350,4 +350,7 @@ panfrost_device_started(struct panfrost_device *pfdev)
 	return pfdev->js;
 }
 
+#ifdef CONFIG_DEBUG_FS
+void panfrost_reset_debugfs_init(struct drm_minor *minor);
+#endif // CONFIG_DEBUG_FS
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 8410de95e364..958f1d36ab10 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -916,6 +916,7 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
 {
 	panthor_gems_debugfs_init(minor);
 	panfrost_sched_debugfs_init(minor);
+	panfrost_reset_debugfs_init(minor);
 }
 #endif
 

-- 
2.55.0

