Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04CC10ED67C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9283010EE6F;
	Fri, 27 Mar 2026 13:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="SRk8Xtwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3wLUryd3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zqnBQUoJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KhF0Gpbf";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AA610EE65
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1D5F5BDE4;
 Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERkkAPz3IyL3k+ha0fb09fz480Vc7KIMncgaaJNPVtQ=;
 b=SRk8Xtwxo8hrhWXwYg9ulCq4/rDKFpz48XhuFF3qZNoEjTVZ4NGsno9UadJmrbgEmrp79/
 L1cG2l6lEqxiVarsOMlphsW/m7oXPvO0FjPBfrz7HJ68+SWdr9HoCda8yyXOhyuyw9uoYg
 nGnwSVSyP5PMhZmGdHr2I9H3bUNxgYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERkkAPz3IyL3k+ha0fb09fz480Vc7KIMncgaaJNPVtQ=;
 b=3wLUryd3+u3vEnKTF+lNHePP8FnyeEFjIlci8IcaWTg3remi5yq5unK1kDT9oRLOrxIW1O
 H6arlBU60m8ALoBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERkkAPz3IyL3k+ha0fb09fz480Vc7KIMncgaaJNPVtQ=;
 b=zqnBQUoJy1yQ9IiqXy0yadjDXV22zN3RHclws71zVRp86YBOJ6Zk1ZMWRZ6XR8qJdSYI34
 N6sP5VXW7lrqg89yKopQ26f4cci+kKy5fkeoc8n+jge7YqXi5TU0/uhm01kUy5JhTRUqq1
 oJiJSZVgqbtqx/378A903SQNU8JEhTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERkkAPz3IyL3k+ha0fb09fz480Vc7KIMncgaaJNPVtQ=;
 b=KhF0GpbfxbtlGvnT2/rupPcRcnZBryDO/CCRZgaCS9XDoCfQ73P45UcFmQkHugLPelGrO4
 5ok+USwgTBlQoHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35F34A0B1;
 Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKBdKqiHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 03/15] drm/ast: Use constants for AHBC registers
Date: Fri, 27 Mar 2026 14:32:55 +0100
Message-ID: <20260327133532.79696-4-tzimmermann@suse.de>
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

AHBC is the Advanced High-Speed Bus Controller. AHBC registers are
located in the memory range within [0x1e600000, 0x1e61ffff]. Refer
to them with constants named AST_REG_AHBC<n>, where <n> is the byte
offset into the range.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_2500.c |  6 +++---
 drivers/gpu/drm/ast/ast_reg.h  | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2500.c b/drivers/gpu/drm/ast/ast_2500.c
index 2a52af0ded56..f751a27e7eb3 100644
--- a/drivers/gpu/drm/ast/ast_2500.c
+++ b/drivers/gpu/drm/ast/ast_2500.c
@@ -109,9 +109,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
 	u32 data;
 
 	/* Clear bus lock condition */
-	__ast_moutdwm(regs, 0x1e600000, 0xAEED1A03);
-	__ast_moutdwm(regs, 0x1e600084, 0x00010000);
-	__ast_moutdwm(regs, 0x1e600088, 0x00000000);
+	__ast_moutdwm(regs, AST_REG_AHBC00, AST_REG_AHBC00_PROTECT_KEY);
+	__ast_moutdwm(regs, AST_REG_AHBC84, 0x00010000);
+	__ast_moutdwm(regs, AST_REG_AHBC88, 0x00000000);
 	__ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
 
 	data = __ast_mindwm(regs, 0x1e6e2070);
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index ca9403efc7f9..0bc033dbac55 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -87,4 +87,15 @@
 #define AST_REG_P2A04				AST_REG_P2A(0xf004)
 #define AST_REG_P2A04_BASE_MASK			GENMASK(31, 16)
 
+/*
+ * AHB Controller (0x1e600000 - 0x1e61ffff)
+ */
+
+#define AST_REG_AHBC_BASE			(0x1e600000)
+#define AST_REG_AHBC(__offset)			(AST_REG_AHBC_BASE + (__offset))
+#define AST_REG_AHBC00				AST_REG_AHBC(0x00)
+#define AST_REG_AHBC00_PROTECT_KEY		(0xaeed1a03)
+#define AST_REG_AHBC84				AST_REG_AHBC(0x84)
+#define AST_REG_AHBC88				AST_REG_AHBC(0x88)
+
 #endif
-- 
2.53.0

