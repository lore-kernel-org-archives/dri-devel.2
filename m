Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD0FE5201
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDB110F4FC;
	Fri, 24 Apr 2026 10:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VVVDjBYi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8708A10F4F8;
 Fri, 24 Apr 2026 10:19:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 07A90600CB;
 Fri, 24 Apr 2026 10:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A2FC2BCB5;
 Fri, 24 Apr 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777025977;
 bh=mvRqiu9k67Lg/bOO98zLzULa9FWxwjUx6Z/LWf0LREA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VVVDjBYiZr9QXHtrx7ORWgJeFCivn5Lxp4tnKujrzIThe9AIv6tgtr1jT5r7QIagT
 YS/0NhRrQKCz9WratZlv72TecLlI4lm+CgDzPXyhDSgAhA9+3XPS8hWsTEzTSgDxzA
 FAVArt3v375o8YTO4WtjC4ZyeM+XqGgWWzR3igDLlH8QzwX6HxHQmyKutFQUgHzXy6
 1auVIeE1Kd3rKwN+0gJrMgx2a0pzqcrcovgTpcr69ykAPxVcCmHxGtaWMgo24fcLLL
 c10Q5Sp4b5uGTL7rdppyH8xUv7vCchWQU0h9yTttqqQueJBTkNbP9Bg99b2vbZHTEj
 rFYvr5ao2L2Lw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 24 Apr 2026 12:18:53 +0200
Subject: [PATCH v3 13/20] drm/atomic-state-helper: Rename
 __drm_atomic_helper_connector_state_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-drm-mode-config-init-v3-13-8b68d9db0d8b@kernel.org>
References: <20260424-drm-mode-config-init-v3-0-8b68d9db0d8b@kernel.org>
In-Reply-To: <20260424-drm-mode-config-init-v3-0-8b68d9db0d8b@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mvRqiu9k67Lg/bOO98zLzULa9FWxwjUx6Z/LWf0LREA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJmvnfv07hnvlmbx/blqi1vmo5aT22VW7pZg2RQgKTopa
 MbZbDvtjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRUFXGhicCodtYMkr6p0j/
 cWuc9dv8aVnXNDn70oe2v6eJBlpzJBhov04Xubeq+f2spRV/AncVMdZKvOHWuT1l8695M4+fYvj
 tz5gTcPfx1epv2cen1HHW1Qev3RXxlC2pUsJgalihm4eBzBkA
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

__drm_atomic_helper_connector_state_reset() is used to initialize a
newly allocated drm_connector_state, and is being typically called by
the drm_connector_funcs.reset implementation.

Since we want to consolidate DRM objects state allocation around the
atomic_create_state callback that will only allocate and initialize a
new drm_connector_state instance, we will need to call
__drm_atomic_helper_connector_state_reset() from both the reset and
atomic_create hooks.

To avoid any confusion, we can thus rename
__drm_atomic_helper_connector_state_reset() to
__drm_atomic_helper_connector_state_init().

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 12 ++++++------
 include/drm/drm_atomic_state_helper.h     |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index b7da134c8c50..f67aacaa3b6e 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -496,24 +496,24 @@ void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_destroy_state);
 
 /**
- * __drm_atomic_helper_connector_state_reset - reset the connector state
+ * __drm_atomic_helper_connector_state_init - Initializes the connector state
  * @conn_state: atomic connector state, must not be NULL
- * @connector: connectotr object, must not be NULL
+ * @connector: connector object, must not be NULL
  *
  * Initializes the newly allocated @conn_state with default
  * values. This is useful for drivers that subclass the connector state.
  */
 void
-__drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_state,
-					  struct drm_connector *connector)
+__drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
+					 struct drm_connector *connector)
 {
 	conn_state->connector = connector;
 }
-EXPORT_SYMBOL(__drm_atomic_helper_connector_state_reset);
+EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
 /**
  * __drm_atomic_helper_connector_reset - reset state on connector
  * @connector: drm connector
  * @conn_state: connector state to assign
@@ -528,11 +528,11 @@ EXPORT_SYMBOL(__drm_atomic_helper_connector_state_reset);
 void
 __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 				    struct drm_connector_state *conn_state)
 {
 	if (conn_state)
-		__drm_atomic_helper_connector_state_reset(conn_state, connector);
+		__drm_atomic_helper_connector_state_init(conn_state, connector);
 
 	connector->state = conn_state;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_connector_reset);
 
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 129762b99de6..e7c097e6dfe3 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -70,11 +70,11 @@ struct drm_plane_state *
 drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);
 void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 					  struct drm_plane_state *state);
 
-void __drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_state,
+void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					       struct drm_connector *connector);
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 					 struct drm_connector_state *conn_state);
 void drm_atomic_helper_connector_reset(struct drm_connector *connector);
 void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);

-- 
2.53.0

