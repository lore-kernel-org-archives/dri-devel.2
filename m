Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C4606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cfXsvK36
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DBE10F2F4;
	Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2B510E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:02:22 +0000 (UTC)
Received: by mail-dl2-f7.google.com with SMTP id
 a92af1059eb24-1433e7b05b0so456239c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792400542; x=1793005342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
 b=cfXsvK364j8G3hXfiu8EQuA+MSDPbnrKtPtT8cY2fkP9iwUGJeaVFMd7SGkHHNNkxD
 Bdi79lvSnEXw/Q8RSQzYhMoeUeL0UXic4yraMetGfvz8YRUqPU81h0RJSv8LEPwK1/12
 U5o44RtnsSELeXzoqQpTJ3jxBgYUPAHtkGX7GoPhEYoK17Q8pUEpC36KWWF9WR3sFuIz
 gIdx0zFDOrneZHPalMM3KO6+s30GIWZTzreevVuRPtZa3gxt2mNqpTVFYgGvKhozUsaC
 X887uoaG5FPvGGl8y4WtBd58dL+FPLbIYQP4lAAqwQlGFD/5lfxotG3WMDB8m2Idgy6Z
 Ar9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400542; x=1793005342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
 b=BO7RO2bllkkTkBQOcprDtIQWzlbbTOn3APqBZAtJ3YeDq+DN+eFDAJoUocd7jEAWkt
 zpZY63oC/33vLNsTeIl41XiLXWFVDce+nZNnf7UfWs42xI44shXVwwonthE5r6E8GLj0
 N8JcTVNgDI2400zDJY6vJ5ch4z9SAZ5j0xA6mVKVhOpEBz7WxupjcAtF0N+JuObuszI2
 JayFQi9dspaes50Tv7pgt2TVs4y9L9DrIN+HCzu2NXddnBWMte0jNSz56hJhk+0MO+2W
 CSLnP+EGqBxRJAAxVGtu7yo79D7KyHMGIwDItF9qhyGkSDlhMKrQyGbOLGPfEa2Ce2qF
 X8PQ==
X-Gm-Message-State: AFq9FYKmJvsqCzkqfEpx+DB0joFPWuoT85GN6LPuAMReKrHZfSONmClP
 90SWtEnYvlePPVfc6As40StWOeYAMWcWyDlpjf6U5M63r649tQV/Ao31
X-Gm-Gg: AYBFou0qzKXcUTOnpRhA0mYwFmJciBRanw/WUVXLtoMz/q2/SQQy0sl4QZVh9DVwQEz
 ou37lvXLi4FC3o2KWVNnKU1nQIxvA86CDMgI/5JGnNl3baRSE2JEZLwGgLwu5AP605o9lxCQK9w
 vTZwvHz+hA78d47f7b69xVR0pJBuCLGSqIzCWyA1cGPbvGlA2TdDyMuuGW8HQE5/i4RQfgkvjpo
 A+67lT1eoDgr+lPocOmM5Ru64DLqgwx5JkP8OnOrpkQNJAGEo8BkoQbFmur2AKyP4VVYO7+DISQ
 UPGcekaWy6vLpSWP4vRSeje4ES+ovtAaJnsUTaAnOzQ/tu+7V1uzVedU1CUJIrencDOpgU3YOij
 Uao54HcNt55wVucIWPE/kSygKnF2PUndTRSdgXHyiJKLgDFicT61yEo4hofeUrvNpX8zWaDmAhf
 Y6OCA2HvDJC4m3hTLod3PB3ecK4cnxCSI8LRnjzLRs3Is+DveVqHljVRYPEsl9ZrHl+Zya1e5Ek
 zbtRylqlG1RsNFx/qf/waBpKvUzkh4gIyk=
X-Received: by 2002:a05:701b:2601:b0:151:f0c5:7a09 with SMTP id
 a92af1059eb24-18513b99fd0mr12384383c88.43.1792400541807; 
 Mon, 19 Oct 2026 02:02:21 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:02:20 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v4 1/3] fbcon: Include font geometry in the rotated font cache
Date: Mon, 19 Oct 2026 17:02:04 +0800
Message-ID: <20261019090206.1094958-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font and
skips the rebuild when the fontdata pointer and the rotation match.
Raw font data carries no geometry, though: width, height and
charcount live in vc->vc_font. fbcon_set_font() deduplicates uploads
by byte equality, so the same bytes re-uploaded with different
dimensions keep the fontdata pointer while the geometry changes, and
the early-out skips the rebuild.

The rotated cell size depends on the geometry (rotation swaps width
and height), so the stale buffer is indexed with the new cell size.
Re-uploading a 4x16 font as 16x8 on a CW-rotated console, for
example, doubles the rotated cell size and reads past the end of the
old buffer.

Record the geometry the buffer was built from and compare it in the
early-out. The pointer-only key used to be backed by an explicit
width check in the deduplication, which commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped.

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

