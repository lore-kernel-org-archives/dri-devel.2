Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F0C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7460D10F718;
	Fri, 11 Sep 2026 23:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="k0dYPoc4";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9993D10F718
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169335; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=liSoQuZJdu4VD++VM6Eb+ng73EYTFGHI+QkjvFlK6xquYMP0vyER9z8OloTPlSA++FE6Xi5F9hc3RmMpaEN5Q9eMKzjsYGL3cgifztAuFlMrA5WwkNScRcZi3NXElzHxe4t3spZGB8MggTXz38cBDC4jOL3HTkd8JeUWxhuZ9TA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169335;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PdTeMb52nf+zL0XsG6UuSmjMA2646Gcmmi64FeA/r4Y=; 
 b=Kr0ycLRHi3Ng/vcK8XwpmIf8HHx906rWPbnxYI6/8QqH6XZj7pi6sMNGikjt3KXb9q2owNYcO4NmDtmhXANZfZesfeXsu8guoG3VCfcu4xQdaqj/jVp/e9hhYLpps6MZa4DjCAjRXKiybrzwMIPF6k/eY718tryOFMvbXaVZYV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169335; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=PdTeMb52nf+zL0XsG6UuSmjMA2646Gcmmi64FeA/r4Y=;
 b=k0dYPoc43Soozllmqj/4vBuQ5+D8FEPFSfVm2OdRybhHuAoJW/EvtMuitvXqsp8A
 iyvfFQuoTGckuTeMisZvej/PvHDA4Dk+ptbwZ/6Z1Fn8dxCgbd1lY2HenOteLLbx1ji
 g6xpOSdgYCo+IIpcx57BUtw8H2+R+/77pNaT8JXw=
Received: by mx.zohomail.com with SMTPS id 1789169334649605.3674708644796;
 Fri, 11 Sep 2026 16:28:54 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:10 +0100
Subject: [PATCH v9 09/16] drm/panfrost: Add warning messages to fatal error
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-9-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
 bh=j8qrQUubvamccgGJ9GLGGmSrfxlD+QXeJh9w1qjNAgU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6DRZrc6GYXBgn0oS1KcyfnF81VWc4Z2rv2U
 9xpxbNZgTaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOgwAKCRAOJn5M7lND
 Pd4KC/9MqzDK800llGMTZEGPwwWwqyUSsBQkTAhfm0rsD/hRGB2HlEIXjdhCLSZsYVRTzbtT0ej
 IXQ/rDzJUn4Arj+OfbkXD2Jv9/Ov2M6cpmK39w2MhFCvChZ2sQC+FSLF16HcMc9XDTRkjKK1Fyz
 VxCIyvjQQVtWC5JZVy7la9zkRIujfp6L7OvfbKdcD5g9HppWJjsPqKTZUyu9xGmHAcd+abgCdrn
 MYcT+/1N2wbcGpGCDVRnxI8OdaEPSiGDSQOFGmZ0UVjgZs+QAmM/w9Xb8xTBIakzd8SAsmKpsTB
 FO3A/FXMKhGENFnGJhlWiuM3uUbfuLQNcOElAc6t34agcycuKjeczREf9jCh6qQG8i/SlVq6RQa
 UdBb2bizeLwEqWCF+ukFqafHK6qLl08RythWv9YSxvchtYvKwuwUwy57NsXApBBBTZ6aUgdF2RD
 VDH5DIdzQkwB1+Qtl2DvimVA40YffXkjKFsrTeEVOB6b+GIBIklU0dgpbbKSnlJw3i2I8=
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
index ec2b1d29a26c..d75566a45392 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -346,7 +347,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -504,7 +505,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);

-- 
2.55.0

