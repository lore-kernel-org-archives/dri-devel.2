Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A7606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nzrgKPTJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587A910E081;
	Fri, 20 Nov 2026 06:26:04 +0000 (UTC)
X-Greylist: delayed 1912 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 06:25:57 UTC
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF9C10E081;
 Fri, 20 Nov 2026 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795155955; bh=Cv3zQ5Ow3HSK/pVktfwWb/MModXLH+vS0Gs5gxq5E34=;
 h=From:To:Cc:Subject:Date;
 b=nzrgKPTJhP85mPGlwOjKdCATs0OldkZhtjtZ0tWn1QsWaCuM57RLFQcGZe+cGE0Y+
 Fv2DhsuElj7u+Quqz8Ssh2yGvpPnArOH0e2QDPse11NsriYLJF7B4qiQsH6qy23FLi
 bShgxOOlrOEj+S6JfI1436Hi8T2dbOAnnHdDFw7E=
Received: from ThinkPad-T14 ([42.80.121.23])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 674BACC5; Fri, 20 Nov 2026 14:25:52 +0800
X-QQ-mid: xmsmtpt1795155952tnbw0dmyd
Message-ID: <tencent_29E977263911A2CF7F7754DEC2963C49D808@qq.com>
X-QQ-XMAILINFO: MoQ+ZqrtYx1+mBjWYzXwu0kd28ZKanwJRyUvyHZW9rdpno0+tTL0d8/FidZ1SQ
 /7YqCHaaY/IRTG6qdMefLDjOuZNzooc5Z66mZ8GywphaEYzTWAkdy17xoHK5MJ3oFUFnP+MZtnrl
 yxse3TkuglBiuYSI2WFbXUwzjbIsWSWTD8aDbCChU9SnIUfyXqlYJZ3YF+KigxJBA9/heFlmaKAU
 3I5bnckj7Ffqmq3P+x7oOBXp78bR8CMzhx69VtPtjuyENdANRyOmopwFkZYFJ/6ivVyRdLaREgC+
 WLoI/FI4zX5Mz2EbtQfxj4Z6sB8ilUE5BEMmrKp5y7Wbsozt0PNdPtP3EWOOv0hew2ca6dB0N1PD
 G+Qj57AvWyFk0aNS5sZECCW1bZugTEdu3nT4XleP9vOf9obSkC2WHg2ol1KUuYI7vg9kRqQcFx7X
 0PV1nCPx+HmjEd92JYBPR6hIEW/YheOmzDJo97uCJVJKr28vH0hvX7n24ULDvBlSuEQmfaT2YdBV
 aWAN2uMFDq5t2J+xy8YBYTzIalEUL96xwJcYU0v37FSdZALAdI7iLI3PGPZBkYUpCmj0b8SA7XYd
 sn7FwbZFxRT5gCFO00wzRd/AM8IgmrKZ4NxSP4+W3zoH7OZb2cTwRSLylekwRDFAj2GqL8UUG2TY
 TKvSzbZ13+eKNvFp4RQIReh2249IOQQ2KS4Da1oUTlxcQomGwpCuDFrbs8UA6Tp9yw3tc6FqhoOl
 VLcsnJYQ6Els432hVA5v1yvMw+UiirRK7+JGQdeGAtMLFjStQcluXXjL6Q+H3PnRWuH6o6BclAbU
 rBxyX12fbUiQw9AM2/VeGoHRDmLChA2I2B8uKGJecMLLpiltY6Or7q43mH207VEqxN8KWaOMW09s
 TKnkMv02E/vLvFcyzdL7Asn07naW/hu3LOwCbIEQJccLFpbkwdMnsRrxe74/paym7vXbSIZqtqyX
 S5q0gtPoWvb7kc+oGcxc6g0JJvBL5ckFIrU5kl4qg541TebWIJogzdKG4wExrWDvLf0ChzqyOIy0
 CVps7AcatwZ2ibMX7cAAk37WP47It9hSckV7Rz8EekIBk8kENxK1S+yj42gRJr3ERydhe/3u2dNz
 7+ncLYBC0NWgmBUD6b1TqHL+wIU8VEXUYuFldoCxZJPaJlYSk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON
 supports HDR
