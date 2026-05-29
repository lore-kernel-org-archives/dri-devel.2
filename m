Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC3FCD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DFB10FFB0;
	Fri, 29 May 2026 14:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="D4Axksh5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYiNLAa+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D4Axksh5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYiNLAa+";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863C210FFB1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:08:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FB526AD6B;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efjuk97bxAbVY/ZjELo3tpTtD8zKWT42WxrwjHCosIs=;
 b=D4Axksh5zcOve79ye0/Ep2N8xfAsIj8UQrrEx7XrTsaTB1kzOwZ7Z3JFVeXl20nUSyB9/Y
 TVVD4wpex+lSdAuev7CsScVDcEAA/baX0DxB4j/SmerNDFeb2d6FktdMzSwgYhSi4t4zCm
 nQeLM1jhg2zRze7OfiJRpVbk9T+IfxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efjuk97bxAbVY/ZjELo3tpTtD8zKWT42WxrwjHCosIs=;
 b=gYiNLAa+ykK3sb90Ep9YGqHx/CPCmMC7XAka/rjgApbVtv+LfD11HHl65bNANQOEcoQYp5
 z52DXyUrSoToVjAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D4Axksh5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gYiNLAa+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efjuk97bxAbVY/ZjELo3tpTtD8zKWT42WxrwjHCosIs=;
 b=D4Axksh5zcOve79ye0/Ep2N8xfAsIj8UQrrEx7XrTsaTB1kzOwZ7Z3JFVeXl20nUSyB9/Y
 TVVD4wpex+lSdAuev7CsScVDcEAA/baX0DxB4j/SmerNDFeb2d6FktdMzSwgYhSi4t4zCm
 nQeLM1jhg2zRze7OfiJRpVbk9T+IfxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efjuk97bxAbVY/ZjELo3tpTtD8zKWT42WxrwjHCosIs=;
 b=gYiNLAa+ykK3sb90Ep9YGqHx/CPCmMC7XAka/rjgApbVtv+LfD11HHl65bNANQOEcoQYp5
 z52DXyUrSoToVjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1332779A9;
 Fri, 29 May 2026 14:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uLHcMcOdGWoybAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, deller@gmx.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/4] lib/fonts: Look up glyph data with font_data_glyph_buf()
Date: Fri, 29 May 2026 16:01:23 +0200
Message-ID: <20260529140759.529929-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529140759.529929-1-tzimmermann@suse.de>
References: <20260529140759.529929-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1FB526AD6B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmx.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 RCPT_COUNT_SEVEN(0.00)[10];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
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

Add font_data_glyph_buf() to retrieve a character's glyph data or NULL
otherwise. Console fonts can currently contain 256 or 512 glyphs. The
kernel-internal characters are of type char, unsigned short or unsigned
int. Catch all of them by accepting unsigned int. Callers possibly have
to cast from signed to unsigned types to reach all glyphs in a font.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/font.h |  3 +++
 lib/fonts/fonts.c    | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/font.h b/include/linux/font.h
index 6845f02d739a..ea23b727388b 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -101,6 +101,9 @@ font_data_t *font_data_import(const struct console_font *font, unsigned int vpit
 void font_data_get(font_data_t *fd);
 bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
+const unsigned char *font_data_glyph_buf(font_data_t *fd,
+					 unsigned int width, unsigned int vpitch,
+					 unsigned int c);
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
 
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index f5d5333450a0..4fc66722d00d 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -178,6 +178,37 @@ unsigned int font_data_size(font_data_t *fd)
 }
 EXPORT_SYMBOL_GPL(font_data_size);
 
+static unsigned int font_data_num_glyphs(font_data_t *fd, unsigned int width, unsigned int height)
+{
+	return font_data_size(fd) / font_glyph_size(width, height);
+}
+
+/**
+ * font_data_glyph_buf() - Returns the glyph for a specific character as raw bytes
+ * @fd: The font data
+ * @width: The glyph width in bits per scanline
+ * @vpitch: The number of scanlines per glyph
+ * @c: The character
+ *
+ * Glyphs start at fixed intervals within the font data. font_data_glyph_buf()
+ * returns the glyph shape of the specified character. If no such glyph
+ * exists in the font, it returns NULL.
+ *
+ * Returns:
+ * The character's raw glyph shape, or NULL if no glyph exists for the character. The
+ * provided buffer is read-only.
+ */
+const unsigned char *font_data_glyph_buf(font_data_t *fd,
+					 unsigned int width, unsigned int vpitch,
+					 unsigned int c)
+{
+	if (c >= font_data_num_glyphs(fd, width, vpitch))
+		return NULL;
+
+	return font_data_buf(fd) + font_glyph_size(width, vpitch) * c;
+}
+EXPORT_SYMBOL_GPL(font_data_glyph_buf);
+
 /**
  * font_data_is_equal - Compares font data for equality
  * @lhs: Left-hand side font data
-- 
2.54.0

