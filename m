Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C359EC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9F410E713;
	Wed, 26 Aug 2026 21:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Xzkb3XtS";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C618310E713
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AKA9xQ9CJtIsZVZMH6i4jKRzRMenFaIJ0PUxVfH79UIDSJYPPHkUyiGHaq093Sf9twK3687q5uUJjuXAcUGSXeVdeO80ksCmwXguTf1HAlgSSE/JMcCYq1KZOHOSjpbsLAn8zY0VCBQW/UwML2qRcMRncQ841CV8Tuf0JEgwnro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1Tq6zEmNykIv8XKjKfzLV2GzV9wqZVjqsPfLMZwAlS4=; 
 b=MyaxlOIE73LwzFcGWb6YSnV/Lpz8zJspArqF/Djs7PgUBxmTdeJQVRf0bbIrDC0MjpKk5JGLErEgJRTxYv6tocTIJM8buF+gkSdaYzc3AJowoCjt3VZR7UrRRW/G8rm9a7ns0Pe1EuSALB4ktLeOe0ph9QIDfnO97W0KA0ksuLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779190; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1Tq6zEmNykIv8XKjKfzLV2GzV9wqZVjqsPfLMZwAlS4=;
 b=Xzkb3XtSyixC92/aYtNRcWEVQx/v0OsVL2WF+f0l3ZoEL/IdcCNOUTCAAiBYyO4S
 WrEHj+RMQdBi1LUe3x+RsEX2ZePA1BfbYmf14XKF/Idg/4gYFyFlMWSiR9BGeVwIxvM
 oV73ViyCWFCP5nyz48a2JkFMqxHvpamFgVlugim0=
Received: by mx.zohomail.com with SMTPS id 178777918924975.85137957340908;
 Wed, 26 Aug 2026 14:19:49 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:18 +0100
Subject: [PATCH v6 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-16-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
In-Reply-To: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=AypLoSBm1KPHQD9f+Zcdy3AMlNPgjcCvidkbs8KFBCQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gMibENL+ADu9l6qy8i4kf0mTXvcmYulYanA
 4rmOf4qBiSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YDAAKCRAOJn5M7lND
 PQDQC/wL8bPyMAh/l2rE1HXrX7y/H5MnG9jBK2q/BRhOOvnthtbf32RTdeERX4tBNt/bnb7Qy8e
 KsGn3eJZs62Np0NVGueUxR3f4GvTJSi39HtfUzg+pspWQVf+LijmOGgq9WV/y0lGSgtUKrs43v0
 UDROs2bAvSuefG5qXZWTLZT8IpPKc7Mjh1WNj0Qkjvl7S+4rq+Y31nQrnB6hr+S2Wmn5Pd5YI/g
 CwMaWh6riJYkYwTSmoXo3KKhX7pxZvU8y8gaEedsVNKYBcEZZ1JkQnzTtE/EAf7FmjWEBylQHRW
 H5hbQCIuIJgpWUCFN5VPNHWesFFyWBdsBWfEih18DoGOJh/lbLWXQXCVgFwgRCFPbOKtFoF4JR4
 Zl5UvHfqCdKqd0oHhbaHPkHal7DvkFeUlPbzK7IFvYM0t5Qzw0jvx0ylEuVG6sesruWS655cMR/
 CRicWi1QNbPpGIMWwYc4fMSnFfTQ7tcvj1Pk8gc5YyqPo+fKCr+sJnEgC/49JJjKRLrWI=
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

Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 571a26b84126..7869a0cfc4c3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req hw_reset field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,

-- 
2.55.0

