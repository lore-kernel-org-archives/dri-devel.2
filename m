Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952C6F483C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C658610E58E;
	Mon, 23 Mar 2026 16:04:32 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A7410E57C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B09D05BD74;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7812F4396A;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MocHH9kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 14/15] drm/ast: dp501: Fix open-coded register access
Date: Mon, 23 Mar 2026 16:56:27 +0100
Message-ID: <20260323160407.245773-15-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B09D05BD74
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

Replace all open-coded access to SCU registers in DP501 support with
the appropriate calls to ast_moutdwm() and ast_mindwm(). Use SCU register
constants. Name variables according to registers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_dp501.c | 124 +++++++++++++++-----------------
 drivers/gpu/drm/ast/ast_reg.h   |   6 ++
 2 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 23142119d733..98d8491ce6c9 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -347,68 +347,65 @@ static int ast_dp512_read_edid_block(void *data, u8 *buf, unsigned int block, si
 static bool ast_init_dvo(struct ast_device *ast)
 {
 	u8 jreg;
-	u32 data;
-	ast_write32(ast, 0xf004, AST_REG_MCR00);
-	ast_write32(ast, 0xf000, 0x1);
-	ast_write32(ast, 0x12000, 0x1688a8a8);
+	u32 scu02c;
+
+	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 
 	jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 	if (!(jreg & 0x80)) {
+		u32 scu008;
+
 		/* Init SCU DVO Settings */
-		data = ast_read32(ast, 0x12008);
-		/* delay phase */
-		data &= 0xfffff8ff;
-		data |= 0x00000500;
-		ast_write32(ast, 0x12008, data);
+
+		scu008 = ast_mindwm(ast, AST_REG_SCU008);
+		scu008 &= 0xfffff8ff;
+		scu008 |= 0x00000500; /* delay phase */
+		ast_moutdwm(ast, AST_REG_SCU008, scu008);
 
 		if (IS_AST_GEN4(ast)) {
-			data = ast_read32(ast, 0x12084);
-			/* multi-pins for DVO single-edge */
-			data |= 0xfffe0000;
-			ast_write32(ast, 0x12084, data);
-
-			data = ast_read32(ast, 0x12088);
-			/* multi-pins for DVO single-edge */
-			data |= 0x000fffff;
-			ast_write32(ast, 0x12088, data);
-
-			data = ast_read32(ast, 0x12090);
-			/* multi-pins for DVO single-edge */
-			data &= 0xffffffcf;
-			data |= 0x00000020;
-			ast_write32(ast, 0x12090, data);
+			u32 scu084, scu088, scu090;
+
+			scu084 = ast_mindwm(ast, AST_REG_SCU084);
+			scu084 |= 0xfffe0000; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU084, scu084);
+
+			scu088 = ast_mindwm(ast, AST_REG_SCU088);
+			scu088 |= 0x000fffff; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU088, scu088);
+
+			scu090 = ast_mindwm(ast, AST_REG_SCU090);
+			scu090 &= 0xffffffcf;
+			scu090 |= 0x00000020; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU090, scu090);
 		} else { /* AST GEN5+ */
-			data = ast_read32(ast, 0x12088);
-			/* multi-pins for DVO single-edge */
-			data |= 0x30000000;
-			ast_write32(ast, 0x12088, data);
-
-			data = ast_read32(ast, 0x1208c);
-			/* multi-pins for DVO single-edge */
-			data |= 0x000000cf;
-			ast_write32(ast, 0x1208c, data);
-
-			data = ast_read32(ast, 0x120a4);
-			/* multi-pins for DVO single-edge */
-			data |= 0xffff0000;
-			ast_write32(ast, 0x120a4, data);
-
-			data = ast_read32(ast, 0x120a8);
-			/* multi-pins for DVO single-edge */
-			data |= 0x0000000f;
-			ast_write32(ast, 0x120a8, data);
-
-			data = ast_read32(ast, 0x12094);
-			/* multi-pins for DVO single-edge */
-			data |= 0x00000002;
-			ast_write32(ast, 0x12094, data);
+			u32 scu088, scu08c, scu0a4, scu0a8, scu094;
+
+			scu088 = ast_mindwm(ast, AST_REG_SCU088);
+			scu088 |= 0x30000000; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU088, scu088);
+
+			scu08c = ast_mindwm(ast, AST_REG_SCU08C);
+			scu08c |= 0x000000cf; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU08C, scu08c);
+
+			scu0a4 = ast_mindwm(ast, AST_REG_SCU0A4);
+			scu0a4 |= 0xffff0000; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU0A4, scu0a4);
+
+			scu0a8 = ast_mindwm(ast, AST_REG_SCU0A8);
+			scu0a8 |= 0x0000000f; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU0A8, scu0a8);
+
+			scu094 = ast_mindwm(ast, AST_REG_SCU094);
+			scu094 |= 0x00000002; /* multi-pins for DVO single-edge */
+			ast_moutdwm(ast, AST_REG_SCU094, scu094);
 		}
 	}
 
 	/* Force to DVO */
