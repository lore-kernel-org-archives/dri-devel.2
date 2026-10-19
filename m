Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EC606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PBU11DbF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C886210F2F9;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2BD10E927
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:43:56 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-3514af07fb4so874963eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403036; x=1793007836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
 b=PBU11DbFF4CkE+jTFxKwzwvF7IhH2Pk7g64RaE5dcuSlHUdY0W6tRlmc5WlHCnEKJO
 POwXLFiV6ysTvFg/nIplbuJnhq1s3T+axeEuQatP8KwiRwQLyr9r9iLSufc/vLPg3QYE
 mWDrlJwNZs/4WXFQ+MMVy9q+AzaICkZPRr6ne+HiOLJET/1z65DFeeA0cr1lwaGuTV45
 /gWw1ZScfxc0l7xbkN+TwfUcTjyz6qrUw+qMDwcE4+8Pxh2sWdruygLfo0GW5rAxgxRA
 0o904ZlftPqYSNICMrK8y6lF3kK5BkouYu3E4km8M3IR/ZuM9j+vhkLdkSqhH0S8J+cY
 6ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403036; x=1793007836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wD2WIpjKVnC6AxNSYVPPB4T+WOtPpt82EYJQTf5ufN8=;
 b=u3HhMfk44EtqgQtt8xWO2qFtxuYvG2IUhWj3gxO83laay6S+fzMxw7CEej379mWntM
 jltjPjIUdkIchPDKu8VfAUb+QqoLIHm8m7OU1HRpwR5Yh+wOM7QeYlTBHs1wpLMHMiKy
 m0tWrboqpMWCNvvSObu1s+ALIGG4rgNeN+1odORIww3K8T3C3mNB3xPkjzMtQYS+SKlG
 HMiP3Ayw8vb9p4E2hoptz5kwEmCZn5s4J1aS7xGitsv0qxyF4qLsuQ33sJClQ4oX087C
 NoaLFsbljur8hRcGwlIM7+/1/1RD8twPCpurJNyMKjhTkurhQA3wSSvdvhlCtwQvHYq7
 LBzg==
X-Gm-Message-State: AFq9FYLW4H6YSuengkFljUVMgfCjhp3tq6TQO7+sGtFYUwqdSeImpNiB
 T/rDdrPEqXj6fnLjOfTuSK3lTJC2plRiopb/vCBPefiURulXWUBFZ9/I
X-Gm-Gg: AYBFou2bPhy+aTA8w/7kCmIBubKMPGmCL1+V59/mysxTxq74U2Mxf0gTJmMK99WW0+b
 v0aJyuWchiF1d64AOon1hM2mSpax5fGlE8xUvA+LnOhdAawn005dcbsR1HFz021LMXz1EWfUAYY
 MXrmVXve4i8NUBhK2auyNTIJgpZiQfAOJr1ZTfkKDMCrj62ec3HyN/lz4tzl+ouji6U+fBl8eCk
 489qZH6uSZnfSJ6b7r+7aG4aw8VQSDmUMVaa9HFEYYZBrFBmbo3gDuAy2h5KxsjzxcWDjIVgOhq
 Fb0mXuXkQ5HswasF9Zf6UQ6QTKPRGmeiBXNEGt6kHRpQ2zTXWOIlw10BjMdyuqvOZn3zc3poipd
 zCmfF/CNytC0AwzzR/NGvZE2udMjwr7ggcnW9c8dIqhhLtxaovCso7vL8XQXlpFzFA7S2YUhM7h
 pFrvM2u2qh5QKcVo4K4tK7cw66HRDtUoiLiQSok+l9ZaPyfpwru1QOMMUo3hdk2qyiQSdjKUFi9
 4rOtZBFxhcg7ZOQKOmw0BEnGDUyWDgPSPc=
X-Received: by 2002:a05:7300:a214:b0:35e:ebb1:8e5a with SMTP id
 5a478bee46e88-361a1b5251cmr9702651eec.26.1792403035840; 
 Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:43:55 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v5 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Mon, 19 Oct 2026 17:43:30 +0800
Message-ID: <20261019094331.1128871-3-yyaqia@gmail.com>
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

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the font is changed through KDFONTOP, the new geometry is
installed and vc_resize() redraws before the buffer is rebuilt. The
rotated putcs/cursor ops then index the old buffer with the new cell
size; KASAN reports a slab-out-of-bounds read in soft_cursor().

Rebuild the buffer for the visible console before the redraw, as the
other callers do: select the console's blitting state with
set_blitting_type() (which also uploads the new font's map on
tile-blitting hardware), then rebuild. Background consoles keep
their rebuild at fbcon_switch() time, as the buffer is shared per
framebuffer and must not be updated for a console that is not being
displayed.

To ensure a correct rollback when the rebuild or the following
vc_resize() fails, save the rotated font state, clear it before
rebuilding, and restore it in the error path of
fbcon_do_set_font().

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v5:

- Save, clear and restore the entire par->rotated state instead of only
  the buffer. Restoring only the buffer left the cache key describing
  the rejected font, so a later switch could take the early-out and
  index the smaller buffer with the larger font's geometry. Clearing
  the whole state also makes the rebuild unconditional, so it does not
  depend on the next patch's buffer check (found by the Sashiko
  review).

Changes in v4:

- Restore the saved rotated buffer on failure instead of re-running
  rotate_font(), so that a second allocation failure cannot leave the
  console in a third state.
- Keep the old buffer out of the rebuild by allocating a fresh one.
- Abort the font change when the rebuild fails.
- Guard the rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.
---
 drivers/video/fbdev/core/fbcon.c | 46 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h | 22 ++++++++-------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..9a5d50d69d00 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2414,6 +2414,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct fbcon_rotated saved_rotated = { };
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2432,6 +2436,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the cached state so
+	 * the rebuild allocates a fresh buffer; the old state is kept until
+	 * the font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated = par->rotated;
+			memset(&par->rotated, 0, sizeof(par->rotated));
+			rotated_saved = true;
+#endif
+			ret = par->bitops->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2448,12 +2473,26 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated.buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * state.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated = saved_rotated;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2466,6 +2505,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Re-select the blitting type, which re-uploads the font map on
+	 * tile-blitting hardware.
+	 */
+	if (con_is_visible(vc))
+		set_blitting_type(vc, info);
+
 	font_data_put(data);
 
 	return ret;
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index bfbd70f8b1cd..a618adf3c871 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -72,6 +72,18 @@ struct fbcon_bitops {
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 };
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+struct fbcon_rotated {
+	font_data_t *fontdata;       /* source font */
+	u8 *buf;                     /* rotated glyphs */
+	size_t bufsize;
+	int buf_rotate;              /* rotation of buf */
+	unsigned int buf_width;      /* geometry of source font */
+	unsigned int buf_height;
+	unsigned int buf_charcount;
+};
+#endif
+
 struct fbcon_par {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct delayed_work cursor_work; /* Cursor timer */
@@ -88,15 +100,7 @@ struct fbcon_par {
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-	struct {
-		font_data_t *fontdata;       /* source font */
-		u8 *buf;                     /* rotated glyphs */
-		size_t bufsize;
-		int buf_rotate;              /* rotation of buf */
-		unsigned int buf_width;      /* geometry of source font */
-		unsigned int buf_height;
-		unsigned int buf_charcount;
-	} rotated;
+	struct fbcon_rotated rotated;
 #endif
 	u8    *cursor_src;
 	u32    cursor_size;
-- 
2.56.0

