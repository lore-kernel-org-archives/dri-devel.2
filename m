Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E10410ED67B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E9D10EE6E;
	Fri, 27 Mar 2026 13:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="kMUyuoNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kXqdfCAP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMUyuoNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kXqdfCAP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE8310EE67
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05ADC4D347;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0im/tsDyLfLs0lK6jrWLHNc2MN/NeUFFrMqxX/5+DI=;
 b=kMUyuoNZtibaFMxj8vkuKNCVO2U59OBoz5bWd0X4LUnohk9M59EGoqR3TT6sy5Bekt7L+D
 PB9PgKDXWvOljxdE1XBfp7FwB6vfOpM5RFpPi2PfLNTcolpR5cyYbkQrzY87WFpUffpv2+
 6DSU7fzfg3NncU85/C2/qKYQyq9cv8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0im/tsDyLfLs0lK6jrWLHNc2MN/NeUFFrMqxX/5+DI=;
 b=kXqdfCAPOfrcGMQiGsK36N2zH5I0+tQp/4UTPhklpFGGI9ACKhpr//4ZvokNwscopg5dnU
 DdbatKhSDxCwpNCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kMUyuoNZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kXqdfCAP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0im/tsDyLfLs0lK6jrWLHNc2MN/NeUFFrMqxX/5+DI=;
 b=kMUyuoNZtibaFMxj8vkuKNCVO2U59OBoz5bWd0X4LUnohk9M59EGoqR3TT6sy5Bekt7L+D
 PB9PgKDXWvOljxdE1XBfp7FwB6vfOpM5RFpPi2PfLNTcolpR5cyYbkQrzY87WFpUffpv2+
 6DSU7fzfg3NncU85/C2/qKYQyq9cv8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0im/tsDyLfLs0lK6jrWLHNc2MN/NeUFFrMqxX/5+DI=;
 b=kXqdfCAPOfrcGMQiGsK36N2zH5I0+tQp/4UTPhklpFGGI9ACKhpr//4ZvokNwscopg5dnU
 DdbatKhSDxCwpNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBDBB4A0A2;
 Fri, 27 Mar 2026 13:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mNtpLKqHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 10/15] drm/ast: Gen1: Fix open-coded register access
Date: Fri, 27 Mar 2026 14:33:02 +0100
Message-ID: <20260327133532.79696-11-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 05ADC4D347
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
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
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

