Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC72CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3BC112978;
	Sat, 30 May 2026 18:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ROKBlRoG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C02112977
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kigU0OurTXgZm9DCTOVylrqR0vRm4WQF5qVMCutlFSM=; b=ROKBlRoG+iTISb0HHbTRVnybr2
 nTncv6HBWPACwiR1dt2104/AtOc4vbkAq/E+9tNiAcoY4aulcZd57qAZMDS+zYGi7akknRSqijVN0
 5C5QS7RXzXTGTnjTxSpiEGPmz5ynpENMeAYnQ9ozYiwVwHHAZDcBuk49zOM4SFh/JEKvbKfxG0GnC
 Tm5UHGl6imqKKkvoOBPykvRwbZhu8XZy51Tyzr3Oudyp9mXIxQhzciXQDrnW/ET2/cNSy43S32Z/o
 v3uBQd59C+brub5h4HCeBCiYRcKtn/NcUJUtH366OngActxLmL5iExv/wMkfneFffxjT14iQ9OCDR
 Dilqfg3Q==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTOZY-00ALNh-UT; Sat, 30 May 2026 20:38:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 15:37:45 -0300
Subject: [PATCH 4/4] drm/v3d: Reduce PM runtime autosuspend delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-4-c2c8307da6ce@igalia.com>
References: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
In-Reply-To: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=WVLGlzOVL1IZbsD1OPq3GwQVsIl44h9bQZM6JL357f0=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFnSep27X7FuPHXoVM6lM99LRNs1D+d9nS1rM3nx6+oVj
 nYBxyqmdDIaszAwcjHIiimy/HgSW8soVs6uuaz8IswgViaQKQxcnAJwo304GG50FIhUdPydO9m6
 K1SvorP49cpbrw/qy9kV2EQa+SguNQ/9LCtRsX2pt+CJlRpl+c8L4wUKpjNx/UgILm3Ymcrxv6H
 S/ruC+3eTG6lmRf/PrH6se40xPDPxzH12rxdf1I+/E7tgKsGq0RZv+W9yxrcpIi0SfhceS3fMvn
 s1ODzfIJXtytetR1yPud655RT7/ufPyK873vkvae42ipeyd0/+dPN84K9N3h/4bhfp2xmUuEan7
 RT5otO/s86QYcLRlxcLTkglf6tIWDDhgMO1DeuPnKzNS9rflGHxVem+oW6XnWWG371Vt5QjkkM+
 SH57+DHcW+bgrlBje4lZ8lVOLaK2NeYXc7kPH4qUkl4CAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The 100ms autosuspend delay was only ever a workaround: shorter delays
caused more frequent runtime suspend/resume cycles on the BCM2711
(Raspberry Pi 4), which exposed the cache and MMU coherency bugs as
random GPU hangs.

With those hangs resolved, the inflated delay is no longer necessary.
Reduce it from 100ms to 50ms so the GPU power domain can be released
sooner once the GPU goes idle.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index fc81dd1247e3..805d84435ee0 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -420,7 +420,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	ident3 = V3D_READ(V3D_HUB_IDENT3);
 	v3d->rev = V3D_GET_FIELD(ident3, V3D_HUB_IDENT3_IPREV);
 
-	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_set_autosuspend_delay(dev, 50);
 	pm_runtime_use_autosuspend(dev);
 
 	ret = drm_dev_register(drm, 0);

-- 
2.54.0

