Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DECC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A330B10E830;
	Wed, 23 Sep 2026 07:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMZTPQPt";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED82D10E403
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:10:05 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso2121385e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790143804; x=1790748604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzigS/BodMBW2I1kmdTZEpfx589O3xIFW3xCJjMx4pU=;
 b=DMZTPQPtqaPIz97neJzqeRhd/aLMeYPq1dNhkc9OyI8shBROskJ6wR0fmzdlHB2mip
 cm+vMSS+EQlCA7LchVbFlzdNvbzOOFdT9vwinfDTMIcDkxnE5Cg+Pv1wcvQ7lzGH/CqA
 wcBJM8gncdJ0jBHFMvRzUrKsnNq5pmh9tTXCVL8Ek9/8tBZCg755bjhvgvhXXAtaVuzV
 aMU9PQozdmMMJa81in/iwH8MHLGtJFpPmWa1we+khJ++G8ga7Fi4CqT3PVd2fTP1sbbz
 4qblc8MIsLFbbGXXmkng017f8/2PTeiKpL8YTWtl3yOkf0/JnK27a7vf6gJ+j9F01FbK
 Etdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790143804; x=1790748604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzigS/BodMBW2I1kmdTZEpfx589O3xIFW3xCJjMx4pU=;
 b=2CHd8w3sJLFvcK5PDqupf2aYYsRoRk5AgzMzlgzmAb1fkdOhQTWlDWOh8qDuCrcpfh
 +HQkO2ZXmDXyWAtrG46TXXmArgz744/iyoSTG6r9sbg7HL0y2l8E+doz8a5a0GE++rIF
 LYlm+DLVbp6I9MokQTYD9GRtZSAyvwHbQ69Rvy0SbNYsjk0FEdw8kVkdrd6V/otXVGui
 MCHpNHZsxZ+I6rvyOqXs45KFu+IwauUTnJl9uh8p6cAMVSkATOQOWygqm/cLvbg3GGkF
 KJtQVs5ws3iLqZZ5Hxe+aMZyagNbyMFOWN1byKzF7GIB1G3YIuA/ezVnRJPS8nh/n7Sl
 MGPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe36esZvcEs5BCcXvWLB3W8uJzcRqQRtUdpVXFY++hSpDN2L3ZwWVYezWrc77ur0uHMoDRmraqtWY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klHwKBeCRLcjCA6I3Lm2B3E/hHAwNXshGU8o2tcswdGW6rShMj
 faw33fzSnGfwxmAWgWaMItZnX7wQbymHzfsFgMCbbKGhVwOTrMSEkeNf
X-Gm-Gg: AYBFou3kUy/MvqNYxsygZySRNhcdwRkjD1KVM2ASXYgfGRtX0ddkOT+MO6zo5N4+j4F
 XWgrBCmaDUVUnx4nUszJIpikjmac3Fk1ljy/T24bZdA7bEk1RUpy/Fw7uV3skPVZV+tjU77KiHV
 +ViOZALtXt9wy3x/TLekW2/9GW2IHrFDVYPJUBe3qslaEnmEyYjT0UOhdT2ZgFmwhYUY9C9wtxl
 fAIvZC8yFaQrS2hH8TpqW6QykdyT+C6a7ZELEYmmPnn03jsFk8MLdfVwOCq19FP+URBlLZi+eqw
 TUTChiCUIMya4AG2yTKPDgFP4eVgxKTwA4ygQqGgjtUHaceeMFBsofO85cWBZY1gG6EraoUjSTq
 PtVr2bEW7oNafyWYLjB8ctHbY7EuV7NgziFS07kr8T+2LSK4ZeiOlke5ZMg3m+N4x+gc1K11SXY
 NiNvNwq2pkaxgLZDqQi3X5QjF8eAduKucGl4KRhvCPplz4J3tsnli+TXexiUCDyFGzbcFJzklaP
 7B4OS//ReXn7PCrRZur7QnoBs1c/Hh3pRsc45kgipQS/4sReJ4ac6I=
