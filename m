Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E30E10ED661
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9524E10EE70;
	Fri, 27 Mar 2026 13:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xGSbRMyB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dkWshTny";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xGSbRMyB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dkWshTny";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785C510EE6B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D9F05BDE7;
 Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3bd8dCfvaaCMVcpAbcgqPC8cikTCScZiHS/a5YNBEw=;
 b=xGSbRMyBbmUVGTFfcONWSt37bHWRZrx3ZOF4GSf3wyNYOrPAfha5KD2cAytNLa1sCV50Qu
 cN5Xnsoul3LTSjUBpihOpVjxpTV9ZuCiRM/qgeA9RSCQBEDtlppn5XSgjxt4R8GWBQjnyE
 aGK01CQ0Ybs48H3HTvQHgkaFYKMXfEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3bd8dCfvaaCMVcpAbcgqPC8cikTCScZiHS/a5YNBEw=;
 b=dkWshTnybQlcAq5TpUPFE5QcnnxvVJ/Jk6vw4fGqxu7/f2x9//D7Q5VAipDfdkfLylM95Q
 PywUhJTJqHsajUCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xGSbRMyB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dkWshTny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3bd8dCfvaaCMVcpAbcgqPC8cikTCScZiHS/a5YNBEw=;
 b=xGSbRMyBbmUVGTFfcONWSt37bHWRZrx3ZOF4GSf3wyNYOrPAfha5KD2cAytNLa1sCV50Qu
 cN5Xnsoul3LTSjUBpihOpVjxpTV9ZuCiRM/qgeA9RSCQBEDtlppn5XSgjxt4R8GWBQjnyE
 aGK01CQ0Ybs48H3HTvQHgkaFYKMXfEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3bd8dCfvaaCMVcpAbcgqPC8cikTCScZiHS/a5YNBEw=;
 b=dkWshTnybQlcAq5TpUPFE5QcnnxvVJ/Jk6vw4fGqxu7/f2x9//D7Q5VAipDfdkfLylM95Q
 PywUhJTJqHsajUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 067D24A0A2;
 Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0L01AKmHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/15] drm/ast: Use constants for MCR registers
Date: Fri, 27 Mar 2026 14:32:56 +0100
Message-ID: <20260327133532.79696-5-tzimmermann@suse.de>
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
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4D9F05BDE7
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

SDRAM registers are located in the memory range at
[0x1e160000, 0x1e160fff]. Refer to them with constants named
AST_REG_MCR<n>, where n is the byte offset into the range.

Replacing the magic values in the ast driver was done with grep
and sed as shown below

  git grep -l \,\ 0x1e6e00 | xargs sed -i -e 's/, 0x1e6e00/, AST_REG_MCR/g'
  git grep -l \,\ 0x1E6E00 | xargs sed -i -e 's/, 0x1E6E00/, AST_REG_MCR/g'

plus some manual fixes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2000.c  |   2 +-
 drivers/gpu/drm/ast/ast_2100.c  |  30 +--
 drivers/gpu/drm/ast/ast_2300.c  | 330 ++++++++++++++++----------------
 drivers/gpu/drm/ast/ast_2500.c  | 224 +++++++++++-----------
 drivers/gpu/drm/ast/ast_dp501.c |   6 +-
 drivers/gpu/drm/ast/ast_drv.c   |   2 +-
 drivers/gpu/drm/ast/ast_post.c  |  10 +-
 drivers/gpu/drm/ast/ast_reg.h   |  71 +++++++
 8 files changed, 373 insertions(+), 302 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2000.c b/drivers/gpu/drm/ast/ast_2000.c
index fa3bc23ce098..204646bb1fa0 100644
--- a/drivers/gpu/drm/ast/ast_2000.c
+++ b/drivers/gpu/drm/ast/ast_2000.c
@@ -106,7 +106,7 @@ static void ast_post_chip_2000(struct ast_device *ast)
 
 	if ((j & 0x80) == 0) { /* VGA only */
 		dram_reg_info = ast2000_dram_table_data;
-		ast_write32(ast, 0xf004, 0x1e6e0000);
+		ast_write32(ast, 0xf004, AST_REG_MCR00);
 		ast_write32(ast, 0xf000, 0x1);
 		ast_write32(ast, 0x10100, 0xa8);
 
diff --git a/drivers/gpu/drm/ast/ast_2100.c b/drivers/gpu/drm/ast/ast_2100.c
index 05aeb0624d41..28cd36571b7f 100644
--- a/drivers/gpu/drm/ast/ast_2100.c
+++ b/drivers/gpu/drm/ast/ast_2100.c
@@ -43,7 +43,7 @@ static enum ast_dram_layout ast_2100_get_dram_layout_p2a(struct ast_device *ast)
 	u32 mcr_cfg;
 	enum ast_dram_layout dram_layout;
 
-	ast_write32(ast, 0xf004, 0x1e6e0000);
+	ast_write32(ast, 0xf004, AST_REG_MCR00);
 	ast_write32(ast, 0xf000, 0x1);
 	mcr_cfg = ast_read32(ast, 0x10004);
 
@@ -209,28 +209,28 @@ static u32 mmctestburst2_ast2150(struct ast_device *ast, u32 datagen)
 {
 	u32 data, timeout;
 
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000001 | (datagen << 3));
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000001 | (datagen << 3));
 	timeout = 0;
 	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x40;
+		data = ast_mindwm(ast, AST_REG_MCR70) & 0x40;
 		if (++timeout > TIMEOUT_AST2150) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
 			return 0xffffffff;
 		}
 	} while (!data);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000003 | (datagen << 3));
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000003 | (datagen << 3));
 	timeout = 0;
 	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x40;
+		data = ast_mindwm(ast, AST_REG_MCR70) & 0x40;
 		if (++timeout > TIMEOUT_AST2150) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
 			return 0xffffffff;
 		}
 	} while (!data);
-	data = (ast_mindwm(ast, 0x1e6e0070) & 0x80) >> 7;
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
+	data = (ast_mindwm(ast, AST_REG_MCR70) & 0x80) >> 7;
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
 	return data;
 }
 
@@ -249,7 +249,7 @@ static int cbrscan_ast2150(struct ast_device *ast, int busw)
 	u32 patcnt, loop;
 
 	for (patcnt = 0; patcnt < CBR_PATNUM_AST2150; patcnt++) {
-		ast_moutdwm(ast, 0x1e6e007c, pattern_AST2150[patcnt]);
+		ast_moutdwm(ast, AST_REG_MCR7C, pattern_AST2150[patcnt]);
 		for (loop = 0; loop < CBR_PASSNUM_AST2150; loop++) {
 			if (cbrtest_ast2150(ast))
 				break;
@@ -276,7 +276,7 @@ static void cbrdlli_ast2150(struct ast_device *ast, int busw)
 	passcnt = 0;
 
 	for (dlli = 0; dlli < 100; dlli++) {
-		ast_moutdwm(ast, 0x1e6e0068, dlli | (dlli << 8) | (dlli << 16) | (dlli << 24));
+		ast_moutdwm(ast, AST_REG_MCR68, dlli | (dlli << 8) | (dlli << 16) | (dlli << 24));
 		data = cbrscan_ast2150(ast, busw);
 		if (data != 0) {
 			if (data & 0x1) {
@@ -294,7 +294,7 @@ static void cbrdlli_ast2150(struct ast_device *ast, int busw)
 		goto cbr_start;
 
 	dlli = dll_min[0] + (((dll_max[0] - dll_min[0]) * 7) >> 4);
-	ast_moutdwm(ast, 0x1e6e0068, dlli | (dlli << 8) | (dlli << 16) | (dlli << 24));
+	ast_moutdwm(ast, AST_REG_MCR68, dlli | (dlli << 8) | (dlli << 16) | (dlli << 24));
 }
 
 static void ast_post_chip_2100(struct ast_device *ast)
@@ -312,7 +312,7 @@ static void ast_post_chip_2100(struct ast_device *ast)
 		else
 			dram_reg_info = ast1100_dram_table_data;
 
-		ast_write32(ast, 0xf004, 0x1e6e0000);
+		ast_write32(ast, 0xf004, AST_REG_MCR00);
 		ast_write32(ast, 0xf000, 0x1);
 		ast_write32(ast, 0x12000, 0x1688A8A8);
 		do {
diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
index 5f50d9f91ffd..56fe9e9f5c66 100644
--- a/drivers/gpu/drm/ast/ast_2300.c
+++ b/drivers/gpu/drm/ast/ast_2300.c
@@ -129,19 +129,19 @@ static u32 mmc_test2(struct ast_device *ast, u32 datagen, u8 test_ctl)
 {
 	u32 data, timeout;
 
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, (datagen << 3) | test_ctl);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, (datagen << 3) | test_ctl);
 	timeout = 0;
 	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x1000;
+		data = ast_mindwm(ast, AST_REG_MCR70) & 0x1000;
 		if (++timeout > TIMEOUT) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x0);
+			ast_moutdwm(ast, AST_REG_MCR70, 0x0);
 			return 0xffffffff;
 		}
 	} while (!data);
-	data = ast_mindwm(ast, 0x1e6e0078);
+	data = ast_mindwm(ast, AST_REG_MCR78);
 	data = (data | (data >> 16)) & 0xffff;
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
 	return data;
 }
 
