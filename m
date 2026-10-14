Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5DFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE2410EAA3;
	Wed, 14 Oct 2026 17:31:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8924910FEB6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CB466053E;
 Wed, 14 Oct 2026 17:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCF31F000C4;
 Wed, 14 Oct 2026 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999105;
 bh=VOmNyftNToMhiBDgM7SXuI6h06ekX0gFYy4r3qp/AGc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LCIl8Uzs6cdGwRtlWcN/Y82dYTY8h1K4j6zOg5+lytQ/QLnaZ1tzhbeTTwMIiGsB2
 tXfhPo2cioNfcxdE8zNhpnxjTPWZhR3Yj3Rq7IJG/womR8ZpJSBpluffT5abXdfw1I
 nt/PRyoYuxFF0N/WbX2aE9LxVGINWkeUns2J4vr/jM3jgZdl/S7DrTDXEdqpy8UunW
 TenldS7SUSM9RLI1ChcS8sEx7pi0W/CfW3PckExQfe9Nr4uXTxNjRakRndGrHd3EX4
 YlIANuKp82Sg4hoRxTZ9kTADwjJp+Y81bwWhBtTAEHE+KV1+eN1FfYuWtSrBNy/eMi
 9eh9hIyIoxVZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:38 +0200
Subject: [PATCH 75/75] drm/connector: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-75-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PCVEUY83TVGUa42c00L4xu07dso2ioQWHSBt9iJgahM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2e/09sjvTlpv5FMiMU6ZYvQ38lC9h+vVHgdE2XR0
 9Opip/cMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYybxFjfSCT8b+7/1eUTZMz
 l7Rbl73i40/mB0ZPZPccfNyanhvzPiTwiNtcvrMtPe1P+VI+yJ+/z1hfsJrfyFxo47EFXMrbPnF
 4dt/eEK2+8aTk64a4gEcJ2aoHuBjTnwgeePJsZ5BkFLeN9m4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

All the drivers that used to implement the reset hook have been
converted to use atomic_create_state instead.

Remove the reset hook from drm_connector_funcs, and the code calling
it in drm_mode_config_reset(), drmm_connector_hdmi_init() and
panel_bridge_attach().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_connector.c   | 8 --------
 drivers/gpu/drm/drm_mode_config.c | 4 +---
 drivers/gpu/drm/drm_panel.c       | 2 --
 include/drm/drm_connector.h       | 9 ---------
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..d66188521881 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -660,14 +660,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		state = connector->funcs->atomic_create_state(connector);
 		if (IS_ERR(state))
 			return PTR_ERR(state);
 
 		connector->state = state;
-	} else if (connector->funcs->reset) {
-		connector->funcs->reset(connector);
-		if (!connector->state)
-			return -ENOMEM;
 	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, hdmi_funcs->max_bpc);
 	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
 	connector->max_bpc = hdmi_funcs->max_bpc;
@@ -768,14 +764,10 @@ int drmm_connector_hdmi_ini2(struct drm_device *dev,
 		state = connector->funcs->atomic_create_state(connector);
 		if (IS_ERR(state))
 			return PTR_ERR(state);
 
 		connector->state = state;
-	} else if (connector->funcs->reset) {
-		connector->funcs->reset(connector);
-		if (!connector->state)
-			return -ENOMEM;
 	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
 	connector->max_bpc = max_bpc;
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 48a56f23dadb..c1e993a78702 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -313,13 +313,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 		if (encoder->funcs && encoder->funcs->reset)
 			encoder->funcs->reset(encoder);
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->funcs->reset)
-			connector->funcs->reset(connector);
-		else if (connector->funcs->atomic_create_state)
+		if (connector->funcs->atomic_create_state)
 			drm_mode_config_connector_reset_with_create_state(connector);
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
 EXPORT_SYMBOL(drm_mode_config_reset);
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 55a1427c7a10..6131aaf2eb70 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -110,12 +110,10 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 			conn_state = connector->funcs->atomic_create_state(connector);
 			if (IS_ERR(conn_state))
 				return PTR_ERR(conn_state);
 
 			connector->state = conn_state;
-		} else if (connector->funcs->reset) {
-			connector->funcs->reset(connector);
 		}
 
 		drm_connector_register(connector);
 	}
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a87cd13d0a45..f656ed8324d3 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1656,19 +1656,10 @@ struct drm_connector_funcs {
 	 *
 	 * 0 on success or a negative error code on failure.
 	 */
 	int (*dpms)(struct drm_connector *connector, int mode);
 
-	/**
-	 * @reset:
-	 *
-	 * Reset connector hardware and software state to off. This function isn't
-	 * called by the core directly, only through drm_mode_config_reset().
-	 * It's not a helper hook only for historical reasons.
-	 */
-	void (*reset)(struct drm_connector *connector);
-
 	/**
 	 * @detect:
 	 *
 	 * Check to see if anything is attached to the connector. The parameter
 	 * force is set to false whilst polling, true when checking the

-- 
2.55.0

