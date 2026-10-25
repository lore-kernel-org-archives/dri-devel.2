Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3A606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LLyjpEmk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79DF10E08A;
	Sun, 25 Oct 2026 21:30:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A0510E08A
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 21:30:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 150DF10B4D8; Sun, 25 Oct 2026 22:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792963832;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=jj1MjgOd7ph17eSLnFe4gEdUh/YrPp8vDaEc/Ca1zL4=;
 b=LLyjpEmki+TFrSIFf1nvZW/KdeHT7Z9a+irrY2XsElQfX3WG2r0KNb2xz0K2zocLSUTdKp
 rAlCnHRQYdYd/lALV7La4xrDOxXmKndkILZ9LYMgNaYlv0X9qH+WQl27vcox9hd3EYERYL
 1/dR7tqwq/TJrKqeNzgh2emioedvGMpu6erdkIekOHw2dTfrps++mrWRPhVnZL/UlR33gW
 oZzHE3mql/gmN2H+axAs9YYgxGMyprGtHsQjH8vILTbLmP4A7zwWo1OlNrgn/skvJLbmv3
 3jr5T1b8BhoUUnGS0gLyWbzfF0pSUYQ+bcQIQdGmXjkWMneA+koXf41KS9KGZA==
From: Marek Vasut <marex@nabladev.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@nabladev.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Li Chen <me@linux.beauty>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Ole Carlsen <ole.carlsen@tutamail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [PATCH] Revert "nouveau: pci: quiesce GPU on shutdown"
Date: Sun, 25 Oct 2026 22:30:06 +0100
Message-ID: <20261025213027.842978-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit 310326bb7df4bba094a3fc60364c641c547fd923.

This breaks shutdown on ThinkPad W510, without the offending commit
the system normally powers off, with the offending commit the system
ends up spinning indefinitely and the CPU fan goes full throttle on
shutdown.

The behavior was already reported in debian bugtracker multiple times
for various other computers too, and git bisect lands as this commit.
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1141969
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1146033

I tested the revert with Linux 7.2.12 from debian unstable, not next
or drm trees, mainly because it was easier with debian test-patches
script on that machine.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Li Chen <me@linux.beauty>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Ole Carlsen <ole.carlsen@tutamail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Uwe Kleine-König <ukleinek@debian.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: nouveau@lists.freedesktop.org
---
NOTE: Maybe the revert is not the ideal solution, but it does fix my
      problem, and I think being able to shut computer down is a good
      functionality to have.
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 32 ---------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5e1336615cf6d..36c74f9edaa83 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1090,37 +1090,6 @@ nouveau_pmops_resume(struct device *dev)
 	return ret;
 }
 
-static void
-nouveau_drm_shutdown(struct pci_dev *pdev)
-{
-	struct nouveau_drm *drm = pci_get_drvdata(pdev);
-	int ret;
-
-	if (!drm)
-		return;
-
-	if (drm->dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
-	    drm->dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
-		return;
-
-	ret = nouveau_do_suspend(drm, false);
-	if (ret)
-		NV_ERROR(drm, "shutdown suspend failed with: %d\n", ret);
-
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-	/*
-	 *  This is just to give the pci power transition time to settle
-	 *  before an immediate kexec jump. it’s mirroring the existing
-	 *  nouveau_pmops_suspend() behavior, which already does
-	 *  udelay(200) right after pci_set_power_state(..., pci_d3hot). In
-	 *  ->shutdown() we’re allowed to sleep, so I used usleep_range()
-	 *  instead of a busy-wait udelay().
-	 */
-	usleep_range(200, 400);
-}
-
 static int
 nouveau_pmops_freeze(struct device *dev)
 {
@@ -1480,7 +1449,6 @@ nouveau_drm_pci_driver = {
 	.id_table = nouveau_drm_pci_table,
 	.probe = nouveau_drm_probe,
 	.remove = nouveau_drm_remove,
-	.shutdown = nouveau_drm_shutdown,
 	.driver.pm = &nouveau_pm_ops,
 };
 
-- 
2.53.0

