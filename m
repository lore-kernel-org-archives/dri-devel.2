Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A7C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A64E10F5A2;
	Thu, 13 Aug 2026 23:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="yXQTj52Q";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD9510F594
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=j/xHcrj4xyL74ydO2CkiHOif5W5/Vh+Dsdgi9S/OuXU=; b=yXQTj52QIAbsvUAtGE+xsxtalo
 iAtQ/L/izVMWbFjLgPUZ1F6WMKS0PVm69SDhSjLTvSadTovaZ0Om5d8wj+Oz4+5Lo8FM2r/Tk6sn4
 CGwk01GWWpDN+6494/gGCZUl0TC9OVWRBPQr/zhKcidnfe0RAnrpa1UhFssfruUhQN6vK8qd6DPpl
 PdsXa/2bB8uECToFJx8myFfWmk4EdlxMY54WKvLYSr5iVrU8yi3wCpQr8bdQz2v5mT0eqSZZHGqmh
 xgq9tL2vuqPdYYqRf25R/Xa0gBdHpt7P+dpYhhPaM3X6aGkI8TWAl+Omw/6GamSSPuJYFsKhbIuWo
 0ntSuutw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wuerf-00000001k8D-3fbO; Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 03/03] fbdev: maxine: fix 64-bit build error
Date: Thu, 13 Aug 2026 16:29:34 -0700
Message-ID: <20260813232934.2718291-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813232934.2718291-1-rdunlap@infradead.org>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
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

The KSEG1ADDR() macro is only defined for non-64BIT builds.
Use the CKSEG1ADDR() macro instead.

In file included from ../drivers/video/fbdev/maxinefb.c:34:
../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_write_register':
../include/video/maxinefb.h:16:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
   16 | #define MAXINEFB_IMS332_ADDRESS         KSEG1ADDR(0x1c140000)
../drivers/video/fbdev/maxinefb.c:66:49: note: in expansion of macro 'MAXINEFB_IMS332_ADDRESS'
   66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
../drivers/video/fbdev/maxinefb.c:66:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 include/video/maxinefb.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260812.orig/include/video/maxinefb.h
+++ linux-next-20260812/include/video/maxinefb.h
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
