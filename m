Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4CC54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4D010EA5B;
	Wed, 29 Jul 2026 02:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="kNl6unK9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B640510EA5B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293709; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XOAqPiicBAa4WvKO3fxwHnLB8Luziepj13WUeyekfocQeJwkme/yt7FhcNvrWrX0+/RKhCSGWAKKz5ANccm8GbUE4ZgxFqCTEyDPuMDCkqfjJIih3u62Ukti23EQsux/o41a+xb66h2s+8FFVBUKVbHbsPHFBo0WywY4F81N2JU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293709;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Y6/txCpkEA9o/9Hb21p6HQfPYmUI3SJWcARAzkRK1P8=; 
 b=d2VyomKUVW+Xronc4GG3RDfD2Dn4GkoNsTR7MNEEfEYAI2h5v+7HQdZ6pRfTSgTlft7Rkq1e70ULvq+XXNWLpf/pwpikMZY+KqPXxFuUMwcrrds1eQxJSD+n1eDbefUXA3flHPHNTQySWi0gK+gBJJX97jgQLMSGsUxhq1/CToo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293709; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Y6/txCpkEA9o/9Hb21p6HQfPYmUI3SJWcARAzkRK1P8=;
 b=kNl6unK9OeBsqs4407PwCxNB6K0YQAIo939ykr7vm7agD8Pms2SGZjN79xZyY4ii
 OzKCjg4LOMmRBdfza10T/qKvoZEfnEvCbSCBLYjAr7r8omaLoxQRdS45AkDAcLpRe84
 r9SGiXzWwqCI5zW1GX+xV1Az1b3cj24K4gMyAiKI=
Received: by mx.zohomail.com with SMTPS id 178529370825151.029050959387746;
 Tue, 28 Jul 2026 19:55:08 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:21 +0100
Subject: [PATCH v4 09/13] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-9-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=7nO+c+xPqoWz2WRorGOFNFAUj4TQ2MfRWQoearaVypM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtXueZbHGwD1NYdjh2lDbesCsYOFngR9PgKy
 FX/aPTBoUyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 PSD4C/9iDhl+iXj665aFJZ736Z0DhqrXqpoDLEFdQdZTG/nnsZz9ytSgdW8QYMpbX08VgtOTMvi
 9HhxyuZwvJ5ZichFcrGFFSaZAG/U/nJQo/W1bM9F6r11xSAxOIqEevIprIJpIEa9SDNFqDjAJ+X
 xg37yUzw1lmdv3nqq5eEjBHThJVP4SbDfHHdlG/FOYF9vB5KySuUbVUmtLSOHa5PP4WmF4aZrkh
 Bt4U6hM1F5om9iJMlzyciLSrJhWjJas1PW22eifBxCGB9UP3OGnmkeVW13bSS6qqM99kh+J6N57
 SGNyNf67oNcJHhbVo0wZ1Ma4rtqiOyRgvkIA3aH9k/ja1wQi9uQBRk/0AdfkOBeWUdEtnGseoMW
 yNl7LTDq140pcKYPtb6wUn8Zg1h8xIvW3L0lvtaOaX/k6BcqABnbGm5HISasTW+Prf4wPl05Ehp
 CrxuhHxUs7zbaEEOEz5svW+RBUFUNv/5q5G0FCYK2HrgYovmR9DYZ5GtrPHTUbUzClxAY=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 41 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index a51f1ef8563c..c0334b72c70b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -629,3 +630,43 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	if (!panfrost_device_started(pfdev) && !ret)
 		pfdev->gpu_started = true;
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
+		ret = wait_event_interruptible_timeout(pfdev->reset.wait,
+						       !atomic_read(&pfdev->reset.pending),
+						       msecs_to_jiffies(60));
+		pm_runtime_put(pfdev->base.dev);
+	}
+
+	return (ret > 0) ? 0 : -ETIMEDOUT;
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
index f0acfc634cd4..f96ba50dfa91 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -352,4 +352,7 @@ panfrost_device_started(struct panfrost_device *pfdev)
 	return pfdev->gpu_started;
 }
 
+#ifdef CONFIG_DEBUG_FS
+void panfrost_reset_debugfs_init(struct drm_minor *minor);
+#endif // CONFIG_DEBUG_FS
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 27f4c4b217f5..fac5be20ad60 100644
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

