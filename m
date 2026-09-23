Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F96C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070CF10E877;
	Wed, 23 Sep 2026 09:09:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D44110E877
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:09:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3101C601F0;
 Wed, 23 Sep 2026 09:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830B91F000FF;
 Wed, 23 Sep 2026 09:09:41 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Helge Deller <deller@gmx.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] video/logo: Improve logo help texts
Date: Wed, 23 Sep 2026 11:09:38 +0200
Message-ID: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

Since commit dfa6ce636cb8faea ("video/logo: allow custom logo"), the
LOGO_LINUX_{MONO,VGA16,CLUT224} configuration options no longer control
the inclusion of the "standard" Linux logo, but the inclusion of
(possibly custom) logos specified through the correspondig *_FILE
options.

Adjust the one-line prompt to reflect this.
Add long help texts while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/logo/Kconfig | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index cda15b95891ed3a8..3cb66ac88d6be0fe 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -19,7 +19,11 @@ config FB_LOGO_EXTRA
 	default y if SPU_BASE
 
 config LOGO_LINUX_MONO
-	bool "Standard black and white Linux logo"
+	bool "Black and white Linux logo"
+	help
+	  Include a monochrome (black and white) Linux logo.
+	  This logo can be shown on all kinds of displays.
+	  Say Y to show a logo on monochrome displays.
 
 config LOGO_LINUX_MONO_FILE
 	string "Monochrome logo .pbm file"
@@ -36,7 +40,13 @@ config LOGO_LINUX_MONO_FILE
 	    magick source_image -compress none destination.pbm
 
 config LOGO_LINUX_VGA16
-	bool "Standard 16-color Linux logo"
+	bool "16-color Linux logo"
+	help
+	  Include a 16-color Linux logo.
+	  This logo can be shown on displays that support showing (at least)
+	  the standard VGA 16 color palette.
+	  Say Y to show a logo on color displays that are limited to less than
+	  256 colors.
 
 config LOGO_LINUX_VGA16_FILE
 	string "16-color logo .ppm file"
@@ -55,8 +65,13 @@ config LOGO_LINUX_VGA16_FILE
 	      -remap drivers/video/logo/clut_vga16.ppm destination.ppm
 
 config LOGO_LINUX_CLUT224
-	bool "Standard 224-color Linux logo"
+	bool "224-color Linux logo"
 	default y
+	help
+	  Include a 224-color Linux logo.
+	  This logo can be shown on displays that support showing a palette of
+	  256 or more colors.
+	  Say Y to show a logo on colorful displays.
 
 config LOGO_LINUX_CLUT224_FILE
 	string "224-color logo .ppm file"
-- 
2.43.0

