Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDDF10ED67B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5010EE65;
	Fri, 27 Mar 2026 13:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1L56ZUw8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Im2x5sz5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1L56ZUw8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Im2x5sz5";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D55010EE64
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 267055BDE9;
 Fri, 27 Mar 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3UPPw9ss0RaPUnj8kxg8Zd7+rzRxFkV+Q1hJwh55NM=;
 b=1L56ZUw8ToJstwAF1nssXRKYIowgmFI0RoxvLtGuQQxD8O2U2C0PCyRjpWza7+wA7pEkVn
 m7ugXlgQKC7LRhz3PdebUAIOxBkzfgfgANCTo33DzZPWJ5y2Ok1nn1uzPL9k6UU/NfgLzC
 7fsw8ZJt1ogBvoKsNjOTnC5CexRm5Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3UPPw9ss0RaPUnj8kxg8Zd7+rzRxFkV+Q1hJwh55NM=;
 b=Im2x5sz5y3Dt4ySzESrMkEko9pEpso4oKuNmdTA06+XxWgvEGzitMKQlIHV9oHXqjpv1yp
 5z1fzl1B/ojseUAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1L56ZUw8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Im2x5sz5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3UPPw9ss0RaPUnj8kxg8Zd7+rzRxFkV+Q1hJwh55NM=;
 b=1L56ZUw8ToJstwAF1nssXRKYIowgmFI0RoxvLtGuQQxD8O2U2C0PCyRjpWza7+wA7pEkVn
 m7ugXlgQKC7LRhz3PdebUAIOxBkzfgfgANCTo33DzZPWJ5y2Ok1nn1uzPL9k6UU/NfgLzC
 7fsw8ZJt1ogBvoKsNjOTnC5CexRm5Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3UPPw9ss0RaPUnj8kxg8Zd7+rzRxFkV+Q1hJwh55NM=;
 b=Im2x5sz5y3Dt4ySzESrMkEko9pEpso4oKuNmdTA06+XxWgvEGzitMKQlIHV9oHXqjpv1yp
 5z1fzl1B/ojseUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFB24A0B1;
 Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SHp8NKmHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 07/15] drm/ast: Use constants for WDT registers
Date: Fri, 27 Mar 2026 14:32:59 +0100
Message-ID: <20260327133532.79696-8-tzimmermann@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 267055BDE9
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
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
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

