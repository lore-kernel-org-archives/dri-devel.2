Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27922C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DBD10E60E;
	Fri, 24 Jul 2026 00:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="e274JjPB";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADA010E60E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851241; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E1nyvwtVYakYpgk21W8w34IjYdcylCRIcycmmDvac9osYm0ttP8J+2FXAX2au/3qXoG0FUyvpTnvulmnIKhYErjpaRxLihMelw4eD/xPT/f4PBpQJDwNFzmgsXIw78REsvdk8kVcQqq/w8Zw9lYsstwckXrgrNCZ3xbMt15onr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851241;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RWquoODj+otOqmvG7GRUPK/89BcUOZ/21tLxF3D9Lik=; 
 b=IhG2zKIIrLaGxJc8ZXbEf7j7jzp+7TqQL3c8twEDXa/K+s/T1dzK1TGneJ+Jh5QZYR5xz5WaltWxuw74vX0m0Gu/ddSNZytojP2HfuhOgH2aeyWwQq1PRznC+uNa/uBxexrIDnB+Eo/64xQa5dZqfvko1FkcwkAFu3vwV3/h2fo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851241; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RWquoODj+otOqmvG7GRUPK/89BcUOZ/21tLxF3D9Lik=;
 b=e274JjPBJjRYrzxMTCUVnBqU4BUNqiruxu06C0wrvWyVl+k/gk7Wpd1BIb3+4VmW
 d2w8oboRcZsbFFPvS7HtQmFq0Mxb/dN9fWc4zPlPrI3lkpeV+QmbiVPz3fJz20Z9X0q
 SsQMoDnXaA3VRnnQvjyK47+C/SkEdC4b1MR17O7c=
Received: by mx.zohomail.com with SMTPS id 1784851240675951.2213263241606;
 Thu, 23 Jul 2026 17:00:40 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:02 +0100
Subject: [PATCH v3 09/13] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-9-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=hIkA9kKBskWx/XZTRbh3ZJYCDHbNCIyDvVQzCFGV/rs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqro2D7K346QTus/1xxLweFKwELzG6/DPKuQu
 JDUolit9pKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PVgeC/sFzwycIQrbLJdgRLcTB+mJ31zrz4niZIUDT7P/EW0VoWm2ZkrR8LtG7haE3xvP0e+7t89
 wuLxp9a9bGjJRRVAlx1MmHONZ12tC9gcu9ufCWtZXOmeEGSMqkg1wFpbzJIxHJVnRDWTT4/r0W8
 U3zZrLfVf/+BlvHCM+P/JqnlCAJZqMnEEgJJiK143YeWUmEIBUKzCTgKh3bIaxAWuD1vskeehl0
 2iH5A5UjrbrS9GYoomB7z1GDMWX6uyyu/wz3PhW/fBVzALya1bR5sczxd2JbGQ8HVeByPVz+Cii
 RPGbZb8NPJVAtHXZeY1/UL+BBDtPYBqSSJH7JBnFl/5JkYhHi/7PqlLT5ONiuioQB4mlQR5KvFi
 cxmeah/xai7X+CgsbVJnWRkOqZLqZvhtfZPXel6lwKkfEuh3YvBAET0WiQucy2bMVEIdV7LgiCT
 bBdpYYem+YhPC+5h6JHsvwrY8eIdQ9AWzL4Tcfew/ITqR3PByoFc/0rIBExV8/ltcZY1M=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 38 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index cf115db9cebf..80746e375410 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -631,3 +632,40 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 			panfrost_jm_enable_interrupts(pfdev);
 	}
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
+
+	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {
+		panfrost_device_schedule_reset(pfdev);
+		wait_event_interruptible_timeout(pfdev->reset.wait,
+						 !atomic_read(&pfdev->reset.pending),
+						 msecs_to_jiffies(60));
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
index 23dea923bd04..855ee4d0fb40 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -346,4 +346,7 @@ panfrost_device_schedule_reset(struct panfrost_device *pfdev)
 		queue_work(pfdev->reset.wq, &pfdev->reset.work);
 }
 
+#ifdef CONFIG_DEBUG_FS
+void panfrost_reset_debugfs_init(struct drm_minor *minor);
+#endif // CONFIG_DEBUG_FS
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 5eb4b095b1f8..2490e9785057 100644
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

