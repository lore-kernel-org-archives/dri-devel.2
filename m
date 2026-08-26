Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC3AC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFE610E34E;
	Wed, 26 Aug 2026 21:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="EbF07MB3";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA3C10E34E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779150; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Oj89sstpMjcchaxG4fI1/r/ujbU2l9yMcqtiXa8kKgO0x0i4yfClwInmFZEAkScqVhe3fWNBhSbBeePPKK1kq+XP6G3LIQjAf3qKWckAhCVMEomZ/oJvFkbXuNmhsmz89VOEQz6vULAj32fS52RHsm1wa/eGKzoYJA4gcAxBtZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779150;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mL/t6AtBgho5ZUgG0J1sVf7T2HPplYZioEmnXUNCwoI=; 
 b=LOn8kEeRUfiLMM7jnPpVb857cufSvXIEqPg+FhI0I4UxbqVKWFANYO14bxQTJ2F3LhTN2ALEi7gCdl5ZtZP5LhygWykV/9gqEfZHQWylCZeUoMdm/Z2jmDXDFfA7CBUznnE8bjQvOHnsn6864dkVgwi5xK+z0+NBOVloibcZn4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779150; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=mL/t6AtBgho5ZUgG0J1sVf7T2HPplYZioEmnXUNCwoI=;
 b=EbF07MB3zDJ3QDEYdie4LlCKU7pyx9yPdwWKBkntfeL8V9wIJfbpM7xhVn+JrZVO
 MCnWodfMxEi1kiQ7o+5I1DGUjtsmUvV3WmXTdPAio3t/ORuzurIZbNDX7OZUxeSagM3
 FPfO68wT7hQNO4+AfSvxcTxoBroVgy0lc35BRWpI=
Received: by mx.zohomail.com with SMTPS id 1787779149171241.2427339605357;
 Wed, 26 Aug 2026 14:19:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:11 +0100
Subject: [PATCH v6 09/16] drm/panfrost: Add warning messages to fatal error
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-9-78119af409e7@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=agRP0RpRtCDjA7QtcvATBit6UJ45pRR68pISHX2erxE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gMrQr6lFPoC+vpxQiWomb5BTbIcGfJky9/h
 nn5hY76YwqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YDAAKCRAOJn5M7lND
 PVRQC/kBmemrgp09dv8de8omyyEJq+btguQdF99PkRTLpAXGUeg6e1tuCAf1327Hg1KUWR1gBJD
 GXf5jkdR2gibbLXJZVSlJozliz0HBby3+ntRaVB46ob9JjtXVzD/gJC8/ziR5nmlVBzlGP81RxW
 p2Ywpsb5p9s2f/IKIb95JNypzjT89c9MnK5vntSENGJ328VMPOuxDeczONAhftxIatsuVb8vA8G
 w3UJZ2WYqH00cwiwpAFTh1rERXlzjFDc0jvOoavblyp0zeKYGZgfSeq7Gm2GdptbfZmrshOnQ9L
 YmguzxKygEuH+zIYMF6iRtocwUTsTMIA9blAB2azK4wFBP1RSdJxFba7pTEjkxT1hmgXw2NLE5N
 olnqMzKeze9nN6YeTu9Cdsz9/BZ0RCDYM925M1UaBD1ssFOkTnJ9KkPVIhl0MeyTksG0Sjf6Ask
 t5JplfYTOiincGgCksRe+Q2cAWlatFCa4pZZmjlbFeI1v5w0US3WXf+G5fB64IgdOSmRE=
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index f6066aef4766..ee4c468b882d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -367,7 +368,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_put_noidle(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -516,7 +517,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_device_disable_hw(pfdev);

-- 
2.55.0

