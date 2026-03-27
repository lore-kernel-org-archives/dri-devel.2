Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE310ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF32F10EE64;
	Fri, 27 Mar 2026 13:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Cja10vG0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtS82BKf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cja10vG0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtS82BKf";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B50310EE65
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 964785BDE8;
 Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5satd8vn/+YVhE8l4P7GEFcYqgQShRu4gHG0CR05ww=;
 b=Cja10vG0WyG2JyvRfiRxEK5iecllR8iJ8cKYFIBGA1JCi+zrKXPDmDdPhwjLZRgFB1Gg6j
 F1dV9QLtwMP0reaURlQT5JVpWS9M4Z5cSs8pYfoPF88PjHttNWjmcD+Vysn+QxSjzwBaUL
 KKK57RMZhF0x8oavDbGh8/JIRlCK0r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5satd8vn/+YVhE8l4P7GEFcYqgQShRu4gHG0CR05ww=;
 b=qtS82BKf4rcxWsijvFb6nL5VpuMloPdS4wHZJGPXnqxRDczsWm20PPlRjB9MhDTihSe/ju
 fRzgRTaEhgXFzSAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cja10vG0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qtS82BKf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5satd8vn/+YVhE8l4P7GEFcYqgQShRu4gHG0CR05ww=;
 b=Cja10vG0WyG2JyvRfiRxEK5iecllR8iJ8cKYFIBGA1JCi+zrKXPDmDdPhwjLZRgFB1Gg6j
 F1dV9QLtwMP0reaURlQT5JVpWS9M4Z5cSs8pYfoPF88PjHttNWjmcD+Vysn+QxSjzwBaUL
 KKK57RMZhF0x8oavDbGh8/JIRlCK0r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5satd8vn/+YVhE8l4P7GEFcYqgQShRu4gHG0CR05ww=;
 b=qtS82BKf4rcxWsijvFb6nL5VpuMloPdS4wHZJGPXnqxRDczsWm20PPlRjB9MhDTihSe/ju
 fRzgRTaEhgXFzSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5357F4A0B1;
 Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJglE6mHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 05/15] drm/ast: Use constants for SCU registers
Date: Fri, 27 Mar 2026 14:32:57 +0100
Message-ID: <20260327133532.79696-6-tzimmermann@suse.de>
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
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 964785BDE8
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

SCU is the System Control Unit. SCU registers are located in the memory
range at [0x1e6e2000, 0x1e6e2fff]. Refer to them with constants named
AST_REG_SCU<n>, where <n> is the byte offset into the range.

Replacing the magic values in the ast driver was done with grep and sed
as shown below

  git grep -l \,\ 0x1e6e2 | xargs sed -i -e 's/, 0x1e6e2/, AST_REG_SCU/g'
  git grep -l \,\ 0x1E6E2 | xargs sed -i -e 's/, 0x1E6E2/, AST_REG_SCU/g'

plus some manual fixes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2300.c  | 50 ++++++++++++++++-----------------
 drivers/gpu/drm/ast/ast_2500.c  | 44 ++++++++++++++---------------
 drivers/gpu/drm/ast/ast_dp501.c | 20 ++++++-------
 drivers/gpu/drm/ast/ast_reg.h   | 19 +++++++++++++
 4 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
index 56fe9e9f5c66..1fe947178124 100644
--- a/drivers/gpu/drm/ast/ast_2300.c
+++ b/drivers/gpu/drm/ast/ast_2300.c
@@ -516,10 +516,10 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 {
 	u32 trap, trap_AC2, trap_MRS;
 
-	ast_moutdwm(ast, 0x1E6E2000, 0x1688A8A8);
+	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 
 	/* Ger trap info */
-	trap = (ast_mindwm(ast, 0x1E6E2070) >> 25) & 0x3;
+	trap = (ast_mindwm(ast, AST_REG_SCU070) >> 25) & 0x3;
 	trap_AC2  = 0x00020000 + (trap << 16);
 	trap_AC2 |= 0x00300000 + ((trap & 0x2) << 19);
 	trap_MRS  = 0x00000010 + (trap << 4);
@@ -533,7 +533,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 
 	switch (param->dram_freq) {
 	case 336:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0190);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0190);
 		param->wodt          = 0;
 		param->reg_AC1       = 0x22202725;
 		param->reg_AC2       = 0xAA007613 | trap_AC2;