@@ -186,7 +186,7 @@ static int cbr_scan(struct ast_device *ast)
 
 	data2 = 3;
 	for (patcnt = 0; patcnt < CBR_PATNUM; patcnt++) {
-		ast_moutdwm(ast, 0x1e6e007c, pattern[patcnt]);
+		ast_moutdwm(ast, AST_REG_MCR7C, pattern[patcnt]);
 		for (loop = 0; loop < CBR_PASSNUM2; loop++) {
 			data = cbr_test(ast);
 			if (data != 0) {
@@ -222,7 +222,7 @@ static u32 cbr_scan2(struct ast_device *ast)
 
 	data2 = 0xffff;
 	for (patcnt = 0; patcnt < CBR_PATNUM; patcnt++) {
-		ast_moutdwm(ast, 0x1e6e007c, pattern[patcnt]);
+		ast_moutdwm(ast, AST_REG_MCR7C, pattern[patcnt]);
 		for (loop = 0; loop < CBR_PASSNUM2; loop++) {
 			data = cbr_test2(ast);
 			if (data != 0) {
@@ -252,7 +252,7 @@ static bool cbr_scan3(struct ast_device *ast)
 	u32 patcnt, loop;
 
 	for (patcnt = 0; patcnt < CBR_PATNUM; patcnt++) {
-		ast_moutdwm(ast, 0x1e6e007c, pattern[patcnt]);
+		ast_moutdwm(ast, AST_REG_MCR7C, pattern[patcnt]);
 		for (loop = 0; loop < 2; loop++) {
 			if (cbr_test3(ast))
 				break;
@@ -274,8 +274,8 @@ static bool finetuneDQI_L(struct ast_device *ast, struct ast2300_dram_param *par
 	}
 	passcnt = 0;
 	for (dlli = 0; dlli < 76; dlli++) {
-		ast_moutdwm(ast, 0x1E6E0068, 0x00001400 | (dlli << 16) | (dlli << 24));
-		ast_moutdwm(ast, 0x1E6E0074, CBR_SIZE1);
+		ast_moutdwm(ast, AST_REG_MCR68, 0x00001400 | (dlli << 16) | (dlli << 24));
+		ast_moutdwm(ast, AST_REG_MCR74, CBR_SIZE1);
 		data = cbr_scan2(ast);
 		if (data != 0) {
 			mask = 0x00010001;
@@ -330,7 +330,7 @@ static bool finetuneDQI_L(struct ast_device *ast, struct ast2300_dram_param *par
 			data |= dlli << 21;
 		}
 	}
-	ast_moutdwm(ast, 0x1E6E0080, data);
+	ast_moutdwm(ast, AST_REG_MCR80, data);
 
 	data = 0;
 	for (cnt = 8; cnt < 16; cnt++) {
@@ -354,7 +354,7 @@ static bool finetuneDQI_L(struct ast_device *ast, struct ast2300_dram_param *par
 			data |= dlli << 21;
 		}
 	}
-	ast_moutdwm(ast, 0x1E6E0084, data);
+	ast_moutdwm(ast, AST_REG_MCR84, data);
 	return status;
 } /* finetuneDQI_L */
 
@@ -367,10 +367,10 @@ static void finetuneDQSI(struct ast_device *ast)
 	char tag[2][76];
 
 	/* Disable DQI CBR */
-	reg_mcr0c  = ast_mindwm(ast, 0x1E6E000C);
-	reg_mcr18  = ast_mindwm(ast, 0x1E6E0018);
+	reg_mcr0c  = ast_mindwm(ast, AST_REG_MCR0C);
+	reg_mcr18  = ast_mindwm(ast, AST_REG_MCR18);
 	reg_mcr18 &= 0x0000ffff;
-	ast_moutdwm(ast, 0x1E6E0018, reg_mcr18);
+	ast_moutdwm(ast, AST_REG_MCR18, reg_mcr18);
 
 	for (dlli = 0; dlli < 76; dlli++) {
 		tag[0][dlli] = 0x0;
@@ -386,14 +386,14 @@ static void finetuneDQSI(struct ast_device *ast)
 		passcnt[0] = 0;
 		passcnt[1] = 0;
 		for (dqsip = 0; dqsip < 2; dqsip++) {
-			ast_moutdwm(ast, 0x1E6E000C, 0);
-			ast_moutdwm(ast, 0x1E6E0018, reg_mcr18 | (dqidly << 16) | (dqsip << 23));
-			ast_moutdwm(ast, 0x1E6E000C, reg_mcr0c);
+			ast_moutdwm(ast, AST_REG_MCR0C, 0);
+			ast_moutdwm(ast, AST_REG_MCR18, reg_mcr18 | (dqidly << 16) | (dqsip << 23));
+			ast_moutdwm(ast, AST_REG_MCR0C, reg_mcr0c);
 			for (dlli = 0; dlli < 76; dlli++) {
-				ast_moutdwm(ast, 0x1E6E0068,
+				ast_moutdwm(ast, AST_REG_MCR68,
 					    0x00001300 | (dlli << 16) | (dlli << 24));
-				ast_moutdwm(ast, 0x1E6E0070, 0);
-				ast_moutdwm(ast, 0x1E6E0074, CBR_SIZE0);
+				ast_moutdwm(ast, AST_REG_MCR70, 0);
+				ast_moutdwm(ast, AST_REG_MCR74, CBR_SIZE0);
 				if (cbr_scan3(ast)) {
 					if (dlli == 0)
 						break;
@@ -457,7 +457,7 @@ static void finetuneDQSI(struct ast_device *ast)
 		}
 	}
 	reg_mcr18 = reg_mcr18 | (g_dqidly << 16) | (g_dqsip << 23);
-	ast_moutdwm(ast, 0x1E6E0018, reg_mcr18);
+	ast_moutdwm(ast, AST_REG_MCR18, reg_mcr18);
 }
 
 static bool cbr_dll2(struct ast_device *ast, struct ast2300_dram_param *param)
@@ -476,8 +476,8 @@ static bool cbr_dll2(struct ast_device *ast, struct ast2300_dram_param *param)
 	dllmax[1] = 0x0;
 	passcnt = 0;
 	for (dlli = 0; dlli < 76; dlli++) {
-		ast_moutdwm(ast, 0x1E6E0068, 0x00001300 | (dlli << 16) | (dlli << 24));
-		ast_moutdwm(ast, 0x1E6E0074, CBR_SIZE2);
+		ast_moutdwm(ast, AST_REG_MCR68, 0x00001300 | (dlli << 16) | (dlli << 24));
+		ast_moutdwm(ast, AST_REG_MCR74, CBR_SIZE2);
 		data = cbr_scan(ast);
 		if (data != 0) {
 			if (data & 0x1) {
@@ -508,7 +508,7 @@ static bool cbr_dll2(struct ast_device *ast, struct ast2300_dram_param *param)
 	dlli  = (dllmin[1] + dllmax[1]) >> 1;
 	dlli <<= 8;
 	dlli += (dllmin[0] + dllmax[0]) >> 1;
-	ast_moutdwm(ast, 0x1E6E0068, ast_mindwm(ast, 0x1E720058) | (dlli << 16));
+	ast_moutdwm(ast, AST_REG_MCR68, ast_mindwm(ast, 0x1E720058) | (dlli << 16));
 	return status;
 } /* CBRDLL2 */
 
@@ -758,115 +758,115 @@ static void ddr3_init(struct ast_device *ast, struct ast2300_dram_param *param)
 	u32 data, data2, retry = 0;
 
 ddr3_init_start:
-	ast_moutdwm(ast, 0x1E6E0000, 0xFC600309);
-	ast_moutdwm(ast, 0x1E6E0018, 0x00000100);
-	ast_moutdwm(ast, 0x1E6E0024, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0034, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x00000100);
+	ast_moutdwm(ast, AST_REG_MCR24, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00000000);
 	udelay(10);
-	ast_moutdwm(ast, 0x1E6E0064, param->reg_MADJ);
-	ast_moutdwm(ast, 0x1E6E0068, param->reg_SADJ);
+	ast_moutdwm(ast, AST_REG_MCR64, param->reg_MADJ);
+	ast_moutdwm(ast, AST_REG_MCR68, param->reg_SADJ);
 	udelay(10);
-	ast_moutdwm(ast, 0x1E6E0064, param->reg_MADJ | 0xC0000);
+	ast_moutdwm(ast, AST_REG_MCR64, param->reg_MADJ | 0xC0000);
 	udelay(10);
 
-	ast_moutdwm(ast, 0x1E6E0004, param->dram_config);
-	ast_moutdwm(ast, 0x1E6E0008, 0x90040f);
-	ast_moutdwm(ast, 0x1E6E0010, param->reg_AC1);
-	ast_moutdwm(ast, 0x1E6E0014, param->reg_AC2);
-	ast_moutdwm(ast, 0x1E6E0020, param->reg_DQSIC);
-	ast_moutdwm(ast, 0x1E6E0080, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0084, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0088, param->reg_DQIDLY);
-	ast_moutdwm(ast, 0x1E6E0018, 0x4000A170);
-	ast_moutdwm(ast, 0x1E6E0018, 0x00002370);
-	ast_moutdwm(ast, 0x1E6E0038, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0040, 0xFF444444);
-	ast_moutdwm(ast, 0x1E6E0044, 0x22222222);
-	ast_moutdwm(ast, 0x1E6E0048, 0x22222222);
-	ast_moutdwm(ast, 0x1E6E004C, 0x00000002);
-	ast_moutdwm(ast, 0x1E6E0050, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0054, 0);
-	ast_moutdwm(ast, 0x1E6E0060, param->reg_DRV);
-	ast_moutdwm(ast, 0x1E6E006C, param->reg_IOZ);
-	ast_moutdwm(ast, 0x1E6E0070, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0074, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0078, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E007C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR04, param->dram_config);
+	ast_moutdwm(ast, AST_REG_MCR08, 0x90040f);
+	ast_moutdwm(ast, AST_REG_MCR10, param->reg_AC1);
+	ast_moutdwm(ast, AST_REG_MCR14, param->reg_AC2);
+	ast_moutdwm(ast, AST_REG_MCR20, param->reg_DQSIC);
+	ast_moutdwm(ast, AST_REG_MCR80, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR84, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR88, param->reg_DQIDLY);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x4000A170);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x00002370);
+	ast_moutdwm(ast, AST_REG_MCR38, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR40, 0xFF444444);
+	ast_moutdwm(ast, AST_REG_MCR44, 0x22222222);
+	ast_moutdwm(ast, AST_REG_MCR48, 0x22222222);
+	ast_moutdwm(ast, AST_REG_MCR4C, 0x00000002);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR54, 0);
+	ast_moutdwm(ast, AST_REG_MCR60, param->reg_DRV);
+	ast_moutdwm(ast, AST_REG_MCR6C, param->reg_IOZ);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR74, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR78, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0x00000000);
 	/* Wait MCLK2X lock to MCLK */
 	do {
-		data = ast_mindwm(ast, 0x1E6E001C);
+		data = ast_mindwm(ast, AST_REG_MCR1C);
 	} while (!(data & 0x08000000));
-	data = ast_mindwm(ast, 0x1E6E001C);
+	data = ast_mindwm(ast, AST_REG_MCR1C);
 	data = (data >> 8) & 0xff;
 	while ((data & 0x08) || ((data & 0x7) < 2) || (data < 4)) {
-		data2 = (ast_mindwm(ast, 0x1E6E0064) & 0xfff3ffff) + 4;
+		data2 = (ast_mindwm(ast, AST_REG_MCR64) & 0xfff3ffff) + 4;
 		if ((data2 & 0xff) > param->madj_max)
 			break;
-		ast_moutdwm(ast, 0x1E6E0064, data2);
+		ast_moutdwm(ast, AST_REG_MCR64, data2);
 		if (data2 & 0x00100000)
 			data2 = ((data2 & 0xff) >> 3) + 3;
 		else
 			data2 = ((data2 & 0xff) >> 2) + 5;
-		data = ast_mindwm(ast, 0x1E6E0068) & 0xffff00ff;
+		data = ast_mindwm(ast, AST_REG_MCR68) & 0xffff00ff;
 		data2 += data & 0xff;
 		data = data | (data2 << 8);
-		ast_moutdwm(ast, 0x1E6E0068, data);
+		ast_moutdwm(ast, AST_REG_MCR68, data);
 		udelay(10);
-		ast_moutdwm(ast, 0x1E6E0064, ast_mindwm(ast, 0x1E6E0064) | 0xC0000);
+		ast_moutdwm(ast, AST_REG_MCR64, ast_mindwm(ast, AST_REG_MCR64) | 0xC0000);
 		udelay(10);
-		data = ast_mindwm(ast, 0x1E6E0018) & 0xfffff1ff;
-		ast_moutdwm(ast, 0x1E6E0018, data);
+		data = ast_mindwm(ast, AST_REG_MCR18) & 0xfffff1ff;
+		ast_moutdwm(ast, AST_REG_MCR18, data);
 		data = data | 0x200;
-		ast_moutdwm(ast, 0x1E6E0018, data);
+		ast_moutdwm(ast, AST_REG_MCR18, data);
 		do {
-			data = ast_mindwm(ast, 0x1E6E001C);
+			data = ast_mindwm(ast, AST_REG_MCR1C);
 		} while (!(data & 0x08000000));
 
-		data = ast_mindwm(ast, 0x1E6E001C);
+		data = ast_mindwm(ast, AST_REG_MCR1C);
 		data = (data >> 8) & 0xff;
 	}
-	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, 0x1E6E0068) & 0xffff);
-	data = ast_mindwm(ast, 0x1E6E0018) | 0xC00;
-	ast_moutdwm(ast, 0x1E6E0018, data);
+	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR68) & 0xffff);
+	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
+	ast_moutdwm(ast, AST_REG_MCR18, data);
 
-	ast_moutdwm(ast, 0x1E6E0034, 0x00000001);
-	ast_moutdwm(ast, 0x1E6E000C, 0x00000040);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00000001);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00000040);
 	udelay(50);
 	/* Mode Register Setting */
-	ast_moutdwm(ast, 0x1E6E002C, param->reg_MRS | 0x100);
-	ast_moutdwm(ast, 0x1E6E0030, param->reg_EMRS);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000005);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000007);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000003);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000001);
-	ast_moutdwm(ast, 0x1E6E002C, param->reg_MRS);
-	ast_moutdwm(ast, 0x1E6E000C, 0x00005C08);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000001);
-
-	ast_moutdwm(ast, 0x1E6E000C, 0x00005C01);
+	ast_moutdwm(ast, AST_REG_MCR2C, param->reg_MRS | 0x100);
+	ast_moutdwm(ast, AST_REG_MCR30, param->reg_EMRS);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000005);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000007);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000003);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000001);
+	ast_moutdwm(ast, AST_REG_MCR2C, param->reg_MRS);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00005C08);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000001);
+
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00005C01);
 	data = 0;
 	if (param->wodt)
 		data = 0x300;
 	if (param->rodt)
 		data = data | 0x3000 | ((param->reg_AC2 & 0x60000) >> 3);
