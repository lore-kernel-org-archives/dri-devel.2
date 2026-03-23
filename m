Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C2F483C6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FF110E58B;
	Mon, 23 Mar 2026 16:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="jym52Pi+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NqNrHZD5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jym52Pi+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NqNrHZD5";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300DC10E585
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EA784D36A;
 Mon, 23 Mar 2026 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tnXVQ0v65gT8OJzXRcGXicEmsQp/+E9NSJMFhfRBj0=;
 b=jym52Pi+g67eGjm6XrxxkwxTbmmmXX+wv6w1d52C+6IBoIj8tLehoLA7gHngbdAHMgl/zp
 7po9H6hNj2qMAW8Le6GtEiXZmGiT6Mm1PleVR5gHQ+DiDMcTq7DLNvhoeYJE8FVvtx9IDV
 qdg09dt2wuarcMLvyooWTJRffoAk2Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tnXVQ0v65gT8OJzXRcGXicEmsQp/+E9NSJMFhfRBj0=;
 b=NqNrHZD54iM8VqUTl2jrLgvnmK8Db55vgC9HdLwL9w2TFXRqzUBuFr5ecIiNPNXc+aA782
 uXPVdhszVbKwGvDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774281853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tnXVQ0v65gT8OJzXRcGXicEmsQp/+E9NSJMFhfRBj0=;
 b=jym52Pi+g67eGjm6XrxxkwxTbmmmXX+wv6w1d52C+6IBoIj8tLehoLA7gHngbdAHMgl/zp
 7po9H6hNj2qMAW8Le6GtEiXZmGiT6Mm1PleVR5gHQ+DiDMcTq7DLNvhoeYJE8FVvtx9IDV
 qdg09dt2wuarcMLvyooWTJRffoAk2Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774281853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tnXVQ0v65gT8OJzXRcGXicEmsQp/+E9NSJMFhfRBj0=;
 b=NqNrHZD54iM8VqUTl2jrLgvnmK8Db55vgC9HdLwL9w2TFXRqzUBuFr5ecIiNPNXc+aA782
 uXPVdhszVbKwGvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 406D54396A;
 Mon, 23 Mar 2026 16:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gGZMDn1kwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 06/15] drm/ast: Use constants for A2P registers
Date: Mon, 23 Mar 2026 16:56:19 +0100
Message-ID: <20260323160407.245773-7-tzimmermann@suse.de>
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
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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

A2P is the AHB-to-P Bridge. A2P registers are located at the memory
range at [0x1e720000, 0x1e73ffff]. Refer to them with constants named
AST_REG_A2P<n>, where <n> is the byte offset into the range.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_2300.c | 6 +++---
 drivers/gpu/drm/ast/ast_reg.h  | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_2300.c b/drivers/gpu/drm/ast/ast_2300.c
index 1fe947178124..96d9909d942c 100644
--- a/drivers/gpu/drm/ast/ast_2300.c
+++ b/drivers/gpu/drm/ast/ast_2300.c
@@ -508,7 +508,7 @@ static bool cbr_dll2(struct ast_device *ast, struct ast2300_dram_param *param)
 	dlli  = (dllmin[1] + dllmax[1]) >> 1;
 	dlli <<= 8;
 	dlli += (dllmin[0] + dllmax[0]) >> 1;
-	ast_moutdwm(ast, AST_REG_MCR68, ast_mindwm(ast, 0x1E720058) | (dlli << 16));
+	ast_moutdwm(ast, AST_REG_MCR68, ast_mindwm(ast, AST_REG_A2P58) | (dlli << 16));
 	return status;
 } /* CBRDLL2 */
 
@@ -826,7 +826,7 @@ static void ddr3_init(struct ast_device *ast, struct ast2300_dram_param *param)
 		data = ast_mindwm(ast, AST_REG_MCR1C);
 		data = (data >> 8) & 0xff;
 	}
-	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR68) & 0xffff);
+	ast_moutdwm(ast, AST_REG_A2P58, ast_mindwm(ast, AST_REG_MCR68) & 0xffff);
 	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
 	ast_moutdwm(ast, AST_REG_MCR18, data);
 
@@ -1188,7 +1188,7 @@ static void ddr2_init(struct ast_device *ast, struct ast2300_dram_param *param)
 		data = ast_mindwm(ast, AST_REG_MCR1C);
 		data = (data >> 8) & 0xff;
 	}
-	ast_moutdwm(ast, 0x1E720058, ast_mindwm(ast, AST_REG_MCR08) & 0xffff);
+	ast_moutdwm(ast, AST_REG_A2P58, ast_mindwm(ast, AST_REG_MCR08) & 0xffff);
 	data = ast_mindwm(ast, AST_REG_MCR18) | 0xC00;
 	ast_moutdwm(ast, AST_REG_MCR18, data);
 
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index e8d4991186ca..730072a3c2cd 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -188,4 +188,12 @@
 #define AST_REG_SCU104				AST_REG_SCU(0x104)
 #define AST_REG_SCU160				AST_REG_SCU(0x160)
 
+/*
+ * AHB-to-P Bus Bridge (0x1e720000 - 0x1e73ffff)
+ */
+
+#define AST_REG_A2P_BASE			(0x1e720000)
+#define AST_REG_A2P(__offset)			(AST_REG_A2P_BASE + (__offset))
+#define AST_REG_A2P58				AST_REG_A2P(0x58)
+
 #endif
-- 
2.53.0

