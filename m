Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBA10ED67E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E1210EE6C;
	Fri, 27 Mar 2026 13:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tB/5R4qL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ixJPtOn4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tB/5R4qL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ixJPtOn4";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EAB10EE66
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E0EA4D34D;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xqnl56CEswpLdYZXWy8JlfyhmP1TXFKvXcyQG2HZVY4=;
 b=tB/5R4qLuNv+Ze5fjIuLgeGOYezDpc3a79U8iGq9syTSVpNLOjbsGnAUVi9jezwnjCofib
 lQAhUT/GQt9ACBHunxLXLmp6No3VboFLSvA8V4QvEcadlr5VEI7aRy9bMSHGqp5BH6SFUo
 FjKnrOM4bONSVvtALOZPpzRa0eYSJZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xqnl56CEswpLdYZXWy8JlfyhmP1TXFKvXcyQG2HZVY4=;
 b=ixJPtOn4ufZFQm5YFM/YjKk01DvHn13u0TIjlvgbwWweKJuMv3fF3V5r3xAJan1IJWABsM
 RGFpqxCLk+mM0mCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tB/5R4qL";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ixJPtOn4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xqnl56CEswpLdYZXWy8JlfyhmP1TXFKvXcyQG2HZVY4=;
 b=tB/5R4qLuNv+Ze5fjIuLgeGOYezDpc3a79U8iGq9syTSVpNLOjbsGnAUVi9jezwnjCofib
 lQAhUT/GQt9ACBHunxLXLmp6No3VboFLSvA8V4QvEcadlr5VEI7aRy9bMSHGqp5BH6SFUo
 FjKnrOM4bONSVvtALOZPpzRa0eYSJZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xqnl56CEswpLdYZXWy8JlfyhmP1TXFKvXcyQG2HZVY4=;
 b=ixJPtOn4ufZFQm5YFM/YjKk01DvHn13u0TIjlvgbwWweKJuMv3fF3V5r3xAJan1IJWABsM
 RGFpqxCLk+mM0mCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E0FB4A0B1;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wC38AauHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 11/15] drm/ast: Gen2: Fix open-coded register access
Date: Fri, 27 Mar 2026 14:33:03 +0100
Message-ID: <20260327133532.79696-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327133532.79696-1-tzimmermann@suse.de>
References: <20260327133532.79696-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4E0EA4D34D
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

Replace all open-coded access to MCR and SCU registers in Gen2 with the
appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR and SCU
register constants. Name variables according to registers.

