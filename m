Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61275F531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26A410E57D;
	Tue, 14 Apr 2026 07:05:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F108310E57C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:05:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E011E5BE56;
 Tue, 14 Apr 2026 07:05:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A81284B301;
 Tue, 14 Apr 2026 07:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cFvVJzbn3WmIOgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 14 Apr 2026 07:05:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/4] drm/ast: Add constant for VGACR91
Date: Tue, 14 Apr 2026 09:02:27 +0200
Message-ID: <20260414070522.33943-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414070522.33943-1-tzimmermann@suse.de>
References: <20260414070522.33943-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: E011E5BE56
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Register VGACR91 receives a password that enables the new mode-info
header in other registers. Replace the password's magic value with a
constant.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 4 ++--
 drivers/gpu/drm/ast/ast_reg.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 21abb6a6d8bc..c150b83aaca7 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -168,7 +168,7 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
 	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
 
 	if (vmode->flags & NewModeInfo) {
-		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0xa8);
+		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
 		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, format->cpp[0] * 8);
 	}
 }
@@ -188,7 +188,7 @@ static void ast_set_vbios_mode_reg(struct ast_device *ast,
 	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
 
 	if (vmode->flags & NewModeInfo) {
-		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0xa8);
+		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
 		ast_set_index_reg(ast, AST_IO_VGACRI, 0x93, adjusted_mode->clock / 1000);
 		ast_set_index_reg(ast, AST_IO_VGACRI, 0x94, adjusted_mode->crtc_hdisplay);
 		ast_set_index_reg(ast, AST_IO_VGACRI, 0x95, adjusted_mode->crtc_hdisplay >> 8);
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index ea7dc382aee7..99d0a8322f89 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -31,6 +31,7 @@
 #define AST_IO_VGACRI			(0x54)
 #define AST_IO_VGACR17_SYNC_ENABLE	BIT(7) /* called "Hardware reset" in docs */
 #define AST_IO_VGACR80_PASSWORD		(0xa8)
+#define AST_IO_VGACR91_PASSWORD		(0xa8)
 #define AST_IO_VGACR99_VGAMEM_RSRV_MASK	GENMASK(1, 0)
 #define AST_IO_VGACRA1_VGAIO_DISABLED	BIT(1)
 #define AST_IO_VGACRA1_MMIO_ENABLED	BIT(2)
-- 
2.53.0

