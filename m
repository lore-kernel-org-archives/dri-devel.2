Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA983CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F91112659;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4206E10E3F9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:45:47 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-35adc681e1aso2618969eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792122346; x=1792727146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0y1dJ5AAiyMzBzdNY5zHpT5jRGPheygtScQcJ1Wvm4=;
 b=VC7UU71PrS0uK/VWUShe42Wr/s3BT2Vt3TNoZDQkeSRwM9W6x0BlTefRXnnjo17a6M
 5ECfP9lyUOLN9BzxLmf3bErphbC0rAp8h8ELPM3kE2nOH72zFV889/IGiS/bwVIsxzsd
 tY1FfXoHm0eNH104ZK3+di3v0knfjxNgZXnJSvOSw2JPAEjBg4aebVqvE68Bo6PCMUhN
 AdRIU/S6fNQQX5ZiaeflRgpbntJ3+HGQIOq/yt/EOD/uloLschn/P4viey+TTEcR83Vz
 JA2NaLfz1MNUbcqkCDLr5At5YMyN1LFrqX4vNSD/8owXQ9xwK1IqUvCb4xV+VDlS5Yu/
 4xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792122346; x=1792727146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0y1dJ5AAiyMzBzdNY5zHpT5jRGPheygtScQcJ1Wvm4=;
 b=LLJN6+oZnY4cTdqKQlbR/uxjHWcXzUPOyUygP6l+1Xi4iXDJWJVr2sgyUThmJas8lQ
 ljuVGijGqGaAZXwbE16MQKCcVc60xaJBJIvlwBQ/MSF6zMebp9x8jej88OX3Gp0RGxY6
 g+p/WP+5N+iU1V1y0YgRpQKj1AldaBfLf8WKyzEFQ2C4zPZCPyTf8L8LrNGlo97ItvoR
 WDRM1vXTRJ4ZXLmG7/Lauv9DaSO+PvXdqJKZISe3OeBAz+/pRGN7mglV6jaG3TlZS7ZN
 75ZsZ0nzXEQEcVbPqdNMcOn/h3C0Tg1Ma+zf5MLiz1eDhyUgEBbzkIrb9IXpvRg6izdM
 EB1Q==
X-Gm-Message-State: AFq9FYKKSKIdNSepmo7YHzoy53nMJ9Fe1kupvFmbUdsRPDYeJ/zq1FQO
 Rh+2VyQh3HwlONWHTGyZ3EikcJifKtglrF10JlKTH5fLigMNPiiZjwJz
X-Gm-Gg: AYBFou2LezBm8b3YFqWmJ4FGYoL9cn86k3TAMkWzqtSTCBItimUYcJarqaWFf5K7HYV
 ptO7tQKu3j/2l4fXD7Xizh4ZyG38wO7nchOK28YrxKq6Gfir527HDwG+s01WghmlAkx0h9MRcmb
 3rqgEkMXLZxyfMd5ZzyUCYp0QrP2Ea4MC6HSmfcAUPI1VrQjmnt7Ll0UdZneCq5hlxOzYtK4qXj
 ciP/aAU06QICsxz5rAPlY+QF8uwlo5Yz3yc0P20JGy+DsL+oFPCZqpOzNNm2EpePr2bIwwOELmM
 7mCPZjjSm3dYARw8nKcMvlsZ9JrDCeCYvvUoyzVdDcYmbYnT/6FRetrN1tJ1rlwBWE+zWHQz6sE
 zcWL4J8rOQp34I1q2Ch4+/8VeuPwUCsBIyafGmWdJ+yfgyePeZf2Xob5QZmJ/yCnTkxuHw4hdr4
 XrcLpksh8MNrPs0oamdUTkKA4pnRtA/RQXJe2vxfomUhK4yx1zavx1xgpnIIdrxnKuOc0ZTK9ys
 xuv9AG9on4GAJVq/GGl3Z//IpQGV1164N+buv0=
X-Received: by 2002:a05:7300:c8cb:b0:35f:f4c3:6403 with SMTP id
 5a478bee46e88-35ff4d2b879mr3439491eec.36.1792122346157; 
 Thu, 15 Oct 2026 20:45:46 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:45:45 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] fbcon: Include font geometry in the rotated font cache
Date: Fri, 16 Oct 2026 11:45:31 +0800
Message-ID: <20261016034533.445862-2-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

From: Yao Yiqi <yyaqia@gmail.com>

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf and skips the rebuild when the cache appears to be
up to date. The cache is keyed on the source font's data pointer and
the rotation alone, on the assumption that an unchanged fontdata
pointer implies an unchanged font.

That assumption does not hold. Raw font data (font_data_t) stores no
glyph geometry; width, height and charcount are tracked separately in
vc->vc_font. When a font is uploaded, fbcon_set_font() deduplicates
it against the fonts of all consoles with font_data_is_equal(), which
compares only the byte count, the checksum and the raw bytes. Two
uploads of the same data that declare different dimensions therefore
end up sharing one font_data_t, and a console can install a new
geometry while its fontdata pointer stays the same.

The early-out in fbcon_rotate_font() then skips the rebuild, and the
rotated blitting routines index the stale buffer with cell sizes
computed from the new geometry:

	src = par->rotated.buf + (scr_readw(s) & charmask) * cellsize;

Rotation swaps a glyph's width and height, so the size of the rotated
cell depends on pitch rounding and differs between geometries. A 4x16
font whose 4096 bytes are re-uploaded as 16x8 on a CW-rotated console,
for example, grows the rotated cell size from 8 to 16 bytes, and the
largest character then reads past the end of the 2048-byte buffer that
was built for the 4x16 geometry.

The key has never included the geometry. Its exposure was limited,
but not eliminated, while the deduplication in fbcon_set_font() also
compared the consoles' font widths and total byte counts: with the
charcount restricted to 256 or 512, differing uploads could then only
trade height against charcount (such as 4x18x256 against 4x9x512),
and even those can change the rotated cell size. Commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped the width comparison, so identical bytes now share font data
across arbitrary dimensions.

Record the geometry that the buffer was built from and compare it in
the early-out, so a geometry change always triggers a rebuild.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.h        | 9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..bfbd70f8b1cd 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -89,10 +89,13 @@ struct fbcon_par {
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct {
-		font_data_t *fontdata;  /* source font */
-		u8 *buf;                /* rotated glyphs */
+		font_data_t *fontdata;       /* source font */
+		u8 *buf;                     /* rotated glyphs */
 		size_t bufsize;
-		int buf_rotate;         /* rotation of buf */
+		int buf_rotate;              /* rotation of buf */
+		unsigned int buf_width;      /* geometry of source font */
+		unsigned int buf_height;
+		unsigned int buf_charcount;
 	} rotated;
 #endif
 	u8    *cursor_src;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6..660a3fa81bae 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -21,11 +21,18 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	unsigned char *buf;
 	int ret;
 
-	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
+	if (par->p->fontdata == par->rotated.fontdata &&
+	    par->rotate == par->rotated.buf_rotate &&
+	    vc->vc_font.width == par->rotated.buf_width &&
+	    vc->vc_font.height == par->rotated.buf_height &&
+	    vc->vc_font.charcount == par->rotated.buf_charcount)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
 	par->rotated.buf_rotate = par->rotate;
+	par->rotated.buf_width = vc->vc_font.width;
+	par->rotated.buf_height = vc->vc_font.height;
+	par->rotated.buf_charcount = vc->vc_font.charcount;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-- 
2.56.0

