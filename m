Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7583DCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F8D11265A;
	Fri, 16 Oct 2026 07:35:48 +0000 (UTC)
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC80112619
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:30:58 +0000 (UTC)
Received: by mail-dl2-f9.google.com with SMTP id
 a92af1059eb24-143255db95bso293528c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792135858; x=1792740658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K9RBwK9DMLq2lboW1315UiNuKOkVh7UxaSWlYUZP2q4=;
 b=Dgax/CYY3mg6/tdHWyE7ZuWPqUt9RDJ+uZeFjeE0VANilnjxENduA7IZ1029L3+7OW
 Uny914WXdyIRjtZL1HAq5291hISQKN7Nwu7D8sr7wQ3Ze7cs2fmuzspX/nzi/gxppi5R
 19+bK6pze6+kmgtDRliCq0qULRec/DVlwA4mM28P4G6O+sKUiLm30ahCnmcL/nibCiwK
 7JcKAhnCk/5AI/VkUV1HIkRHvQ1U70cPI2Gs2bTu4QEL9aLARSpToEZD3Ya+08Z1RsuN
 Q0Y5cbTqkaMgMJd0aPxVYFloVG6GcCVxAgK4CLMnhvaSR34OgKhxBCipiS+WgoSWi+Xa
 5QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135858; x=1792740658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K9RBwK9DMLq2lboW1315UiNuKOkVh7UxaSWlYUZP2q4=;
 b=UED5JqLq2Dex2715gCI12sTQ4IjvIqjtaRPkoiwZfli1MkWXlmolUVqSKnbgcco8XB
 8SmWsxifAddFko3GPzXns0Xo4pMHECj7qOd0n9e8dWLL8SxH0+Kka8g/LR0AOlttu4fx
 8r4I4iUaQ5oMGTumukdsWmmHBEp+P7VHxR1ZGoUoYyuNCV/r8vaH7KcFq51Q1ylUfdKi
 beUq2+HFn7CYIIU2+gEA7vaUxkgsQ4e7tnFnwmUCyNtwtRrRig/XG/VHnMohduABitwo
 Pgqxdv6RqZ9e9zQDApvjd5hFPR2IaSz4JdYZ74TzMUkm+tcw0oEhyyHbhGFNqLqOtccN
 pXNg==
X-Gm-Message-State: AFq9FYLAj2/wbWuVYD67VjgobEq8eEUiR2aN40VJIqZRvZymtlFMlkqX
 3cH6GLiBOjNH5BZCgE6E57CZazJT4STrzbubMFIU5N6yFDHDmxIh7PZM
X-Gm-Gg: AYBFou0M8EIspC6Ezew+6iPse/RU4RPdLF6C9RwM7riKB74FZmQMRCuC0drUSWsaXgl
 ouHLxA6NkeUfSYIW1bBWZcclO8LRn45e1MrJIBClwMqbbOG2wTarMCuIO/tI3Pw3hqxI9pv/CrB
 Ipo+EK7XacDbI4tAKeCyCHcXNTVhhjFig/iCcuNo3nZK3O8E+OWIeH8dnrCvkySJy9dS2NPleX8
 INQgpHHoX+M9rxbpCu+Zv27Sh+n9rNe3U3vkdLfL0YSiHng2tVAWFiYnh0hZjVzJdJ00PXQBwLT
 pqV10m/gcCzSVfpmlq5RSE5PJ4qmDNbr61MxIxQe9z3tlGiMJd6CNsHKbRMnVc43qLAmusmrt+K
 JTwtwvmlVY/H+vTo22DxYkXvhE7Ozvo7YAHOxqcNarq8MLDWLBsxeq48SoSysmp60zzYvnHbKnv
 21SCp+3OEJmfh0K3cR/2ws3S9GW8AmWU1tGizp3yqvsuC3vnvecTx+Rqz9vCwgHo40NcDLe1bz3
 UVGBmF0oZ7M+LNUAzOmea07lhwXDQAqtDQ=
X-Received: by 2002:a05:7022:5f04:b0:17d:961d:7db0 with SMTP id
 a92af1059eb24-17d961d7e11mr8510456c88.28.1792135857744; 
 Fri, 16 Oct 2026 00:30:57 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 00:30:54 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] fbcon: Include font geometry in the rotated font cache
Date: Fri, 16 Oct 2026 15:30:21 +0800
Message-ID: <20261016073023.490430-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073023.490430-1-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
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

