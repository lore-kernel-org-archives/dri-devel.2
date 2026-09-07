Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF31C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A1410E8F8;
	Mon,  7 Sep 2026 20:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="lACJUHaJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAF910E8F8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812253; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=On5WxD9EIZrbINOjqvGceeA+s48TBWUhqDolgRPinDRa7D7xvXyJVOlDCtxrmtGtHvNliXBWDFGwKNJQYZLovS46sl5zE3a+1Ir65BOpXRlIXBm8+Ocjg+dK7VQHz2zpwnTjqHEtQdfh3zvOe8JFUbwd/zcPk101P2ODQ05E5/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812253;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xvtZy+588vvNRELPvHTWe8SWq3OINK8uRg+k6pQWcYo=; 
 b=Ko65kix8Aq3p3EN+3mlbQJiLMWtzTz/Vq9SiIqNnUaqEhZNjhdIUEzsCXW48MxpkrmD6dh+x2aWKi393dZiz3odG9I3CaQiQAcll/qEg11m6STI2l+vRM2aTkv+Fi67fS9Yd1IDLGCUNt0sYUmwjssufoL6x9m8qnFbSOhcHHBc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812253; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=xvtZy+588vvNRELPvHTWe8SWq3OINK8uRg+k6pQWcYo=;
 b=lACJUHaJpzPqdaOqiaLUKejOqoVr3hKUCaAM9Zm4pJb5weGeTDgWzjwQWZy9pS+B
 bS0kg/WB/6aWUdFON46mEcyIslLDEB3Alo8cEF8BG3e6wN3mkO9pweitIfJvIYAbeJU
 /iOklhes6lP7R3dRoEprXJpeYDSvTL4emVTGIo/s=
Received: by mx.zohomail.com with SMTPS id 1788812251808736.0281902780624;
 Mon, 7 Sep 2026 13:17:31 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:19 +0100
Subject: [PATCH v8 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-10-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
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
 bh=eDn5Yrvo+UNTyZZswV8LnMNa0J4/HbH7rB91vZac1CA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuLCvCf/HPVs0saeTT1IGHl2q9STZRkgskWJ
 Ff78vzuaJOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8biwAKCRAOJn5M7lND
 PabHC/9isn3kvCiylQapm3680r04dKN1kLLvHCyvLXO0yZSJQRLpGDbye/NUBRyCdMbXc/MHGPg
 wbWWnhRkyXgSEey+Zdu15kW23cMZxlxg9ZKsJf/Hq5ynS+H3uqkdBw+NSQG0AHB92KGwEtMT57P
 5sJUi716X/sGQoPLZPnvVjAuIjSn0y6/3brweqoOnEGXfbRYSNH6LZRtDDmiQaVLywonSAk5nyN
 0VZxd2uoscQ+yasR1GdJT2QmrtxTpf+ZS1Gdq0U1wlKi+D1NA8u1Xoe1R46rSjOJ6l+d/Dd2cKj
 NdHhKdPE/W/voHqOJ6Zpme4CDAiAoCb1meewXwgJvMOCM5V3tPyLSkCFWm00vuoqDBmEH/nGtS7
 m6Lmo8U0Ea0jjltF2vM3iTCJQnf7EEn34WKEAn00BhtopaqYwWa0SfTd3N4vlAX+2v0DCaRoROi
 WG2nF0R/D4pWGaz0IEXY5m6ZHOaBsHseDRs8beKt9I1NB8JYwHIlnH82qgc8DNltolZoU=
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
index f0fae6fa1e24..f171abe26f80 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -589,9 +590,45 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
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

