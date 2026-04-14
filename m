Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC29F531F6
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB2510E57C;
	Tue, 14 Apr 2026 07:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mejO1po8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bl9saPYY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mejO1po8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bl9saPYY";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323B610E57C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:05:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DB946A960;
 Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF/5zMy9Mons8kiLgsj8R8m3RTsCFM6kAIr6g5R6YKM=;
 b=mejO1po8nM+A9kfh5GZSurGn1IJEdnVnoZCLnrR8fmVOoMq0zQJc5D1jPVxlmL04h/6gux
 rBilU3sFJ4hUBaywRYG0frCf+yGRWIw9aNu108vA53rVtuIjMnZD5kLCzahlDZlQNdzs+r
 mAhWl7N8T/Q8e/GbJvb+HJUCBqpwUok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF/5zMy9Mons8kiLgsj8R8m3RTsCFM6kAIr6g5R6YKM=;
 b=Bl9saPYYnqlwcO4x555vAvTuM1fuCspOTojKTdNBpRBvUY6em+OzdAs8Okh2hJRVQE+9lU
 zclNEtBtV2hwaJCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF/5zMy9Mons8kiLgsj8R8m3RTsCFM6kAIr6g5R6YKM=;
 b=mejO1po8nM+A9kfh5GZSurGn1IJEdnVnoZCLnrR8fmVOoMq0zQJc5D1jPVxlmL04h/6gux
 rBilU3sFJ4hUBaywRYG0frCf+yGRWIw9aNu108vA53rVtuIjMnZD5kLCzahlDZlQNdzs+r
 mAhWl7N8T/Q8e/GbJvb+HJUCBqpwUok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF/5zMy9Mons8kiLgsj8R8m3RTsCFM6kAIr6g5R6YKM=;
 b=Bl9saPYYnqlwcO4x555vAvTuM1fuCspOTojKTdNBpRBvUY6em+OzdAs8Okh2hJRVQE+9lU
 zclNEtBtV2hwaJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F06D4B301;
 Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SC9MCjfn3WmIOgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 14 Apr 2026 07:05:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] drm/ast: Replace references to struct drm_format_info.cpp
Date: Tue, 14 Apr 2026 09:02:29 +0200
Message-ID: <20260414070522.33943-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414070522.33943-1-tzimmermann@suse.de>
References: <20260414070522.33943-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_DN_SOME(0.00)[];
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

Replace all uses of struct drm_format_info.cpp with the corresponding
4CC constant. Color-mode selection uses switch statements that branch
by cpp in several places. While at it, also name the involved variables
according to register names and replace magic values with constants.

Replace the use of *ModeIndex constants in ast_set_vbios_color_reg()
with correct register constants. The former are array indices and do
not belong into registers.

In ast_set_color_reg(), vgacra0 is independent from the color format,
so move it out from the switch statements.

There is also a flag for gamma correction in vgacra8, which currently
ast_set_color_reg() handles as part of the primary plane. The gamma LUT
and its programming is located in the CRTC. A future update should
consolidate gamma correction in the primary plane and implement the
functionality with DRM's colorop helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 65 ++++++++++++++++++----------------
 drivers/gpu/drm/ast/ast_reg.h  | 55 +++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 49585fd16267..340ea680df47 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -146,29 +146,31 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
 				    const struct drm_format_info *format,
 				    const struct ast_vbios_enhtable *vmode)
 {
-	u32 color_index;
+	u8 vgacr8c = 0x00;
+	u8 vgacr92 = 0x00;
 
-	switch (format->cpp[0]) {
-	case 1:
-		color_index = VGAModeIndex - 1;
+	switch (format->format) {
+	case DRM_FORMAT_C8:
+		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_VGA;
+		vgacr92 = 8;
 		break;
-	case 2:
-		color_index = HiCModeIndex;
+	case DRM_FORMAT_RGB565:
+		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_16_BPP;
+		vgacr92 = 16;
 		break;
-	case 4:
-		color_index = TrueCModeIndex;
+	case DRM_FORMAT_XRGB8888:
+		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_32_BPP;
+		vgacr92 = 32;
 		break;
-	default:
-		return;
 	}
 
-	ast_set_index_reg(ast, AST_IO_VGACRI, 0x8c, (u8)((color_index & 0x0f) << 4));
+	ast_set_index_reg(ast, AST_IO_VGACRI, 0x8c, vgacr8c);
 
 	ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, 0x00);
 
 	if (vmode->flags & NewModeInfo) {
 		ast_set_index_reg(ast, AST_IO_VGACRI, 0x91, AST_IO_VGACR91_PASSWORD);
-		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, format->cpp[0] * 8);
+		ast_set_index_reg(ast, AST_IO_VGACRI, 0x92, vgacr92);
 	}
 }
 
