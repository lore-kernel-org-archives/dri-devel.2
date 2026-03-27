Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC87210ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537E010EE63;
	Fri, 27 Mar 2026 13:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VWmrV40o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LnDHt21j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VWmrV40o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LnDHt21j";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2E410EE72
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:36:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2CCA5BDD9;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=de/kHiUF6VuakwtXrEm5bkFdfMXo2fzC8vRdmKcTitk=;
 b=VWmrV40ojdGeDd/IaOz9zG+FqfN6WBPBcSASHz4kBelVOJbh18CO1Fxsvo8X7B4aMVJmFV
 bHVR+HYoo7vwlPlplpMVnzEd8dn970v8NVpzN6dt3JMGm54mQWyiXccZ2rtIgjn2WjK6zt
 5kN1XfQ7ihVnkEfHZIQDzMkS9Nx2UtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=de/kHiUF6VuakwtXrEm5bkFdfMXo2fzC8vRdmKcTitk=;
 b=LnDHt21jy3OkW8p3tAqHgp3vpHrMpRZ0lJibysLXdetmZ90cddvD4G3UrZM75VL3Zmrl7R
 FYPdEjkXaTb3Y6DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VWmrV40o;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LnDHt21j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=de/kHiUF6VuakwtXrEm5bkFdfMXo2fzC8vRdmKcTitk=;
 b=VWmrV40ojdGeDd/IaOz9zG+FqfN6WBPBcSASHz4kBelVOJbh18CO1Fxsvo8X7B4aMVJmFV
 bHVR+HYoo7vwlPlplpMVnzEd8dn970v8NVpzN6dt3JMGm54mQWyiXccZ2rtIgjn2WjK6zt
 5kN1XfQ7ihVnkEfHZIQDzMkS9Nx2UtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=de/kHiUF6VuakwtXrEm5bkFdfMXo2fzC8vRdmKcTitk=;
 b=LnDHt21jy3OkW8p3tAqHgp3vpHrMpRZ0lJibysLXdetmZ90cddvD4G3UrZM75VL3Zmrl7R
 FYPdEjkXaTb3Y6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98B714A0B2;
 Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2E4PJKuHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 13/15] drm/ast: Gen6: Fix open-coded register access
Date: Fri, 27 Mar 2026 14:33:05 +0100
Message-ID: <20260327133532.79696-14-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: D2CCA5BDD9
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

Replace all open-coded access to MCR and SCU registers in Gen6 with
the appropriate calls to ast_moutdwm() and ast_mindwm(). Use MCR and
SCU register constants. Name variables according to registers.

v2:
- also fix MCR constants

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2500.c | 16 ++++++++--------
 drivers/gpu/drm/ast/ast_reg.h  |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index 39f401dd1f47..03a67ec9684b 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -280,15 +280,13 @@ static void enable_cache_2500(struct ast_device *ast)
 
 static void set_mpll_2500(struct ast_device *ast)
 {
-	u32 addr, data, param;
+	u32 mcr, data, param;
 
 	/* Reset MMC */
 	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
 	ast_moutdwm(ast, AST_REG_MCR34, 0x00020080);
-	for (addr = 0x1e6e0004; addr < 0x1e6e0090;) {
-		ast_moutdwm(ast, addr, 0x0);
-		addr += 4;
-	}
+	for (mcr = AST_REG_MCR04; mcr <= AST_REG_MCR8C; mcr += 4)
+		ast_moutdwm(ast, mcr, 0x00000000);
 	ast_moutdwm(ast, AST_REG_MCR34, 0x00020000);
 
 	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
@@ -507,6 +505,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
 
 	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 	if ((reg & AST_IO_VGACRD0_VRAM_INIT_STATUS_MASK) == 0) {/* vga only */
+		u32 scu008;
+
 		/* Clear bus lock condition */
 		ast_2500_patch_ahb(ast->regs);
 
@@ -540,9 +540,9 @@ static void ast_post_chip_2500(struct ast_device *ast)
 			ast_moutdwm(ast, AST_REG_SCU07C, 0x00004000);
 
 		/* Slow down CPU/AHB CLK in VGA only mode */
-		temp = ast_read32(ast, 0x12008);
-		temp |= 0x73;
-		ast_write32(ast, 0x12008, temp);
+		scu008 = ast_mindwm(ast, AST_REG_SCU008);
+		scu008 |= 0x00000073;
+		ast_moutdwm(ast, AST_REG_SCU008, scu008);
 
 		if (!ast_dram_init_2500(ast))
 			drm_err(dev, "DRAM init failed !\n");
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index c3473cad4545..b7259d44a822 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -140,6 +140,7 @@
 #define AST_REG_MCR80				AST_REG_MCR(0x80)
 #define AST_REG_MCR84				AST_REG_MCR(0x84)
 #define AST_REG_MCR88				AST_REG_MCR(0x88)
+#define AST_REG_MCR8C				AST_REG_MCR(0x8c)
 #define AST_REG_MCR100				AST_REG_MCR(0x100)
 #define AST_REG_MCR108				AST_REG_MCR(0x108)
 #define AST_REG_MCR120				AST_REG_MCR(0x120)
-- 
2.53.0