-	ast_moutdwm(ast, 0x1E6E0034, data | 0x3);
+	ast_moutdwm(ast, AST_REG_MCR34, data | 0x3);
 
 	/* Calibrate the DQSI delay */
 	if ((cbr_dll2(ast, param) == false) && (retry++ < 10))
 		goto ddr3_init_start;
 
-	ast_moutdwm(ast, 0x1E6E0120, param->reg_FREQ);
+	ast_moutdwm(ast, AST_REG_MCR120, param->reg_FREQ);
 	/* ECC Memory Initialization */
 #ifdef ECC
-	ast_moutdwm(ast, 0x1E6E007C, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0070, 0x221);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x221);
 	do {
-		data = ast_mindwm(ast, 0x1E6E0070);
+		data = ast_mindwm(ast, AST_REG_MCR70);
 	} while (!(data & 0x00001000));
-	ast_moutdwm(ast, 0x1E6E0070, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x00000000);
 #endif
 }
 
@@ -1121,104 +1121,104 @@ static void ddr2_init(struct ast_device *ast, struct ast2300_dram_param *param)
 	u32 data, data2, retry = 0;
 
 ddr2_init_start:
-	ast_moutdwm(ast, 0x1E6E0000, 0xFC600309);
-	ast_moutdwm(ast, 0x1E6E0018, 0x00000100);
-	ast_moutdwm(ast, 0x1E6E0024, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0064, param->reg_MADJ);
-	ast_moutdwm(ast, 0x1E6E0068, param->reg_SADJ);
+	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x00000100);
+	ast_moutdwm(ast, AST_REG_MCR24, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR64, param->reg_MADJ);
+	ast_moutdwm(ast, AST_REG_MCR68, param->reg_SADJ);
 	udelay(10);