@@ -380,30 +382,33 @@ static void ast_set_dclk_reg(struct ast_device *ast,
 static void ast_set_color_reg(struct ast_device *ast,
 			      const struct drm_format_info *format)
 {
-	u8 jregA0 = 0, jregA3 = 0, jregA8 = 0;
+	u8 vgacra0 = 0x00;
+	u8 vgacra3 = 0x00;
+	u8 vgacra8 = 0x00;
 
-	switch (format->cpp[0] * 8) {
-	case 8:
-		jregA0 = 0x70;
-		jregA3 = 0x01;
-		jregA8 = 0x00;
+	vgacra0 |= AST_IO_VGACRA0_MEMORY_CHAIN4_MODE |
+		   AST_IO_VGACRA0_LINEAR_EXT_ACCESS |
+		   AST_IO_VGACRA0_SEGMENTED_EXT_ACCESS;
+
+	switch (format->format) {
+	case DRM_FORMAT_C8:
+		vgacra3 |= AST_IO_VGACRA3_256_COLORS;
+		vgacra8 &= ~AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
 		break;
-	case 15:
-	case 16:
-		jregA0 = 0x70;
-		jregA3 = 0x04;
-		jregA8 = 0x02;
+	case DRM_FORMAT_XRGB1555:
+	case DRM_FORMAT_RGB565:
+		vgacra3 |= AST_IO_VGACRA3_16_BPP;
+		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
 		break;
-	case 32:
-		jregA0 = 0x70;
-		jregA3 = 0x08;
-		jregA8 = 0x02;
+	case DRM_FORMAT_XRGB8888:
+		vgacra3 |= AST_IO_VGACRA3_32_BPP;
+		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
 		break;
 	}
 
-	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa0, 0x8f, jregA0);
-	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xf0, jregA3);
-	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa8, 0xfd, jregA8);
+	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa0, 0x8f, vgacra0);
+	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xf0, vgacra3);
+	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa8, 0xfd, vgacra8);
 }
 
 static void ast_set_crtthd_reg(struct ast_device *ast)
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 99d0a8322f89..9267b70a3ec8 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -28,19 +28,48 @@
 #define AST_IO_VGAPDR		        (0x49)
 #define AST_IO_VGAGRI			(0x4E)
 
