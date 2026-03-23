Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72C8F483C2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9C110E57E;
	Mon, 23 Mar 2026 16:04:58 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026E410E57E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDF054D382;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77A343968;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qMFlK39kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 15/15] drm/ast: Fix open-coded scu_rev access
Date: Mon, 23 Mar 2026 16:56:28 +0100
Message-ID: <20260323160407.245773-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: EDF054D382
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

Replace all open-coded access to P2A and SCU registers in the device
detection with the appropriate calls to ast_moutdwm() and ast_mindwm().
Use P2A and MCR register constants. Name variables according to registers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_drv.c | 13 ++++++-------
 drivers/gpu/drm/ast/ast_reg.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 6fe549f16309..ba6cf5fa901c 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -242,7 +242,7 @@ static int ast_detect_chip(struct pci_dev *pdev,
 	enum ast_config_mode config_mode = ast_use_defaults;
 	uint32_t scu_rev = 0xffffffff;
 	enum ast_chip chip;
-	u32 data;
+	u32 data, p2a04, scu07c;
 	u8 vgacrd0, vgacrd1;
 
 	/*
@@ -275,14 +275,13 @@ static int ast_detect_chip(struct pci_dev *pdev,
 			}
 
 			/* Double check that it's actually working */
-			data = __ast_read32(regs, 0xf004);
-			if ((data != 0xffffffff) && (data != 0x00)) {
+			p2a04 = __ast_read32(regs, AST_REG_P2A04);
+			if (p2a04 != 0xffffffff && p2a04 != 0x00000000) {
 				config_mode = ast_use_p2a;
 
-				/* Read SCU7c (silicon revision register) */
-				__ast_write32(regs, 0xf004, AST_REG_MCR00);
-				__ast_write32(regs, 0xf000, 0x1);
-				scu_rev = __ast_read32(regs, 0x1207c);
+				/* Read SCU7C (silicon revision register) */
+				scu07c = __ast_mindwm(regs, AST_REG_SCU07C);
+				scu_rev = scu07c & AST_REG_SCU07C_CHIP_BONDING_MASK;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 9d6ea0765990..00e496d61551 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -190,6 +190,7 @@
 #define AST_REG_SCU040				AST_REG_SCU(0x040)
 #define AST_REG_SCU070				AST_REG_SCU(0x070)
 #define AST_REG_SCU07C				AST_REG_SCU(0x07c)
+#define AST_REG_SCU07C_CHIP_BONDING_MASK	GENMASK(15, 8)
 #define AST_REG_SCU084				AST_REG_SCU(0x084)
 #define AST_REG_SCU088				AST_REG_SCU(0x088)
 #define AST_REG_SCU08C				AST_REG_SCU(0x08c)
-- 
2.53.0

