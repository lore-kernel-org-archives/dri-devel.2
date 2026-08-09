Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065B8C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 16:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046F10E17F;
	Sun,  9 Aug 2026 16:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="o1TPQ6a8";
	dkim-atps=neutral
X-Greylist: delayed 544 seconds by postgrey-1.36 at gabe;
 Sun, 09 Aug 2026 16:26:51 UTC
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr
 [80.12.242.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D24210E126
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 16:26:51 +0000 (UTC)
Received: from device-101.home ([10.65.86.60]) by smtp.orange.fr with ESMTP
 id t6DbwZeJ9kV7ot6DbwrWtd; Sun, 09 Aug 2026 18:17:47 +0200
Received: from device-101.home ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
 by smtp.orange.fr with ESMTPSA
 id t6DYwVSUk9pEKt6DYwIjtx; Sun, 09 Aug 2026 18:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1786292265;
 bh=KN9TULj4LFJAhcy9BTobkr11FxLmc4WeUlnGkANIOrU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=o1TPQ6a8vtshQgv8uSVnf0y0f3dvDr9XIszATtE9G4EGSDqtnz8U0eCJHD0SgVV4w
 B64HUDVeoGRmW2Zz6KKNWAzBH5xvU0bSUH0jiNEcx+iAJRywjXSyXsSXWn6CIaGp7Y
 gGTi1fhhEs59qD9Lq+ismRlu3CzjMTnGH99t70XCOHYZMPVBSasHamvD6xL4dxYLpK
 zFVMbvwG90kc7PIMx3VywfDrvucy6LgTV8nh0itoF1ebMgWSpnzbirH/gr8CWVoYus
 X0JlaiGS5loiy6sPrlxRJww8olVTdzXJIBYtx+xo8MeVJ6JdxXphWiPuW7L277zrr4
 vf/X/k0BzBQpA==
X-ME-Helo: device-101.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2026 18:17:45 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] accel/amdxdna: Constify struct xrs_action_ops
Date: Sun,  9 Aug 2026 18:17:39 +0200
Message-ID: <77aa53d77dbd4dccf8b2dc9de3641f22ca46055b.1786291298.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

'struct xrs_action_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  55888	  17696	      0	  73584	  11f70	drivers/accel/amdxdna/aie2_pci.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  55952	  17632	      0	  73584	  11f70	drivers/accel/amdxdna/aie2_pci.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/accel/amdxdna/aie2_pci.c    | 2 +-
 drivers/accel/amdxdna/aie2_solver.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index daec1f6b4907..71045c72df60 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -285,7 +285,7 @@ static int aie2_xrs_set_dft_dpm_level(struct drm_device *ddev, u32 dpm_level)
 	return aie2_pm_set_dpm(ndev, dpm_level);
 }
 
-static struct xrs_action_ops aie2_xrs_actions = {
+static const struct xrs_action_ops aie2_xrs_actions = {
 	.load = aie2_xrs_load,
 	.unload = aie2_xrs_unload,
 	.set_dft_dpm_level = aie2_xrs_set_dft_dpm_level,
diff --git a/drivers/accel/amdxdna/aie2_solver.h b/drivers/accel/amdxdna/aie2_solver.h
index a2e3c52229e9..0b1ca7a4b800 100644
--- a/drivers/accel/amdxdna/aie2_solver.h
+++ b/drivers/accel/amdxdna/aie2_solver.h
@@ -111,7 +111,7 @@ struct init_config {
 	u32			latency_adj;    /* latency adjustment in ms */
 	struct clk_list_info	clk_list;       /* List of frequencies available in system */
 	struct drm_device	*ddev;
-	struct xrs_action_ops	*actions;
+	const struct xrs_action_ops	*actions;
 };
 
 /*
-- 
2.55.0

