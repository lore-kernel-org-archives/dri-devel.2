Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39E606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=leOEFay9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC9610EB96;
	Tue, 20 Oct 2026 07:36:37 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D588510E570
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:43:49 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-36374abd904so858457eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403029; x=1793007829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
 b=leOEFay952uuzpNNJ5Pspy6eAJHvaRp1rixf+org5piOTgmGxF2C/30dihSkzI7/jO
 5A4JcaKwbyt3tlSGM1v+I9VcebccSkiJHfLTc+NHKms1nGUmacVO1OFVA/3HV9L5BmnS
 5ulzpRsLFwEEjlqRuYqsFTV/e38NjM+9H9FUVn3RJFqcMUfyOhAzzTkwDhMW09xGowrE
 kporl7Sb/pk6IYa8Dvcocs1dG0wT8zppPbXEyG1esaaHcNHaGzhHP3njxPUjq8AUnNVS
 1Oz2kpwUpjVsyYRfSv0xOPq7DzJw9tVRrfOCMbpevCGdFa5ejQmhfpjMdkTt25ZPQsC4
 Z8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403029; x=1793007829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
 b=ORq5wbPe12aOm2Sx554y5yS99IbI5W5d7zJlrzS3YbafshAuCsG4jptp7GZaE3/FTX
 48rNxphtYfifB9CZBL7bacJ0R4a/0wsehoxmWIcwNEfY3YQw6xTMKy/P4epaTSf5yl11
 ykI6y9q7yON9vOT+j7nM+maKcIhkEU6v9qvp0Y2QsropdxLdeIOsFEhxz9S4PL+Nbg3F
 1pVUTRuENKd3Gx5NY0b3hZr/HUfSgPubUkyT5+PIvfaVry7CHItcoC6kNJIi9jh4lijh
 quMmcrqgNJdBzYxhB75V7tS5Awlzcd+FW/MXidMFcLx7GjBU6tTrJ8uZgQuGz7murFPa
 3GgA==
X-Gm-Message-State: AFq9FYKI0qbfTK3i8wFrdUvdQfLyHlhcCt1hFcr/Qw8hhy5vqyeIbvVR
 EnD0wy1b/jmE/PZ0F3zJbpNO5eqHc6hYb0m4llzIl3e9OlFX7OBr92e6+lj2Nep22DlQig==
X-Gm-Gg: AYBFou0AnGkB6ep6F6Gl0Uqri4cK5XKoH0YAdqbb/u8oxke/lvzeyt5b4ePdDoCWGKh
 LGfaq2OyEa6I0kI5GOT9Hdhs5z0+9ak+3ESvl8PjwiqrGP49+Y3DdrPwEHGk19ue/Vue8Wq1nDC
 qDZIEDyvg0gcIvj5ewUhPvFlRbkby2XNuWg2pOGj19jZBzhEH9Gw/ICUjl0hguYajt2xjUcRu7e
 pjdSt9QhTukW8s4jp5dCEUvgeplUoo0riLf2dwze/mrfgi4QL1Pbs7MWWya43mWoqnzpB6r+ZBb
 CIfpXulwIA6IaOZsT7tsb4TX7y3272HS9V0FXGsV6zG85aBe/ZKNGcETXsa+xGZ0Go4XaCEoRSd
 Y9O6ChVsqoRs4VaQu7LslRTVBYW7pzWj1fCrHrcnF7UBHyhYhNJFMl8xCIqYPMPQOT0lLIInfUc
 eyZosVbNONVLdM4hAK7/zydHS6wStOKKwdzyXbs0S5OoT1kdlVuwTReZj9CnJnqdqHci1HownYW
 Kx2QL4nePjJX6ilWSnqDJVGQr2/C9h2Q3RM
X-Received: by 2002:a05:7300:ea0b:b0:35d:8c39:b31f with SMTP id
 5a478bee46e88-361a2a3e8f4mr10129688eec.35.1792403029024; 
 Mon, 19 Oct 2026 02:43:49 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:43:48 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v5 1/3] fbcon: Include font geometry in the rotated font cache
Date: Mon, 19 Oct 2026 17:43:29 +0800
Message-ID: <20261019094331.1128871-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
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

