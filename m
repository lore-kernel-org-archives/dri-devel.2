Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10680606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRkS6dI+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730351125D5;
	Thu, 22 Oct 2026 12:37:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80FA1125D0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:37:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAD1943D06;
 Thu, 22 Oct 2026 12:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143FF1F000C2;
 Thu, 22 Oct 2026 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672638;
 bh=FEKUEE/r+iy4+tS+EjFChyyMiSfuuUeMZdkv6oEzv7s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BRkS6dI+/vVBNKlaHVg2KXFT45fSZqg8o3vOYhJw2G7HZnBmikPHsjpTilUvyBmqq
 RvqKtLBEe12/qotXeDBlXf9YrCYLec+I4DLN0rR0kQp6Y8hL3gP3Mt0YQh2kpLB/wu
 AGNcKwn4htlqAP7iv2x5lGhul2FC74EB5kPKO5o98YiZEXJQTyd2Dowwj2KSVgGa85
 +OzDiTaTkA537E8bq5sD6fPkMPnF5wyH8c5XJb0ULDEIAvOCcslFLF2qUPosEJf7BK
 t/BCScwnNdUl37QN88Ci3ceEtpc9ZCYU4w6z4fo04g9qcsWhLkLsf3l83QZZQpgnUI
 QjggS0JeXfl5g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:58 +0200
Subject: [PATCH v2 59/59] drm/connector: Remove reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-59-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KPsmTwPpWyRcxeq2fNkQHdH5lxr8jWoFrVyopRX7zlw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mJZrTzZ/u4s1VaBayFZh1YKv07S4zxt982Lwn3q+5
 fmCWRzhHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAirTcZG3aHeThXFadXLXxm
 6Bx6gzVU8+fFZlaD9Impfx61XD0T5nL36fLJ566pLs1QnD498feidMaGY/P03W2vPu5dcXSO5qG
 vohOOPvuke7jrxOkLK9tnigh+0y2Z/qn680b3PcvjvgVP5r95GwA=
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
@@ -663,8 +663,4 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 
 		connector->state = state;
-	} else if (connector->funcs->reset) {
-		connector->funcs->reset(connector);
-		if (!connector->state)
-			return -ENOMEM;
 	}
 
@@ -771,8 +767,4 @@ int drmm_connector_hdmi_ini2(struct drm_device *dev,
 
 		connector->state = state;
-	} else if (connector->funcs->reset) {
-		connector->funcs->reset(connector);
-		if (!connector->state)
-			return -ENOMEM;
 	}
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 48a56f23dadb..c1e993a78702 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -316,7 +316,5 @@ void drm_mode_config_reset(struct drm_device *dev)
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->funcs->reset)
-			connector->funcs->reset(connector);
-		else if (connector->funcs->atomic_create_state)
+		if (connector->funcs->atomic_create_state)
 			drm_mode_config_connector_reset_with_create_state(connector);
 	}
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 760f074f947e..c70f09a7e3e1 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -115,6 +115,4 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 			connector->state = conn_state;
-		} else if (connector->funcs->reset) {
-			connector->funcs->reset(connector);
 		}
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a87cd13d0a45..f656ed8324d3 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1659,13 +1659,4 @@ struct drm_connector_funcs {
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

-- 
2.55.0