-	ast_moutdwm(ast, 0x1E6E0064, param->reg_MADJ | 0xC0000);
+	ast_moutdwm(ast, AST_REG_MCR64, param->reg_MADJ | 0xC0000);
 	udelay(10);
 
-	ast_moutdwm(ast, 0x1E6E0004, param->dram_config);
-	ast_moutdwm(ast, 0x1E6E0008, 0x90040f);
-	ast_moutdwm(ast, 0x1E6E0010, param->reg_AC1);
-	ast_moutdwm(ast, 0x1E6E0014, param->reg_AC2);
-	ast_moutdwm(ast, 0x1E6E0020, param->reg_DQSIC);
-	ast_moutdwm(ast, 0x1E6E0080, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0084, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0088, param->reg_DQIDLY);
-	ast_moutdwm(ast, 0x1E6E0018, 0x4000A130);
-	ast_moutdwm(ast, 0x1E6E0018, 0x00002330);
-	ast_moutdwm(ast, 0x1E6E0038, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0040, 0xFF808000);
-	ast_moutdwm(ast, 0x1E6E0044, 0x88848466);
-	ast_moutdwm(ast, 0x1E6E0048, 0x44440008);
-	ast_moutdwm(ast, 0x1E6E004C, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0054, 0);
-	ast_moutdwm(ast, 0x1E6E0060, param->reg_DRV);
-	ast_moutdwm(ast, 0x1E6E006C, param->reg_IOZ);
-	ast_moutdwm(ast, 0x1E6E0070, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0074, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0078, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E007C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR04, param->dram_config);
+	ast_moutdwm(ast, AST_REG_MCR08, 0x90040f);
+	ast_moutdwm(ast, AST_REG_MCR10, param->reg_AC1);
+	ast_moutdwm(ast, AST_REG_MCR14, param->reg_AC2);
+	ast_moutdwm(ast, AST_REG_MCR20, param->reg_DQSIC);
+	ast_moutdwm(ast, AST_REG_MCR80, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR84, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR88, param->reg_DQIDLY);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x4000A130);
+	ast_moutdwm(ast, AST_REG_MCR18, 0x00002330);
+	ast_moutdwm(ast, AST_REG_MCR38, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR40, 0xFF808000);
+	ast_moutdwm(ast, AST_REG_MCR44, 0x88848466);
+	ast_moutdwm(ast, AST_REG_MCR48, 0x44440008);
+	ast_moutdwm(ast, AST_REG_MCR4C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR54, 0);
+	ast_moutdwm(ast, AST_REG_MCR60, param->reg_DRV);
+	ast_moutdwm(ast, AST_REG_MCR6C, param->reg_IOZ);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR74, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR78, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0x00000000);
 
 	/* Wait MCLK2X lock to MCLK */
 	do {
-		data = ast_mindwm(ast, 0x1E6E001C);
+		data = ast_mindwm(ast, AST_REG_MCR1C);
 	} while (!(data & 0x08000000));
-	data = ast_mindwm(ast, 0x1E6E001C);
+	data = ast_mindwm(ast, AST_REG_MCR1C);
 	data = (data >> 8) & 0xff;
 	while ((data & 0x08) || ((data & 0x7) < 2) || (data < 4)) {
-		data2 = (ast_mindwm(ast, 0x1E6E0064) & 0xfff3ffff) + 4;
+		data2 = (ast_mindwm(ast, AST_REG_MCR64) & 0xfff3ffff) + 4;
 		if ((data2 & 0xff) > param->madj_max)
 			break;
-		ast_moutdwm(ast, 0x1E6E0064, data2);
+		ast_moutdwm(ast, AST_REG_MCR64, data2);
 		if (data2 & 0x00100000)
 			data2 = ((data2 & 0xff) >> 3) + 3;
 		else
 			data2 = ((data2 & 0xff) >> 2) + 5;
-		data = ast_mindwm(ast, 0x1E6E0068) & 0xffff00ff;
+		data = ast_mindwm(ast, AST_REG_MCR68) & 0xffff00ff;
 		data2 += data & 0xff;
 		data = data | (data2 << 8);
-		ast_moutdwm(ast, 0x1E6E0068, data);
+		ast_moutdwm(ast, AST_REG_MCR68, data);
 		udelay(10);
-		ast_moutdwm(ast, 0x1E6E0064, ast_mindwm(ast, 0x1E6E0064) | 0xC0000);
+		ast_moutdwm(ast, AST_REG_MCR64, ast_mindwm(ast, AST_REG_MCR64) | 0xC0000);
 		udelay(10);
-		data = ast_mindwm(ast, 0x1E6E0018) & 0xfffff1ff;
-		ast_moutdwm(ast, 0x1E6E0018, data);
+		data = ast_mindwm(ast, AST_REG_MCR18) & 0xfffff1ff;
+		ast_moutdwm(ast, AST_REG_MCR18, data);
 		data = data | 0x200;
-		ast_moutdwm(ast, 0x1E6E0018, data);
+		ast_moutdwm(ast, AST_REG_MCR18, data);
 		do {
-			data = ast_mindwm(ast, 0x1E6E001C);
+			data = ast_mindwm(ast, AST_REG_MCR1C);
 		} while (!(data & 0x08000000));
 
-		data = ast_mindwm(ast, 0x1E6E001C);
+		data = ast_mindwm(ast, AST_REG_MCR1C);
 		data = (data >> 8) & 0xff;
 	}
-	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, 0x1E6E0008) & 0xffff);
-	data = ast_mindwm(ast, 0x1E6E0018) | 0xC00;
-	ast_moutdwm(ast, 0x1E6E0018, data);
+	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR08) & 0xffff);
+	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
+	ast_moutdwm(ast, AST_REG_MCR18, data);
 
-	ast_moutdwm(ast, 0x1E6E0034, 0x00000001);
-	ast_moutdwm(ast, 0x1E6E000C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00000001);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00000000);
 	udelay(50);
 	/* Mode Register Setting */
-	ast_moutdwm(ast, 0x1E6E002C, param->reg_MRS | 0x100);
-	ast_moutdwm(ast, 0x1E6E0030, param->reg_EMRS);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000005);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000007);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000003);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000001);
-
-	ast_moutdwm(ast, 0x1E6E000C, 0x00005C08);
-	ast_moutdwm(ast, 0x1E6E002C, param->reg_MRS);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000001);
-	ast_moutdwm(ast, 0x1E6E0030, param->reg_EMRS | 0x380);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000003);
-	ast_moutdwm(ast, 0x1E6E0030, param->reg_EMRS);
-	ast_moutdwm(ast, 0x1E6E0028, 0x00000003);
-
-	ast_moutdwm(ast, 0x1E6E000C, 0x7FFF5C01);
+	ast_moutdwm(ast, AST_REG_MCR2C, param->reg_MRS | 0x100);
+	ast_moutdwm(ast, AST_REG_MCR30, param->reg_EMRS);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000005);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000007);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000003);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000001);
+
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00005C08);
+	ast_moutdwm(ast, AST_REG_MCR2C, param->reg_MRS);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000001);
+	ast_moutdwm(ast, AST_REG_MCR30, param->reg_EMRS | 0x380);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000003);
+	ast_moutdwm(ast, AST_REG_MCR30, param->reg_EMRS);
+	ast_moutdwm(ast, AST_REG_MCR28, 0x00000003);
+
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x7FFF5C01);
 	data = 0;
 	if (param->wodt)
 		data = 0x500;
 	if (param->rodt)
 		data = data | 0x3000 | ((param->reg_AC2 & 0x60000) >> 3);
