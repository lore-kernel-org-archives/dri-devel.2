Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE718F483C1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D553E10E5A9;
	Mon, 23 Mar 2026 16:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="aJDqiHli";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d8i1Uo++";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aJDqiHli";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d8i1Uo++";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B207D10E598
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 716FA4D376;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySu/2G+bLe49ljcM5QIoGlyRgj9y9eXQB01xC7pF6Iw=;
 b=aJDqiHlixPxKQeOw3Aaa8LEZTQ8zWpY3wxgqMDLtNA41fgyJR675PSLIQPfLBIT+TH5m7u
 RavlLSLsAmuWiOmpbWKHmWnimhabfPCqUSlcTBqhkqx8e9Yt8XjGTUWGe5+9x0R+qoaKy0
 S1cEoHJILzuaWOnM/B1TZCA/cwNIYW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySu/2G+bLe49ljcM5QIoGlyRgj9y9eXQB01xC7pF6Iw=;
 b=d8i1Uo+++KXynTuZkMAqMhFQNi55MTFciHgQU8gLnCcg9qtPMkAGv1Y5nRdjIqLTd031hr
 JquzNc9RdIFe/UBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySu/2G+bLe49ljcM5QIoGlyRgj9y9eXQB01xC7pF6Iw=;
 b=aJDqiHlixPxKQeOw3Aaa8LEZTQ8zWpY3wxgqMDLtNA41fgyJR675PSLIQPfLBIT+TH5m7u
 RavlLSLsAmuWiOmpbWKHmWnimhabfPCqUSlcTBqhkqx8e9Yt8XjGTUWGe5+9x0R+qoaKy0
 S1cEoHJILzuaWOnM/B1TZCA/cwNIYW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySu/2G+bLe49ljcM5QIoGlyRgj9y9eXQB01xC7pF6Iw=;
 b=d8i1Uo+++KXynTuZkMAqMhFQNi55MTFciHgQU8gLnCcg9qtPMkAGv1Y5nRdjIqLTd031hr
 JquzNc9RdIFe/UBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A8CD43968;
 Mon, 23 Mar 2026 16:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wGHbDH9kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/15] drm/ast: Gen6: Fix open-coded register access
Date: Mon, 23 Mar 2026 16:56:26 +0100
Message-ID: <20260323160407.245773-14-tzimmermann@suse.de>
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

Replace all open-coded access to SCU registers in Gen6 with the
appropriate calls to ast_moutdwm() and ast_mindwm(). Use SCU register
constants. Name variables according to registers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_2500.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index 39f401dd1f47..e442cb6a23d9 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -507,6 +507,8 @@ static void ast_post_chip_2500(struct ast_device *ast)
 
 	reg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd0, 0xff);
 	if ((reg & AST_IO_VGACRD0_VRAM_INIT_STATUS_MASK) == 0) {/* vga only */
+		u32 scu008;
+
 		/* Clear bus lock condition */
 		ast_2500_patch_ahb(ast->regs);
 
@@ -540,9 +542,9 @@ static void ast_post_chip_2500(struct ast_device *ast)
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
-- 
2.53.0

