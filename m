Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2077EF483C1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8710E10E565;
	Mon, 23 Mar 2026 16:04:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E603110E57F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A351F5BDCD;
 Mon, 23 Mar 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6495443968;
 Mon, 23 Mar 2026 16:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mMEbF35kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/15] drm/ast: Gen1: Fix open-coded register access
Date: Mon, 23 Mar 2026 16:56:23 +0100
Message-ID: <20260323160407.245773-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A351F5BDCD
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

Replace all open-coded access to MCR registers in Gen1 with the
appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR register
constants.

For the poll loop on MCR100, add ast_moutdwm_poll(). The helper polls
the register until it has been updated to the given value. Relax the
CPU while busy-waiting.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_2000.c | 18 +++++++-----------
 drivers/gpu/drm/ast/ast_drv.c  | 12 ++++++++++++
 drivers/gpu/drm/ast/ast_drv.h  |  1 +
 drivers/gpu/drm/ast/ast_reg.h  |  2 ++
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2000.c b/drivers/gpu/drm/ast/ast_2000.c
index e683edf595e2..4cf951b3533d 100644
--- a/drivers/gpu/drm/ast/ast_2000.c
+++ b/drivers/gpu/drm/ast/ast_2000.c
@@ -99,20 +99,15 @@ static const struct ast_dramstruct ast2000_dram_table_data[] = {
 static void ast_post_chip_2000(struct ast_device *ast)
 {
 	u8 j;
-	u32 temp, i;
-	const struct ast_dramstruct *dram_reg_info;
+	u32 i;
 
 	j = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 
 	if ((j & 0x80) == 0) { /* VGA only */
-		dram_reg_info = ast2000_dram_table_data;
-		ast_write32(ast, 0xf004, AST_REG_MCR00);
-		ast_write32(ast, 0xf000, 0x1);
-		ast_write32(ast, 0x10100, 0xa8);
+		const struct ast_dramstruct *dram_reg_info = ast2000_dram_table_data;
+		u32 mcr140;
 
-		do {
-			;
-		} while (ast_read32(ast, 0x10100) != 0xa8);
+		ast_moutdwm_poll(ast, AST_REG_MCR100, 0xa8, 0xa8);
 
 		while (!AST_DRAMSTRUCT_IS(dram_reg_info, INVALID)) {
 			if (AST_DRAMSTRUCT_IS(dram_reg_info, UDELAY)) {
@@ -124,8 +119,9 @@ static void ast_post_chip_2000(struct ast_device *ast)
 			dram_reg_info++;
 		}
 
-		temp = ast_read32(ast, 0x10140);
-		ast_write32(ast, 0x10140, temp | 0x40);
+		mcr140 = ast_mindwm(ast, AST_REG_MCR140);
+		mcr140 |= 0x00000040;
+		ast_moutdwm(ast, AST_REG_MCR140, mcr140);
 	}
 
 	/* wait ready */
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 3da0cce0a3f6..6fe549f16309 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -102,6 +102,18 @@ void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
 	__ast_moutdwm(ast->regs, r, v);
 }
 
+void ast_moutdwm_poll(struct ast_device *ast, u32 r, u32 v, u32 res)
+{
+	void __iomem *regs = ast->regs;
+
+	__ast_selseg(regs, r);
+	__ast_wrseg32(regs, r, v);
+
+	do {
+		cpu_relax();
+	} while (__ast_rdseg32(regs, r) != res);
+}
+
 /*
  * AST device
  */
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 3eedf8239333..4f221b848d68 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -361,6 +361,7 @@ u32 __ast_mindwm(void __iomem *regs, u32 r);
 void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
 u32 ast_mindwm(struct ast_device *ast, u32 r);
 void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
+void ast_moutdwm_poll(struct ast_device *ast, u32 r, u32 v, u32 res);
 
 /*
  * VBIOS
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index a01af2bfbae6..9ebdbbde9a47 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -140,8 +140,10 @@
 #define AST_REG_MCR80				AST_REG_MCR(0x80)
 #define AST_REG_MCR84				AST_REG_MCR(0x84)
 #define AST_REG_MCR88				AST_REG_MCR(0x88)
+#define AST_REG_MCR100				AST_REG_MCR(0x100)
 #define AST_REG_MCR108				AST_REG_MCR(0x108)
 #define AST_REG_MCR120				AST_REG_MCR(0x120)
+#define AST_REG_MCR140				AST_REG_MCR(0x140)
 #define AST_REG_MCR200				AST_REG_MCR(0x200)
 #define AST_REG_MCR204				AST_REG_MCR(0x204)
 #define AST_REG_MCR208				AST_REG_MCR(0x208)
-- 
2.53.0

