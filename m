Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8E110ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BE010EE71;
	Fri, 27 Mar 2026 13:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1eVIO5xN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Li+3983o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1eVIO5xN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Li+3983o";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FEF10EE6B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:36:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65CE34D341;
 Fri, 27 Mar 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRjgCaMdR61ay0RyfuqPPJNkjBsvxKWS+isBaiXAKcM=;
 b=1eVIO5xN+eywucxyWG/OaNGwFcERZnxQN0ubXrFpZmHSlfSgL1MbXBk40tFQwgiYtl0jew
 +El3Hxjd6lVjhiLZtdU6KpqVEnDw7cDCSh8dzSkrfhP0ADAhV/0iBhjo2kUZL+NOSv8d/J
 JoiJi3vsQfOeKUSBWoobh927pSHMtBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRjgCaMdR61ay0RyfuqPPJNkjBsvxKWS+isBaiXAKcM=;
 b=Li+3983ogDwln5Z0STRNbu3PfIQfkpDUXG3DnX7v7NQkhZ+j8C7JASbQ94dC/3V2KGODlT
 opf3k1I7delVaFAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1eVIO5xN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Li+3983o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRjgCaMdR61ay0RyfuqPPJNkjBsvxKWS+isBaiXAKcM=;
 b=1eVIO5xN+eywucxyWG/OaNGwFcERZnxQN0ubXrFpZmHSlfSgL1MbXBk40tFQwgiYtl0jew
 +El3Hxjd6lVjhiLZtdU6KpqVEnDw7cDCSh8dzSkrfhP0ADAhV/0iBhjo2kUZL+NOSv8d/J
 JoiJi3vsQfOeKUSBWoobh927pSHMtBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRjgCaMdR61ay0RyfuqPPJNkjBsvxKWS+isBaiXAKcM=;
 b=Li+3983ogDwln5Z0STRNbu3PfIQfkpDUXG3DnX7v7NQkhZ+j8C7JASbQ94dC/3V2KGODlT
 opf3k1I7delVaFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A4A54A0B2;
 Fri, 27 Mar 2026 13:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBoiCayHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 15/15] drm/ast: Fix open-coded scu_rev access
Date: Fri, 27 Mar 2026 14:33:07 +0100
Message-ID: <20260327133532.79696-16-tzimmermann@suse.de>
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
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Rspamd-Queue-Id: 65CE34D341
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
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
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
index 92cfa02b642f..ea7dc382aee7 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -191,6 +191,7 @@
 #define AST_REG_SCU040				AST_REG_SCU(0x040)
 #define AST_REG_SCU070				AST_REG_SCU(0x070)
 #define AST_REG_SCU07C				AST_REG_SCU(0x07c)
+#define AST_REG_SCU07C_CHIP_BONDING_MASK	GENMASK(15, 8)
 #define AST_REG_SCU084				AST_REG_SCU(0x084)
 #define AST_REG_SCU088				AST_REG_SCU(0x088)
 #define AST_REG_SCU08C				AST_REG_SCU(0x08c)
-- 
2.53.0

