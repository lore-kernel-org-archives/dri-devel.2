Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD16C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 19:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5C910E5F0;
	Sat, 18 Jul 2026 19:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="2xRR8kIh";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6400C10E5F0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=BNHLUNHyQAHE28eE+/Gt2t5Riz8NHTo+92Z3v7bQho4=; b=2xRR8kIhUsE9uAVhm2hC89iZ5D
 htNbZcNxD2XC7DqvYagvPdfVX43HAG4kVkaBcGQNS1Uqyt1+ajERmfc1JUl+nwAwuvzIFGimfI4xQ
 4BBVq1W2eIn2/dxhI2gWPaV1xON87J8Le6DComxYHQnahH+8APegeJNXohVcb/DJns8wRUAOv93wC
 raoYADFsFhTCyeGa7MRjuYRdABx2VPgGIL96YNrhspQT5sD5BRCHQYmyzzepdRkmPzJ/cFuQafNg6
 dSzXlJ+h/twNymvkuvwyHAeA399PLUz7K/N5BYeSMkC8UzlSJBhxFr6W3Wp38Jz7nc/wCcP2x0/2y
 UJVvA2+Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wlATW-00000004TSa-3Our; Sat, 18 Jul 2026 19:13:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH] fonts: fixup font.h kernel-doc warnings
Date: Sat, 18 Jul 2026 12:13:26 -0700
Message-ID: <20260718191326.1907423-1-rdunlap@infradead.org>
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

Use the typedef keyword when describing a typedef.
Add the missing function return value for font_glyph_size().

Warning: include/linux/font.h:84 cannot understand function prototype:
  'typedef const unsigned char font_data_t;'
Warning: include/linux/font.h:53 No description found for return value
  of 'font_glyph_size'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org

 include/linux/font.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20260717.orig/include/linux/font.h
+++ linux-next-20260717/include/linux/font.h
@@ -49,6 +49,8 @@ static inline unsigned int font_glyph_pi
  * scanlines, which is usually the glyph's height in scanlines. Fonts
  * coming from user space can sometimes have a different vertical pitch
  * with empty scanlines between two adjacent glyphs.
+ *
+ * Returns: the number of bytes per glyph
  */
 static inline unsigned int font_glyph_size(unsigned int width, unsigned int vpitch)
 {
@@ -60,7 +62,7 @@ static inline unsigned int font_glyph_si
  */
 
 /**
- * font_data_t - Raw font data
+ * typedef font_data_t - Raw font data
  *
  * Values of type font_data_t store a pointer to raw font data. The format
  * is monochrome. Each bit sets a pixel of a stored glyph. Font data does
