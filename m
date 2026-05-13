Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F934CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BC110F082;
	Wed, 13 May 2026 20:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="l65gntyR";
	dkim-atps=neutral
X-Greylist: delayed 603 seconds by postgrey-1.36 at gabe;
 Wed, 13 May 2026 12:15:45 UTC
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCE810E305
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 12:15:45 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [112.10.223.127])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e43f8521;
 Wed, 13 May 2026 20:00:35 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: tomi.valkeinen@ideasonboard.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 getshell@seu.edu.cn, jianhao.xu@seu.edu.cn,
 Slavin Liu <220245772@seu.edu.cn>
Subject: [PATCH] drm/omapdrm: avoid double drm_mode_config_cleanup()
Date: Wed, 13 May 2026 20:00:34 +0800
Message-ID: <20260513120034.182-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e2135cf9603a1kunm47f9c4fb6587c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0pNVklMTksdS0tNSkhMHVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSklVSktVSUlIVUpJTFlXWRYaDxIVHRRZQVlLVUtVS1VLWQ
 Y+
DKIM-Signature: a=rsa-sha256;
 b=l65gntyRAbfrjpZsAnTZmep7Yla+HAobTstcsS2Iu0zzceCC5StCYR3ci5iCFLATIleyfvTQQfXErjCI8qs0gEsZ2vuHE8rGkp112cFPnabLlj7RtrETXFPy6OtWtrGjd+/LehALrR9nuAQu8tx4PBk5J0DordEBIpJSesyjO4c=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=Xa0d+UNBMZwuB0ZCYSY8W+dd2tOK9S8K+AuU2bmHfsw=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

omapdrm_init() unwinds drm_vblank_init() and drm_dev_register()
failures through omap_modeset_fini() and then falls through to
err_gem_deinit, which calls drm_mode_config_cleanup() again.

omapdrm_cleanup() has the same problem during the normal teardown path:
it calls omap_modeset_fini() and then calls drm_mode_config_cleanup()
again afterwards.

omap_modeset_fini() should only undo omap_modeset_init(). The
drm_mode_config_init()/drm_mode_config_cleanup() pairing already lives
in the top-level init and cleanup paths, so keeping another
drm_mode_config_cleanup() inside omap_modeset_fini() causes repeated
cleanup of the same mode_config state.

Remove drm_mode_config_cleanup() from omap_modeset_fini() so each path
cleans mode_config exactly once.

Fixes: 2f95bc6d324a ("drm: omapdrm: Perform initialization/cleanup at probe/remove time")
Issue found using a prototype static analysis tool
and confirmed by code review.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index bf0bad8c8cf1..838a1a236160 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -538,8 +538,6 @@ static int omap_modeset_init(struct drm_device *dev)
 static void omap_modeset_fini(struct drm_device *ddev)
 {
 	omap_drm_irq_uninstall(ddev);
-
-	drm_mode_config_cleanup(ddev);
 }
 
 /*
-- 
2.50.1.windows.1

