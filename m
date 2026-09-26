Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6359FCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEFE10E894;
	Mon, 28 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mdPxfJLN";
	dkim-atps=neutral
X-Greylist: delayed 93264 seconds by postgrey-1.36 at gabe;
 Sat, 26 Sep 2026 14:32:25 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC86910E049
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y8
 uk6acIn5+spuh54iSxJYMKnZSAnNC7gMYO6fVnpnc=; b=mdPxfJLNwx6YY83Auv
 0fPtxCpADKcY1v1wYNv32qUC0ZvLsOXL893lisG/QlJD0Q2BKsE5qblUVzySUSFS
 2KKW42/Tr3NwRGLuSM/fgqLNBq/xVu8qYv2HoQetOxTiOtbSgSMdhcZ8QBi0Cr4v
 TTTpBEg4OqRt1aY53FoiEQNOA=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3N5Y117dqTFyMAw--.64413S2; 
 Sat, 26 Sep 2026 22:31:19 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Mihail Atanassov <mihail.atanassov@arm.com>,
 "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] drm/arm/komeda: Fix early runtime PM NULL dereference
Date: Sat, 26 Sep 2026 22:31:16 +0800
Message-Id: <20260926143116.3457144-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N5Y117dqTFyMAw--.64413S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkGFWUKw18WryUuFWDXFb_yoW8WF48pF
 4UWF4UJry8GF4ay3srAanrZFy5GayfX3y7Ar1Uu3Z5u345AF18tryDJryvyFWUtFZ5AFnF
 grn7XF4xZFsayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU1OJnUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzReLxWq31zfhbQAA3l
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

komeda_platform_probe() enables runtime PM before publishing the driver
data.  The runtime PM callbacks dereference the driver data, so a
callback running in that window dereferences NULL.

The debugfs register file is created while komeda_dev_create() runs and
its read path calls pm_runtime_get_sync().  The DRM minor is registered
before dev_set_drvdata() as well.  Either path can invoke
komeda_rt_pm_resume() while the driver data is still NULL.

Publish mdrv immediately after komeda_dev_create() succeeds and before
enabling runtime PM.  This guarantees that runtime PM callbacks always
see a fully initialized mdrv->mdev.

Fixes: efb465088518 ("drm/komeda: Add runtime_pm support")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index 67fffab018ae..82efa74199be 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -73,6 +73,8 @@ static int komeda_platform_probe(struct platform_device *pdev)
 		goto free_mdrv;
 	}
 
+	dev_set_drvdata(dev, mdrv);
+
 	pm_runtime_enable(dev);
 	if (!pm_runtime_enabled(dev)) {
 		err = komeda_dev_resume(mdrv->mdev);
@@ -86,7 +88,6 @@ static int komeda_platform_probe(struct platform_device *pdev)
 		goto destroy_mdev;
 	}
 
-	dev_set_drvdata(dev, mdrv);
 	drm_client_setup(&mdrv->kms->base, NULL);
 
 	return 0;
-- 
2.34.1

