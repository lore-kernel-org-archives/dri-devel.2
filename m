Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE6606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWblnJrN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC0C10E803;
	Fri, 13 Nov 2026 13:43:29 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5FC10E663
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:56:24 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b1535be329so354830a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794531383; x=1795136183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
 b=wWblnJrNCG7r/p9/NkUxPfdQtX3rjGSMdvIoHKICo/e452RUhc1RWTBxLpYt8pzuHI
 vAbZfHgnfmfxNVBJ31b8SKct2buv8ftUzRtoA5fBP9qo31GHynzRBkG92k4Z8HoOsTBy
 LPq/2KDfNjoGvzvPZJlYzjY2taeewoY3Gk7MnHQVinn6bkG6SKpGGUQ8ZotHp640z9HP
 iyXqE0MJRscFuW61aYXO/pHwvr0ojKDmZjkgK998AoIVIFe+2adiyUnzbYc7e2La4SGH
 cgAnnwRw6juCYN9glC9+cPRFPmgBfnSJVI2o1qQAWMks/VOHPBi9w+MXUyO6+pxaKk3Q
 rrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531383; x=1795136183;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
 b=KB1X5vVLwWQI0h9FfF/BrHGOvRg0GdVBJ7elui+F8MhFc0rGtltFFTOHWxHkhXLkvT
 lbdVFDszzMKmybRth2/VuYJCFiu50ABG6JY7pdXRnyhRSiG9zfaNcxeU4C1BiY39upJI
 pjv56LbuUh23QBLx1V7dmfGdMAqMAgWcF33ozUYN2MKtBTWzDkT6VGOAF7KWYDli8Yt0
 Uh64/u4UOXxWMxAYfGDSpxyT4YC3jW7sLmxdQeDOeQMaz9K8UYrK803za/LvhTZC/5et
 lKMFiOlBaEhfT+cHoe9XTuQBDmP4gTczIkcbuF3qmX3Gcar20tXVQiijM3XENckvSkIR
 YDPA==
X-Forwarded-Encrypted: i=1;
 AL+hErGJNXPlE9BZqASftHO1xqIr/0acoa+nEFICuq6q+fgQnOR18GaTvVgXORG0KG0pcJ7GRc0SyR/4f+I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/smkkv44vptnXMUjlpuK/sG9KruooZ/vytf1q8wIHoKjHfLbD6
 NKfW3pW4Wkt4eJcrrhNf/tMkRLqq9D37X74kEr82ppuhYomAFxSb2uxr
X-Gm-Gg: AYBFou2WuJsJikvULIgePdaKiqo+yuwPXAUl39MO7kjujLqFg1qvc9isobn26PQTQhQ
 PLR/tlzFYTa9lRtUh/SKgZOIcT61db+VA/UDVKctgNL6wtIgaWxUMnyBaqhnzV+1aEJ2Qyb1NYC
 5zpciEmLgl6xJaQL8NDa0FNLD2UEOA0Q3DKAyAupreXHw2lQ7a1Ke4abJ5bspwX4ljEejB1e9AT
 ETkFNk62tVyxjJPAGr/5v3IlPb2MEZquK1XxJxWFt6DR7SicQX49jzWkp9eu3N4fdW8w65cXYW6
 46dZpPY2Js4sgTS0za3iG1z/OI+qsh+omrGeYKPDRs00TVieP/imQnMaj+4UsPOFOJH3O3+sYfv
 UUsGJS9tpmEFfvHGDPWmUgcugBoOZ0lRisoU2kGFznMzeimmrR0HlskYqeXCULWQ/v8zrynSNyD
 q4I8fZHyUMxvudBIahkCS1srFHtmcMK2xx9LqXgWbBnUh7FfYi33jrVt4gkFFppnRB2xVaRfzDf
 wTR2Oe2fRyA6++a3HeHNKQm01HjXuEzV4LY/o+lYTrXAnHxPREzGbnsaSFJ/xR36rOL5sMDABk5
 NILWTgqAfFkFab3nlWDjrcaMxT74sqTlU8+Rs5KOjdDnUQ5COWtlzayEWZNyp8ECawp8RaeA/Fd
 CNWx/psMdy0lX0vEpV3tIx1J24CM7m6HUbIddueOpext+cwAOAaH3roDNewz21pyk3nUd5SJ0AF
 t376Zya47eCqrA/5T2wzdANjCWZA9yX3l14TLxq5u+a77izGn1+C1CMDztK1ukkLSjh8AnVTmH6
 ssmKIvqQHDVoqw3J6XESgsF
