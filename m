Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB110606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngCPkUY0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C53B10F8DB;
	Tue,  3 Nov 2026 22:42:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B810210F770;
 Tue,  3 Nov 2026 22:42:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D90743DF4;
 Tue,  3 Nov 2026 22:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2A1F00A18;
 Tue,  3 Nov 2026 22:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745754;
 bh=PEvKgHuzMcEqcFdxZxPthE75TieLrA0urwCwR3k19ac=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ngCPkUY0jlR5Djwrf4nIjSIorDE1ghYkWYzgJSc1vgf4n9R9yaGn3wULmw0KOcstt
 6aZGCzzU4BeKvANk8Gfa/qHtpmfmDbRX+zXEvNMWUY3HsGEbcy5yzNikUJmgTPC7MC
 +1+yY1aExPT3mr+4jratPgIP8zrDN0DsMS9F1PVS22AskyURF0L025OV8bLuhlemRR
 0Kx9HCZgOzqrhIfDumPV313oJFhKOMaPW7pdcwwZ7O/Ji6M/7M5l7jT3dLX7uJbO+V
 4aFXp/rjwtb7uv/PAlvQ0io6IwjFq/gv5VLqlRiew35lIjfsa/Iq7PRrp5h67G6LYv
 K7U61LGn4wCYA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:11 -0600
Subject: [PATCH v11 10/12] drm/gud: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-10-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
In-Reply-To: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mario Limonciello <mario.limonciello@amd.com>

Expose GUD display brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. The value is mirrored into tv.brightness
during atomic check so it is sent to the device with
GUD_REQ_SET_STATE_CHECK in the same commit.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Apply LUMINANCE in the atomic commit instead of a worker, fixing an
   endless commit loop, a use-after-free on disconnect and brightness
   being clobbered on DPMS off (Sashiko)
 * Attach the property at connector init (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
---
 drivers/gpu/drm/gud/gud_connector.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ddbf3b3ebbca8..bfb298bbc9b51 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -292,10 +292,19 @@ static int gud_connector_atomic_check(struct drm_connector *connector,
 	struct drm_connector_state *old_state;
 
 	new_state = drm_atomic_get_new_connector_state(state, connector);
+	old_state = drm_atomic_get_old_connector_state(state, connector);
+
+	/*
+	 * LUMINANCE is sent to the device as tv.brightness in the same commit,
+	 * the brightness change below then triggers GUD_REQ_SET_STATE_CHECK.
+	 */
+	if (connector->luminance_property &&
+	    old_state->luminance != new_state->luminance)
+		new_state->tv.brightness = new_state->luminance;
+
 	if (!new_state->crtc)
 		return 0;
 
-	old_state = drm_atomic_get_old_connector_state(state, connector);
 	new_crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
 
 	if (old_state->tv.margins.left != new_state->tv.margins.left ||
@@ -324,7 +333,7 @@ static int gud_connector_late_register(struct drm_connector *connector)
 {
 	struct gud_connector *gconn = to_gud_connector(connector);
 
-	if (gconn->initial_brightness < 0)
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) || gconn->initial_brightness < 0)
 		return 0;
 
 	return gud_connector_backlight_register(gconn);
@@ -699,6 +708,13 @@ static int gud_connector_create(struct gud_device *gdrm, unsigned int index,
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && gconn->initial_brightness >= 0) {
+		ret = drm_connector_attach_luminance_property(connector, 0, 100,
+							      gconn->initial_brightness);
+		if (ret)
+			return ret;
+	}
+
 	gconn->encoder.possible_crtcs = drm_crtc_mask(&gdrm->crtc);
 	ret = drm_encoder_init(drm, &gconn->encoder, &gud_drm_simple_encoder_funcs_cleanup,
 			       DRM_MODE_ENCODER_NONE, NULL);

-- 
2.53.0

