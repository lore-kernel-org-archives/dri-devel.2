Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C355606A69E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=coJlhts0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AFC10E941;
	Sat, 21 Nov 2026 01:35:51 +0000 (UTC)
Received: from out203-205-221-247.mail.qq.com (out203-205-221-247.mail.qq.com
 [203.205.221.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBB110E0C9;
 Sat, 21 Nov 2026 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795224938; bh=68OPjLr3+DXy2wHqGP1Egywl/7clFJ0PKwDXbR1MsAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=coJlhts0jWEZGSy0+44B5GdA3ueNJIIhdoTw2pLjxJWSD04ZAXGSCgaZTumgLcu1l
 Y/YTUBocCmQqwsvkqkrOVJrtIJ/NOPYxJOGHynb3j6kwSSce7JqmAZ6BpbsHDhrV+2
 T27RDDxvX652fM5M3iKQzRVx1z03ci/40QP8e/HM=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 8E0AE630; Sat, 21 Nov 2026 09:35:32 +0800
X-QQ-mid: xmsmtpt1795224936tm26ehsl8
Message-ID: <tencent_E55221A93A9DD8A438C2E1D9E18ECEFBCC05@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5mIjI9Gh4CedFvSqc179uG03pn846kdehXLrOF5wGhAzKIC7AFc
 ae7gm6D0ky7i0G/cn7Tte+oxXXC4mzYFbbwBOQHCA8YhU/sBES7Oi+dTIwjiOe3LwP9vqZFJj0EX
 N5IlOLf1t+uVoVBNk4f249ytA98Drr2bsejEGPkE2hVZE71kVl9TVn/vP0Wt+VbkMOPCc0HXsLsQ
 xsKppcWL8sDPWR2A3QjcG7c3qfmd1JupIt7tga3IIxYTPMiVlmaWeOsY+9mVPWEA5ceY6ou6Wt3y
 UrzymlVb0mDcXgkohGMZdtI5L2FpmLOkqCK+DdLZ1JKuP8f2pi1Sn0F0d5u0/tdxW/BfL2S+S6RD
 M7WYekXLlxNhFOQkzpM8yv0qAPqqJN4x5x11X50oLYFhQdota5E5OXhG3RbWxgPyh6nyK+MQYHp0
 9OPPjYUm0lvzYL7JMbXD9X6bTUj7SwapffmBKv8MXLTxSg8Fe2eOvgcNsS+G8fGT7du3aOL0GpMR
 ci+5+1Hr5RXytvpKTRJ8B6eJNq/INOwrhY9C9JRpdOIu6Z4QbsAw3cQsnpQ3lPT6nnOdmecgdagy
 tyml9X8nSNnDf06MTXJPPwr3Q1YuesH0uzTyjurWsIahQBOlJcRIAaehDAflhB6CJwjyjiQU57bF
 3IwoDICT1s8l01fqC1M7l8xoRwHps6f1Y/DwHtfTJH6Ztic0CoXvYHnsTg5j6UpORFF0is04bkl9
 GQjocOWgAyGFNCk+9NC0lStL918aDeQQisSSjy6DmKGva2qvFc48nlQk86ou87lA1qmYpr/mZW6l
 YJdtjU/qKS0cz3sqjUSnssXVZNeOYcLk7NfkvWeQSP2eWrmoHnmACftmDig7ZD3m3t2t3YYGYMtG
 t59mFz4QDyW/TdGWn83gtqeYm4hooE6KM7a5SIaianOLVw0n+h/tw81x8boQhZnjRoppkVQpxtXl
 6El2WKTWvnfbgX+qtFk/TLO2hhBr2cvB/Y8+z5sRFrUfVRzdXYu+gZa/QsUlaToxFi0CjZ0W/Tl1
 eCd6Vv2C/iARQqfipgEJFD76SnSzijtpLjCRTUG4egvReF7Q9MMXMXA9cfHeMAx/UanrrJM3yhve
 C11pywiOLKKqDOxqqmA8Xlz586PtHMqaBIBx/Y
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v4 2/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP with
 TCON HDR support
Date: Sat, 21 Nov 2026 09:35:30 +0800
X-OQ-MSGID: <20261121013532.21135-3-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121013532.21135-1-fighters390@qq.com>
References: <20261121013532.21135-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
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

