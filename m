Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E01F531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C502610E57E;
	Tue, 14 Apr 2026 07:05:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80D410E57E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:05:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5E4D6A985;
 Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D7264B302;
 Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0L6EGTfn3WmIOgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 14 Apr 2026 07:05:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/4] drm/ast: Support DRM_FORMAT_XRGB1555 on the primary plane
Date: Tue, 14 Apr 2026 09:02:30 +0200
Message-ID: <20260414070522.33943-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414070522.33943-1-tzimmermann@suse.de>
References: <20260414070522.33943-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A5E4D6A985
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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

Export DRM_FORMAT_XRGB1555 in the primary plane's format array and
handle the format in the color-format updates. With this, ast is now
feature complete wrt. color-format support.

Also update the comments in the gamma-LUT code to reflect the ast
manual's terminology.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 15 +++++++++++++--
 drivers/gpu/drm/ast/ast_reg.h  |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 340ea680df47..91b83ec00e9c 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -105,8 +105,9 @@ static void ast_crtc_fill_gamma(struct ast_device *ast,
 		/* gamma table is used as color palette */
 		drm_crtc_fill_palette_8(crtc, ast_set_gamma_lut);
 		break;
+	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_RGB565:
-		/* also uses 8-bit gamma ramp on low-color modes */
+		/* also uses 24-bit gamma correction on high-color modes */
 		fallthrough;
 	case DRM_FORMAT_XRGB8888:
 		drm_crtc_fill_gamma_888(crtc, ast_set_gamma_lut);
@@ -129,8 +130,9 @@ static void ast_crtc_load_gamma(struct ast_device *ast,
 		/* gamma table is used as color palette */
 		drm_crtc_load_palette_8(crtc, lut, ast_set_gamma_lut);
 		break;
+	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_RGB565:
-		/* also uses 8-bit gamma ramp on low-color modes */
+		/* also uses 24-bit gamma correction on high-color modes */
 		fallthrough;
 	case DRM_FORMAT_XRGB8888:
 		drm_crtc_load_gamma_888(crtc, lut, ast_set_gamma_lut);
@@ -154,6 +156,10 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
 		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_VGA;
 		vgacr92 = 8;
 		break;
+	case DRM_FORMAT_XRGB1555:
+		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_15_BPP;
+		vgacr92 = 15;
+		break;
 	case DRM_FORMAT_RGB565:
 		vgacr8c |= AST_IO_VGACR8C_CUR_MODE_16_BPP;
 		vgacr92 = 16;
@@ -396,6 +402,9 @@ static void ast_set_color_reg(struct ast_device *ast,
 		vgacra8 &= ~AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
 		break;
 	case DRM_FORMAT_XRGB1555:
+		vgacra3 |= AST_IO_VGACRA3_15_BPP;
+		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
+		break;
 	case DRM_FORMAT_RGB565:
 		vgacra3 |= AST_IO_VGACRA3_16_BPP;
 		vgacra8 |= AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED;
@@ -493,6 +502,7 @@ void __iomem *ast_plane_vaddr(struct ast_plane *ast_plane)
 static const uint32_t ast_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_C8,
 };
 
@@ -766,6 +776,7 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	case DRM_FORMAT_C8:
 		ast_state->std_table = &vbios_stdtable[VGAModeIndex];
 		break;
+	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_RGB565:
 		ast_state->std_table = &vbios_stdtable[HiCModeIndex];
 		break;
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 9267b70a3ec8..b808b0a02ba8 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -62,6 +62,7 @@
 #define AST_IO_VGACRA3_DVO_ENABLED		BIT(7)
 #define AST_IO_VGACRA3_32_BPP			BIT(3)
 #define AST_IO_VGACRA3_16_BPP			BIT(2)
+#define AST_IO_VGACRA3_15_BPP			BIT(1)
 #define AST_IO_VGACRA3_256_COLORS		BIT(0)
 
 #define AST_IO_VGACRA8_GAMMA_CORRECTION_ENABLED	BIT(1)
-- 
2.53.0

