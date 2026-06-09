Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D2CCD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EED10E5E9;
	Tue,  9 Jun 2026 12:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="duOpVB6g";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175F010E5E9;
 Tue,  9 Jun 2026 12:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781009312; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NPg+vp1TI/db8JXzU94LadDYCuQrqZX9/8Ohm+6vjonROdE5nfv9reyM+HhEXAET3jmcZ+i0aW6I9Ne6Dl0MZ90zBBUMZLUr2Eu89fUjBQgvx2FnxLB+mOm1sM/d4Fe2+jPRmUTeMHWzDQLJARWNm2N9dNAoiIjGe5Q8lRb5kRI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781009312;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fyWNAHICY2KhYaf6kzOMrIfDJnWrHa9uDl/uAd31SJY=; 
 b=edl3/QjF47m+0qPQLr6iQE5s4HCyTxU4mLjNwShCK7rM+1gUPY9G4NS9ch/oaN0p/vsv91IIT3bOv8qVs3mOIU97BQkdn4dwfO3MXOIIO57z345LuLS4uha9ZpNyh/brVfHfROVkmCXxNcg0aGudEVvWCL/ijX0wzTGVxhDm2wQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781009312; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=fyWNAHICY2KhYaf6kzOMrIfDJnWrHa9uDl/uAd31SJY=;
 b=duOpVB6gZ/9K37Uda3EUjKJuLTDNC91hdB2auIXRhJL7NwE4UOJc1jXv50kRmCwF
 B0Id13t21aXYU2ScED+gzwXyqXe5JX+ogjiRJ9qsAMNO02XaflUY6D+PN8NiPyDVnhw
 hhOOVFRFrBVhP8tY9xng3P5VsL7GeEdoiPY4rfO4=
Received: by mx.zohomail.com with SMTPS id 1781009310310432.5986253974912;
 Tue, 9 Jun 2026 05:48:30 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 09 Jun 2026 14:44:14 +0200
Subject: [PATCH v17 27/28] drm/i915/hdmi: Implement "color format" DRM property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-color-format-v17-27-35739b5782cc@collabora.com>
References: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
In-Reply-To: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Implement the "color format" DRM property for HDMI. The values of the
property include RGB, YCbCr420, YCbCr444 and Auto. Auto will pick RGB,
with a fallback to YCbCr420.

The mask of supported formats by the source exposed by the property is
an optimistic scenario, as specific DFP-related caveats can't be
established before an EDID is present.

Should the explicitly requested color format not be supported by the
sink (or by the source in combination with the sink), then an error is
returned to userspace, so that it can make a better choice.

Reviewed-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 52 ++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 6c6a3a0677fe..9e5d88f07262 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2322,10 +2322,10 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	return intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits);
 }
 
-static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
-				      struct intel_crtc_state *crtc_state,
-				      const struct drm_connector_state *conn_state,
-				      bool respect_downstream_limits)
+static int intel_hdmi_compute_formats_auto(struct intel_encoder *encoder,
+					   struct intel_crtc_state *crtc_state,
+					   const struct drm_connector_state *conn_state,
+					   bool respect_downstream_limits)
 {
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
@@ -2360,6 +2360,35 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 	return ret;
 }
 
+static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
+				      struct intel_crtc_state *crtc_state,
+				      const struct drm_connector_state *conn_state,
+				      bool respect_downstream_limits)
+{
+	struct intel_connector *connector = to_intel_connector(conn_state->connector);
+
+	switch (conn_state->color_format) {
+	case DRM_CONNECTOR_COLOR_FORMAT_RGB444:
+		return intel_hdmi_compute_output_format(encoder, crtc_state, connector,
+							respect_downstream_limits,
+							INTEL_OUTPUT_FORMAT_RGB);
+	case DRM_CONNECTOR_COLOR_FORMAT_YCBCR444:
+		return intel_hdmi_compute_output_format(encoder, crtc_state, connector,
+							respect_downstream_limits,
+							INTEL_OUTPUT_FORMAT_YCBCR444);
+	case DRM_CONNECTOR_COLOR_FORMAT_YCBCR420:
+		return intel_hdmi_compute_output_format(encoder, crtc_state, connector,
+							respect_downstream_limits,
+							INTEL_OUTPUT_FORMAT_YCBCR420);
+	case DRM_CONNECTOR_COLOR_FORMAT_AUTO:
+		return intel_hdmi_compute_formats_auto(encoder, crtc_state, conn_state,
+						       respect_downstream_limits);
+	default:
+		MISSING_CASE(conn_state->color_format);
+		return -EINVAL;
+	}
+}
+
 static bool intel_hdmi_is_cloned(const struct intel_crtc_state *crtc_state)
 {
 	return crtc_state->uapi.encoder_mask &&
@@ -2732,6 +2761,20 @@ static const struct drm_connector_helper_funcs intel_hdmi_connector_helper_funcs
 	.atomic_check = intel_hdmi_connector_atomic_check,
 };
 
+static void
+intel_hdmi_attach_color_format_property(struct intel_connector *connector)
+{
+	unsigned long fmts = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
+
+	if (connector->base.ycbcr_420_allowed)
+		fmts |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+
+	if (intel_hdmi_can_ycbcr444(connector))
+		fmts |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
+
+	drm_connector_attach_color_format_property(&connector->base, fmts);
+}
+
 static void
 intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *_connector)
 {
@@ -2744,6 +2787,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *_
 
 	intel_attach_hdmi_colorspace_property(&connector->base);
 	drm_connector_attach_content_type_property(&connector->base);
+	intel_hdmi_attach_color_format_property(connector);
 
 	if (DISPLAY_VER(display) >= 10)
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);

-- 
2.54.0