-	ast_moutdwm(ast, 0x1E6E0034, data | 0x3);
-	ast_moutdwm(ast, 0x1E6E0120, param->reg_FREQ);
+	ast_moutdwm(ast, AST_REG_MCR34, data | 0x3);
+	ast_moutdwm(ast, AST_REG_MCR120, param->reg_FREQ);
 
 	/* Calibrate the DQSI delay */
 	if ((cbr_dll2(ast, param) == false) && (retry++ < 10))
@@ -1226,14 +1226,14 @@ static void ddr2_init(struct ast_device *ast, struct ast2300_dram_param *param)
 
 	/* ECC Memory Initialization */
 #ifdef ECC
-	ast_moutdwm(ast, 0x1E6E007C, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0070, 0x221);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x221);
 	do {
-		data = ast_mindwm(ast, 0x1E6E0070);
+		data = ast_mindwm(ast, AST_REG_MCR70);
 	} while (!(data & 0x00001000));
-	ast_moutdwm(ast, 0x1E6E0070, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E0050, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x00000000);
 #endif
 }
 
@@ -1245,7 +1245,7 @@ static void ast_post_chip_2300(struct ast_device *ast)
 
 	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 	if ((reg & 0x80) == 0) {/* vga only */
-		ast_write32(ast, 0xf004, 0x1e6e0000);
+		ast_write32(ast, 0xf004, AST_REG_MCR00);
 		ast_write32(ast, 0xf000, 0x1);
 		ast_write32(ast, 0x12000, 0x1688a8a8);
 		do {
diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index f751a27e7eb3..4a9df920509f 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -148,8 +148,8 @@ static bool mmc_test_single_2500(struct ast_device *ast, u32 datagen)
 
 static bool cbr_test_2500(struct ast_device *ast)
 {
-	ast_moutdwm(ast, 0x1E6E0074, 0x0000FFFF);
-	ast_moutdwm(ast, 0x1E6E007C, 0xFF00FF00);
+	ast_moutdwm(ast, AST_REG_MCR74, 0x0000FFFF);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0xFF00FF00);
 	if (!mmc_test_burst(ast, 0))
 		return false;
 	if (!mmc_test_single_2500(ast, 0))
@@ -159,8 +159,8 @@ static bool cbr_test_2500(struct ast_device *ast)
 
 static bool ddr_test_2500(struct ast_device *ast)
 {
-	ast_moutdwm(ast, 0x1E6E0074, 0x0000FFFF);
-	ast_moutdwm(ast, 0x1E6E007C, 0xFF00FF00);
+	ast_moutdwm(ast, AST_REG_MCR74, 0x0000FFFF);
+	ast_moutdwm(ast, AST_REG_MCR7C, 0xFF00FF00);
 	if (!mmc_test_burst(ast, 0))
 		return false;
 	if (!mmc_test_burst(ast, 1))
@@ -176,25 +176,25 @@ static bool ddr_test_2500(struct ast_device *ast)
 
 static void ddr_init_common_2500(struct ast_device *ast)
 {
-	ast_moutdwm(ast, 0x1E6E0034, 0x00020080);
-	ast_moutdwm(ast, 0x1E6E0008, 0x2003000F);
-	ast_moutdwm(ast, 0x1E6E0038, 0x00000FFF);
-	ast_moutdwm(ast, 0x1E6E0040, 0x88448844);
-	ast_moutdwm(ast, 0x1E6E0044, 0x24422288);
-	ast_moutdwm(ast, 0x1E6E0048, 0x22222222);
-	ast_moutdwm(ast, 0x1E6E004C, 0x22222222);
-	ast_moutdwm(ast, 0x1E6E0050, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E0208, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0218, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0220, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0228, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0230, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E02A8, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E02B0, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0240, 0x86000000);
-	ast_moutdwm(ast, 0x1E6E0244, 0x00008600);
-	ast_moutdwm(ast, 0x1E6E0248, 0x80000000);
-	ast_moutdwm(ast, 0x1E6E024C, 0x80808080);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00020080);
+	ast_moutdwm(ast, AST_REG_MCR08, 0x2003000F);
+	ast_moutdwm(ast, AST_REG_MCR38, 0x00000FFF);
+	ast_moutdwm(ast, AST_REG_MCR40, 0x88448844);
+	ast_moutdwm(ast, AST_REG_MCR44, 0x24422288);
+	ast_moutdwm(ast, AST_REG_MCR48, 0x22222222);
+	ast_moutdwm(ast, AST_REG_MCR4C, 0x22222222);
+	ast_moutdwm(ast, AST_REG_MCR50, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR208, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR218, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR220, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR228, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR230, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR2A8, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR2B0, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR240, 0x86000000);
+	ast_moutdwm(ast, AST_REG_MCR244, 0x00008600);
+	ast_moutdwm(ast, AST_REG_MCR248, 0x80000000);
+	ast_moutdwm(ast, AST_REG_MCR24C, 0x80808080);
 }
 
 static void ddr_phy_init_2500(struct ast_device *ast)
@@ -202,26 +202,26 @@ static void ddr_phy_init_2500(struct ast_device *ast)
 	u32 data, pass, timecnt;
 
 	pass = 0;
-	ast_moutdwm(ast, 0x1E6E0060, 0x00000005);
+	ast_moutdwm(ast, AST_REG_MCR60, 0x00000005);
 	while (!pass) {
 		for (timecnt = 0; timecnt < TIMEOUT; timecnt++) {
-			data = ast_mindwm(ast, 0x1E6E0060) & 0x1;
+			data = ast_mindwm(ast, AST_REG_MCR60) & 0x1;
 			if (!data)
 				break;
 		}
 		if (timecnt != TIMEOUT) {
-			data = ast_mindwm(ast, 0x1E6E0300) & 0x000A0000;
+			data = ast_mindwm(ast, AST_REG_MCR300) & 0x000A0000;
 			if (!data)
 				pass = 1;
 		}
 		if (!pass) {
-			ast_moutdwm(ast, 0x1E6E0060, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR60, 0x00000000);
 			udelay(10); /* delay 10 us */
-			ast_moutdwm(ast, 0x1E6E0060, 0x00000005);
+			ast_moutdwm(ast, AST_REG_MCR60, 0x00000005);
 		}
 	}
 
-	ast_moutdwm(ast, 0x1E6E0060, 0x00000006);
+	ast_moutdwm(ast, AST_REG_MCR60, 0x00000006);
 }
 
 /*
@@ -235,8 +235,8 @@ static void check_dram_size_2500(struct ast_device *ast, u32 tRFC)
 {
 	u32 reg_04, reg_14;
 
-	reg_04 = ast_mindwm(ast, 0x1E6E0004) & 0xfffffffc;
-	reg_14 = ast_mindwm(ast, 0x1E6E0014) & 0xffffff00;
+	reg_04 = ast_mindwm(ast, AST_REG_MCR04) & 0xfffffffc;
+	reg_14 = ast_mindwm(ast, AST_REG_MCR14) & 0xffffff00;
 
 	ast_moutdwm(ast, 0xA0100000, 0x41424344);
 	ast_moutdwm(ast, 0x90100000, 0x35363738);
@@ -258,21 +258,21 @@ static void check_dram_size_2500(struct ast_device *ast, u32 tRFC)
 	} else {
 		reg_14 |= tRFC & 0xFF;
 	}
-	ast_moutdwm(ast, 0x1E6E0004, reg_04);
-	ast_moutdwm(ast, 0x1E6E0014, reg_14);
+	ast_moutdwm(ast, AST_REG_MCR04, reg_04);
+	ast_moutdwm(ast, AST_REG_MCR14, reg_14);
 }
 
 static void enable_cache_2500(struct ast_device *ast)
 {
 	u32 reg_04, data;
 
-	reg_04 = ast_mindwm(ast, 0x1E6E0004);
-	ast_moutdwm(ast, 0x1E6E0004, reg_04 | 0x1000);
+	reg_04 = ast_mindwm(ast, AST_REG_MCR04);
+	ast_moutdwm(ast, AST_REG_MCR04, reg_04 | 0x1000);
 
 	do
-		data = ast_mindwm(ast, 0x1E6E0004);
+		data = ast_mindwm(ast, AST_REG_MCR04);
 	while (!(data & 0x80000));
-	ast_moutdwm(ast, 0x1E6E0004, reg_04 | 0x400);
+	ast_moutdwm(ast, AST_REG_MCR04, reg_04 | 0x400);
 }
 
 static void set_mpll_2500(struct ast_device *ast)
@@ -280,13 +280,13 @@ static void set_mpll_2500(struct ast_device *ast)
 	u32 addr, data, param;
 
 	/* Reset MMC */
-	ast_moutdwm(ast, 0x1E6E0000, 0xFC600309);
-	ast_moutdwm(ast, 0x1E6E0034, 0x00020080);
+	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00020080);
 	for (addr = 0x1e6e0004; addr < 0x1e6e0090;) {
 		ast_moutdwm(ast, addr, 0x0);
 		addr += 4;
 	}
