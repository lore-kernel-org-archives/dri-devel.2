Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB52A606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=Zkl2Zlcy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060D810E546;
	Sat, 24 Oct 2026 22:59:08 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A758B10E32B;
 Sat, 24 Oct 2026 16:33:52 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jBlnq0qtWz8sb1;
 Sat, 24 Oct 2026 18:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792859631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3tgvrUsFi4GN/V4BTiVMEFcYaEE2L14qNp0gE7VNQE=;
 b=Zkl2Zlcy9WCmjSBTcsw1zL9sFYirNkJ3jjImOeopxiBg3QVCMKQnFLQpZfGLMNe++9HF0i
 rBMN+eOXmGvu+CvLohHwjMe8KEjKel68kQDVTpiE3/w7gCVACS6I5LFPsU8OcwE+2FzSoM
 0Olpdv38xKBpnoXaf/9GsRxuO7VPygbE+vlq5Kegq0R5L3jDivHd+GYWwWtmc+tDEELop8
 wF9IrPvWUnnvR1KwzR0sWT/FYqEQ4xi2eyRl8TkMUiyfwxtrmoAQdQbKLlDjPYgwGWytcX
 px8dVhLxb0FiDEdEF4eGov59OKezfWNnLEyRMy0/NUoHQq7Alce9VOYgcVmBog==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com,
 "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: Fall back to the native mode,
 not the first, on eDP/LVDS
Date: Sat, 24 Oct 2026 17:33:46 +0100
Message-ID: <20261024163347.2413649-2-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024163347.2413649-1-hugo@hsal.es>
References: <74c73b6f-a6b3-4652-8da1-b5c46ae58809@amd.com>
 <20261024163347.2413649-1-hugo@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBlnq0qtWz8sb1
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, create_stream_for_sink() takes the native timing for a scaled
mode from the preferred mode in connector->modes. After fbdev emulation
probes with size limits below the native resolution, as it does when
video= sets a smaller mode, that mode is no longer in the list

If that probe is the last one before a suspend, for example after an
HDMI hotplug, the resume finds no preferred mode, and the panel is
driven with the scaled mode's timing instead of its own

amdgpu_dm_get_native_mode() copies the preferred mode to the encoder on
every probe, before the size limits apply. When connector->modes has no
preferred mode, take a mode of the native size from the list, or that
copy if the limits pruned them all. The list comes first because
mode_valid may have rejected the copy's timing and kept another mode of
the same size. Limit this to eDP and LVDS, where amdgpu turns scaling on
by itself. On other connectors mode_valid can also leave the preferred
mode out, and then the first valid mode is the right fallback

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5983
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ded8e21897f1c..a13e3b641fd27 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -257,6 +257,8 @@ STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
 EXPORT_IF_KUNIT(update_subconnector_property);
 
 STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
+STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(
+	struct drm_connector *connector);
 
 STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
@@ -1545,6 +1547,51 @@ create_stream_for_sink(struct drm_connector *connector,
 			break;
 		}
 	}
+
+	/*
+	 * After a probe with size limits smaller than the preferred mode,
+	 * connector->modes no longer has that mode, and the first mode left
+	 * would become the stream timing. fbdev emulation probes with limits
+	 * that video= can set below the native size. Only eDP and LVDS panels
+	 * get a fallback here, since they take only their native size. On other
+	 * connectors mode_valid can also reject the preferred mode, and then
+	 * the first valid mode is the right one
+	 *
+	 * Take a mode of the native size from connector->modes if one is left,
+	 * since mode_valid may have rejected the preferred timing itself. The
+	 * probe sorts the list, so the first one has the highest refresh rate
+	 * left. If the limits pruned them all, use the copy of the preferred
+	 * mode that amdgpu_dm_get_native_mode() keeps in the encoder. It is
+	 * made on every probe, before the limits apply
+	 */
+	if (!preferred_mode && aconnector && aconnector->drm_edid &&
+	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
+	     connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
+		struct drm_encoder *encoder = amdgpu_dm_connector_to_encoder(connector);
+		const struct drm_display_mode *enc_native =
+			encoder ? &to_amdgpu_encoder(encoder)->native_mode : NULL;
+
+		if (enc_native && enc_native->clock) {
+			list_for_each_entry(connector_mode, &connector->modes, head) {
+				if (connector_mode->hdisplay == enc_native->hdisplay &&
+				    connector_mode->vdisplay == enc_native->vdisplay) {
+					preferred_mode = connector_mode;
+					break;
+				}
+			}
+
+			/*
+			 * saved_mode is only used for FreeSync video modes, and
+			 * that path doesn't read preferred_mode
+			 */
+			if (!preferred_mode) {
+				drm_mode_init(&saved_mode, enc_native);
+				drm_mode_set_crtcinfo(&saved_mode, CRTC_INTERLACE_HALVE_V);
+				preferred_mode = &saved_mode;
+			}
+		}
+	}
+
 	if (!preferred_mode)
 		preferred_mode = list_first_entry_or_null(
 				&connector->modes,
-- 
2.55.0

