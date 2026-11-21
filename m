Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A5606A6A2
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LyMmIQCz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5E310E0D8;
	Sat, 21 Nov 2026 00:54:23 +0000 (UTC)
Received: from out203-205-221-247.mail.qq.com (out203-205-221-247.mail.qq.com
 [203.205.221.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A16310E382;
 Sat, 21 Nov 2026 00:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795222455; bh=3acQru+YL6DpQdGAVngLsot+h5cBo1OvXMxSITvu+aY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LyMmIQCzD+WgrLb6VHRC21R+bW+/vVTbdpxrHwA45nc63D7bALEtZbzpzuhxIzO1r
 couUBr1lao1uvifB4/TnXD8z+C2El+0rtY+xYGXMrDbPSlgded2aSn+KETr1VpGMnR
 NUyVSquSBQyQtyhVCLXCmjg8aVMX3v1VJGvNneQc=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D8985C1C; Sat, 21 Nov 2026 08:54:09 +0800
X-QQ-mid: xmsmtpt1795222452tqdlfzmis
Message-ID: <tencent_B8BA9FC944C4CE33D89D83F78E255E124606@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeKmC/Fb2zpKg9//ZBVfvLwa/dNzOooYE+VeJjVoOSdsL7ZKqpwd
 ekWw/eEzPHJuL2WeV1h04GzcN+YT2Ox4EhDFInQO466qTxQ90sC3SW4gFDxbAtHLNdyc8iejTBFq
 /o3o3AXNLlZkRSJrARp5Y4EDTvmsmpw6+QwSjjWofp7TKdvO3HFyMKrOvEizafyE2dUbJEZDmwL8
 QbAxexdLotzTJd+B30N3nmLG2rx54quelt9DZyV9B/ECf4ArkZ2enXxzDL/UI8msYLjhPXGqXX+r
 Ewp++E0L2I19bL9XcIaHpWHBWE1No6OgbGEToozXgbY7IDbrGUwGc1ykGeUjVinJxoAlAMbY1oYD
 XtbZh6ldJQIBSQXB3b8P3ofXZ0/IBEnhA0L/LlPclBxRwEGbtPXjOGtZfZUXkYfOCoR1vAeUSbn9
 cPryg/OzgOBJ+of4Z83WDRgZpRFJmg83BcmLk0goY0OHtAofi4A4a21IHnSsvgZ8H4ZxB1/Bcic7
 tCbbq/XiB7/jlBOLTI6gCQ0dl9rIMX1Sy3Vz98Dv4uLjJFOjAWTUkjncIUDoeMTrjeOyTXjaxYe2
 eHt1cfR0fHd/UW5+gjbR6sdNmJChDdxM8OzekGlQAdJ1xklfgNaakB/18ReKI4m5GKc4hwckaC7x
 b4+dZK7t/g3qzBkUaiRWRjeEMYLjPBHf474hu4dYlc6EfATxFDHxbBeR6uJDjr2fXqIbn3S64EeF
 crSI3Ne801txYhQE02UvsAVI7y3C2s1U8GuhX/DR7Ra0nt6b+o4T1NoycwWUXj8y26xQSqxB/1uL
 lmlFxdOCljjsAcomAoaxmnjIG4b93LZLjE5qI5IN+i2V0TEpWh47vqbF6FM18GXYnKDx45qcPbBr
 Meb5rt0KZiIXSjkace0bgZT3N0cXoChBz320wH5hfigXdc1a4iR5CWRR6rp/Vz+cw7yDK8sJpnsh
 +GFRve18cQN4g02dHY0FeuHKUVcF3+/GLJ+LfHDt9yUv/KXVDtcO3raX9VL6qtbVJxN1jQxHwOAE
 AbNW74B4waA1hsFINjRs2d2dsuyyCcX+QVhr6ICQKBEkscS04aX7XhB3Sb1m0w4galXyz9qg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v3 2/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP with
 TCON HDR support
Date: Sat, 21 Nov 2026 08:54:07 +0800
X-OQ-MSGID: <20261121005409.17626-3-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121005409.17626-1-fighters390@qq.com>
References: <20261121005409.17626-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_dp_add_properties() attaches HDR_OUTPUT_METADATA only when the
encoder can send a gamut metadata DIP, so pre-ICL eDP panels on port A
never expose it even when their EDID advertises HDR.

Those panels do not use a DIP at all: the metadata is programmed through
the Intel AUX HDR interface, and the TCON capability is already known
because intel_edp_backlight_setup() runs before intel_dp_add_properties().

Factor the whole decision into intel_dp_hdr_metadata_supported() and let
it accept eDP panels whose TCON advertises PQ (ST2084) decoding through
the Intel AUX HDR backlight interface.

Since no DIP is transmitted in that case, skip computing the infoframe
when the encoder has no gamut metadata DIP, so that the computed state
matches what is actually programmed.

Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c       | 31 +++++++++++++++++--
 .../drm/i915/display/intel_dp_aux_backlight.c |  5 +++
 .../drm/i915/display/intel_dp_aux_backlight.h |  3 ++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2736a78..eeead26 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -70,6 +70,7 @@
 #include "intel_display_types.h"
 #include "intel_dp.h"
 #include "intel_dp_aux.h"
+#include "intel_dp_aux_backlight.h"
 #include "intel_dp_hdcp.h"
 #include "intel_dp_link_training.h"
 #include "intel_dp_mst.h"
@@ -3085,9 +3086,17 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
 					    const struct drm_connector_state *conn_state)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 	int ret;
 	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
 
+	/*
+	 * Without a gamut metadata DIP there is nothing to program here; on
+	 * pre-ICL eDP the metadata goes through the AUX HDR interface instead.
+	 */
+	if (!intel_dp_has_gamut_metadata_dip(encoder))
+		return;
+
 	if (!conn_state->hdr_output_metadata)
 		return;
 
@@ -6685,6 +6694,24 @@ intel_dp_has_gamut_metadata_dip(struct intel_encoder *encoder)
 	return false;
 }
 
