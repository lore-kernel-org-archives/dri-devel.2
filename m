Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A0310ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDC910ECEC;
	Fri, 27 Mar 2026 13:04:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E4D10EC8C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:04:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 035D34D39F;
 Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B44294A0B1;
 Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIjRKmWAxmmweQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/10] lib/fonts: Refactor glyph-rotation helpers
Date: Fri, 27 Mar 2026 13:49:40 +0100
Message-ID: <20260327130431.59481-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 035D34D39F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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

Change the signatures of the glyph-rotation helpers to match their
public interfaces. Drop the inline qualifier.

Rename several variables to better match their meaning. Especially
rename variables to bit_pitch (or a variant thereof) if they store
a pitch value in bits per scanline. The original code is fairly
confusing about this. Move the calculation of the bit pitch into the
new helper font_glyph_bit_pitch().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font_rotate.c | 85 ++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index cfaf5b98f49a..f1e441a931ab 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -15,6 +15,12 @@
 
 #include "font.h"
 
+/* number of bits per line */
+static unsigned int font_glyph_bit_pitch(unsigned int width)
+{
+	return round_up(width, 8);
+}
+
 static unsigned int __font_glyph_pos(unsigned int x, unsigned int y, unsigned int bit_pitch,
 				     unsigned int *bit)
 {
@@ -44,18 +50,21 @@ static void font_glyph_set_bit(unsigned char *glyph, unsigned int x, unsigned in
 	glyph[i] |= bit;
 }
 
-static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_90(const unsigned char *glyph,
+				   unsigned int width, unsigned int height,
+				   unsigned char *out)
 {
-	int i, j, h = height, w = width;
-	int shift = (8 - (height % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, height - 1 - i - shift, j, height);
+	unsigned int x, y;
+	unsigned int shift = (8 - (height % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+	unsigned int out_bit_pitch = font_glyph_bit_pitch(height);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch)) {
+				font_glyph_set_bit(out, out_bit_pitch - 1 - y - shift, x,
+						   out_bit_pitch);
+			}
 		}
 	}
 }
@@ -79,22 +88,24 @@ void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsign
 {
 	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
 
-	rotate_cw(glyph, out, width, height);
+	__font_glyph_rotate_90(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_90);
 
-static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_180(const unsigned char *glyph,
+				    unsigned int width, unsigned int height,
+				    unsigned char *out)
 {
-	int i, j;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-
-	for (i = 0; i < height; i++) {
-		for (j = 0; j < width - shift; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, width - (1 + j + shift),
-						   height - (1 + i), width);
+	unsigned int x, y;
+	unsigned int shift = (8 - (width % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch)) {
+				font_glyph_set_bit(out, width - (1 + x + shift), height - (1 + y),
+						   bit_pitch);
+			}
 		}
 	}
 }
@@ -115,22 +126,24 @@ void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsig
 {
 	memset(out, 0, font_glyph_size(width, height));
 
-	rotate_ud(glyph, out, width, height);
+	__font_glyph_rotate_180(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_180);
 
-static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_270(const unsigned char *glyph,
+				    unsigned int width, unsigned int height,
+				    unsigned char *out)
 {
-	int i, j, h = height, w = width;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, i, width - 1 - j - shift, height);
+	unsigned int x, y;
+	unsigned int shift = (8 - (width % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+	unsigned int out_bit_pitch = font_glyph_bit_pitch(height);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch))
+				font_glyph_set_bit(out, y, bit_pitch - 1 - x - shift,
+						   out_bit_pitch);
 		}
 	}
 }
@@ -154,6 +167,6 @@ void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsig
 {
 	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
 
-	rotate_ccw(glyph, out, width, height);
+	__font_glyph_rotate_270(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
-- 
2.53.0

