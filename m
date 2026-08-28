Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52AAC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA7F10F47A;
	Fri, 28 Aug 2026 20:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QP+m7eWU";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0550310F47A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GSQGLR5Rik0lxiitkFbk36jsjQP7ASXnyyJSg4Glr7RdkFajYCK04uBSNwdDdwGn6p8/5r86yocyUopaBm5NRqLXzMw6uHuX5R4b7wfb12IqtWfmQBXDvBoYUR1MNqKif81kP5rLLisdKQsuOInhoMNLHlcLQNMJ2+cpcrc7Gzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=me0hJGwfv9K2eIDbXpthci/ifnbqwxMprC0nvdT9/zg=; 
 b=fMm5/2YFiMGg4m00pAOIbKQz13B9Nmg7CkFIlbj00fwgIqVj1fcWYuf+GAJzgz8ux7Ff/EchIAcmFLRC8trtCHKDYs34lmGzzWkfVv5dTQXB7stq1P18zA1Y47mU9rheg16g20g+1/gmMTqiq3RRt/vpQDRxlAxoBMf3vFdjmT8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950706; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=me0hJGwfv9K2eIDbXpthci/ifnbqwxMprC0nvdT9/zg=;
 b=QP+m7eWUTR4wGjyiKEEQevHKpPSnNOxCSXBkKi0wCywTVPPUW+zq+KJXYupwXFfQ
 De5ES1VpYuR8Z7WjeG/Ep3a+LUpNHJDKtphhGeaewfkeh8HdG0R/5wmSvxxV+oMC/7T
 lT2Dc5Fc6WmyO2hohGuFBu/Ac4KEM15wxsiZa8CI=
Received: by mx.zohomail.com with SMTPS id 1787950705565590.6697846984891;
 Fri, 28 Aug 2026 13:58:25 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:51 +0100
Subject: [PATCH v7 11/17] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=H9gEFoBms7/QkuuLE3cPlFUi4zdZO3D3TGDhbhWgY6w=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtGFvxP/99bwZ0Dl3htwhTQRVRXKgq1x8lh
 6eWohnpg7aJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 PSGSC/9ncAv9TpB2VM6xku2WT66uWsZRPD6xVzS/ESEr49eK2QcEotAZwh+Igpl7NK6vcaCE0yf
 cyJz+Ifmz4eCFHy9o1LPB902Yb7QdTL+TczIJ1LNb8UA21o1EOQ6WYQFzxA6i/NpKgpacqk4NKw
 ITXU3HQ2U+jayWFHYYr2wh6vPLWDj61FzUYyO16b1D2MYuKa8ikc9nTWNkbkR9qPwjPuTevuBKT
 /sAx1R2gfv0FDFDltuL1nkQ0noWHjihKrPFKgkbl6sg5JN0IikVNr/9qB/OQmxHtyg2HYMK4E72
 LtbDF0nvg0ACwsdJdnA2PpRYWL7R1FNyoLFtoTXy3oT7LSWmmDaUdAwGJoYeKAVZV64n8QE63oU
 wjpG6Dt2STCX0HD56ZtgBlKdUKzPS5dpwss5bM543SGzHPTgHpmbNqT+9tXm6FF2IcPUVDrMxST
 kcHplpaysjSkUncir1In+3xtK5Ald2lb/F/SeKH7yQ1TqjD2O9vLZXl1LeFI2b61NOUBE=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index d8acae9b8cfa..b6a48ae0d3a6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -600,9 +601,43 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
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
+
+	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {
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
+static void panfrost_reset_debugfs_init(struct drm_minor *minor)
+{
+	debugfs_create_file("reset", 0600, minor->debugfs_root,
+			    minor->dev, &panfrost_reset_debugfs_fops);
+}
+
 void panfrost_device_debugfs_init(struct drm_minor *minor)
 {
 	panfrost_gems_debugfs_init(minor);
 	panfrost_sched_debugfs_init(minor);
+	panfrost_reset_debugfs_init(minor);
 }
 #endif // CONFIG_DEBUG_FS

-- 
2.55.0