The values in MCR04 that control VRAM allocation do not look correct.
Leave a FIXME comment for later investigation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2100.c | 73 ++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2100.c b/drivers/gpu/drm/ast/ast_2100.c
index 930e9f2d0ccf..5cf8ad9c3446 100644
--- a/drivers/gpu/drm/ast/ast_2100.c
+++ b/drivers/gpu/drm/ast/ast_2100.c
@@ -40,21 +40,19 @@
 
 static enum ast_dram_layout ast_2100_get_dram_layout_p2a(struct ast_device *ast)
 {
-	u32 mcr_cfg;
+	u32 mcr04;
 	enum ast_dram_layout dram_layout;
 
-	ast_write32(ast, 0xf004, AST_REG_MCR00);
-	ast_write32(ast, 0xf000, 0x1);
-	mcr_cfg = ast_read32(ast, 0x10004);
+	mcr04 = ast_mindwm(ast, AST_REG_MCR04);
 
-	switch (mcr_cfg & 0x0c) {
+	switch (mcr04 & GENMASK(3, 2)) {
 	case 0:
 	case 4:
 	default:
 		dram_layout = AST_DRAM_512Mx16;
 		break;
 	case 8:
-		if (mcr_cfg & 0x40)
+		if (mcr04 & 0x40)
 			dram_layout = AST_DRAM_1Gx16;
 		else
 			dram_layout = AST_DRAM_512Mx32;
@@ -300,51 +298,52 @@ static void cbrdlli_ast2150(struct ast_device *ast, int busw)
 static void ast_post_chip_2100(struct ast_device *ast)
 {
 	u8 j;
-	u32 data, temp, i;
-	const struct ast_dramstruct *dram_reg_info;
-	enum ast_dram_layout dram_layout  = ast_2100_get_dram_layout_p2a(ast);
+	u32 i;
+	enum ast_dram_layout dram_layout = ast_2100_get_dram_layout_p2a(ast);
+	u32 mcr120;
+	u32 scu00c, scu040;
 
 	j = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 
 	if ((j & 0x80) == 0) { /* VGA only */
+		const struct ast_dramstruct *dram_reg_info;
+
 		if (ast->chip == AST2100 || ast->chip == AST2200)
 			dram_reg_info = ast2100_dram_table_data;
 		else
 			dram_reg_info = ast1100_dram_table_data;
 
-		ast_write32(ast, 0xf004, AST_REG_MCR00);
-		ast_write32(ast, 0xf000, 0x1);
-		ast_write32(ast, 0x12000, 0x1688A8A8);
-		do {
-			;
-		} while (ast_read32(ast, 0x12000) != 0x01);
-
-		ast_write32(ast, 0x10000, 0xfc600309);
-		do {
-			;
-		} while (ast_read32(ast, 0x10000) != 0x01);
+		ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
+		ast_moutdwm_poll(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY, 0x01);
 
 		while (!AST_DRAMSTRUCT_IS(dram_reg_info, INVALID)) {
 			if (AST_DRAMSTRUCT_IS(dram_reg_info, UDELAY)) {
 				for (i = 0; i < 15; i++)
 					udelay(dram_reg_info->data);
 			} else if (AST_DRAMSTRUCT_IS_REG(dram_reg_info, AST_REG_MCR04)) {
+				u32 mcr04;
+				u32 scu070;
+
 				switch (dram_layout) {
 				case AST_DRAM_1Gx16:
-					data = 0x00000d89;
+					mcr04 = 0x00000d89;
 					break;
 				case AST_DRAM_1Gx32:
-					data = 0x00000c8d;
+					mcr04 = 0x00000c8d;
 					break;
 				default:
-					data = dram_reg_info->data;
+					mcr04 = dram_reg_info->data;
 					break;
 				}
 
-				temp = ast_read32(ast, 0x12070);
-				temp &= 0xc;
-				temp <<= 2;
-				ast_moutdwm(ast, dram_reg_info->index, data | temp);
+				/*
+				 * FIXME: There might be bits already in MCR04[5:4]. Should
+				 *        we only do this in the default case?
+				 */
+				scu070 = ast_mindwm(ast, AST_REG_SCU070);
+				mcr04 |= (scu070 & GENMASK(3, 2)) << 2;
+
+				ast_moutdwm(ast, dram_reg_info->index, mcr04);
 			} else {
 				ast_moutdwm(ast, dram_reg_info->index, dram_reg_info->data);
 			}
@@ -352,19 +351,23 @@ static void ast_post_chip_2100(struct ast_device *ast)
 		}
 
 		/* AST 2100/2150 DRAM calibration */
-		data = ast_read32(ast, 0x10120);
-		if (data == 0x5061) { /* 266Mhz */
-			data = ast_read32(ast, 0x10004);
-			if (data & 0x40)
+		mcr120 = ast_mindwm(ast, AST_REG_MCR120);
+		if (mcr120 == 0x5061) { /* 266Mhz */
+			u32 mcr04 = ast_mindwm(ast, AST_REG_MCR04);
+
+			if (mcr04 & 0x40)
 				cbrdlli_ast2150(ast, 16); /* 16 bits */
 			else
 				cbrdlli_ast2150(ast, 32); /* 32 bits */
 		}
 
-		temp = ast_read32(ast, 0x1200c);
-		ast_write32(ast, 0x1200c, temp & 0xfffffffd);
-		temp = ast_read32(ast, 0x12040);
-		ast_write32(ast, 0x12040, temp | 0x40);
+		scu00c = ast_mindwm(ast, AST_REG_SCU00C);
+		scu00c &= 0xfffffffd;
+		ast_moutdwm(ast, AST_REG_SCU00C, scu00c);
+
+		scu040 = ast_mindwm(ast, AST_REG_SCU040);
+		scu040 |= 0x00000040;
+		ast_moutdwm(ast, AST_REG_SCU040, scu040);
 	}
 
 	/* wait ready */
-- 
2.53.0

