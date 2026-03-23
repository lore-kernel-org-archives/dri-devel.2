Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A621F483C4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE82210E598;
	Mon, 23 Mar 2026 16:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NdVAHmcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LPxK+P9K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NdVAHmcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LPxK+P9K";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45A510E596
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C41914D373;
 Mon, 23 Mar 2026 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61M6P0ITZsKdtAieD7SuS7Z4SCYLoVFSYNus27d1IfQ=;
 b=NdVAHmcSs/M/k+ZbxdXyPJlZtAqPED3fJEET8cRRQHdFi0iY/59wsPy4UAV2ddLY36Nv/x
 PIpMoDNS/dAo0CUxSFanR9Vz+VLGagzvS5xrTW2wzAbrW4GwJ3gPS3BVH+NwW0TNC78gGV
 x3Gaw4sTY0AqigwZAgJeMdMWOCmM3EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61M6P0ITZsKdtAieD7SuS7Z4SCYLoVFSYNus27d1IfQ=;
 b=LPxK+P9KFfh1JdRM6CSVUBdcJ8coBJxTtEokqx3/X7p6F22+MuyspKFKX/GxSXPKoGNgjb
 nVg0YO7gUHiFLFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61M6P0ITZsKdtAieD7SuS7Z4SCYLoVFSYNus27d1IfQ=;
 b=NdVAHmcSs/M/k+ZbxdXyPJlZtAqPED3fJEET8cRRQHdFi0iY/59wsPy4UAV2ddLY36Nv/x
 PIpMoDNS/dAo0CUxSFanR9Vz+VLGagzvS5xrTW2wzAbrW4GwJ3gPS3BVH+NwW0TNC78gGV
 x3Gaw4sTY0AqigwZAgJeMdMWOCmM3EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61M6P0ITZsKdtAieD7SuS7Z4SCYLoVFSYNus27d1IfQ=;
 b=LPxK+P9KFfh1JdRM6CSVUBdcJ8coBJxTtEokqx3/X7p6F22+MuyspKFKX/GxSXPKoGNgjb
 nVg0YO7gUHiFLFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85B8A43968;
 Mon, 23 Mar 2026 16:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GMRyH31kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/15] drm/ast: Use constants for WDT registers
Date: Mon, 23 Mar 2026 16:56:20 +0100
Message-ID: <20260323160407.245773-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
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

WDT is the Watchdog timer. WDC registers are located at the memory
range at [0x1e785000, 0x1e785fff]. There are currently up to 8
watchdog timers in the range, of which 2 are being used by AST2500.

Refer to them with macros named AST_REG_WDT<n>, where <n> is the byte
offset into the watchdog timer's memory range. Each macro also takes
the index of the watchdog timer to access. A new watchdog timer starts
at each 0x40 byte offset.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_2500.c | 20 ++++++++++----------
 drivers/gpu/drm/ast/ast_reg.h  | 13 +++++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index d141b34548a9..f0639f1ef062 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -127,9 +127,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
 		 *	[1]:= 1:WDT will be cleeared and disabled after timeout occurs
 		 *	[0]:= 1:WDT enable
 		 */
-		__ast_moutdwm(regs, 0x1E785004, 0x00000010);
-		__ast_moutdwm(regs, 0x1E785008, 0x00004755);
-		__ast_moutdwm(regs, 0x1E78500c, 0x00000033);
+		__ast_moutdwm(regs, AST_REG_WDT04(0), 0x00000010);
+		__ast_moutdwm(regs, AST_REG_WDT08(0), 0x00004755);
+		__ast_moutdwm(regs, AST_REG_WDT0C(0), 0x00000033);
 		udelay(1000);
 	}
 
@@ -304,12 +304,12 @@ static void set_mpll_2500(struct ast_device *ast)
 
 static void reset_mmc_2500(struct ast_device *ast)
 {
-	ast_moutdwm(ast, 0x1E78505C, 0x00000004);
-	ast_moutdwm(ast, 0x1E785044, 0x00000001);
-	ast_moutdwm(ast, 0x1E785048, 0x00004755);
-	ast_moutdwm(ast, 0x1E78504C, 0x00000013);
+	ast_moutdwm(ast, AST_REG_WDT1C(1), 0x00000004);
+	ast_moutdwm(ast, AST_REG_WDT04(1), 0x00000001);
+	ast_moutdwm(ast, AST_REG_WDT08(1), 0x00004755);
+	ast_moutdwm(ast, AST_REG_WDT0C(1), 0x00000013);
 	mdelay(100);
-	ast_moutdwm(ast, 0x1E785054, 0x00000077);
+	ast_moutdwm(ast, AST_REG_WDT14(1), 0x00000077);
 	ast_moutdwm(ast, AST_REG_MCR00, AST_REG_MCR00_PROTECTION_KEY);
 }
 
@@ -508,8 +508,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
 		ast_2500_patch_ahb(ast->regs);
 
 		/* Disable watchdog */
-		ast_moutdwm(ast, 0x1E78502C, 0x00000000);
-		ast_moutdwm(ast, 0x1E78504C, 0x00000000);
+		ast_moutdwm(ast, AST_REG_WDT2C(0), 0x00000000);
+		ast_moutdwm(ast, AST_REG_WDT0C(1), 0x00000000);
 
 		/*
 		 * Reset USB port to patch USB unknown device issue
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 730072a3c2cd..5effe6897b51 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -196,4 +196,17 @@
 #define AST_REG_A2P(__offset)			(AST_REG_A2P_BASE + (__offset))
 #define AST_REG_A2P58				AST_REG_A2P(0x58)
 
+/*
+ * Watchdog timer (0x1e785000 - 0x1e785fff)
+ */
+
+#define AST_REG_WDT_BASE(__n)			(0x1e785000 + (__n) * 0x40)
+#define AST_REG_WDT(__n, __offset)		(AST_REG_WDT_BASE((__n)) + (__offset))
+#define AST_REG_WDT04(__n)			AST_REG_WDT((__n), 0x04)
+#define AST_REG_WDT08(__n)			AST_REG_WDT((__n), 0x08)
+#define AST_REG_WDT0C(__n)			AST_REG_WDT((__n), 0x0c)
+#define AST_REG_WDT14(__n)			AST_REG_WDT((__n), 0x14)
+#define AST_REG_WDT1C(__n)			AST_REG_WDT((__n), 0x1c)
+#define AST_REG_WDT2C(__n)			AST_REG_WDT((__n), 0x2c)
+
 #endif
-- 
2.53.0

