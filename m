Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371A6C54F54
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7D110EA6A;
	Wed, 29 Jul 2026 02:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AWs/B+Gx";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED6810EA67
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293731; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fFfZxuyMutkkNy417DcbyIWUZ8JWoQU2N6uwd3vg0+4DCqT4NCnSxVzNGbTbPylBZC5zhoXk/4COZOh98x4M9ZG+mNIUoBHmFdftnOjujD1gox7EDnq8Vt4HKqKqZezT9lI6yfm1T/92nDnbJ6uzHoVAoJcGhddf7PyqOgffpb8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293731;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Gjm1Ylu0DsZFfTs2cNEBc7jk4bldMuD8UCeJE26jC10=; 
 b=TigqofIZYyQz+1TjcAz3uwIo793GNk0fsnHiKxhHPGNKsGn1ATJgqXF+vq4Si71czOo7rSZ540ftNLPqk8Qfv07rHfLecWp+WL7N4fVAcqWYSIBQpLxP3pOdZIpE0fRNfd3YnW3ocShvS9iRHwOZMQ+q1KVABGhMaZGGmAZ46Lk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293731; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Gjm1Ylu0DsZFfTs2cNEBc7jk4bldMuD8UCeJE26jC10=;
 b=AWs/B+GxzKug32/yZ//urIEtnSr8jXCdI1+W7laGEQQJLpouxNAziYCYk2OIi+rX
 xJMBXL8Ljk0WWHDTC6qqIbVtj7486vnP4A5xl7eIdSK1vIU/J6GZzznJ4ZlF6AiomlH
 pXd3nsKy5KnxsoOxJShyXSTJJgjAtE+pJCI2IZ/A=
Received: by mx.zohomail.com with SMTPS id 1785293728847356.340253525953;
 Tue, 28 Jul 2026 19:55:28 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:25 +0100
Subject: [PATCH v4 13/13] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-13-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=NcC2UlLXR59UiaVuPdD/gd0NCPNv26exEJCOZfdzK8o=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtX52cE0I7+fOx4TxYJIKPR3vKiw8xttXC+K
 V7Gg/XA+7uJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 PdMHC/9Y2HjDzBwL0KXRIuL9GuAjPj4ExQ89a8MaWpELnOPsWpFKkGK8NJXkRS3IOMCZYff7zcL
 TmLU+mU+e2NMPFWRRLtW9uYEOEtmPJ0+ivY3q89quzPKS5z8cW8OCJ5nEbPJ+VR9jEyeUxR86K+
 ZtsJdrHoGKMfJzgTn5PIlktB7Ld9YpNsPbXgmyGPC4OY6WR32yJK34CNhDXA22cp3ghp5l4JmyV
 P/zr94j74Hn8LinQOSEJDFOOvVa+eCoLqypmdcS4SG5Matwar6Zf5Wss4D4o0nAco0IalzeKgz5
 ll+T0jx0HC+7butrjISYUx+ZSNecZSkHdsketpjmU4dcStIG/UnYKjsVz+03DxC1GSo3y2yRYwP
 BfgIwxHt+/1qEWTIspf4saWg3KZhfj5+DlfsEWv2e9nbyFNusIdG0aak3yHJ00BWxmIvXYrguKg
 C/eWSms5MPkh2cXhTBZ+1R+eLqodkzDsN9Q3qn/V2s0TzeBU6z82xQNxbB9KZl830Li7o=
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
index 3212dbadcdb8..4384f8f744e5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -936,6 +936,7 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req hw_reset field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -948,7 +949,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,

-- 
2.55.0

