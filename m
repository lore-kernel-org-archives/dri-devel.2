Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80987CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8C711218C;
	Thu, 15 Oct 2026 07:57:14 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0E510FFCA;
 Wed, 14 Oct 2026 22:30:47 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j4mBF3fsWzMlNY;
 Thu, 15 Oct 2026 00:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792017045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WgqLzBnMblvgKQOe+F+gtOEHsvv6QGYMZ3EsN/yUdg=;
 b=hD/7TCk0PTEMagUT0KsMUE66jTguCDiXlV0wmC1c/erStkt5hMuQP6qNw/IcMcWrm5nuVA
 Zk0zzB+ki3jmTbudWYIi9gExy54TFayiDSAEUue+btCSzcEwHlw6ClY1s/DEUXz6/eOz8U
 R6qNgU/J4TR689cFf6+lHx6bZVK4a8ZPJnbDILLjjjv4bH3Tsul8GXF8h8DNoi6ScZy/kG
 qDKXFT5+UpyQPx5WPI5TrRXaH17mFfI3A2GQjQaX7o7pUIz+zMm+H1qGyAVZTlh5DIylqZ
 Zooj9qVfYZbn4TP4zOyfJs3Fr87Va3JX5hwdhsTq7Io/d3gSdMV16X7GKGrLWQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 1/2] drm/amd/display: Fall back to the native mode,
 not the first, on eDP/LVDS
Date: Wed, 14 Oct 2026 23:30:40 +0100
Message-ID: <20261014223041.171317-2-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014223041.171317-1-hugo@hsal.es>
References: <20261014223041.171317-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j4mBF3fsWzMlNY
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Currently, create_stream_for_sink() takes the native timing for a scaled
mode from the preferred mode in connector->modes. After fbdev emulation
probes with size limits below the native resolution, as it does when
video= sets a smaller mode, that mode is no longer in the list

If that probe is the last one before a suspend, for example after an
HDMI hotplug, the resume finds no preferred mode, and the panel is
driven with the scaled mode's timing instead of its own

amdgpu_dm_get_native_mode() copies the preferred mode to the encoder on
every probe, before the size limits apply. Fall back to that copy when
connector->modes has no preferred mode. Limit this to eDP and LVDS,
where amdgpu turns scaling on by itself. On other connectors mode_valid
can also leave the preferred mode out, and then the first valid mode is
the right fallback

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5983
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 428a5f937..a1dc3e287 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -257,6 +257,8 @@ STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
 EXPORT_IF_KUNIT(update_subconnector_property);
 
 STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
+STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(
+	struct drm_connector *connector);
 
 STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
@@ -1470,6 +1472,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct dc_stream_state *stream = NULL;
 	struct drm_display_mode mode;
 	struct drm_display_mode saved_mode;
+	struct drm_display_mode native_mode;
 	struct drm_display_mode *freesync_mode = NULL;
 	bool native_mode_found = false;
 	bool recalculate_timing = false;
@@ -1529,6 +1532,31 @@ create_stream_for_sink(struct drm_connector *connector,
 			break;
 		}
 	}
+
+	/*
+	 * After a probe with size limits smaller than the preferred mode,
+	 * connector->modes no longer has that mode, and the first mode left
+	 * would become the stream timing. fbdev emulation probes with limits
+	 * that video= can set below the native size. The encoder has a copy of
+	 * the preferred mode from amdgpu_dm_get_native_mode(), made on every
+	 * probe before the limits apply, so use that copy. Only do this for eDP
+	 * and LVDS panels, which take only their native timing. On other
+	 * connectors mode_valid can also reject the preferred mode, and then
+	 * the first valid mode is the right one
+	 */
+	if (!native_mode_found && aconnector && !aconnector->mst_root && aconnector->drm_edid &&
+	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
+	     connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
+		struct drm_encoder *encoder = amdgpu_dm_connector_to_encoder(connector);
+
+		if (encoder && to_amdgpu_encoder(encoder)->native_mode.clock) {
+			drm_mode_copy(&native_mode, &to_amdgpu_encoder(encoder)->native_mode);
+			drm_mode_set_crtcinfo(&native_mode, CRTC_INTERLACE_HALVE_V);
+			preferred_mode = &native_mode;
+			native_mode_found = true;
+		}
+	}
+
 	if (!native_mode_found)
 		preferred_mode = list_first_entry_or_null(
 				&connector->modes,
-- 
2.55.0