@@ -561,7 +561,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		break;
 	default:
 	case 396:
-		ast_moutdwm(ast, 0x1E6E2020, 0x03F1);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x03F1);
 		param->wodt          = 1;
 		param->reg_AC1       = 0x33302825;
 		param->reg_AC2       = 0xCC009617 | trap_AC2;
@@ -591,7 +591,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		break;
 
 	case 408:
-		ast_moutdwm(ast, 0x1E6E2020, 0x01F0);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x01F0);
 		param->wodt          = 1;
 		param->reg_AC1       = 0x33302825;
 		param->reg_AC2       = 0xCC009617 | trap_AC2;
@@ -621,7 +621,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 
 		break;
 	case 456:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0230);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0230);
 		param->wodt          = 0;
 		param->reg_AC1       = 0x33302926;
 		param->reg_AC2       = 0xCD44961A;
@@ -635,7 +635,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 4;
 		break;
 	case 504:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0270);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0270);
 		param->wodt          = 1;
 		param->reg_AC1       = 0x33302926;
 		param->reg_AC2       = 0xDE44A61D;
@@ -649,7 +649,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 4;
 		break;
 	case 528:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0290);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0290);
 		param->wodt          = 1;
 		param->rodt          = 1;
 		param->reg_AC1       = 0x33302926;
@@ -665,7 +665,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 576:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0140);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0140);
 		param->reg_MADJ      = 0x00136868;
 		param->reg_SADJ      = 0x00004534;
 		param->wodt          = 1;
@@ -683,7 +683,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 600:
-		ast_moutdwm(ast, 0x1E6E2020, 0x02E1);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x02E1);
 		param->reg_MADJ      = 0x00136868;
 		param->reg_SADJ      = 0x00004534;
 		param->wodt          = 1;
@@ -701,7 +701,7 @@ static void get_ddr3_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 624:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0160);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0160);
 		param->reg_MADJ      = 0x00136868;
 		param->reg_SADJ      = 0x00004534;
 		param->wodt          = 1;
@@ -874,10 +874,10 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 {
 	u32 trap, trap_AC2, trap_MRS;
 
-	ast_moutdwm(ast, 0x1E6E2000, 0x1688A8A8);
+	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 
 	/* Ger trap info */
-	trap = (ast_mindwm(ast, 0x1E6E2070) >> 25) & 0x3;
+	trap = (ast_mindwm(ast, AST_REG_SCU070) >> 25) & 0x3;
 	trap_AC2  = (trap << 20) | (trap << 16);
 	trap_AC2 += 0x00110000;
 	trap_MRS  = 0x00000040 | (trap << 4);
@@ -890,7 +890,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 
 	switch (param->dram_freq) {
 	case 264:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0130);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0130);
 		param->wodt          = 0;
 		param->reg_AC1       = 0x11101513;
 		param->reg_AC2       = 0x78117011;
@@ -905,7 +905,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 336:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0190);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0190);
 		param->wodt          = 1;
 		param->reg_AC1       = 0x22202613;
 		param->reg_AC2       = 0xAA009016 | trap_AC2;
@@ -936,7 +936,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		break;
 	default:
 	case 396:
-		ast_moutdwm(ast, 0x1E6E2020, 0x03F1);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x03F1);
 		param->wodt          = 1;
 		param->rodt          = 0;
 		param->reg_AC1       = 0x33302714;
@@ -970,7 +970,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		break;
 
 	case 408:
-		ast_moutdwm(ast, 0x1E6E2020, 0x01F0);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x01F0);
 		param->wodt          = 1;
 		param->rodt          = 0;
 		param->reg_AC1       = 0x33302714;
@@ -1003,7 +1003,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 
 		break;
 	case 456:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0230);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0230);
 		param->wodt          = 0;
 		param->reg_AC1       = 0x33302815;
 		param->reg_AC2       = 0xCD44B01E;
