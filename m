Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C715DC5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E7310F59E;
	Thu, 13 Aug 2026 23:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="EVliN0QM";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D13210F59E
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kM2TD3DfowE2cKLzEA2GjNOhlCpAPeFQCX6hfajS8yc=; b=EVliN0QM38cMZWlTNeL5gCPy+K
 VZf8RdAyKQjW0nqTlXmuuoXsdZgBvHa+6IU2eXU4o674tbZdCIK94Ii9YpzNDXNw6wjrvuiPPOE5P
 oqUUHUayH/SAiYnNDZBd6UJHN7FtqEEhqudlkncym8zppzWnzi21UWxzeFnbzM6kCj5ndUglmNsJO
 MhFIONmM49ulnLh/6/wrfaeVl2i6Um0RCx0ad+KaMtRYNSx6m60aYvjk68vvlodQIYspy3yMm5kNw
 aqMWFt0FyKO5/MJksDXnIUsT40ZmGlD9BPyoFeZOlBXwZ+0zzE3mdyUm0lE7YRswTyNXIyh/U8wLp
 K7JLJeVQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wuerf-00000001k8D-2Tqz; Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 02/03] fbdev: maxine: elide an unused function
Date: Thu, 13 Aug 2026 16:29:33 -0700
Message-ID: <20260813232934.2718291-3-rdunlap@infradead.org>
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

maxinefb_ims332_read_register() is not used, but since it describes a
hardware interface, leave it in the source file as documentation
and surround it inside an #if 0/#endif block.

../drivers/video/fbdev/maxinefb.c:74:21: warning: 'maxinefb_ims332_read_register' defined but not used [-Wunused-function]
   74 | static unsigned int maxinefb_ims332_read_register(int regno)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20260812.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260812/drivers/video/fbdev/maxinefb.c
@@ -71,6 +71,8 @@ static void maxinefb_ims332_write_regist
 	*((volatile unsigned short *) (wptr)) = val;
 }
 
+#if 0
+/* dead code: leave here for hardware interface documentation */
 static unsigned int maxinefb_ims332_read_register(int regno)
 {
 	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
@@ -83,6 +85,7 @@ static unsigned int maxinefb_ims332_read
 
 	return (j & 0xffff) | ((k & 0xff00) << 8);
 }
+#endif
 
 /* Set the palette */
 static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
