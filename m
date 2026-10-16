Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808B3CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA76A112642;
	Fri, 16 Oct 2026 07:35:41 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF8310E2E4
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:45:53 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-35aca4e7547so4873345eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792122352; x=1792727152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daqdSqsQywkW4QFvPS0cowFZqZyMXgakPffXgvi9+4c=;
 b=bejbjAfvUxK9AcPnv0gGwyTyQ77q289P4eIrKsmCgvlbRuWM15mMsRpF59yEvu7GNe
 q+Xi9VBsPMqku/upMcAKsNtE75USaH0qOp/4B1NDku/LEwGhxlfe1fUuutB+kbGHyRY7
 W+kUVLUbPH54lXppWDLb/nvPmVhIvtC8+TNIYLLwWSv4VR1mR23w+cZB7cXN5l9+p+S+
 493F433PMw9Lto/8uNxR8heyeHQN601KtjE7ybBxpb34mw0fz0+DN+KHsrlFfNOCiniI
 iF+xVu98J+Yyd/LewnoznuaYkKiE/zjtUACJsI+0h4EZqGDJcjGxNnFJ7ivHqaQDhtkH
 vlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792122352; x=1792727152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daqdSqsQywkW4QFvPS0cowFZqZyMXgakPffXgvi9+4c=;
 b=LZiNOvY9xWIS5bdLHBrPIiJJD1oe+enJ9FtGs/LJ7TE+k2XfAfQmU4YK++xS6TBb5V
 5GVgjmP4rJ2S/bWutvW40IQAEO0Wozz3K3Io9AJBsGWvP5cYKU0mfvdckGHMPEoiw1NN
 2hR5qle0Ot97ZqD2eS8NXSutal0FCTEpYmHw97+XlSN3oOX/RNHweDlniC+MkMO64Bqr
 XGKe3K7p2HxrT928puLdV93xLbcjOXX+qt7CQi4AupdPPbAvTuuIzpL3QVAzljLy6n1Y
 T+0uw6w0+m6e2yHT04QeCRQTH4xxDWzGHvaM35A5RBVNFDr7z3Tdtg90iMGqHwLpuAXk
 C1xg==
X-Gm-Message-State: AFq9FYJ07kD6ktHaheF5gfRNKW5WfdN05LB+R1jw1zkNUK/2mCu3tdWF
 l+U8gAHfeGIyDGPh8xemPtZBtKYXB7HVee/CgZDuA/3fXPRbhltIl32E
X-Gm-Gg: AYBFou1TWQfU8PuGZSqtRtcf+4MLF2zBAY83t3bybKcqCLdbi54VmvrLHdUSS59OJt9
 +oqv76KaeuTPhksBwL16uDce9Y6O5rKWVsYUu0MQI9foSDn+r0h+gDTJ5wkZ/nlGahn/FWF0Mou
 TBMJJaw3nGvC+Hcd+FYtGteUV/80KUKTj6r7DgL3IisjUeenI2DTJpLUXX8BEGys36qaoUM1eM8
 1OrwD8S5EgZvLWgf4VUXUMcU7DI/YGxmIQpYqy+CWqYa/3Ltf+lEY70ePONfNh4jwpzdfAkEAQn
 lLgx9jTNNrf5D1ihmpv4NYhvRUzHtQRo2/VfLNEevImnLcpe8ludV2FB4vKGhfs9GEggq9Q2v1g
 tEentFNmlHSvDFb+iZ59TdkuW1WDx2UBwyv/OAWD2HaNYLp6VHQGdoaDGs7jfLHw4Kd6D45//Yi
 9lbnRAh1DdLhRHa2RKsFT3gcda2SM9WJ2lo54X/8Zi/tdSbi7aD2853R7PxghtSfmZjhHSNNb+S
 LtTPkT7gc58YgkcSGiVwzlM/+Yps+615/uzXZR4QFiVtv3qpw==
X-Received: by 2002:a05:693c:80c1:b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-35e51e5fd78mr8412093eec.27.1792122352334; 
 Thu, 15 Oct 2026 20:45:52 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:45:51 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Fri, 16 Oct 2026 11:45:32 +0800
Message-ID: <20261016034533.445862-3-yaoyiqi3@huawei.com>
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
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the
new font data and geometry are installed and vc_resize() is called.
The redraw that follows reaches the rotated bitops while the buffer
still holds the old font: the rotated putcs/cursor ops index
par->rotated.buf with the new cell size and character codes, so a
stale, too-small buffer is read out of bounds.

KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Rebuild the buffer for the visible console right after the new font
geometry has been installed and before any redraw. Select the
console's blitting state with set_blitting_type() first, as
fbcon_init(), fbcon_switch() and fbcon_modechanged() do before their
rotate_font() calls: fbcon_rotate_font() reads the source font
through par->p, which may otherwise still refer to another console of
this framebuffer. Background consoles keep their rebuild at
fbcon_switch() time, as the buffer is shared per framebuffer and must
not be rebuilt for a console that is not being displayed.

If vc_resize() fails, err_out restores the previous font. The rotated
buffer that was rebuilt for the new font earlier in the function
cannot be restored with it: font_data_rotate() has already reused or
freed the buffer that belonged to the old font. Rebuild the buffer
again after the restore. Otherwise the console keeps rendering with
the old geometry against a buffer that was laid out for the rejected
font, and par->rotated.fontdata keeps referencing the font data whose
last reference the error path drops. A failing rebuild leaves
par->rotated.buf NULL, so the rotated ops skip drawing instead of
reading a mismatched buffer; the next patch retries the allocation on
the following call.

Unlike the other callers, this one does not fall back to unrotated
rendering on failure. The "par->rotate = FB_ROTATE_UR;
set_blitting_type(vc, info);" fallback they use does not actually
switch to unrotated rendering: set_blitting_type() calls
fbcon_set_rotation(), which immediately re-derives par->rotate from
par->p->con_rotate. Replicating that pattern here would not change
the outcome; repairing the fallback is left to separate work.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v2:

- Rebuild the buffer again in the error path of fbcon_do_set_font().
  Without this, a failed vc_resize() left the rotated cache describing
  the rejected font while the console rendered with the restored one,
  and par->rotated.fontdata referenced freed font data (found by the
  Sashiko review).
- Select the console's blitting state with set_blitting_type() before
  rebuilding, like the other rotate_font() callers, instead of writing
  par->p directly.
- Reworded the note about the unrotated-rendering fallback, which is
  now left to separate work.
---
 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..1a2fe9fc1dc2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2466,6 +2477,14 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * The rotated font buffer was rebuilt for the new font before
+	 * vc_resize() was attempted. Call rotate_font() again to
+	 * overwrite par->rotated with the restored font's state.
+	 */
+	if (con_is_visible(vc) && par->bitops->rotate_font)
+		par->bitops->rotate_font(info, vc);
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0

