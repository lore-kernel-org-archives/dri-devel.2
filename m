Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF210ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0363F10EE6B;
	Fri, 27 Mar 2026 13:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MfSrVOK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5VELlxjR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MfSrVOK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5VELlxjR";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9BA10EE6B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:36:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E2AC5BDED;
 Fri, 27 Mar 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep6FLcUt1O/a2t+7dlVHhY58+0xACNxN4yzybXotCJU=;
 b=MfSrVOK5xc2O6MUekGUVLjsLKuCBaPkgWoGE0PVbnZ8KWJ2EgLfgnBq2EbKPY3olwLX62n
 zq+vbqCGp6B6eCZJwmlfF7yPaIW0v9bK2D6j2Vlrd+/RdQ45yAvWP52/TKk3q7ItcA4H/1
 Cf8MWEC2y4WHxCVJcySNPiyPnBPwZoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep6FLcUt1O/a2t+7dlVHhY58+0xACNxN4yzybXotCJU=;
 b=5VELlxjRrpHYID/a8QiDzIkVz0I0zvRiqKW3LLh4+eDcdvwXlLI691JAtNAWhKBa5U901E
 A/7HQgR2RMifroDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep6FLcUt1O/a2t+7dlVHhY58+0xACNxN4yzybXotCJU=;
 b=MfSrVOK5xc2O6MUekGUVLjsLKuCBaPkgWoGE0PVbnZ8KWJ2EgLfgnBq2EbKPY3olwLX62n
 zq+vbqCGp6B6eCZJwmlfF7yPaIW0v9bK2D6j2Vlrd+/RdQ45yAvWP52/TKk3q7ItcA4H/1
 Cf8MWEC2y4WHxCVJcySNPiyPnBPwZoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep6FLcUt1O/a2t+7dlVHhY58+0xACNxN4yzybXotCJU=;
 b=5VELlxjRrpHYID/a8QiDzIkVz0I0zvRiqKW3LLh4+eDcdvwXlLI691JAtNAWhKBa5U901E
 A/7HQgR2RMifroDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D4034A0B2;
 Fri, 27 Mar 2026 13:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFucCaqHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 08/15] drm/ast: Use constants for SDRAM registers
Date: Fri, 27 Mar 2026 14:33:00 +0100
Message-ID: <20260327133532.79696-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327133532.79696-1-tzimmermann@suse.de>
References: <20260327133532.79696-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Aspeed hardware allows for acceessing the SDRAM from the host. SDRAM
registers are located at the memory range at [0x80000000, 0xffffffff].

Refer to memory access with the macro AST_SDRAM(). Also add a TODO item
for the nonsensical documentation next to its caller.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2500.c | 17 ++++++++++-------
 drivers/gpu/drm/ast/ast_reg.h  |  7 +++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index f0639f1ef062..39f401dd1f47 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -225,6 +225,9 @@ static void ddr_phy_init_2500(struct ast_device *ast)
 }
 
 /*
+ * TODO: Review and fix the comments. The function below only detects
+ *       up to 1 GiB of SDRAM.
+ *
  * Check DRAM Size
  * 1Gb : 0x80000000 ~ 0x87FFFFFF
  * 2Gb : 0x80000000 ~ 0x8FFFFFFF
@@ -238,21 +241,21 @@ static void check_dram_size_2500(struct ast_device *ast, u32 tRFC)
 	reg_04 = ast_mindwm(ast, AST_REG_MCR04) & 0xfffffffc;
 	reg_14 = ast_mindwm(ast, AST_REG_MCR14) & 0xffffff00;
 
-	ast_moutdwm(ast, 0xA0100000, 0x41424344);
-	ast_moutdwm(ast, 0x90100000, 0x35363738);
-	ast_moutdwm(ast, 0x88100000, 0x292A2B2C);
-	ast_moutdwm(ast, 0x80100000, 0x1D1E1F10);
+	ast_moutdwm(ast, AST_SDRAM(0x20100000), 0x41424344);
+	ast_moutdwm(ast, AST_SDRAM(0x10100000), 0x35363738);
+	ast_moutdwm(ast, AST_SDRAM(0x08100000), 0x292A2B2C);
+	ast_moutdwm(ast, AST_SDRAM(0x00100000), 0x1D1E1F10);
 
 	/* Check 8Gbit */
-	if (ast_mindwm(ast, 0xA0100000) == 0x41424344) {
+	if (ast_mindwm(ast, AST_SDRAM(0x20100000)) == 0x41424344) {
 		reg_04 |= 0x03;
 		reg_14 |= (tRFC >> 24) & 0xFF;
 		/* Check 4Gbit */
-	} else if (ast_mindwm(ast, 0x90100000) == 0x35363738) {
+	} else if (ast_mindwm(ast, AST_SDRAM(0x10100000)) == 0x35363738) {
 		reg_04 |= 0x02;
 		reg_14 |= (tRFC >> 16) & 0xFF;
 		/* Check 2Gbit */
-	} else if (ast_mindwm(ast, 0x88100000) == 0x292A2B2C) {
+	} else if (ast_mindwm(ast, AST_SDRAM(0x08100000)) == 0x292A2B2C) {
 		reg_04 |= 0x01;
 		reg_14 |= (tRFC >> 8) & 0xFF;
 	} else {
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 5effe6897b51..78fabe2a9c81 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -209,4 +209,11 @@
 #define AST_REG_WDT1C(__n)			AST_REG_WDT((__n), 0x1c)
 #define AST_REG_WDT2C(__n)			AST_REG_WDT((__n), 0x2c)
 
+/*
+ * SDRAM (0x80000000 - 0xffffffff)
+ */
+
+#define AST_SDRAM_BASE				(0x80000000)
+#define AST_SDRAM(__offset)			(AST_SDRAM_BASE + (__offset))
+
 #endif
-- 
2.53.0

