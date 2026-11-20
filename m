Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E560A2608
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cj+uLyHl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE80B112CAF;
	Fri, 20 Nov 2026 19:17:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68167112CAF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B0254447C;
 Fri, 20 Nov 2026 19:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7F1F000D0;
 Fri, 20 Nov 2026 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795202223;
 bh=8c0/NtjrTm+B61tLaSp0UuIedJNCONp0D79/5KD3kpw=;
 h=Date:From:To:Subject;
 b=cj+uLyHlU4Z9OEQn6EMHtpuN0H7xI6GAZryLNjxkjIkKwU+GwZ+xwWmcR5lH7b7q1
 l4YaDC2Tnn6pjqjkHJ7botKoEtImHCTabrA0Z7SqKfawCtZC0Q8fjBBcn1YPKyFQr/
 kVE3ATOO+Iefr0TXNTig/lfcEm1bLc7cHheEsSaOkilbk5NOmjHp+/PrQXhOZ9HVkk
 Opqa0jXOLb4vKRb96o0aguLgtUs/8xsoY9nHDX8e0YolWnvQ2ee25WDPdEJi3XvusE
 oybhT3EukWL1VLKcJTKvvBTZiBkBPJXXnAbRpQj0agIGTyQNulkVd8imLl3NTl3C4w
 +LgZL+lGSRw9w==
Date: Fri, 20 Nov 2026 20:16:59 +0100
From: Helge Deller <deller@kernel.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Henri Roosen <henri.roosen@ginzinger.com>
Subject: [PATCH v3] fbcon: Don't drop last logo line if logo is same size as
 screen
Message-ID: <awCcqwVKi_n0KMhi@carbonx1>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Henri reported a regression that when a custom bootlogo is exactly as
big as the screen, a white bar with the size of the font height is
displayed at the bottom of the display.

This patch fixes this off-by-one bug, but now -as sashiko-bot noticed-
since the logo covers the whole screen there is no area left in which
the text can be scrolled. To avoid accesses outside the screen memory
simply keep the text area covering the full screen (and possibly
overwriting) the full-screen logo.

Fixes: 94e6a058b168 ("fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo")
Tested-by: Henri Roosen <henri.roosen@ginzinger.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v7.3+

---
v2: first sashiko-bot fixes
v3: sashiko-bot noticed another problem that screen gets cleared on full screen logo

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d7890e119dc7..e7240eeb8381 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -666,7 +666,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 	logo_height = fb_prepare_logo(info, par->rotate);
 	logo_lines = DIV_ROUND_UP(logo_height, vc->vc_font.height);
 	logo_lines = min(logo_lines, rows);
-	logo_lines = min(logo_lines, new_rows - 1);
+	logo_lines = min(logo_lines, new_rows);
 	if (logo_lines <= 0) {
 		logo_lines = 0;
 		logo_shown = FBCON_LOGO_DONTSHOW;
@@ -734,7 +734,9 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
 	} else {
 		logo_shown = FBCON_LOGO_DRAW;
-		vc->vc_top = logo_lines;
+		/* keep vc_top if logo covers whole screen */
+		if (logo_lines < vc->vc_bottom)
+			vc->vc_top = logo_lines;
 	}
 }
 #endif /* MODULE */
@@ -2269,7 +2271,9 @@ static bool fbcon_switch(struct vc_data *vc)
 
 		logo_shown = fg_console;
 		fb_show_logo(info, par->rotate);
-		update_region(vc,
+		/* avoid screen update on full screen sized logo */
+		if (vc->vc_top)
+			update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
 						 vc->vc_top) / 2);