-#define AST_IO_VGACRI			(0x54)
-#define AST_IO_VGACR17_SYNC_ENABLE	BIT(7) /* called "Hardware reset" in docs */
-#define AST_IO_VGACR80_PASSWORD		(0xa8)
-#define AST_IO_VGACR91_PASSWORD		(0xa8)
-#define AST_IO_VGACR99_VGAMEM_RSRV_MASK	GENMASK(1, 0)
-#define AST_IO_VGACRA1_VGAIO_DISABLED	BIT(1)
-#define AST_IO_VGACRA1_MMIO_ENABLED	BIT(2)
-#define AST_IO_VGACRA3_DVO_ENABLED	BIT(7)
-#define AST_IO_VGACRAA_VGAMEM_SIZE_MASK	GENMASK(1, 0)
-#define AST_IO_VGACRB6_HSYNC_OFF	BIT(0)
-#define AST_IO_VGACRB6_VSYNC_OFF	BIT(1)
-#define AST_IO_VGACRCB_HWC_16BPP	BIT(0) /* set: ARGB4444, cleared: 2bpp palette */
-#define AST_IO_VGACRCB_HWC_ENABLED	BIT(1)
+#define AST_IO_VGACRI				(0x54)
+#define AST_IO_VGACR17_SYNC_ENABLE		BIT(7) /* called "Hardware reset" in docs */
+#define AST_IO_VGACR80_PASSWORD			(0xa8)
+
+#define AST_IO_VGACR8C_NEW_MODE_MASK		GENMASK(3, 0)
+#define AST_IO_VGACR8C_NEW_MODE_EGA		(0x00)
+#define AST_IO_VGACR8C_NEW_MODE_VGA		(0x01)
+#define AST_IO_VGACR8C_NEW_MODE_15_BPP		(0x02)
+#define AST_IO_VGACR8C_NEW_MODE_16_BPP		(0x03)
+#define AST_IO_VGACR8C_NEW_MODE_32_BPP		(0x04)
+#define AST_IO_VGACR8C_NEW_MODE_CGA		(0x0f)
+#define AST_IO_VGACR8C_NEW_MODE_TEXT		(0x0e)
+#define AST_IO_VGACR8C_CUR_MODE_MASK		GENMASK(7, 4)
+#define AST_IO_VGACR8C_CUR_MODE_EGA		(0x00)
+#define AST_IO_VGACR8C_CUR_MODE_VGA		(0x10)
+#define AST_IO_VGACR8C_CUR_MODE_15_BPP		(0x20)
+#define AST_IO_VGACR8C_CUR_MODE_16_BPP		(0x30)
+#define AST_IO_VGACR8C_CUR_MODE_32_BPP		(0x40)
+#define AST_IO_VGACR8C_CUR_MODE_CGA		(0xf0)
+#define AST_IO_VGACR8C_CUR_MODE_TEXT		(0xe0)
+
+#define AST_IO_VGACR91_PASSWORD			(0xa8)
+#define AST_IO_VGACR99_VGAMEM_RSRV_MASK		GENMASK(1, 0)
+
+#define AST_IO_VGACRA0_MEMORY_CHAIN4_MODE	BIT(6)
+#define AST_IO_VGACRA0_LINEAR_EXT_ACCESS	BIT(5)
+#define AST_IO_VGACRA0_SEGMENTED_EXT_ACCESS	BIT(4)
+
+#define AST_IO_VGACRA1_VGAIO_DISABLED		BIT(1)
+#define AST_IO_VGACRA1_MMIO_ENABLED		BIT(2)
+
+#define AST_IO_VGACRA3_DVO_ENABLED		BIT(7)
+#define AST_IO_VGACRA3_32_BPP			BIT(3)
+#define AST_IO_VGACRA3_16_BPP			BIT(2)
+#define AST_IO_VGACRA3_256_COLORS		BIT(0)
+
+#define AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED	BIT(1)
+#define AST_IO_VGACRAA_VGAMEM_SIZE_MASK		GENMASK(1, 0)
+#define AST_IO_VGACRB6_HSYNC_OFF		BIT(0)
+#define AST_IO_VGACRB6_VSYNC_OFF		BIT(1)
+#define AST_IO_VGACRCB_HWC_16BPP		BIT(0) /* set: ARGB4444, cleared: 2bpp palette */
+#define AST_IO_VGACRCB_HWC_ENABLED		BIT(1)
 
 /* mirrors SCU100[7:0] */
 #define AST_IO_VGACRD0_VRAM_INIT_STATUS_MASK	GENMASK(7, 6)
-- 
2.53.0

