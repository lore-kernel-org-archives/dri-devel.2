Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE33F483C1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD6F10E597;
	Mon, 23 Mar 2026 16:04:52 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F32910E596
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 329644D28B;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF3724396A;
 Mon, 23 Mar 2026 16:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFsxOX5kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 12/15] drm/ast: Gen4: Fix open-coded register access
Date: Mon, 23 Mar 2026 16:56:25 +0100
Message-ID: <20260323160407.245773-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 329644D28B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

