Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CC2C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBE110E58D;
	Fri, 14 Aug 2026 18:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="kIYah7Jn";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F3010E1A8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=f95P4MUmI1ujQc62rr5prDkoqcixRSf+PR0x1gpnLNc=; b=kIYah7Jn4yXU3v566aU3hWuQRu
 z4Fg/wejBgUV06X+QvqHtvL2M+oRX0jQfOVMUBB83kZS9ICihr/DaVuWPSFHQU02tpo2rWQpMg5iC
 dOkLm4KftFSFHVg/DQF5A6Bhe8Unz5N5KswmzYde1I8TcAxu8Fd8E/mbcexvw4Ue8Pk0B2FfPT+Pg
 QpbcRmvQOwqYixTLr4rg7D5aTkHraBTKjshe1HPZGk3T1/r8PzrnLDAtNKnv9ynxe6YMl9TBCwqlv
 DPDitbfxUgzVmxiC2jpTaN0Gkyz4IGJid9tJ72EqASUtMwQAXD7EpMuKIexZUjHq0zHdkcNfQGJNX
 6k1Fjj3Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wuwrT-000000033V3-1SlN; Fri, 14 Aug 2026 18:42:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
Date: Fri, 14 Aug 2026 11:42:34 -0700
Message-ID: <20260814184234.3013510-1-rdunlap@infradead.org>
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

This driver cannot be built as a loadable module so testing for
"#ifdef MODULE" is not appropriate here.
Also, MODULE_LICENSE() is always available.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20260814.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260814/drivers/video/fbdev/maxinefb.c
@@ -169,9 +169,7 @@ static void __exit maxinefb_exit(void)
 	unregister_framebuffer(&fb_info);
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
 module_init(maxinefb_init);
 module_exit(maxinefb_exit);
 
