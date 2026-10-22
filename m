Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEC606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VER2cUxy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A8D11259C;
	Thu, 22 Oct 2026 12:34:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB55112595
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:33:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C187A60200;
 Thu, 22 Oct 2026 12:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D71F000C9;
 Thu, 22 Oct 2026 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672434;
 bh=NL0rmwWvvEWcr/+Ey4Oe5+LRCAJVTtogoD2qGSpq0mU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VER2cUxyNAGUII0NQ4HHJmRuwX7oZpgEpjruaioztSdO/clxc4qpG4xez2l863ur1
 lD88ZfnzMPCxZZhtZE3R+1zrSn12ySLMgNVEoRnQMvw2eUC7bN5gSd35R4yttifukG
 dS2vXKEvN2FLfUisI56GEj3swEq+sg/7z93Nb3Y4ASI/ht7d5tOf2rNLKhFup3ax14
 CHPz1eFm3Chwf2qC2gJa/fJvKZuNSvqoHFNAmTT75N7t3LfZ9Pfvx/o9/9d4sGKQ90
 GKrVv/yFMxmKtXslcgph7ri4JAMxGFOxplJEpflVU4moGDBI1k9HK32XS4IStCSyA0
 9o4oeubbeM4fg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:01 +0200
Subject: [PATCH v2 02/59] drm/atomic-state-helper: Rename
 connector_tv_margins_reset to state_init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-2-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5082; i=mripard@kernel.org;
 h=from:subject:message-id; bh=B9sUmzUY6h4NrK0XQNUKe/Cf8owKBgw4kE5PwatvV3Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mPoY5hyZ+HWB3vqCY/Mj/uv9sYp0/xCbNcfmiVQLR
 8iR1R9vdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEN4eIUgIkIMDHWJ7Rpcu5+qrDrG/uf
 TUX7Uv8lSUQKFU2aXlnNIjKz4eWfT+KF/wsm/GQOPJaUJhfe8MeCsWFDXlLK5Mmv+Za0/i19fUe
 FkSnfavWPlRvCO+orldTYN61/8Fa3fP5Vp9tNHsW+76evFgQA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recent commits renamed other reset helpers to use the state_init
suffix when they only initialize properties rather than allocate or
update the object state itself.

drm_atomic_helper_connector_tv_margins_reset() falls in the same
category: it initializes the TV margin properties from the kernel
command line without allocating any state. It also reads the
connector state through connector->state, coupling it to the reset
path.

Rename it to drm_atomic_helper_connector_tv_margins_state_init() and
pass the connector state explicitly as a parameter. This decouples
it from the reset hook and prepares for the conversion to
atomic_create_state where connector->state is not yet assigned.

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 13 +++++++------
 drivers/gpu/drm/gud/gud_connector.c       |  3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c            |  3 ++-
 include/drm/drm_atomic_state_helper.h     |  3 ++-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 406157a3660f..565947c544fe 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -483,13 +483,14 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_create_state);
 
 /**
- * drm_atomic_helper_connector_tv_margins_reset - Resets TV connector properties
+ * drm_atomic_helper_connector_tv_margins_state_init - Initializes TV connector properties
+ * @state: the DRM state object
  * @connector: DRM connector
  *
- * Resets the TV-related properties attached to a connector.
+ * Initializes the TV-related properties attached to a connector.
  */
-void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector)
+void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
+						       struct drm_connector *connector)
 {
 	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
-	struct drm_connector_state *state = connector->state;
 
 	state->tv.margins.left = cmdline->tv_margins.left;
@@ -498,5 +499,5 @@ void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connecto
 	state->tv.margins.bottom = cmdline->tv_margins.bottom;
 }
-EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);
+EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
 
 /**
@@ -571,5 +572,5 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
 			state->tv.hue = val;
 
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state, connector);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 8141c3a1e30a..a57f2565d33e 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -355,5 +355,6 @@ static void gud_connector_reset(struct drm_connector *connector)
 	connector->state->tv = gconn->initial_tv_state;
 	/* Set margins from command line */
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+							  connector);
 	if (gconn->initial_brightness >= 0)
 		connector->state->tv.brightness = gconn->initial_brightness;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 31942638fcd8..e14cbe4b5f15 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -509,5 +509,6 @@ static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 	drm_atomic_helper_connector_reset(connector);
 	__drm_atomic_helper_connector_hdmi_state_init(connector->state, connector);
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+							  connector);
 }
 
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 4706eeab52c1..4dac741af22c 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -75,5 +75,6 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 					 struct drm_atomic_commit *state);
-void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
+void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
+						       struct drm_connector *connector);
 void
 __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,

-- 
2.55.0