X-Received: by 2002:a17:90a:d883:b0:3a4:b74a:795c with SMTP id
 98e67ed59e1d1-3b1b09f3b50mr619305a91.16.1794531383375; 
 Thu, 12 Nov 2026 16:56:23 -0800 (PST)
Received: from lenovo.localdomain (42-155-215-210.ipv4.nexon.net.au.
 [210.215.155.42]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f75c86asm2351735ad.23.2026.11.12.16.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:56:22 -0800 (PST)
From: Miro Kropacek <miro.kropacek@gmail.com>
To: deller@gmx.de
Cc: geert@linux-m68k.org, schmitzmic@gmail.com, lilinmao@kylinos.cn,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Miro Kropacek <miro.kropacek@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] fbdev: atafb: Restrict SuperVidel handling to the Falcon
Date: Fri, 13 Nov 2026 10:56:16 +1000
Message-ID: <20261113005616.402721-1-miro.kropacek@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A framebuffer at 0xa0000000 or above is taken as being in SuperVidel
RAM. A TT with a VME graphics card such as the Nova has its framebuffer
there too, so in 8bpp it gets the Falcon palette registers instead of
the card's VGA DAC, and in 8, 16 and 32bpp the SuperBlitter, which it
does not have.

The SuperVidel exists only for the Falcon, so check for the Falcon video
hardware as well.

Fixes: 51df976c3268 ("fbdev: atafb: Add support for further video bit depths on atafb:external")
Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
Cc: stable@vger.kernel.org
Reported-by: Christian Zietz <czietz@gmx.net>
Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
---
 drivers/video/fbdev/atafb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index c32576cb1720..5d9265caa9ab 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2065,6 +2065,15 @@ static void st_ovsc_switch(void)
 
 #ifdef ATAFB_EXT
 
+/*
+ * Only a Falcon can have a SuperVidel; a TT with a VME graphics card can
+ * have its framebuffer in the same address range.
+ */
+static bool ext_is_supervidel(void)
+{
+	return ATARIHW_PRESENT(VIDEL_SHIFTER) && external_addr >= 0xa0000000;
+}
+
 static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 {
 	strcpy(fix->id, "Unknown Extern");
@@ -2083,8 +2092,7 @@ static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 		 * SuperVidel 8bpp chunky (fb in SV RAM) uses the Falcon palette
 		 */
 		int visual = (external_vgaiobase ||
-			      (external_depth == 8 &&
-			       external_addr >= 0xa0000000)) ?
+			      (external_depth == 8 && ext_is_supervidel())) ?
 					 FB_VISUAL_PSEUDOCOLOR :
 					 FB_VISUAL_STATIC_PSEUDOCOLOR;
 		switch (external_pmode) {
@@ -2181,7 +2189,7 @@ static int ext_encode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
 		var->transp.offset = 24;
 		var->transp.length = 8;
 	} else if (external_pmode == FB_TYPE_PACKED_PIXELS &&
-		   external_depth == 8 && external_addr >= 0xa0000000) {
+		   external_depth == 8 && ext_is_supervidel()) {
 		/* SuperVidel 8bpp chunky: palette has 8 bits per channel.
 		 * Without this, fb_get_color_depth() sees length 0 and
 		 * fbcon falls back to its 2-color palette — the console
@@ -2245,7 +2253,7 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 		return 0;
 	}
 	if (external_pmode == FB_TYPE_PACKED_PIXELS && external_depth == 8 &&
-	    external_addr >= 0xa0000000) {
+	    ext_is_supervidel()) {
 		/* SuperVidel native 8bpp chunky scans out via the Falcon
 		 * palette registers, honoring all 8 bits per channel
 		 */
@@ -3336,7 +3344,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 		memset (screen_base, 0, external_len);
 
 		/* framebuffer in SV RAM: enable the SuperBlitter */
-		if (external_addr >= 0xa0000000 &&
+		if (ext_is_supervidel() &&
 		    ((external_pmode == FB_TYPE_PACKED_PIXELS &&
 		      external_depth == 8) ||
 		     (external_pmode == -1 &&
-- 
2.43.0

