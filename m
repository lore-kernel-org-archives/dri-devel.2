Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B76C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1821F10F6FD;
	Thu, 24 Sep 2026 18:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Yy8F/eqD";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EA810F6FD
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790273431; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CLW6kt5V3tN145zz9RMsb3vhxMAOsKstvB5IbFTOOZZPUIPq0nN27sl5avM8+SiwRVj7kM29XLM6L1RetHrAaplB9r02PYXFfHFgEOizdGtzEOMzSOKNsp6cXxE7Aex+qY1lRttEN1dXxKta5UUVLfp3NQ0q4HlKJELnVbsm7TY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790273431;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WGZqj8I3PYqtK1XojY7l/9Se3j42ujPk2rp3W3Jcudg=; 
 b=Cg3KUavL/sXiwzPr93vj6z2tRWiag0X7WghYq8ShCx6cNjXboBADjNlZzpFqHYJLOmILYNInLKiSsDCJisVUW3ARbXOtlup3jHNU0ZSW4vroL0RVbFwMxq6gJTXhMI4gTdcKlIciiRXgTPtPc4MyIxodeESwxvzZ5bVVC7GZafc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790273431; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=WGZqj8I3PYqtK1XojY7l/9Se3j42ujPk2rp3W3Jcudg=;
 b=Yy8F/eqDDam9QQMTQLyUJWI92gQj0HBNV3oJJodzqgIvLPGbS4oxGq4fTqgZQvT0
 zot0nImfM4yuF7f8CbtZRsRXC6Gw4qwP1wM64S03lHpv2QjCAfEAnTcMQ3HchAv40Qz
 hf7pulqVLFiheMWiFopv+RjwmL99zfrUU4LvHcNc=
Received: by smtp.zohomail.com with SMTPS id 1790273430339196.4844061871114;
 Thu, 24 Sep 2026 11:10:30 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 24 Sep 2026 19:09:26 +0100
Subject: [PATCH v10 09/15] drm/panfrost: Add warning messages to fatal
 error conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-claude-fixes-v10-9-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
In-Reply-To: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
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
 bh=jfnaD7OhoWMHnuX7Wt42p9Iz6j/oSc1hvb6/iC6KKqs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtWdZO2jAPDdoGbukJCzm2XR9CsVKmFUIsUPur
 oBt112045SJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarVnWQAKCRAOJn5M7lND
 Pd/aDACzX2DHvHwM5FwYRxQ35mVzuxCjn6k+42YsycBOTrCq1XHOKipZadqbjRuabW9KlViK84t
 jQLSH2pGiQjEo0lU0cYZBBbYHUMHc9HMLaH5OfDu86PWqRrRQjni/ytgXP675Hi8d7WPhiSgCLy
 LuFOKvo2xPmfagBb72mb//q5hwr4V0jbijtgNqzq73xH3nNlO5LLqs89iYC7Y5KxgQlomiWk54T
 89QwKQurl0YTSrnCXiMP/yloTzGnei9KDETtDIKhKM/GOoNm6wLCTY1/2NCoe+Skd/AwvmwAdZW
 KJBeLJUdI786TMOMkkyB/JK9ffmbm6YYYqANmfJWGPWmEo4hpH9/Q9BTETT7DYmvVtb/dv6aPsB
 llyjvCZnIlZzky+8NhjyF0FI/875vtwrThAfwNke3MmcDowv11b/tc4jJybdMxjYTVWitghSOvW
 fdKSFjMi0dUH3f6iL96Fj1HRez85rOzR0akhXQ9z+qVtatAPMiCcpFaX04w+IiF2y/LKA=
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
index d531bada62f6..e6de71e99ab4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -350,7 +351,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -508,7 +509,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);

-- 
2.55.0

