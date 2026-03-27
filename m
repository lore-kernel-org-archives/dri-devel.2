Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED12710ED661
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D0A10EE66;
	Fri, 27 Mar 2026 13:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="KTbFrH9P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Tw80qpj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KTbFrH9P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Tw80qpj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F02D10EE64
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92AD84D34F;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xH2fImoOS1vUgD47THHygbsGa53j8wN8F44vTw6IUT0=;
 b=KTbFrH9PSteyLSwF4dQh6lq6S2wTMdcqpSdkslmKBszw8iYRAar8O1oXaqrozFPBFmmsje
 7k5IEF9EQxyvY+pD6smlPhsXLvJd7NYkG34Ib/BKdgshh3HZ1eGQN5l3XDC8FeZjNmHTZV
 QOieGOMcONlkY3bZOj4SwAeZCMaKqOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xH2fImoOS1vUgD47THHygbsGa53j8wN8F44vTw6IUT0=;
 b=7Tw80qpjB2O8LYWYIqP4eLmqdMzSyEEAYS/29cYzANTIvO4mDb5vcjV6qbiltSmvNKC+D5
 3x/fzRIpUH1cyaAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KTbFrH9P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Tw80qpj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xH2fImoOS1vUgD47THHygbsGa53j8wN8F44vTw6IUT0=;
 b=KTbFrH9PSteyLSwF4dQh6lq6S2wTMdcqpSdkslmKBszw8iYRAar8O1oXaqrozFPBFmmsje
 7k5IEF9EQxyvY+pD6smlPhsXLvJd7NYkG34Ib/BKdgshh3HZ1eGQN5l3XDC8FeZjNmHTZV
 QOieGOMcONlkY3bZOj4SwAeZCMaKqOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xH2fImoOS1vUgD47THHygbsGa53j8wN8F44vTw6IUT0=;
 b=7Tw80qpjB2O8LYWYIqP4eLmqdMzSyEEAYS/29cYzANTIvO4mDb5vcjV6qbiltSmvNKC+D5
 3x/fzRIpUH1cyaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5443D4A0A2;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GG9gE6uHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 12/15] drm/ast: Gen4: Fix open-coded register access
Date: Fri, 27 Mar 2026 14:33:04 +0100
Message-ID: <20260327133532.79696-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327133532.79696-1-tzimmermann@suse.de>
References: <20260327133532.79696-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 92AD84D34F
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

Replace all open-coded access to MCR and SCU registers in Gen4 with the
appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR and SCU
register constants. Name variables according to registers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2300.c | 24 +++++++++---------------
 drivers/gpu/drm/ast/ast_reg.h  |  1 +
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
index 96d9909d942c..cbeac6990c27 100644
--- a/drivers/gpu/drm/ast/ast_2300.c
+++ b/drivers/gpu/drm/ast/ast_2300.c
@@ -1245,22 +1245,15 @@ static void ast_post_chip_2300(struct ast_device *ast)
 
 	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 	if ((reg & 0x80) == 0) {/* vga only */
-		ast_write32(ast, 0xf004, AST_REG_MCR00);
-		ast_write32(ast, 0xf000, 0x1);
-		ast_write32(ast, 0x12000, 0x1688a8a8);
-		do {
-			;
-		} while (ast_read32(ast, 0x12000) != 0x1);
+		u32 scu008, scu040;
 
-		ast_write32(ast, 0x10000, 0xfc600309);
-		do {
-			;
-		} while (ast_read32(ast, 0x10000) != 0x1);
+		ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
+		ast_moutdwm_poll(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY, 0x01);
 
 		/* Slow down CPU/AHB CLK in VGA only mode */
-		temp = ast_read32(ast, 0x12008);
-		temp |= 0x73;
-		ast_write32(ast, 0x12008, temp);
+		scu008 = ast_mindwm(ast, AST_REG_SCU008);
+		scu008 |= 0x00000073;
+		ast_moutdwm(ast, AST_REG_SCU008, scu008);
 
 		param.dram_freq = 396;
 		param.dram_type = AST_DDR3;
@@ -1306,8 +1299,9 @@ static void ast_post_chip_2300(struct ast_device *ast)
 			ddr2_init(ast, &param);
 		}
 
-		temp = ast_mindwm(ast, AST_REG_SCU040);
-		ast_moutdwm(ast, AST_REG_SCU040, temp | 0x40);
+		scu040 = ast_mindwm(ast, AST_REG_SCU040);
+		scu040 |= 0x00000040;
+		ast_moutdwm(ast, AST_REG_SCU040, scu040);
 	}
 
 	/* wait ready */
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 9ebdbbde9a47..c3473cad4545 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -183,6 +183,7 @@
 #define AST_REG_SCU(__offset)			(AST_REG_SCU_BASE + (__offset))
 #define AST_REG_SCU000				AST_REG_SCU(0x000)
 #define AST_REG_SCU000_PROTECTION_KEY		(0x1688a8a8)
+#define AST_REG_SCU008				AST_REG_SCU(0x008)
 #define AST_REG_SCU00C				AST_REG_SCU(0x00c)
 #define AST_REG_SCU020				AST_REG_SCU(0x020)
 #define AST_REG_SCU040				AST_REG_SCU(0x040)
-- 
2.53.0

