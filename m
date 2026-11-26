Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68635606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=OqDcfKpS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5756A1127FF;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C54210E145
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:24:57 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 8EC5A202F55B;
 Thu, 26 Nov 2026 13:24:55 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 4432420378BD;
 Thu, 26 Nov 2026 13:16:34 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 4432420378BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1795680998; bh=LbkIXOmap6GC+YXtWNvPVcnSMTU3cle+PSX8H0JOaH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OqDcfKpSiGruDmI/noSXA/xbnAyhF8ZNYydIvkybxK8U1U1Jdl7pOJjx1uzi5A8PC
 gqSHBl+IIzzxAK1sKo6FjzCS5iR8JF52rbEuc/gEYrhi6e0tuJwD13lGITrdn//p1y
 auPYLj1FnNPJCcstGEvlhOuP6jCcm6+QVfkCTnPMlk0dIOL7WlpBG6GnmuD+YYWk66
 qEy/RCxoZZEmUPXqfreDMKnrUedOrod9+mBlTgoVaQVyP2JUiUVhV0hL7nTcKifEq3
 Zfju5Jt2ucuD4xQGEPvDtF643tPmVVhUlfvTYxTloBB32qjuZUzRNui2RNXQqB2fEN
 Lth5CxWAkRTXg==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Alex Hung <alex.hung@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 Adrian Betschart <adrian.betschart@cinemaone.ch>,
 Alex Huang <Alex.Huang2@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Hans Verkuil <hverkuil@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, lvc-project@linuxtesting.org
Subject: [PATCH 3/5] drm/connector: Propagate content type property creation
 errors
Date: Thu, 26 Nov 2026 12:15:58 +0400
Message-ID: <20261126081602.2901498-4-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

drm_connector_attach_content_type_property() returns success even when
drm_mode_create_content_type_property() fails. The property is safely
left unattached, but callers cannot detect the failure.

Propagate the creation error and document the return value. Check the
result in the Intel HDMI and DP/LSPCON paths and in AMDGPU, logging the
failure while preserving initialization without the optional property.

Fixes: 50525c332b55 ("drm: content-type property for HDMI connector")
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c  |  3 ++-
 drivers/gpu/drm/drm_connector.c                  | 16 +++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp.c          |  3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c        |  3 ++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 8a039ef6e4b7..3d163c2fc106 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3325,7 +3325,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		/* Content Type is currently only implemented for HDMI. */
-		drm_connector_attach_content_type_property(&aconnector->base);
+		if (drm_connector_attach_content_type_property(&aconnector->base))
+			drm_err(adev_to_drm(adev), "Failed to attach content type property\n");
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 51e616f5aa5e..5ab121860050 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2253,14 +2253,20 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
  *
  * Called by a driver the first time a HDMI connector is made.
  *
- * Returns: %0
+ * Returns:
+ * Zero on success, negative errno on failure.
  */
 int drm_connector_attach_content_type_property(struct drm_connector *connector)
 {
-	if (!drm_mode_create_content_type_property(connector->dev))
-		drm_object_attach_property(&connector->base,
-					   connector->dev->mode_config.content_type_property,
-					   DRM_MODE_CONTENT_TYPE_NO_DATA);
+	int ret;
+
+	ret = drm_mode_create_content_type_property(connector->dev);
+	if (ret)
+		return ret;
+
+	drm_object_attach_property(&connector->base,
+				   connector->dev->mode_config.content_type_property,
+				   DRM_MODE_CONTENT_TYPE_NO_DATA);
 	return 0;
 }
 EXPORT_SYMBOL(drm_connector_attach_content_type_property);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 47741957935a..768cb02f22fb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7012,7 +7012,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
 
 	/* Register HDMI colorspace for case of lspcon */
 	if (intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata)) {
-		drm_connector_attach_content_type_property(&connector->base);
+		if (drm_connector_attach_content_type_property(&connector->base))
+			drm_err(connector->base.dev, "Failed to attach content type property\n");
 		intel_attach_hdmi_colorspace_property(&connector->base);
 	} else {
 		intel_attach_dp_colorspace_property(&connector->base);
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b6fa1a1558b8..83daf6d1af4a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2719,7 +2719,8 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *_
 	intel_attach_aspect_ratio_property(&connector->base);
 
 	intel_attach_hdmi_colorspace_property(&connector->base);
-	drm_connector_attach_content_type_property(&connector->base);
+	if (drm_connector_attach_content_type_property(&connector->base))
+		drm_err(connector->base.dev, "Failed to attach content type property\n");
 
 	if (DISPLAY_VER(display) >= 10)
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);
-- 
2.56.0