@@ -1018,7 +1018,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 504:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0261);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0261);
 		param->wodt          = 1;
 		param->rodt          = 1;
 		param->reg_AC1       = 0x33302815;
@@ -1034,7 +1034,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 528:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0120);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0120);
 		param->wodt          = 1;
 		param->rodt          = 1;
 		param->reg_AC1       = 0x33302815;
@@ -1050,7 +1050,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 552:
-		ast_moutdwm(ast, 0x1E6E2020, 0x02A1);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x02A1);
 		param->wodt          = 1;
 		param->rodt          = 1;
 		param->reg_AC1       = 0x43402915;
@@ -1066,7 +1066,7 @@ static void get_ddr2_info(struct ast_device *ast, struct ast2300_dram_param *par
 		param->dll2_finetune_step = 3;
 		break;
 	case 576:
-		ast_moutdwm(ast, 0x1E6E2020, 0x0140);
+		ast_moutdwm(ast, AST_REG_SCU020, 0x0140);
 		param->wodt          = 1;
 		param->rodt          = 1;
 		param->reg_AC1       = 0x43402915;
@@ -1264,7 +1264,7 @@ static void ast_post_chip_2300(struct ast_device *ast)
 
 		param.dram_freq = 396;
 		param.dram_type = AST_DDR3;
-		temp = ast_mindwm(ast, 0x1e6e2070);
+		temp = ast_mindwm(ast, AST_REG_SCU070);
 		if (temp & 0x01000000)
 			param.dram_type = AST_DDR2;
 		switch (temp & 0x18000000) {
@@ -1306,8 +1306,8 @@ static void ast_post_chip_2300(struct ast_device *ast)
 			ddr2_init(ast, &param);
 		}
 
-		temp = ast_mindwm(ast, 0x1e6e2040);
-		ast_moutdwm(ast, 0x1e6e2040, temp | 0x40);
+		temp = ast_mindwm(ast, AST_REG_SCU040);
+		ast_moutdwm(ast, AST_REG_SCU040, temp | 0x40);
 	}
 
 	/* wait ready */
diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index 4a9df920509f..d141b34548a9 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -112,9 +112,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
 	__ast_moutdwm(regs, AST_REG_AHBC00, AST_REG_AHBC00_PROTECT_KEY);
 	__ast_moutdwm(regs, AST_REG_AHBC84, 0x00010000);
 	__ast_moutdwm(regs, AST_REG_AHBC88, 0x00000000);
-	__ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
+	__ast_moutdwm(regs, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 
-	data = __ast_mindwm(regs, 0x1e6e2070);
+	data = __ast_mindwm(regs, AST_REG_SCU070);
 	if (data & 0x08000000) { /* check fast reset */
 		/*
 		 * If "Fast restet" is enabled for ARM-ICE debugger,
@@ -134,11 +134,11 @@ void ast_2500_patch_ahb(void __iomem *regs)
 	}
 
 	do {
-		__ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
-		data = __ast_mindwm(regs, 0x1e6e2000);
+		__ast_moutdwm(regs, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
+		data = __ast_mindwm(regs, AST_REG_SCU000);
 	} while (data != 1);
 
-	__ast_moutdwm(regs, 0x1e6e207c, 0x08000000); /* clear fast reset */
+	__ast_moutdwm(regs, AST_REG_SCU07C, 0x08000000); /* clear fast reset */
 }
 
 static bool mmc_test_single_2500(struct ast_device *ast, u32 datagen)
@@ -288,17 +288,17 @@ static void set_mpll_2500(struct ast_device *ast)
 	}
 	ast_moutdwm(ast, AST_REG_MCR34, 0x00020000);
 
-	ast_moutdwm(ast, 0x1E6E2000, 0x1688A8A8);
-	data = ast_mindwm(ast, 0x1E6E2070) & 0x00800000;
+	ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
+	data = ast_mindwm(ast, AST_REG_SCU070) & 0x00800000;
 	if (data) {
 		/* CLKIN = 25MHz */
 		param = 0x930023E0;
-		ast_moutdwm(ast, 0x1E6E2160, 0x00011320);
+		ast_moutdwm(ast, AST_REG_SCU160, 0x00011320);
 	} else {
 		/* CLKIN = 24MHz */
 		param = 0x93002400;
 	}
