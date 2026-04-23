Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9BDFDEE46
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F9310F27F;
	Thu, 23 Apr 2026 19:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PW5IGQXn";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D672710F24A;
 Thu, 23 Apr 2026 19:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776971120; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D8pBdc3/tnggta8aXWJGkalpzLSoKkl9RI1kRRl8p4xXZ3tYdlAiPmqPEsRqtXhkAvIHZgReAjH7DG7x2D5wqH9COkZDwGlTer0zHP/7tw1XwzMNkWvOWM+e/GvXD9zAjRBmVK0wnBLlccu0yu4T4d5ta5WmZdZPmutMFdhhRAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776971120;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tTwgeWxJjTj3zgZ7H2pPIg1FKRse0ow00ezleoUdZMU=; 
 b=g1SmoujqSrYvBw5rP1xPDBGHr2hCIAE11S0td7aLwyRhSQeSo2gvHsAQYCa32bLMw/qnHS+X6bf1PPju531+hMqyfiazXrIuDxxZTmJSr2U8ePcXdjg6Qne0ajmT/TuqmMiDCn50i/WQkEP1xCCAE0/T6F53+5inr7UD31qzLRs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776971120; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=tTwgeWxJjTj3zgZ7H2pPIg1FKRse0ow00ezleoUdZMU=;
 b=PW5IGQXn5/fqsoVnDzVpFnNW0j4+ag7FRX034TBZNlieh34iw9qrJPcwMZncfRo7
 Ho2d8PS3SVCSWYO+MryNu8bjHp+2NhW7sTO7HtE+86jiYrANPfnxriA65VX2QNjmNc7
 LYNMLDaeX42EC1kIVYSln9GBiC4eAXjW/HM9yy+o=
Received: by mx.zohomail.com with SMTPS id 1776971117666621.558874860145;
 Thu, 23 Apr 2026 12:05:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 23 Apr 2026 21:03:34 +0200
Subject: [PATCH v14 11/28] drm/i915/hdmi: Add YCBCR444 handling for sink
 formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-color-format-v14-11-449a419ccbd4@collabora.com>
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
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

In anticipation of userspace being able to explicitly select supported
sink formats, add handling of the YCBCR444 sink format. The AUTO path
does not choose this format, but with explicit format selection added to
the driver, it becomes a possibility.

Check for YCBCR444 support on the sink in sink_bpc_possible, and on the
source and sink in sink_format_valid.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 874076a29da4..ee7a7655e9b4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1966,6 +1966,8 @@ static bool intel_hdmi_sink_bpc_possible(struct drm_connector *_connector,
 
 		if (sink_format == INTEL_OUTPUT_FORMAT_YCBCR420)
 			return hdmi->y420_dc_modes & DRM_EDID_YCBCR420_DC_36;
+		else if (sink_format == INTEL_OUTPUT_FORMAT_YCBCR444)
+			return info->edid_hdmi_ycbcr444_dc_modes & DRM_EDID_HDMI_DC_36;
 		else
 			return info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36;
 	case 10:
@@ -1974,6 +1976,8 @@ static bool intel_hdmi_sink_bpc_possible(struct drm_connector *_connector,
 
 		if (sink_format == INTEL_OUTPUT_FORMAT_YCBCR420)
 			return hdmi->y420_dc_modes & DRM_EDID_YCBCR420_DC_30;
+		else if (sink_format == INTEL_OUTPUT_FORMAT_YCBCR444)
+			return info->edid_hdmi_ycbcr444_dc_modes & DRM_EDID_HDMI_DC_30;
 		else
 			return info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30;
 	case 8:
@@ -2021,6 +2025,27 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 	return status;
 }
 
+/**
+ * intel_hdmi_can_ycbcr444 - Check whether connector can output YCbCr444
+ * @connector: pointer to &struct intel_connector to check
+ *
+ * Checks whether the hardware that backs @connector is capable of outputting
+ * YCbCr444 video over HDMI. Does not check whether currently connected sink is
+ * capable of receiving it.
+ *
+ * Returns: %true if source supports outputting YCbCr444, %false otherwise.
+ */
+static bool
+intel_hdmi_can_ycbcr444(struct intel_connector *connector)
+{
+	const struct intel_display *display = to_intel_display(connector);
+
+	if (HAS_GMCH(display))
+		return true;
+
+	return false;
+}
+
 static enum drm_mode_status
 intel_hdmi_sink_format_valid(struct intel_connector *connector,
 			     const struct drm_display_mode *mode,
@@ -2038,6 +2063,13 @@ intel_hdmi_sink_format_valid(struct intel_connector *connector,
 
 		return MODE_OK;
 	case INTEL_OUTPUT_FORMAT_RGB:
+		return MODE_OK;
+	case INTEL_OUTPUT_FORMAT_YCBCR444:
+		if (!intel_hdmi_can_ycbcr444(connector))
+			return MODE_BAD;
+		if (!(info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444)))
+			return MODE_BAD;
+
 		return MODE_OK;
 	default:
 		MISSING_CASE(sink_format);

-- 
2.53.0

