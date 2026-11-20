Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80B606A335
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=A7K8DMtF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DpFWRg5P;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=A7K8DMtF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DpFWRg5P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CD0112946;
	Fri, 20 Nov 2026 11:52:44 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA90C10E6A8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:52:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3269D1F457;
 Fri, 20 Nov 2026 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795175547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WImkfxqEQGNeYfAHj0WE2CtADgBK8HXMO/5PqrE+/AA=;
 b=A7K8DMtFQU7u5DnAjt50SjCNt1pabvKnUUIE5KwSx7QhyGekGnxttmfHcg3CLIRHL8aUMo
 Uu6DqJgpgWn0druR4G8/ammRkL80BYXhmr/usPTUxIsRz15sy1IDy3faiiISRnDHH1S+GB
 7FYod8ld3+dFC/pBesTx1gJ0GZKIfAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795175547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WImkfxqEQGNeYfAHj0WE2CtADgBK8HXMO/5PqrE+/AA=;
 b=DpFWRg5Plq03c+7DjW8K2KvKbeXe+6/nOf+WvMU9pIvXhA+3GNe/fa0Qux904xmWf0CVjl
 p1D/iYEEilNyaXDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795175547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WImkfxqEQGNeYfAHj0WE2CtADgBK8HXMO/5PqrE+/AA=;
 b=A7K8DMtFQU7u5DnAjt50SjCNt1pabvKnUUIE5KwSx7QhyGekGnxttmfHcg3CLIRHL8aUMo
 Uu6DqJgpgWn0druR4G8/ammRkL80BYXhmr/usPTUxIsRz15sy1IDy3faiiISRnDHH1S+GB
 7FYod8ld3+dFC/pBesTx1gJ0GZKIfAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795175547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WImkfxqEQGNeYfAHj0WE2CtADgBK8HXMO/5PqrE+/AA=;
 b=DpFWRg5Plq03c+7DjW8K2KvKbeXe+6/nOf+WvMU9pIvXhA+3GNe/fa0Qux904xmWf0CVjl
 p1D/iYEEilNyaXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD23113507;
 Fri, 20 Nov 2026 11:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UE2UA3o0AGsbDAAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 11:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/6] lib/fonts: Provide internal helpers for allocating
 font_data_t
Date: Fri, 20 Nov 2026 12:49:55 +0100
Message-ID: <20261120115215.52092-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120115215.52092-1-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-15.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -15.80
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factor out the allocation code for font_data_t from font import in
font_data_import(). Retrieve a writable glyph buffer from the new
helper __font_data_wrbuf().

Having the allocation code in separate functions makes it available
for font rotation and maybe other font utilities. The _wrbuf() helper
returns a writable glyph buffer. Font data is only readable in general.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font.h  | 12 +++++++++
 lib/fonts/fonts.c | 63 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/lib/fonts/font.h b/lib/fonts/font.h
index 4f1adf0b6b54..eae8c563f148 100644
--- a/lib/fonts/font.h
+++ b/lib/fonts/font.h
@@ -4,6 +4,7 @@
 #define _LIB_FONTS_FONT_H
 
 #include <linux/font.h>
+#include <linux/types.h>
 
 /*
  * Font data
@@ -16,6 +17,17 @@ struct font_data {
 	unsigned char data[];
 } __packed;
 
+/*
+ * font_data_t and helpers
+ */
+
+static inline unsigned char *__font_data_wrbuf(font_data_t *fd)
+{
+	return (unsigned char *)fd;
+}
+
+font_data_t *__font_data_alloc(unsigned int size, gfp_t flags);
+
 /*
  * Built-in fonts
  */
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 4fc66722d00d..e66a5b6fc3bb 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -47,6 +47,39 @@ static bool font_data_is_internal(font_data_t *fd)
 	return !REFCOUNT(fd); /* internal fonts have no reference counting */
 }
 
+font_data_t *__font_data_alloc(unsigned int size, gfp_t flags)
+{
+	unsigned int alloc_size;
+	struct font_data *font_data;
+	font_data_t *fd;
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
+		return ERR_PTR(-EINVAL);
+
+	font_data = kzalloc(alloc_size, flags);
+	if (!font_data)
+		return ERR_PTR(-ENOMEM);
+
+	fd = font_data->data;
+	REFCOUNT(fd) = 1; /* start with reference acquired */
+	FNTSIZE(fd) = size;
+
+	return fd;
+}
+
+static font_data_t *font_data_alloc(unsigned int pitch, unsigned int h, unsigned int charcount)
+{
+	unsigned int size;
+
+	/* Check for integer overflow in font-size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return ERR_PTR(-EINVAL);
+
+	return __font_data_alloc(size, GFP_USER);
+}
+
 static void font_data_free(font_data_t *fd)
 {
 	kfree(to_font_data_struct(fd));
@@ -75,36 +108,20 @@ font_data_t *font_data_import(const struct console_font *font, unsigned int vpit
 	unsigned int h = font->height;
 	unsigned int charcount = font->charcount;
 	const unsigned char *data = font->data;
-	u32 csum = 0;
-	struct font_data *font_data;
-	int size, alloc_size;
+	unsigned char *font_data;
 	unsigned int i;
 	font_data_t *fd;
 
-	/* Check for integer overflow in font-size calculation */
-	if (check_mul_overflow(h, pitch, &size) ||
-	    check_mul_overflow(size, charcount, &size))
-		return ERR_PTR(-EINVAL);
-
-	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
-		return ERR_PTR(-EINVAL);
-
-	font_data = kmalloc(alloc_size, GFP_USER);
-	if (!font_data)
-		return ERR_PTR(-ENOMEM);
-	memset(font_data->extra, 0, sizeof(font_data->extra));
+	fd = font_data_alloc(pitch, h, charcount);
+	if (IS_ERR(fd))
+		return fd;
+	font_data = __font_data_wrbuf(fd);
 
 	for (i = 0; i < charcount; ++i)
-		memcpy(font_data->data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
+		memcpy(font_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
 
 	if (calc_csum)
-		csum = calc_csum(0, font_data->data, size);
-
-	fd = font_data->data;
-	REFCOUNT(fd) = 1; /* start with reference acquired */
-	FNTSIZE(fd) = size;
-	FNTSUM(fd) = csum;
+		FNTSUM(fd) = calc_csum(0, font_data, FNTSIZE(fd));
 
 	return fd;
 }
-- 
2.56.0