-	ast_moutdwm(ast, 0x1E6E0034, 0x00020000);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00020000);
 
 	ast_moutdwm(ast, 0x1E6E2000, 0x1688A8A8);
 	data = ast_mindwm(ast, 0x1E6E2070) & 0x00800000;
@@ -310,50 +310,50 @@ static void reset_mmc_2500(struct ast_device *ast)
 	ast_moutdwm(ast, 0x1E78504C, 0x00000013);
 	mdelay(100);
 	ast_moutdwm(ast, 0x1E785054, 0x00000077);
-	ast_moutdwm(ast, 0x1E6E0000, 0xFC600309);
+	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
 }
 
 static void ddr3_init_2500(struct ast_device *ast, const u32 *ddr_table)
 {
-	ast_moutdwm(ast, 0x1E6E0004, 0x00000303);
-	ast_moutdwm(ast, 0x1E6E0010, ddr_table[REGIDX_010]);
-	ast_moutdwm(ast, 0x1E6E0014, ddr_table[REGIDX_014]);
-	ast_moutdwm(ast, 0x1E6E0018, ddr_table[REGIDX_018]);
-	ast_moutdwm(ast, 0x1E6E0020, ddr_table[REGIDX_020]);	     /* MODEREG4/6 */
-	ast_moutdwm(ast, 0x1E6E0024, ddr_table[REGIDX_024]);	     /* MODEREG5 */
-	ast_moutdwm(ast, 0x1E6E002C, ddr_table[REGIDX_02C] | 0x100); /* MODEREG0/2 */
-	ast_moutdwm(ast, 0x1E6E0030, ddr_table[REGIDX_030]);	     /* MODEREG1/3 */
+	ast_moutdwm(ast, AST_REG_MCR04, 0x00000303);
+	ast_moutdwm(ast, AST_REG_MCR10, ddr_table[REGIDX_010]);
+	ast_moutdwm(ast, AST_REG_MCR14, ddr_table[REGIDX_014]);
+	ast_moutdwm(ast, AST_REG_MCR18, ddr_table[REGIDX_018]);
+	ast_moutdwm(ast, AST_REG_MCR20, ddr_table[REGIDX_020]);	     /* MODEREG4/6 */
+	ast_moutdwm(ast, AST_REG_MCR24, ddr_table[REGIDX_024]);	     /* MODEREG5 */
+	ast_moutdwm(ast, AST_REG_MCR2C, ddr_table[REGIDX_02C] | 0x100); /* MODEREG0/2 */
+	ast_moutdwm(ast, AST_REG_MCR30, ddr_table[REGIDX_030]);	     /* MODEREG1/3 */
 
 	/* DDR PHY Setting */
-	ast_moutdwm(ast, 0x1E6E0200, 0x02492AAE);
-	ast_moutdwm(ast, 0x1E6E0204, 0x00001001);
-	ast_moutdwm(ast, 0x1E6E020C, 0x55E00B0B);
-	ast_moutdwm(ast, 0x1E6E0210, 0x20000000);
-	ast_moutdwm(ast, 0x1E6E0214, ddr_table[REGIDX_214]);
-	ast_moutdwm(ast, 0x1E6E02E0, ddr_table[REGIDX_2E0]);
-	ast_moutdwm(ast, 0x1E6E02E4, ddr_table[REGIDX_2E4]);
-	ast_moutdwm(ast, 0x1E6E02E8, ddr_table[REGIDX_2E8]);
-	ast_moutdwm(ast, 0x1E6E02EC, ddr_table[REGIDX_2EC]);
-	ast_moutdwm(ast, 0x1E6E02F0, ddr_table[REGIDX_2F0]);
-	ast_moutdwm(ast, 0x1E6E02F4, ddr_table[REGIDX_2F4]);
-	ast_moutdwm(ast, 0x1E6E02F8, ddr_table[REGIDX_2F8]);
-	ast_moutdwm(ast, 0x1E6E0290, 0x00100008);
-	ast_moutdwm(ast, 0x1E6E02C0, 0x00000006);
+	ast_moutdwm(ast, AST_REG_MCR200, 0x02492AAE);
+	ast_moutdwm(ast, AST_REG_MCR204, 0x00001001);
+	ast_moutdwm(ast, AST_REG_MCR20C, 0x55E00B0B);
+	ast_moutdwm(ast, AST_REG_MCR210, 0x20000000);
+	ast_moutdwm(ast, AST_REG_MCR214, ddr_table[REGIDX_214]);
+	ast_moutdwm(ast, AST_REG_MCR2E0, ddr_table[REGIDX_2E0]);
+	ast_moutdwm(ast, AST_REG_MCR2E4, ddr_table[REGIDX_2E4]);
+	ast_moutdwm(ast, AST_REG_MCR2E8, ddr_table[REGIDX_2E8]);
+	ast_moutdwm(ast, AST_REG_MCR2EC, ddr_table[REGIDX_2EC]);
+	ast_moutdwm(ast, AST_REG_MCR2F0, ddr_table[REGIDX_2F0]);
+	ast_moutdwm(ast, AST_REG_MCR2F4, ddr_table[REGIDX_2F4]);
+	ast_moutdwm(ast, AST_REG_MCR2F8, ddr_table[REGIDX_2F8]);
+	ast_moutdwm(ast, AST_REG_MCR290, 0x00100008);
+	ast_moutdwm(ast, AST_REG_MCR2C0, 0x00000006);
 
 	/* Controller Setting */
-	ast_moutdwm(ast, 0x1E6E0034, 0x00020091);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x00020091);
 
 	/* Wait DDR PHY init done */
 	ddr_phy_init_2500(ast);
 
-	ast_moutdwm(ast, 0x1E6E0120, ddr_table[REGIDX_PLL]);
-	ast_moutdwm(ast, 0x1E6E000C, 0x42AA5C81);
-	ast_moutdwm(ast, 0x1E6E0034, 0x0001AF93);
+	ast_moutdwm(ast, AST_REG_MCR120, ddr_table[REGIDX_PLL]);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x42AA5C81);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x0001AF93);
 
 	check_dram_size_2500(ast, ddr_table[REGIDX_RFC]);
 	enable_cache_2500(ast);
-	ast_moutdwm(ast, 0x1E6E001C, 0x00000008);
-	ast_moutdwm(ast, 0x1E6E0038, 0xFFFFFF00);
+	ast_moutdwm(ast, AST_REG_MCR1C, 0x00000008);
+	ast_moutdwm(ast, AST_REG_MCR38, 0xFFFFFF00);
 }
 
 static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
@@ -363,34 +363,34 @@ static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
 	u32 min_ddr_vref = 0, min_phy_vref = 0;
 	u32 max_ddr_vref = 0, max_phy_vref = 0;
 