-	data = ast_read32(ast, 0x1202c);
-	data &= 0xfffbffff;
-	ast_write32(ast, 0x1202c, data);
+	scu02c = ast_mindwm(ast, AST_REG_SCU02C);
+	scu02c &= 0xfffbffff;
+	ast_moutdwm(ast, AST_REG_SCU02C, scu02c);
 
 	/* Init VGA DVO Settings */
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x80);
@@ -418,25 +415,20 @@ static bool ast_init_dvo(struct ast_device *ast)
 
 static void ast_init_analog(struct ast_device *ast)
 {
-	u32 data;
+	u32 scu02c;
 
 	/*
 	 * Set DAC source to VGA mode in SCU2C via the P2A
-	 * bridge. First configure the P2U to target the SCU
-	 * in case it isn't at this stage.
+	 * bridge.
 	 */
-	ast_write32(ast, 0xf004, AST_REG_MCR00);
-	ast_write32(ast, 0xf000, 0x1);
-
-	/* Then unlock the SCU with the magic password */
-	ast_write32(ast, 0x12000, 0x1688a8a8);
-	ast_write32(ast, 0x12000, 0x1688a8a8);
-	ast_write32(ast, 0x12000, 0x1688a8a8);
-
-	/* Finally, clear bits [17:16] of SCU2c */
-	data = ast_read32(ast, 0x1202c);
-	data &= 0xfffcffff;
-	ast_write32(ast, 0x1202c, data);
+
+	/* Unlock the SCU with the magic password */
+	ast_moutdwm_poll(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY, 0x01);
+
+	/* Clear bits [17:16] of SCU2C */
+	scu02c = ast_mindwm(ast, AST_REG_SCU02C);
+	scu02c &= 0xfffcffff;
+	ast_moutdwm(ast, AST_REG_SCU02C, scu02c);
 
 	/* Disable DVO */
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index c3473cad4545..9d6ea0765990 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -186,11 +186,17 @@
 #define AST_REG_SCU008				AST_REG_SCU(0x008)
 #define AST_REG_SCU00C				AST_REG_SCU(0x00c)
 #define AST_REG_SCU020				AST_REG_SCU(0x020)
+#define AST_REG_SCU02C				AST_REG_SCU(0x02c)
 #define AST_REG_SCU040				AST_REG_SCU(0x040)
 #define AST_REG_SCU070				AST_REG_SCU(0x070)
 #define AST_REG_SCU07C				AST_REG_SCU(0x07c)
+#define AST_REG_SCU084				AST_REG_SCU(0x084)
+#define AST_REG_SCU088				AST_REG_SCU(0x088)
+#define AST_REG_SCU08C				AST_REG_SCU(0x08c)
 #define AST_REG_SCU090				AST_REG_SCU(0x090)
 #define AST_REG_SCU094				AST_REG_SCU(0x094)
+#define AST_REG_SCU0A4				AST_REG_SCU(0x0a4)
+#define AST_REG_SCU0A8				AST_REG_SCU(0x0a8)
 #define AST_REG_SCU100				AST_REG_SCU(0x100)
 #define AST_REG_SCU104				AST_REG_SCU(0x104)
 #define AST_REG_SCU160				AST_REG_SCU(0x160)
-- 
2.53.0

