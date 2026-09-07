Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3511C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F63F10E8F7;
	Mon,  7 Sep 2026 20:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="L79uMPTB";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59E510E8F7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812241; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OSTxbewsjM9Z19ffh94qj7iQorlww6IBMPVN5hFZW9LIKEJc18keOwMyk2tTcUfKmm6ru1oBSaXEjjtFm/F7vzNRiPUAFlQsDd75uQTmWxLBTqbEe1gGHDYVN6ZsSxhHHteXYmrh8UjGoegQrD2x6LSN1jg9X1/wwNZviqb0aVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812241;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6M13TZPP7oUqvUc1g291xz+3tm1ArWqnIZv6qGHUXZI=; 
 b=mn09mE6lnkLifsOA20MNOo1x4OiJknYTrqv5ziRJ85JTIb8tOh0l8LaZCrU067dD9+t/Bws5nQsKWXsSUPnXMpZEsUVu2DT8a4Rnf0XR6cWV9T2HkI9ZdJjc9TP9c7ML5p1LwsGJIaHwI8PT/H33/io/foRTjDvk62fx9WloPnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812240; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=6M13TZPP7oUqvUc1g291xz+3tm1ArWqnIZv6qGHUXZI=;
 b=L79uMPTBLKfSCrpIQk4uZcw9HpKbyaFghFm4gDxxRZ8Gb/tNkQwrCTXyQvu6BjWo
 xHoejVDcJUlmB3Ts8Wi8bDm1Fe+yB1Z4rgqRlmUF8YLNdH3D9OF58ULH/+iY5+O98fq
 a+EzwLLd41g69k5GUhvj/V3atnRumyzyBJfa4020=
Received: by mx.zohomail.com with SMTPS id 17888122402391000.8631023574272;
 Mon, 7 Sep 2026 13:17:20 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:18 +0100
Subject: [PATCH v8 09/16] drm/panfrost: Add warning messages to fatal error
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-9-c2bcb5e82184@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=msNOWUffbRkrfSraVB7gjtlcxGicDQCYrGfFUU2cXOI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuLt2MzWFZ8f9diCxsE79Tm9S5k4ihOsVvHv
 a4asE5tJGyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8biwAKCRAOJn5M7lND
 PbLkC/kBMI9NHh2ycE+ZTpq+MbjuTGEOUEIgg5cRpASEzm2JGWMggNyI1PG3DvaEQNrZt2IgE7r
 oHjXB1a34nhziioqr79LDceou45C8w+7SAKDiWe71488bShmLRjGRuYDg7zZlzSYluUEZxrbU9q
 t/h7en0Dj355qRfxmG76Igan2Ep/wYx8kv8YuNHQgcWTRG+TwkdGxGaP8o17ZN+46IpRTBwOA9a
 MgjNJEjfFgcA6Ur8fLChH7APvSUbx0I6FTKI7tSPz47gZ/v4gRuW3Xcx19DC+k3e5jrk6zJ3wPr
 LG+/u4/OvIOgXg+Kk1DtIFw8GZAOqu0o7Dz9f0Qyc5jRVQgWyblykzp67qYp1c5o4ORfFGNBsNG
 WjSNU75XXk7YWj1+Wl+/SXgtuV0t/D4O9oZ/OzAlYWeCypVx0z2DYYfNMtWO+hrrQj1zSlW5uhD
 9hSFhMSIzgQb1kEJvRIcIpMhWaIZAcbc/e0b5Xbf0ZcDQKdI8InwdyUjJoQ7U9tLUMCns=
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

Rather than just failing silently, let's warn the user of device remove not
being able to take an PM reference or the PM suspend path still reporting
inflight jobs. Neither situation should ever happen.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index be4443e41d9a..f0fae6fa1e24 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -343,7 +344,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -501,7 +502,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);

-- 
2.55.0

