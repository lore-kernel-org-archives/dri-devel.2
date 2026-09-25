Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D65C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB39310FC0E;
	Fri, 25 Sep 2026 18:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dkdCEFEe";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A58310FC0E
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790361982; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U5xLY6f7551jk6xc6Z9XKWux7TBLtUsmBtG2+NTJIqaSgcZjg6bf64/V9dIVLQgkj+iP9mCwnizKGauezSXNYpN4xdp0rL08KSvtj2TEi56WmJmU4Jsb1conK+1hAVEL/XsIoY0p6+gAkdcYHTNM0L/5VvrNxtN2TySo2c2Goqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790361982;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fCIzVS0GdUX+gQ+3/IeJnAKdmRiDGt1SmeJJDngnL0w=; 
 b=I/vQDGcuaH3Yz+rvVZCbWSDHk81bc+dI6K5ajJMZV7PElvTwlV94W1YAT0HI6AWjlI/4mBxVZFO0KkuCYR0p0nrGl95CrGVVsjrpKctVEFdi/vKUINkHK9Q+p7qbYUNzslHt61n/tUf3Tbckq5MyOnGZLtcs+zayI2Nn7QfzcT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790361982; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=fCIzVS0GdUX+gQ+3/IeJnAKdmRiDGt1SmeJJDngnL0w=;
 b=dkdCEFEe8FCiB+vnzujsHSntysTS3NuUNMxBKJhPYou/NPrLbzxxxoE08vSPSuwC
 zHO6/ZOUHpF7htPk5X+nWPgIxZeUYUbT3FTUSLu5nLcLpkZqV8nYikYCl/MmC85uwmg
 avGlZJzmcvRLL5U5eKoJEF3tOju+urU5GukmH+GA=
Received: by smtp.zohomail.com with SMTPS id 1790361981288183.50898722012334; 
 Fri, 25 Sep 2026 11:46:21 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:30 +0100
Subject: [PATCH v11 09/15] drm/panfrost: Add warning messages to fatal
 error conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-9-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
 bh=MwAqAAJWt4gkpGyl7RgZL1G6QDS7kjbkt724b66TZZA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFESKrxg9vfz2YM1UJVR2N8OeozE+Bhw2g7Y
 qrlEEGtDB+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBRAAKCRAOJn5M7lND
 PQjuC/44tAd6M+zFhv22Rj8rybURT2AgIxSsuwgVGnu4fg5rl/jOzoY178RoyVNsPR9BSn5jnIM
 9asxfGfHWykZofH95COKaXowx6prLc0nM9N0WrUZ52PoDVNTLKjew6N7WmHUVcxjCneYePKV0Ve
 jTA5aMJAWWxaA6E1rEGqxlow+ma1dzS2yHv9bUknB9LlhlZQ+Z5At4jBrDjrUcMU6OiAGjpjSDq
 9mvbvqmf6Ke39bage3ud5JElTmfUIKeiDyN36ijZDJe1Qtt7f2wWtgnP2qqPBCZkQkdACCJUtDZ
 nvNXh60lNVMxGlGooZKBN4uRaNJs2MSImV5OCobatpGoqtLuOQW5eGn26TNe57KTgsS6NM85Mnl
 r1Tp/pzrRbkr4JAl9NRogm9TA4V0gvUmbNZ8HbpMjImrRRt/2kJE79MTUXLbQtE0dTswxraDh7V
 tzhmBhPNHdUUYEDM53QCUAs2gcKxOdtxPLl8TtaSp78rpJ82ILzRqbp2krMKfiMxGfup8=
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
index b8094c0d1252..967cabd18a72 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -354,7 +355,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -513,7 +514,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);

-- 
2.55.0