-	ast_moutdwm(ast, 0x1E6E0004, 0x00000313);
-	ast_moutdwm(ast, 0x1E6E0010, ddr_table[REGIDX_010]);
-	ast_moutdwm(ast, 0x1E6E0014, ddr_table[REGIDX_014]);
-	ast_moutdwm(ast, 0x1E6E0018, ddr_table[REGIDX_018]);
-	ast_moutdwm(ast, 0x1E6E0020, ddr_table[REGIDX_020]);	     /* MODEREG4/6 */
-	ast_moutdwm(ast, 0x1E6E0024, ddr_table[REGIDX_024]);	     /* MODEREG5 */
-	ast_moutdwm(ast, 0x1E6E002C, ddr_table[REGIDX_02C] | 0x100); /* MODEREG0/2 */
-	ast_moutdwm(ast, 0x1E6E0030, ddr_table[REGIDX_030]);	     /* MODEREG1/3 */
+	ast_moutdwm(ast, AST_REG_MCR04, 0x00000313);
+	ast_moutdwm(ast, AST_REG_MCR10, ddr_table[REGIDX_010]);
+	ast_moutdwm(ast, AST_REG_MCR14, ddr_table[REGIDX_014]);
+	ast_moutdwm(ast, AST_REG_MCR18, ddr_table[REGIDX_018]);
+	ast_moutdwm(ast, AST_REG_MCR20, ddr_table[REGIDX_020]);	     /* MODEREG4/6 */
+	ast_moutdwm(ast, AST_REG_MCR24, ddr_table[REGIDX_024]);	     /* MODEREG5 */
+	ast_moutdwm(ast, AST_REG_MCR2C, ddr_table[REGIDX_02C] | 0x100); /* MODEREG0/2 */
+	ast_moutdwm(ast, AST_REG_MCR30, ddr_table[REGIDX_030]);	     /* MODEREG1/3 */
 
 	/* DDR PHY Setting */
-	ast_moutdwm(ast, 0x1E6E0200, 0x42492AAE);
-	ast_moutdwm(ast, 0x1E6E0204, 0x09002000);
-	ast_moutdwm(ast, 0x1E6E020C, 0x55E00B0B);
-	ast_moutdwm(ast, 0x1E6E0210, 0x20000000);
-	ast_moutdwm(ast, 0x1E6E0214, ddr_table[REGIDX_214]);
-	ast_moutdwm(ast, 0x1E6E02E0, ddr_table[REGIDX_2E0]);
-	ast_moutdwm(ast, 0x1E6E02E4, ddr_table[REGIDX_2E4]);
-	ast_moutdwm(ast, 0x1E6E02E8, ddr_table[REGIDX_2E8]);
-	ast_moutdwm(ast, 0x1E6E02EC, ddr_table[REGIDX_2EC]);
-	ast_moutdwm(ast, 0x1E6E02F0, ddr_table[REGIDX_2F0]);
-	ast_moutdwm(ast, 0x1E6E02F4, ddr_table[REGIDX_2F4]);
-	ast_moutdwm(ast, 0x1E6E02F8, ddr_table[REGIDX_2F8]);
-	ast_moutdwm(ast, 0x1E6E0290, 0x00100008);
-	ast_moutdwm(ast, 0x1E6E02C4, 0x3C183C3C);
-	ast_moutdwm(ast, 0x1E6E02C8, 0x00631E0E);
+	ast_moutdwm(ast, AST_REG_MCR200, 0x42492AAE);
+	ast_moutdwm(ast, AST_REG_MCR204, 0x09002000);
+	ast_moutdwm(ast, AST_REG_MCR20C, 0x55E00B0B);
+	ast_moutdwm(ast, AST_REG_MCR210, 0x20000000);
+	ast_moutdwm(ast, AST_REG_MCR214, ddr_table[REGIDX_214]);
+	ast_moutdwm(ast, AST_REG_MCR2E0, ddr_table[REGIDX_2E0]);
+	ast_moutdwm(ast, AST_REG_MCR2E4, ddr_table[REGIDX_2E4]);
+	ast_moutdwm(ast, AST_REG_MCR2E8, ddr_table[REGIDX_2E8]);
+	ast_moutdwm(ast, AST_REG_MCR2EC, ddr_table[REGIDX_2EC]);
+	ast_moutdwm(ast, AST_REG_MCR2F0, ddr_table[REGIDX_2F0]);
+	ast_moutdwm(ast, AST_REG_MCR2F4, ddr_table[REGIDX_2F4]);
+	ast_moutdwm(ast, AST_REG_MCR2F8, ddr_table[REGIDX_2F8]);
+	ast_moutdwm(ast, AST_REG_MCR290, 0x00100008);
+	ast_moutdwm(ast, AST_REG_MCR2C4, 0x3C183C3C);
+	ast_moutdwm(ast, AST_REG_MCR2C8, 0x00631E0E);
 
 	/* Controller Setting */
-	ast_moutdwm(ast, 0x1E6E0034, 0x0001A991);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x0001A991);
 
 	/* Train PHY Vref first */
 	pass = 0;
@@ -398,17 +398,17 @@ static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
 	for (retrycnt = 0; retrycnt < 4 && pass == 0; retrycnt++) {
 		max_phy_vref = 0x0;
 		pass = 0;
-		ast_moutdwm(ast, 0x1E6E02C0, 0x00001C06);
+		ast_moutdwm(ast, AST_REG_MCR2C0, 0x00001C06);
 		for (phy_vref = 0x40; phy_vref < 0x80; phy_vref++) {
-			ast_moutdwm(ast, 0x1E6E000C, 0x00000000);
-			ast_moutdwm(ast, 0x1E6E0060, 0x00000000);
-			ast_moutdwm(ast, 0x1E6E02CC, phy_vref | (phy_vref << 8));
+			ast_moutdwm(ast, AST_REG_MCR0C, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR60, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR2CC, phy_vref | (phy_vref << 8));
 			/* Fire DFI Init */
 			ddr_phy_init_2500(ast);
-			ast_moutdwm(ast, 0x1E6E000C, 0x00005C01);
+			ast_moutdwm(ast, AST_REG_MCR0C, 0x00005C01);
 			if (cbr_test_2500(ast)) {
 				pass++;
-				data = ast_mindwm(ast, 0x1E6E03D0);
+				data = ast_mindwm(ast, AST_REG_MCR3D0);
 				data2 = data >> 8;
 				data  = data & 0xff;
 				if (data > data2)
@@ -422,7 +422,7 @@ static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
 			}
 		}
 	}
-	ast_moutdwm(ast, 0x1E6E02CC, min_phy_vref | (min_phy_vref << 8));
+	ast_moutdwm(ast, AST_REG_MCR2CC, min_phy_vref | (min_phy_vref << 8));
 
 	/* Train DDR Vref next */
 	pass = 0;
@@ -432,12 +432,12 @@ static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
 		max_ddr_vref = 0x0;
 		pass = 0;
 		for (ddr_vref = 0x00; ddr_vref < 0x40; ddr_vref++) {
-			ast_moutdwm(ast, 0x1E6E000C, 0x00000000);
-			ast_moutdwm(ast, 0x1E6E0060, 0x00000000);
-			ast_moutdwm(ast, 0x1E6E02C0, 0x00000006 | (ddr_vref << 8));
+			ast_moutdwm(ast, AST_REG_MCR0C, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR60, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR2C0, 0x00000006 | (ddr_vref << 8));
 			/* Fire DFI Init */
 			ddr_phy_init_2500(ast);
-			ast_moutdwm(ast, 0x1E6E000C, 0x00005C01);
+			ast_moutdwm(ast, AST_REG_MCR0C, 0x00005C01);
 			if (cbr_test_2500(ast)) {
 				pass++;
 				if (min_ddr_vref > ddr_vref)
@@ -450,22 +450,22 @@ static void ddr4_init_2500(struct ast_device *ast, const u32 *ddr_table)
 		}
 	}
 
-	ast_moutdwm(ast, 0x1E6E000C, 0x00000000);
-	ast_moutdwm(ast, 0x1E6E0060, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR60, 0x00000000);
 	ddr_vref = (min_ddr_vref + max_ddr_vref + 1) >> 1;
-	ast_moutdwm(ast, 0x1E6E02C0, 0x00000006 | (ddr_vref << 8));
+	ast_moutdwm(ast, AST_REG_MCR2C0, 0x00000006 | (ddr_vref << 8));
 
 	/* Wait DDR PHY init done */
 	ddr_phy_init_2500(ast);
 
-	ast_moutdwm(ast, 0x1E6E0120, ddr_table[REGIDX_PLL]);
-	ast_moutdwm(ast, 0x1E6E000C, 0x42AA5C81);
-	ast_moutdwm(ast, 0x1E6E0034, 0x0001AF93);
+	ast_moutdwm(ast, AST_REG_MCR120, ddr_table[REGIDX_PLL]);
+	ast_moutdwm(ast, AST_REG_MCR0C, 0x42AA5C81);
+	ast_moutdwm(ast, AST_REG_MCR34, 0x0001AF93);
 
 	check_dram_size_2500(ast, ddr_table[REGIDX_RFC]);
 	enable_cache_2500(ast);
