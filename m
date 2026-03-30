Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55B3FB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5650810E4C9;
	Mon, 30 Mar 2026 09:45:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258AA10E4C9
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:45:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EEC4443DB;
 Mon, 30 Mar 2026 09:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F86FC4CEF7;
 Mon, 30 Mar 2026 09:45:02 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] fbdev: atyfb: Remove unused fb_list
Date: Mon, 30 Mar 2026 11:44:59 +0200
Message-ID: <571a3e072a2eef5a587d768d74559fc549b03ab6.1774863796.git.geert@linux-m68k.org>
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

With clang and W=1:

    drivers/video/fbdev/aty/atyfb_base.c:2327:24: warning: variable 'fb_list' set but not used [-Wunused-but-set-global]
	2327 | static struct fb_info *fb_list = NULL;

Indeed, the last user of fb_list was removed in 2004, while the actual
linked list was removed in 2002.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603300931.osMYxYZ7-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index d5e107730a4d75dd..9fc5af09f86c4df2 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2324,8 +2324,6 @@ static void aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
  * Initialisation
  */
 
-static struct fb_info *fb_list = NULL;
-
 #if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
 static int atyfb_get_timings_from_lcd(struct atyfb_par *par,
 				      struct fb_var_screeninfo *var)
@@ -2758,8 +2756,6 @@ static int aty_init(struct fb_info *info)
 #endif
 	}
 
-	fb_list = info;
-
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
 		info->node, info->fix.id, par->bus_type == ISA ? "ISA" : "PCI");
 	return 0;
-- 
2.43.0