-	ast_moutdwm(ast, 0x1E6E2020, param);
+	ast_moutdwm(ast, AST_REG_SCU020, param);
 	udelay(100);
 }
 
@@ -480,18 +480,18 @@ static bool ast_dram_init_2500(struct ast_device *ast)
 		reset_mmc_2500(ast);
 		ddr_init_common_2500(ast);
 
-		data = ast_mindwm(ast, 0x1E6E2070);
+		data = ast_mindwm(ast, AST_REG_SCU070);
 		if (data & 0x01000000)
 			ddr4_init_2500(ast, ast2500_ddr4_1600_timing_table);
 		else
 			ddr3_init_2500(ast, ast2500_ddr3_1600_timing_table);
 	} while (!ddr_test_2500(ast));
 
-	ast_moutdwm(ast, 0x1E6E2040, ast_mindwm(ast, 0x1E6E2040) | 0x41);
+	ast_moutdwm(ast, AST_REG_SCU040, ast_mindwm(ast, AST_REG_SCU040) | 0x41);
 
 	/* Patch code */
-	data = ast_mindwm(ast, 0x1E6E200C) & 0xF9FFFFFF;
-	ast_moutdwm(ast, 0x1E6E200C, data | 0x10000000);
+	data = ast_mindwm(ast, AST_REG_SCU00C) & 0xF9FFFFFF;
+	ast_moutdwm(ast, AST_REG_SCU00C, data | 0x10000000);
 
 	return true;
 }
@@ -524,17 +524,17 @@ static void ast_post_chip_2500(struct ast_device *ast)
 		 * SCU7C is Write clear reg to SCU70
 		 *	[23]:= write 1 and then SCU70[23] will be clear as 0b.
 		 */
-		ast_moutdwm(ast, 0x1E6E2090, 0x20000000);
-		ast_moutdwm(ast, 0x1E6E2094, 0x00004000);
-		if (ast_mindwm(ast, 0x1E6E2070) & 0x00800000) {
-			ast_moutdwm(ast, 0x1E6E207C, 0x00800000);
+		ast_moutdwm(ast, AST_REG_SCU090, 0x20000000);
+		ast_moutdwm(ast, AST_REG_SCU094, 0x00004000);
+		if (ast_mindwm(ast, AST_REG_SCU070) & 0x00800000) {
+			ast_moutdwm(ast, AST_REG_SCU07C, 0x00800000);
 			mdelay(100);
-			ast_moutdwm(ast, 0x1E6E2070, 0x00800000);
+			ast_moutdwm(ast, AST_REG_SCU070, 0x00800000);
 		}
 		/* Modify eSPI reset pin */
-		temp = ast_mindwm(ast, 0x1E6E2070);
+		temp = ast_mindwm(ast, AST_REG_SCU070);
 		if (temp & 0x02000000)
-			ast_moutdwm(ast, 0x1E6E207C, 0x00004000);
+			ast_moutdwm(ast, AST_REG_SCU07C, 0x00004000);
 
 		/* Slow down CPU/AHB CLK in VGA only mode */
 		temp = ast_read32(ast, 0x12008);
@@ -544,8 +544,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
 		if (!ast_dram_init_2500(ast))
 			drm_err(dev, "DRAM init failed !\n");
 
-		temp = ast_mindwm(ast, 0x1e6e2040);
-		ast_moutdwm(ast, 0x1e6e2040, temp | 0x40);
+		temp = ast_mindwm(ast, AST_REG_SCU040);
+		ast_moutdwm(ast, AST_REG_SCU040, temp | 0x40);
 	}
 
 	/* wait ready */
diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 8c2243cf8187..23142119d733 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -183,7 +183,7 @@ static void ast_set_dp501_video_output(struct ast_device *ast, u8 mode)
 
 static u32 get_fw_base(struct ast_device *ast)
 {
-	return ast_mindwm(ast, 0x1e6e2104) & 0x7fffffff;
+	return ast_mindwm(ast, AST_REG_SCU104) & 0x7fffffff;
 }
 
 bool ast_backup_fw(struct ast_device *ast, u8 *addr, u32 size)