+static bool intel_dp_hdr_metadata_supported(struct intel_dp *intel_dp,
+					     struct intel_connector *connector)
+{
+	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
+
+	/* LSPCON attaches the property itself in intel_dp_connector_register() */
+	if (intel_bios_encoder_is_lspcon(encoder->devdata))
+		return false;
+
+	if (intel_dp_has_gamut_metadata_dip(encoder))
+		return true;
+
+	/* Pre-ICL eDP programs the metadata via the AUX HDR interface */
+	return intel_dp_is_edp(intel_dp) &&
+	       intel_dp_aux_is_hdr_backlight(connector) &&
+	       connector->panel.backlight.edp.intel_cap.supports_2084_decode;
+}
+
 static void
 intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connector)
 {
@@ -6712,9 +6739,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
 		intel_attach_dp_colorspace_property(&connector->base);
 	}
 
-	/* LSPCON attaches the property itself in intel_dp_connector_register() */
-	if (!intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata) &&
-	    intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
+	if (intel_dp_hdr_metadata_supported(intel_dp, connector))
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);
 
 	if (HAS_VRR(display))
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index eb05ef4..8c7fd99 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -630,6 +630,11 @@ static const struct intel_panel_bl_funcs intel_dp_hdr_bl_funcs = {
 	.get = intel_dp_aux_hdr_get_backlight,
 };
 
+bool intel_dp_aux_is_hdr_backlight(const struct intel_connector *connector)
+{
+	return connector->panel.backlight.funcs == &intel_dp_hdr_bl_funcs;
+}
+
 static const struct intel_panel_bl_funcs intel_dp_vesa_bl_funcs = {
 	.setup = intel_dp_aux_vesa_setup_backlight,
 	.enable = intel_dp_aux_vesa_enable_backlight,
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
index ed60c28..1fa1b93 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
@@ -6,8 +6,11 @@
 #ifndef __INTEL_DP_AUX_BACKLIGHT_H__
 #define __INTEL_DP_AUX_BACKLIGHT_H__
 
+#include <linux/types.h>
+
 struct intel_connector;
 
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector);
+bool intel_dp_aux_is_hdr_backlight(const struct intel_connector *connector);
 
 #endif /* __INTEL_DP_AUX_BACKLIGHT_H__ */
-- 
2.53.0