-	ast_moutdwm(ast, 0x1E6E001C, 0x00000008);
-	ast_moutdwm(ast, 0x1E6E0038, 0xFFFFFF00);
+	ast_moutdwm(ast, AST_REG_MCR1C, 0x00000008);
+	ast_moutdwm(ast, AST_REG_MCR38, 0xFFFFFF00);
 }
 
 static bool ast_dram_init_2500(struct ast_device *ast)
diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 677c52c0d99a..8c2243cf8187 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -230,7 +230,7 @@ static bool ast_launch_m68k(struct ast_device *ast)
 		}
 		/* Get BootAddress */
 		ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);
-		data = ast_mindwm(ast, 0x1e6e0004);
+		data = ast_mindwm(ast, AST_REG_MCR04);
 		switch (data & 0x03) {
 		case 0:
 			boot_address = 0x44000000;
@@ -348,7 +348,7 @@ static bool ast_init_dvo(struct ast_device *ast)
 {
 	u8 jreg;
 	u32 data;
-	ast_write32(ast, 0xf004, 0x1e6e0000);
+	ast_write32(ast, 0xf004, AST_REG_MCR00);
 	ast_write32(ast, 0xf000, 0x1);
 	ast_write32(ast, 0x12000, 0x1688a8a8);
 
@@ -425,7 +425,7 @@ static void ast_init_analog(struct ast_device *ast)
 	 * bridge. First configure the P2U to target the SCU
 	 * in case it isn't at this stage.
 	 */
-	ast_write32(ast, 0xf004, 0x1e6e0000);
+	ast_write32(ast, 0xf004, AST_REG_MCR00);
 	ast_write32(ast, 0xf000, 0x1);
 
 	/* Then unlock the SCU with the magic password */
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 05ec3542ab62..3da0cce0a3f6 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -268,7 +268,7 @@ static int ast_detect_chip(struct pci_dev *pdev,
 				config_mode = ast_use_p2a;
 
 				/* Read SCU7c (silicon revision register) */
-				__ast_write32(regs, 0xf004, 0x1e6e0000);
+				__ast_write32(regs, 0xf004, AST_REG_MCR00);
 				__ast_write32(regs, 0xf000, 0x1);
 				scu_rev = __ast_read32(regs, 0x1207c);
 			}
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 5cec5d735b6a..297230f1efaf 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -69,19 +69,19 @@ bool mmc_test(struct ast_device *ast, u32 datagen, u8 test_ctl)
 {
 	u32 data, timeout;
 
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, (datagen << 3) | test_ctl);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
+	ast_moutdwm(ast, AST_REG_MCR70, (datagen << 3) | test_ctl);
 	timeout = 0;
 	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x3000;
+		data = ast_mindwm(ast, AST_REG_MCR70) & 0x3000;
 		if (data & 0x2000)
 			return false;
 		if (++timeout > TIMEOUT) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
+			ast_moutdwm(ast, AST_REG_MCR70, 0x00000000);
 			return false;
 		}
 	} while (!data);
-	ast_moutdwm(ast, 0x1e6e0070, 0x0);
+	ast_moutdwm(ast, AST_REG_MCR70, 0x0);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 0bc033dbac55..a54733dc2675 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -98,4 +98,75 @@
 #define AST_REG_AHBC84				AST_REG_AHBC(0x84)
 #define AST_REG_AHBC88				AST_REG_AHBC(0x88)
 
+/*
+ * SDRAM Memory Controller (0x1e6e0000 - 0x1e6e0fff)
+ */
+
+#define AST_REG_MCR_BASE			(0x1e6e0000)
+#define AST_REG_MCR(__offset)			(AST_REG_MCR_BASE + (__offset))
+#define AST_REG_MCR00				AST_REG_MCR(0x00)
+#define AST_REG_MCR00_PROTECTION_KEY		(0xfc600309)
+#define AST_REG_MCR04				AST_REG_MCR(0x04)
+#define AST_REG_MCR08				AST_REG_MCR(0x08)
+#define AST_REG_MCR0C				AST_REG_MCR(0x0c)
+#define AST_REG_MCR10				AST_REG_MCR(0x10)
+#define AST_REG_MCR14				AST_REG_MCR(0x14)
+#define AST_REG_MCR18				AST_REG_MCR(0x18)
+#define AST_REG_MCR1C				AST_REG_MCR(0x1c)
+#define AST_REG_MCR20				AST_REG_MCR(0x20)
+#define AST_REG_MCR24				AST_REG_MCR(0x24)
+#define AST_REG_MCR28				AST_REG_MCR(0x28)
+#define AST_REG_MCR2C				AST_REG_MCR(0x2C)
+#define AST_REG_MCR30				AST_REG_MCR(0x30)
+#define AST_REG_MCR34				AST_REG_MCR(0x34)
+#define AST_REG_MCR38				AST_REG_MCR(0x38)
+#define AST_REG_MCR40				AST_REG_MCR(0x40)
+#define AST_REG_MCR44				AST_REG_MCR(0x44)
+#define AST_REG_MCR48				AST_REG_MCR(0x48)
+#define AST_REG_MCR4C				AST_REG_MCR(0x4C)
+#define AST_REG_MCR50				AST_REG_MCR(0x50)
+#define AST_REG_MCR54				AST_REG_MCR(0x54)
+#define AST_REG_MCR60				AST_REG_MCR(0x60)
+#define AST_REG_MCR64				AST_REG_MCR(0x64)
+#define AST_REG_MCR68				AST_REG_MCR(0x68)
+#define AST_REG_MCR6C				AST_REG_MCR(0x6c)
+#define AST_REG_MCR70				AST_REG_MCR(0x70)
+#define AST_REG_MCR74				AST_REG_MCR(0x74)
+#define AST_REG_MCR78				AST_REG_MCR(0x78)
+#define AST_REG_MCR7C				AST_REG_MCR(0x7c)
+#define AST_REG_MCR80				AST_REG_MCR(0x80)
+#define AST_REG_MCR84				AST_REG_MCR(0x84)
+#define AST_REG_MCR88				AST_REG_MCR(0x88)
+#define AST_REG_MCR120				AST_REG_MCR(0x120)
+#define AST_REG_MCR200				AST_REG_MCR(0x200)
+#define AST_REG_MCR204				AST_REG_MCR(0x204)
+#define AST_REG_MCR208				AST_REG_MCR(0x208)
+#define AST_REG_MCR20C				AST_REG_MCR(0x20C)
+#define AST_REG_MCR210				AST_REG_MCR(0x210)
+#define AST_REG_MCR214				AST_REG_MCR(0x214)
+#define AST_REG_MCR218				AST_REG_MCR(0x218)
+#define AST_REG_MCR220				AST_REG_MCR(0x220)
+#define AST_REG_MCR228				AST_REG_MCR(0x228)
+#define AST_REG_MCR230				AST_REG_MCR(0x230)
+#define AST_REG_MCR2A8				AST_REG_MCR(0x2a8)
+#define AST_REG_MCR2B0				AST_REG_MCR(0x2b0)
+#define AST_REG_MCR240				AST_REG_MCR(0x240)
+#define AST_REG_MCR244				AST_REG_MCR(0x244)
+#define AST_REG_MCR248				AST_REG_MCR(0x248)
+#define AST_REG_MCR24C				AST_REG_MCR(0x24c)
+#define AST_REG_MCR290				AST_REG_MCR(0x290)
+#define AST_REG_MCR2C0				AST_REG_MCR(0x2c0)
+#define AST_REG_MCR2C4				AST_REG_MCR(0x2c4)
+#define AST_REG_MCR2C8				AST_REG_MCR(0x2c8)
+#define AST_REG_MCR2CC				AST_REG_MCR(0x2cc)
+#define AST_REG_MCR2E0				AST_REG_MCR(0x2e0)
+#define AST_REG_MCR2E4				AST_REG_MCR(0x2e4)
+#define AST_REG_MCR2E8				AST_REG_MCR(0x2e8)
+#define AST_REG_MCR2EC				AST_REG_MCR(0x2ec)
+#define AST_REG_MCR2F0				AST_REG_MCR(0x2f0)
+#define AST_REG_MCR2F4				AST_REG_MCR(0x2f4)
+#define AST_REG_MCR2F8				AST_REG_MCR(0x2f8)
+#define AST_REG_MCR300				AST_REG_MCR(0x300)
+#define AST_REG_MCR3D0				AST_REG_MCR(0x3d0)
+
 #endif
-- 
2.53.0