@@ -194,7 +194,7 @@ bool ast_backup_fw(struct ast_device *ast, u8 *addr, u32 size)
 	if (ast->config_mode != ast_use_p2a)
 		return false;
 
-	data = ast_mindwm(ast, 0x1e6e2100) & 0x01;
+	data = ast_mindwm(ast, AST_REG_SCU100) & 0x01;
 	if (data) {
 		boot_address = get_fw_base(ast);
 		for (i = 0; i < size; i += 4)
@@ -214,7 +214,7 @@ static bool ast_launch_m68k(struct ast_device *ast)
 	if (ast->config_mode != ast_use_p2a)
 		return false;
 
-	data = ast_mindwm(ast, 0x1e6e2100) & 0x01;
+	data = ast_mindwm(ast, AST_REG_SCU100) & 0x01;
 	if (!data) {
 
 		if (ast->dp501_fw_addr) {
@@ -229,7 +229,7 @@ static bool ast_launch_m68k(struct ast_device *ast)
 			len = ast->dp501_fw->size;
 		}
 		/* Get BootAddress */
-		ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);
+		ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 		data = ast_mindwm(ast, AST_REG_MCR04);
 		switch (data & 0x03) {
 		case 0:
@@ -255,16 +255,16 @@ static bool ast_launch_m68k(struct ast_device *ast)
 		}
 
 		/* Init SCU */
-		ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);
+		ast_moutdwm(ast, AST_REG_SCU000, AST_REG_SCU000_PROTECTION_KEY);
 
 		/* Launch FW */
-		ast_moutdwm(ast, 0x1e6e2104, 0x80000000 + boot_address);
-		ast_moutdwm(ast, 0x1e6e2100, 1);
+		ast_moutdwm(ast, AST_REG_SCU104, 0x80000000 + boot_address);
+		ast_moutdwm(ast, AST_REG_SCU100, 1);
 
 		/* Update Scratch */
-		data = ast_mindwm(ast, 0x1e6e2040) & 0xfffff1ff;		/* D[11:9] = 100b: UEFI handling */
-		data |= 0x800;
-		ast_moutdwm(ast, 0x1e6e2040, data);
+		data = ast_mindwm(ast, AST_REG_SCU040) & 0xfffff1ff;
+		data |= 0x800; /* D[11:9] = 100b: UEFI handling */
+		ast_moutdwm(ast, AST_REG_SCU040, data);
 
 		jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0x99, 0xfc); /* D[1:0]: Reserved Video Buffer */
 		jreg |= 0x02;
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index a54733dc2675..e8d4991186ca 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -169,4 +169,23 @@
 #define AST_REG_MCR300				AST_REG_MCR(0x300)
 #define AST_REG_MCR3D0				AST_REG_MCR(0x3d0)
 
+/*
+ * System Control Unit (0x1e6e2000 - 0x1e6e2fff)
+ */
+
+#define AST_REG_SCU_BASE			(0x1e6e2000)
+#define AST_REG_SCU(__offset)			(AST_REG_SCU_BASE + (__offset))
+#define AST_REG_SCU000				AST_REG_SCU(0x000)
+#define AST_REG_SCU000_PROTECTION_KEY		(0x1688a8a8)
+#define AST_REG_SCU00C				AST_REG_SCU(0x00c)
+#define AST_REG_SCU020				AST_REG_SCU(0x020)
+#define AST_REG_SCU040				AST_REG_SCU(0x040)
+#define AST_REG_SCU070				AST_REG_SCU(0x070)
+#define AST_REG_SCU07C				AST_REG_SCU(0x07c)
+#define AST_REG_SCU090				AST_REG_SCU(0x090)
+#define AST_REG_SCU094				AST_REG_SCU(0x094)
+#define AST_REG_SCU100				AST_REG_SCU(0x100)
+#define AST_REG_SCU104				AST_REG_SCU(0x104)
+#define AST_REG_SCU160				AST_REG_SCU(0x160)
+
 #endif
-- 
2.53.0

