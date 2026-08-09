Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAF3C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 23:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B62110E0D3;
	Sun,  9 Aug 2026 23:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="iaiM43SR";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F1010E121
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=LXOlse/Rb/skFPgnAyQvYUyvUw8UGb1ABBFvABcCKdQ=; b=iaiM43SR7OSQsNCn0zcja9PIDy
 ausYqS859P8EXog17H3JWyYMFvz5WPAfKEypSMonPSJ/QIMiA/5LQ6lbkA0BcSHmo2gSfefkTONzT
 OVZEUjXxh2GJEUAS8ND2rUiyZKfl5XOWmBVrAJjR4d70jJ9tbu3bFeiCGRFfzpX1X6XZ5kNuCGi48
 nAlFDJfAkGC9IADnIjNmLqqeq2khwz9e2nAMViSdDWE5Rso9sekLwnn6Kablc+NoZZn3r2oLprBnk
 RCV0TucFBzOLkFid3oXosOv5FvhWk+QL4xl/h/gcALrUQrQDOKYAWH/FJQT4lWz7naOlXDaVNwU0v
 YmPtdraA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wtDFS-0000000Aq3X-45Jv; Sun, 09 Aug 2026 23:48:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
Subject: [RFC PATCH] fbdev: maxinefb: fix build issues
Date: Sun,  9 Aug 2026 16:48:10 -0700
Message-ID: <20260809234810.982500-1-rdunlap@infradead.org>
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

This is all ancient source code from the beginning of git time.
Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.

Fixes these build errors/warnings:

../drivers/video/fbdev/maxinefb.c:64:6: warning: no previous prototype for 'maxinefb_ims332_write_register' [-Wmissing-prototypes]
   64 | void maxinefb_ims332_write_register(int regno, register unsigned int val)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In file included from ../drivers/video/fbdev/maxinefb.c:34:
../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_write_register':
../include/video/maxinefb.h:16:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
   16 | #define MAXINEFB_IMS332_ADDRESS         KSEG1ADDR(0x1c140000)
      |                                         ^~~~~~~~~
../drivers/video/fbdev/maxinefb.c:66:49: note: in expansion of macro 'MAXINEFB_IMS332_ADDRESS'
   66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/video/fbdev/maxinefb.c:66:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
      |                                        ^
../drivers/video/fbdev/maxinefb.c: At top level:
../drivers/video/fbdev/maxinefb.c:74:14: warning: no previous prototype for 'maxinefb_ims332_read_register' [-Wmissing-prototypes]
   74 | unsigned int maxinefb_ims332_read_register(int regno)
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/video/fbdev/maxinefb.c: At top level:
../drivers/video/fbdev/maxinefb.c:74:21: warning: 'maxinefb_ims332_read_register' defined but not used [-Wunused-function]
   74 | static unsigned int maxinefb_ims332_read_register(int regno)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_read_register':
../drivers/video/fbdev/maxinefb.c:76:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   76 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
      |                                        ^
../drivers/video/fbdev/maxinefb.c: At top level:
../drivers/video/fbdev/maxinefb.c:114:12: warning: no previous prototype for 'maxinefb_init' [-Wmissing-prototypes]
  114 | int __init maxinefb_init(void)
      |            ^~~~~~~~~~~~~
In file included from ../drivers/video/fbdev/maxinefb.c:34:
../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_init':
../include/video/maxinefb.h:22:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
   22 | #define DS5000_xx_ONBOARD_FBMEM_START   KSEG1ADDR(0x0a000000)
      |                                         ^~~~~~~~~
../drivers/video/fbdev/maxinefb.c:119:20: note: in expansion of macro 'DS5000_xx_ONBOARD_FBMEM_START'
  119 |         fb_start = DS5000_xx_ONBOARD_FBMEM_START;
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org

 drivers/video/fbdev/maxinefb.c |   17 ++---------------
 include/video/maxinefb.h       |    4 ++--
 2 files changed, 4 insertions(+), 17 deletions(-)

--- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
@@ -61,7 +61,7 @@ static struct fb_fix_screeninfo maxinefb
 
 /* Handle the funny Inmos RamDAC/video controller ... */
 
-void maxinefb_ims332_write_register(int regno, register unsigned int val)
+static void maxinefb_ims332_write_register(int regno, register unsigned int val)
 {
 	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
 	unsigned char *wptr;
@@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
 	*((volatile unsigned short *) (wptr)) = val;
 }
 
-unsigned int maxinefb_ims332_read_register(int regno)
-{
-	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
-	unsigned char *rptr;
-	register unsigned int j, k;
-
-	rptr = regs + 0x80000 + (regno << 4);
-	j = *((volatile unsigned short *) rptr);
-	k = *((volatile unsigned short *) regs);
-
-	return (j & 0xffff) | ((k & 0xff00) << 8);
-}
-
 /* Set the palette */
 static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			      unsigned blue, unsigned transp, struct fb_info *info)
@@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops
 	.fb_setcolreg	= maxinefb_setcolreg,
 };
 
-int __init maxinefb_init(void)
+static int __init maxinefb_init(void)
 {
 	unsigned long fboff;
 	unsigned long fb_start;
--- linux-next-20260807.orig/include/video/maxinefb.h
+++ linux-next-20260807/include/video/maxinefb.h
@@ -13,13 +13,13 @@
 /*
  * IMS332 video controller register base address
  */
-#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
+#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
 
 /*
  * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
  * is 1024x768x8
  */
-#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
+#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)
 
 /*
  *      The IMS 332 video controller used in the DECstation 5000/xx series