X-Received: by 2002:a05:600c:8b86:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49fdf1354b4mr15462555e9.16.1790143804001; 
 Tue, 22 Sep 2026 23:10:04 -0700 (PDT)
Received: from LS-Tayyab-Farooq.dreambig.corp ([58.27.187.115])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1acb91sm48246775e9.15.2026.09.22.23.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 23:10:03 -0700 (PDT)
From: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@osdl.org>,
 Antonino Daplas <adaplas@pol.net>,
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER CONSOLE),
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER CONSOLE),
 linux-kernel@vger.kernel.org (open list)
Cc: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>,
 syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: fbcon: Fix KASAN slab-out-of-bounds read in rotated
 font buffer
Date: Wed, 23 Sep 2026 11:08:07 +0500
Message-ID: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

The root cause of this KASAN slab-out-of-bounds read is that fbcon fails to
reallocate the rotated font buffer (par->rotated.buf) when the font
character count changes but the font dimensions (width and height) remain
the same.

When a user changes the font via ioctl(KDFONTOP), fbcon_do_set_font() is
called. If the user first sets a 256-character font, enables rotation, and
then sets a 512-character font with the exact same width and height, resize
evaluates to false. The function then directly calls update_screen(vc).
Notice that fbcon_do_set_font() never calls par->bitops->rotate_font() to
update the rotated font buffer for the new font. As a result,
par->rotated.buf remains sized for the old 256-character font.

When update_screen(vc) is called, it eventually reaches cw_putcs_aligned(),
which attempts to read the glyphs from the rotated buffer. Since
vc->vc_font.charcount is now 512, vc->vc_hi_font_mask is set, making
charmask equal to 0x1ff (511). If the text buffer contains a character with
an index >= 256, src will point out of bounds of the old par->rotated.buf
(which only holds 256 glyphs). The subsequent read in
__fb_pad_aligned_buffer() triggers the KASAN slab-out-of-bounds crash.

To fix this, fbcon_do_set_font() must call par->bitops->rotate_font() to
update the rotated font buffer before calling vc_resize() or
update_screen(). If vc_resize() fails and the old font is restored in the
error path, rotate_font() must be called again to restore the rotated
buffer.

This pattern of updating the rotated font buffer was previously established
in fbcon_modechanged() by commit ef7656e85f1a ("fbdev: Fix out-of-bounds
access when rotating console after font resize"). The fix applies this
exact idiom to fbcon_do_set_font(). By placing it before vc_resize() and
update_screen(), we ensure the buffer is correctly sized before any
rendering occurs. Checking con_is_visible(vc) is also correct here, as
hidden consoles will have their rotation state updated later via
fbcon_switch() when they become visible.

Furthermore, by calling rotate_font() again in the err_out path, we ensure
that if vc_resize() fails, the rotated buffer is restored to match the old
vc->vc_font. Without this, restoring a 512-character font to a
256-character font on failure would leave the rotated buffer sized for 512
characters, which wastes memory; or worse, restoring a 256-character font
to a 512-character font would leave the buffer too small, causing an
out-of-bounds read later.

Fixes: e4fc27618b75 ("[PATCH] fbcon: Console Rotation - Prepare fbcon for console rotation")
Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bf4020519fbd94b2355d
Link: https://syzkaller.appspot.com/ai_job?id=59f0d7d9-607c-4497-b2e2-0b16693f9502
Signed-off-by: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..158b2f91d68e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2432,6 +2432,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	if (con_is_visible(vc)) {
+		if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
+			par->rotate = FB_ROTATE_UR;
+			set_blitting_type(vc, info);
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2466,6 +2473,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	if (con_is_visible(vc)) {
+		if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
+			par->rotate = FB_ROTATE_UR;
+			set_blitting_type(vc, info);
+		}
+	}
+
 	font_data_put(data);
 
 	return ret;
-- 
2.43.0

