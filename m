Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B9DCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 01:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1C210F1A8;
	Thu, 21 May 2026 01:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Uw3HHJgh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9624210F1A8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779327885; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZvY2oNaiJKjJu2CrdxxIQv5WGzMj+Y8jD8EivUDWfPje/ZkDTjTz6ypeTus4e1JUrup0YXP51I88sOPLu303tXtfYTmcywqBOmQvvNuL8iA4OJyPsAFZW1FkpHoJHGMDdeDqMQB+lJJp14hgOmD+JmAAQ+W/lH2ZhSP9SRQHFS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779327885;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uXh2mb3EqCBjA3lTtrQ2lSKuGm0LC9cSnJSD2N7NX0Y=; 
 b=WDEnxCb88aBBVwWadAEQy1CD8CEqRMVJyZBhceoOifkWEUUqgHmSfYqg4FsQJXTrNqajdQcvruIk7t89YSlTXMAJApOY42wIx3aCAqHb9AdTTaT3my1vX7hK5ljnnsGdqZRTUPXWkRfWV0xd1FYZpUC1ipE69TWPN+rDHZH1XtQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779327885; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uXh2mb3EqCBjA3lTtrQ2lSKuGm0LC9cSnJSD2N7NX0Y=;
 b=Uw3HHJghYTU9c1wwYtzmqC3JdXeXiWSy4neANq4xlAT1Ph4474rUntQ3/DToL82f
 IVxNfAPgH7kNrWas6GzCbaR7Fmj4HS4h6krgu1HGyH73eNLqgh2NBo0sJyH1dW8rciu
 WQkjF376fsKztz9dJZouY9XiD21o0VUeuz6Luwmk=
Received: by mx.zohomail.com with SMTPS id 1779327883287740.4573484817469;
 Wed, 20 May 2026 18:44:43 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v12 6/6] drm/panthor: Bump the driver version to 1.9
Date: Thu, 21 May 2026 02:43:13 +0100
Message-ID: <20260521014359.2011484-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
References: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Bump the driver version to reflect the new DRM_PANTHOR_DEV_QUERY_MMU_INFO
query type and the DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index bfb49fe2a306..4b6dbd600d61 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
+ * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
+ *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1800,7 +1802,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 8,
+	.minor = 9,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
-- 
2.53.0