Date: Fri, 20 Nov 2026 14:25:52 +0800
X-OQ-MSGID: <20261120062552.60585-1-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
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

intel_dp_has_gamut_metadata_dip() returns false for port A on pre-ICL
platforms. intel_dp_add_properties() uses that helper to decide whether
to attach the HDR_OUTPUT_METADATA connector property, so eDP panels on
those platforms never expose it even when the panel advertises HDR in
its EDID.

On such panels the HDR metadata is not sent as a gamut metadata SDP, but
programmed through the Intel AUX HDR interface instead. The TCON is
already probed during intel_edp_backlight_setup(), which runs before
intel_dp_add_properties(), so the capability is known at that point.

Attach the property when the panel's TCON advertises PQ (ST2084) decode
support and the Intel AUX HDR backlight interface is the one in use, so
that userspace can enable HDR on these panels.

Since no SDP is transmitted in that case, also bail out early from
intel_dp_compute_hdr_metadata_infoframe_sdp() when the encoder cannot
send gamut metadata. LSPCON is excluded from that early return, as it
still needs the infoframe populated for lspcon_write_infoframe().

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/10415
Signed-off-by: Yitian Shao <fighters390@qq.com>
---
v2:
 - Do not skip the infoframe on LSPCON, which still needs it for
   lspcon_write_infoframe(). Reported by Sashiko.
 - Add intel_dp_aux_is_hdr_backlight() and use it to attach the property
   only when the Intel AUX HDR backlight interface is in use, instead of
   reading the untagged union unconditionally. Reported by Sashiko.

v1 was tested on a CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP
panel that advertises BT2020 + ST2084 in its EDID: the connector gains
HDR_OUTPUT_METADATA, GNOME 50 offers the HDR switch, and the panel enters
PQ/BT2020 mode. The Intel TCON HDR backlight interface was already in use
before the change. v2 keeps that path unchanged on this hardware (the new
helper returns true there) and was compile-tested; I have not re-run the
runtime test for v2.

Sashiko also raised a fastset concern: with the early return,
crtc_state->infoframes.enable no longer changes when HDR metadata is
toggled, so the commit might be downgraded to a fastset and skip
intel_dp_aux_hdr_enable_backlight(). I don't think that can happen,
because intel_digital_connector_atomic_check() sets mode_changed = true
whenever drm_connector_atomic_hdr_metadata_equal() fails, which forces a
full modeset and therefore intel_dp_encoder_enable() ->
intel_backlight_enable() -> funcs->enable(). Happy to be corrected if
there is a path I am missing.

One remaining question: intel_dp_aux_write_content_luminance() also
returns early when !intel_dp_has_gamut_metadata_dip(), which is exactly
the PORT_A case where the AUX path is used. max_cll/max_fall therefore
never reach the TCON. Should that check be relaxed too?

 drivers/gpu/drm/i915/display/intel_dp.c           | 15 ++++++++++++++-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c |  5 +++++
 .../gpu/drm/i915/display/intel_dp_aux_backlight.h |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index afd4169..f816dd5 100644
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
@@ -3086,8 +3087,17 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	int ret;
+	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
 
+	/*
+	 * LSPCON does not use a gamut metadata DIP, but still needs the
+	 * infoframe populated for lspcon_write_infoframe().
+	 */
+	if (!intel_dp_has_gamut_metadata_dip(encoder) &&
+	    !intel_bios_encoder_is_lspcon(encoder->devdata))
+		return;
+
 	if (!conn_state->hdr_output_metadata)
 		return;
 
@@ -6715,7 +6725,10 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
 		intel_attach_dp_colorspace_property(&connector->base);
 	}
 
-	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
+	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base) ||
+	    (intel_dp_is_edp(intel_dp) &&
+	     intel_dp_aux_is_hdr_backlight(connector) &&
+	     connector->panel.backlight.edp.intel_cap.supports_2084_decode))
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);
 
 	if (HAS_VRR(display))
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 266e042..069895f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -672,6 +672,11 @@ static const struct intel_panel_bl_funcs intel_dp_hdr_bl_funcs = {
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

