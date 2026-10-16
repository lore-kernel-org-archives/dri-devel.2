Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBD3CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B0F112657;
	Fri, 16 Oct 2026 07:35:48 +0000 (UTC)
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A8511263D
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:31:02 +0000 (UTC)
Received: by mail-dl2-f9.google.com with SMTP id
 a92af1059eb24-1397ad3d891so1518834c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792135862; x=1792740662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
 b=it2A+0n37LYL+1W/l1NIz+j/ZpG85XJe9dpaNt+WOJ9u6PD9iiLyoE3i4NFMNtX2PE
 uVOTYk8ZZjii1N713Dbg5mBwdqw5xns0BtFLIIjjn+u0rSfTS7+UdsoebjC37/4CxB/l
 48pKXlY29z7lQyl0CRLv7RyvauNS0VsEe038dma2GrRfNxt/ApFt2c3X/9SdeR8c64Af
 OZtjQ5vaKhFWjl+vxZabxVrPV9hoyZJrqAnyfbnE5hSGT/FBmBIW3TjxrAOb87j//WgH
 HUbNIeZXvonAui8dEuiQ53iDJvd8fEAfi/UajF4/jGhiknrWok75lEwiEdp3tZfPVIbL
 UXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135862; x=1792740662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
 b=td1EFEOJcFWjqAyVU5haQDAFPv6VmsVofl9G519bW3LKoEUx0rEI8aG56SgAqubH0r
 0F4/M7Q+KjZAvSaafpb54cgRdBXQ5t+cL8eijtyoQ1lLzt0SY0Wef/jfEWhC0r4F5f7p
 SKqmIznjheua6RMfJaxThAK9y88bL+J3hWlaaSUaeFhzOLSTN/rhLxa6cNZr7mnF9ayj
 V5q8GqzS14IgTXmZ9nMNUNBLA+T1RF8WI7pMxgPHPNS8nIu4fyw7rBh5LUillf3avahN
 XXwuvfABbWgFEDgbr324l4YvXw/UsA4y2GzN3K7Pkr1HbOc3FfWWiQHRdzYfZHj/IhoR
 bTiA==
X-Gm-Message-State: AFq9FYI0scm7C4yrNcy+7yNQu9VHisAHZ7psf3mExN0Tq53LxuI99Og7
 pNLnURs3xem4HMpfmGEWeoTov3qkIhUxISLi+W7/ifJrnlaZVpSG3OOL
X-Gm-Gg: AYBFou1NnnHdjBQjLuGoi+7yJjpltqen7MaqVYH0y0MqUOVBTil7ayAdF/19qDdSwtt
 qdd1ux2vGnGGbi0V4Wy1WVNq9nQE8A+125ch8/QH8WdUxG0wE2t+A37noweh71M54FhPielsbsZ
 uhwZ44cHM4DkWI3zN1wkawcwQRh8Smb6yoZTdFEHUtHznw32NlN1wI4qfipkUuRCkvbT5qKY/v1
 BQmn7k2IqhnTZrT5VQUz+xs73TZN77EIiaDeAm8VDJGXyRWVcdy6bHXylqSaIn7le1cDcPBhfAV
 ISga2TFIts/DNwdBJZOBzMyuFqJ2Zitw1FvvNL5TJ3mbnkx+JyWOTGApxngTGe1IrYkEk4366Lw
 NQ8DGrBSovpUhbuXglZ7y+5+9y2Qs3BnZOFKB3I1BQIXluchwnnHghlD0fN314atwf982grTkQi
 QEiJrJtfQIxNU6tnEAd43SwcvE43tWvPNsjhR0LIJ3Zpa8gIZOkDyZG7uViRvKlM6h2t+4xrUHK
 V+2t+q7hEuQFZeOnoT79sfCtJLP27RoEoUTa2LSBDNRyYQ=
X-Received: by 2002:a05:701b:2713:b0:143:26cf:8615 with SMTP id
 a92af1059eb24-16a6169558fmr30706517c88.25.1792135861737; 
 Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Fri, 16 Oct 2026 15:30:22 +0800
Message-ID: <20261016073023.490430-3-yyaqia@gmail.com>
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
this framebuffer. On tile-blitting hardware, the same call uploads
the new font's map to the text engine, which previously happened only
when the console was switched. Background consoles keep their rebuild
at fbcon_switch() time, as the buffer is shared per framebuffer and
must not be rebuilt for a console that is not being displayed.

If vc_resize() fails, err_out restores the previous font. The rotated
buffer that was rebuilt for the new font earlier in the function
cannot be restored with it: font_data_rotate() has already reused or
freed the buffer that belonged to the old font. Select the blitting
type and rebuild the buffer again after the restore: the upload to
tile-blitting hardware and the rotated cache would otherwise keep
describing the rejected font, and par->rotated.fontdata would keep
referencing the font data whose last reference the error path drops.
A failing rebuild leaves par->rotated.buf NULL, so the rotated ops
skip drawing instead of reading a mismatched buffer; the next patch
retries the allocation on the following call.

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
Changes in v3:

- Also select the blitting type again in the error path of
  fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
  uploads the font map to the text engine; without the second call, a
  failed vc_resize() left the engine with the rejected font (found by
  the Sashiko review).

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
 drivers/video/fbdev/core/fbcon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..d90a2ad45053 100644
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
 
@@ -2466,6 +2477,18 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Restore the rendering state for the old font: re-select the
+	 * blitting type, which re-uploads the font map on tile-blitting
+	 * hardware, and overwrite par->rotated with the restored font's
+	 * state.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0

