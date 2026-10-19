Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C22606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfNXUead
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A225310F306;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC3F10E8AE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:02:26 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-3537f63c9e6so1146668eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792400546; x=1793005346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2RQ5WGjn2LIf6pS+EL+gZuJjI5Zbzl0HNqA1FRv6fM=;
 b=BfNXUeadZ6zaAEfoLGTqvzVjcISCx80nw9gRb0QpUVDuaqNU5kCGRsvoaMAFmkG8hd
 957AOw0j+xFPwEFVUoTzC8YA1aHtjryIeaVlUPueYkfoUI2djzmuQ+btlxQiLfm3++fc
 9vmm/csY9HVZBbu6JxgauoOXm5tG3rRY8uP/Vr062O6v1UFtwBQSNkzoSx4HRljl3M+b
 aaMFSU/RozUMQONJk7H9IYUzm2a02xNJU8LCO1V+vVwNBu3Tq9KpsJ7h9O0LvaRnTNUP
 ekJgFZ8ZlB8gyq6191XJVogTrI3dZ97QytN/XF8seyvJp169HdlYjLdfvbbkzNsZ5U3q
 HDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400546; x=1793005346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w2RQ5WGjn2LIf6pS+EL+gZuJjI5Zbzl0HNqA1FRv6fM=;
 b=1eL7MSCbwvjqvNRuBD4QKKsNDabEHYFD6zWgsEFNHsVvDgAmwSqIs6iEmmLAI7tpGT
 73rYAxlTZZfaKU8yg7ApJ/OP8tdB+p1ws57bnUQfK0T08z5bJurqaEk1Wi7FvFMH+VXz
 LwCJHQCvgsWKwy2lyKo0Wj025vi8C8apYCnELtpKRPUZfSS0J4clMw56q14Hj44yAgXi
 HIOS1e+E6sevmZJxQ5Yxz3r6SQrKHpdHQDfony/Rpv5KKDZiP6B53u+aZbnpekM5mw63
 U/hwOohh7NtYVC2b7YAqI8MJ5j7fTZ+oCWySmRuTunJK6f4c7DOZLAmsVaTpuhGg2HQA
 dTQQ==
X-Gm-Message-State: AFq9FYJ4DwHDUS8vDeJKIPIo9RjA8e9Yg9/zrSpOVDpKUY+7wQWP9WUI
 EcsMVX5MG7LUmiDA/8eVxsKjHx/oBNYSwepemDNDsf7dSVDWQXEROIQL
X-Gm-Gg: AYBFou3yCPjeULgGnr6MDz9yKthu1qGOuAbjwyDUZ71iaqsZJDw0B+ane3WqKVocNNV
 KGKN9uvyAWFL8oSXrxW4smygSY+8uJnBmsFcOC69WGzuFaYoUIrUWpEkZpUQRLfg+JBej0viKtt
 ZXr0OHjgDS6ioch91CavI7N2hwqlJFDan9+uoO0ddddWds+DsEOMXSqNGrb+ac5PTRqMJ/byKMN
 zZ8/Oo5SrDA86JE+K3hrbnY6E62KtH26xefMJE/BEeuOeeQC9kniwidQwYGCbvJT5WYhim28RdO
 mHlhkogBKdHR0JVIbYi5mj08TLBUuuslY0vZWS2k7coMvrKm/Wb7LF+ujBRRhigdZ9JV6fm9I7E
 YThVsMDIHfyZCGyKUlQp7fp710+olKWmgPNDvxqdOkRJDDOaW/dkm1ClhweqOsVFg7QWct2nFAV
 j2ISp0YPf7zm5lqiwVNZdItTEnxkotPiTNND58xrGPy2UUfC/TrUIBv1UyojW2o9eXgyer8yuZS
 1kHoIK9hDTmpYF59y7jtVOO/4o9VOQgXuM=
X-Received: by 2002:a05:7022:5f04:b0:149:1feb:6dae with SMTP id
 a92af1059eb24-18513b9ac38mr8670710c88.39.1792400545600; 
 Mon, 19 Oct 2026 02:02:25 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:02:24 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v4 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Mon, 19 Oct 2026 17:02:05 +0800
Message-ID: <20261019090206.1094958-3-yyaqia@gmail.com>
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

Keep the old buffer out of the rebuild so that it can be restored if
vc_resize() fails: clear par->rotated.buf before calling
rotate_font(), which then allocates a fresh buffer. On failure,
err_out puts the old buffer back and re-selects the blitting state
so tile-blitting hardware gets the restored font's map; the font
change fails as a whole, and the error path never runs rotate_font()
again. The retry added by the next patch still covers
fbcon_switch() and fbcon_modechanged(), which cannot roll back.

Unlike the other callers, this one does not fall back to unrotated
rendering on failure: their "par->rotate = FB_ROTATE_UR;
set_blitting_type(vc, info);" pattern is ineffective, because
set_blitting_type() re-derives par->rotate from par->p->con_rotate.
Repairing that fallback is left to separate work.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v4:

- Restore the saved rotated buffer on failure instead of re-running
  rotate_font(), so that a second allocation failure cannot leave the
  console in a third state.
- Keep the old buffer out of the rebuild by allocating a fresh one.
- Abort the font change when the rebuild fails.
- Guard the rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.
---
 drivers/video/fbdev/core/fbcon.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..7605e4237ca5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2414,6 +2414,11 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	u8 *saved_rotated_buf = NULL;
+	size_t saved_rotated_bufsize = 0;
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2432,6 +2437,29 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the buffer so the
+	 * rebuild allocates a fresh one; the old buffer is kept until the
+	 * font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated_buf = par->rotated.buf;
+			saved_rotated_bufsize = par->rotated.bufsize;
+			par->rotated.buf = NULL;
+			par->rotated.bufsize = 0;
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
 
@@ -2448,12 +2476,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated_buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * one.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated.buf = saved_rotated_buf;
+		par->rotated.bufsize = saved_rotated_bufsize;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2466,6 +2509,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
-- 
2.56.0

