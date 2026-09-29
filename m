Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1FC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3312910EC7E;
	Tue, 29 Sep 2026 03:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="H6bG3rdD";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CBD10EC7C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653550; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VW0VkTAZKM6eb1BRAGXWFQtfJzpfHqAfILxFuJUlevUjNdHPtbHQinbiG2i2+JLSxA3i9CpTsU8NTzuE/FRZ2ycku/qz/UCQiiPwT0e3Js7SQhyAq1UQ35HzDWxTAFlT/ec+TgXNPYuQhUW7jBGEg5alaHMD6EuG70G2NBTblF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653550;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5DrYlETIJhi3ZxxsoItXF6z6Gt/+1gIZxU6D5aEyB1c=; 
 b=Mp0KkXywh7CsdErIF04MPbyohlcVC8gzm5x0adDNdgym+1JU5xQ5fP+l9Wuvs5GPPUWb9sFSjizmpdAc91zZ4uADlhw6gL8B4w8YveyMmDONrmN9vmHllI8S/rrxRvuOiagSjWQu8YABbtIMJlNa4HAVtpbPgqEeJNTY9qNtolc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653550; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5DrYlETIJhi3ZxxsoItXF6z6Gt/+1gIZxU6D5aEyB1c=;
 b=H6bG3rdDigUNZzQp5HIqSXwwsgy8aFJctG0SIyMkoqvNenXzIIEu4I1RfKbzssYH
 bG3oaG22zDXdmrqeCKEZZYN/vIBt62zMd5y0l1KzbbJ8SPbDJ+uXlAjOlgNX3x3YbTF
 Uz3RTcYOwG9tZWDz+oLzZUg9QcsUM3blardHBu3I=
Received: by smtp.zohomail.com with SMTPS id 1790653548547318.6363371036126;
 Mon, 28 Sep 2026 20:45:48 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:44 +0100
Subject: [PATCH v12 10/15] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-10-62beb08de207@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=o098HaC0Lqx0oV7rNN1fcYcROV6la5GqRpdM36GzEXQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQui8MW6Alpr8eSX4W6f4k7oexQKZLfyESWH
 EJ+0IiEbDCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LgAKCRAOJn5M7lND
 PVrmDACy+4IPzfsAWxtCz0/PaYO/BVZqgN6nnG8Sbc2yzxHFw+0DMWC+hX1FcTQIPYYV2meUVsg
 aB2wbrgmeWkZUUOubB0AmI1pRTKSjTM3hwJpZXXBimbweuaRUijvZMBLxmfcb3YKVndOQ9KN5D5
 u9c7CumMAkI5TRoeFRLzr4zFEjPxn+Fv5laZLVogkPBlobMNZhEhL78tzEfZcApgiazXevmdbjY
 vVb1+jenyJ8HXxYfGGhAGw6j8NJq6pEDQgakMJ1OilM4tJmLe1to8bVQ+wM9vTUU0XfLM2mIW/V
 Esqw+04T/Wqh1MO9il/OZvbD4jPrTXVXLOOKzjMPIUNZwNtz/gXHf6qH3cwlphBkSx7ATNFrTJb
 Uj0kU2y4FfsC50c9hRL4dAARkTlE/B+eysgWlRjzPqQojVTG/EEDKCe6ryip0WankxbJmb++Td1
 6xqCgDAx/+Vzp30CEVwoky1qpRPDfUecLxqw1YKKq1MPpkO5qagLFdu60TJRC0X7u1lrs=
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

We must also disable the reset work item rather than simply cancelling
it, to prevent the knob from triggering another reset when the device
is being removed.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 42 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.c    |  2 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 09a5752a3f40..94d2de341838 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -595,9 +596,50 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
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
+	if (!ret)
+		return 0;
+
+	panfrost_device_schedule_reset(pfdev);
+	flush_work(&pfdev->reset.work);
+
+	/* ret < 0 means runtime PM for the device is disabled, so we
+	 * only need to return the PM reference in the opposite case
+	 */
+	if (ret > 0)
+		pm_runtime_put(pfdev->base.dev);
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
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 00fb36c577df..ab65786bf63b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -932,7 +932,7 @@ void panfrost_jm_fini(struct panfrost_device *pfdev)
 		drm_sched_fini(&js->queue[j].sched);
 	}
 
-	cancel_work_sync(&pfdev->reset.work);
+	disable_work_sync(&pfdev->reset.work);
 	destroy_workqueue(pfdev->reset.wq);
 }
 

-- 
2.55.0

