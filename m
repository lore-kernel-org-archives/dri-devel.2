Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02948C88E54
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461E010F527;
	Fri, 11 Sep 2026 07:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="CaVJgGpl";
	dkim-atps=neutral
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F5F10E2D0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:15:21 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hgm7C3yXvzyHb;
 Thu, 10 Sep 2026 20:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1789064119;
 bh=RZefKOnVfiL9JNII1ZYlmPnKnTh94CstW5go0Osd9Xg=;
 h=From:To:Cc:Subject:Date:From;
 b=CaVJgGpl1eBzB9wnSMes3HiZ+tX/fAtXsEPvdA5HSzKCgQ5flcLi461UIDkE+g5St
 DR+Q2Xg14CYWzZM0vZpGj2FytrNkTmnUGZysDnVj4bWFLUZZvsbS3Adhca08BfkdFG
 Pf4sSv5Mf02VNL2eRMdGBuhm3p/xqvMhDfrSShPDuwbaC8N7WMw1tLBeq344pNJCgt
 ZB7VJCl+kRtfwP0cvnoQA3ZD4aiGJ1BlJze5xskiMFtumP+42oe1Ry1qVU/EX71gZW
 9XKGZPVHccWTnq8aoPFgP+S90GcDeHYxRbd+tWH9Vy58tHGRrjMLisHYTibHbX6bCT
 smb1VRqafm2TA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hgm7B3jv5zf3K; Thu, 10 Sep 2026 20:15:18 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Satyajit Roy <sroy14@alum.utk.edu>, Alex Hung <alex.hung@amd.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Default HDMI RGB output to limited range on
 CTA modes
Date: Thu, 10 Sep 2026 20:15:17 +0200
Message-ID: <20260910181517.68781-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

With the Broadcast RGB property at Automatic, amdgpu_dm_get_output_color_space()
selects COLOR_SPACE_SRGB for RGB output, so DC neither compresses the pixels
nor, without a QS-capable sink, signals full range in the AVI InfoFrame. A sink
that follows CTA-861 treats the default quantization of a CTA video format as
limited and expands 16-235 to 0-255: everything below 16 is crushed to black,
everything above 235 clips.

Follow the CTA-861 default for Automatic instead, as the DRM HDMI state helper
(hdmi_is_limited_range()) and i915 do: limited range on an HDMI sink for CTA
modes other than 640x480, full range elsewhere. Full and Limited keep their
explicit meaning. The same rule applies to the BT.2020 RGB branch. With
commit a56a50074 ("drm/amd/display: Propagate HDMI RGB quantization
selectability") the AVI InfoFrame then carries the matching Q value on
sinks that support selection.

Measured on a Radeon RX 7600 (DCN 3.2.1) driving a JVC DLA-RS4100 at
1920x1080p24 RGB 12 bpc: the sink reports the signal as limited range while
the picture shows crushed shadows; rendering limited range in the client makes
it match a reference source.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5796
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude Code:claude-fable-5-1
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133e..13cbe099c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -734,6 +734,24 @@ get_aspect_ratio(const struct drm_display_mode *mode_in)
 }
 EXPORT_IF_KUNIT(get_aspect_ratio);
 
+/*
+ * CTA-861 5.1: RGB video formats default to limited range except 640x480 (VIC 1).
+ * With Broadcast RGB left at Automatic follow that default, as i915 does.
+ */
+static bool rgb_output_is_limited_range(const struct dc_crtc_timing *dc_crtc_timing,
+					const struct drm_connector_state *connector_state)
+{
+	switch (connector_state->hdmi.broadcast_rgb) {
+	case DRM_HDMI_BROADCAST_RGB_FULL:
+		return false;
+	case DRM_HDMI_BROADCAST_RGB_LIMITED:
+		return true;
+	default:
+		return connector_state->connector->display_info.is_hdmi &&
+		       dc_crtc_timing->vic > 1;
+	}
+}
+
 enum dc_color_space
 amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 				 const struct drm_connector_state *connector_state)
@@ -759,7 +777,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	case DRM_MODE_COLORIMETRY_BT2020_RGB:
 	case DRM_MODE_COLORIMETRY_BT2020_YCC:
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
-			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
 				color_space = COLOR_SPACE_2020_RGB_LIMITEDRANGE;
 			else
 				color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
@@ -771,7 +789,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	default:
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
 			color_space = COLOR_SPACE_SRGB;
-			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
 				color_space = COLOR_SPACE_SRGB_LIMITED;
 		/*
 		 * 27030khz is the separation point between HDTV and SDTV
-- 
2.55.0

