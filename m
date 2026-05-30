Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D40CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAC6112850;
	Sat, 30 May 2026 14:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rd0zzjs3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4079711283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8536600BB;
 Sat, 30 May 2026 14:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3631F00893;
 Sat, 30 May 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149788;
 bh=8rIEwVNKP9Ktmy1UkEiFLuE7Ku1xuFxC/aKApg1pOQM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Rd0zzjs3Yqsbi/NKOwP1f5GZDjR3LfGh1CBhwIl8Br85KYARZ9NWTclyShPVFNFQ4
 OOBaOy27H7bB8kLurVPgEHUqfFA8k0t1aJRLG5CPLFK5PElK+crtI12b6nTk3SzsCE
 g+I4txDc6YhDOohLLkRsP2Ghwip7Vrj2MtWn9wFyxK5pUZbkb6vLxAHSCWxbMgFsQy
 hyXqOqed3KlaN1+Q7N7lzG7KZLAtqgon9neBbONVmnOec0NFQDdbYxUQ1eeNk/Wjjf
 eAkNXm3B1B+u5qhoq4H6EFtOxsNDTyEA3uBc45wgMqe1ud/vsz+Zg45ZvwWJwUAjyE
 tFu43smwF6dnw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:17 +0200
Subject: [PATCH 72/76] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-72-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FqLKQtCc8eEhDCTPjXiSL7kRwWs/+J+Tc5E4q0ZxZbQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb0N9jxlknHTbbZdq9pxfmv3cAmGR/MmTp7XNPxruf
 PswT+2ujqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRrSmMdYqnTl0Q2b3maYB6
 YiyL69kDTOGuPAc/Nb7dedG5WEr9lfoSXpNpbPe/5ft/XWYSYLp8FWPDwd+Cs6w6ygTkJk2uuMD
 ksSxV8d0e/W0mVlbrW+Lrqu/5zHkc/fpxl+GLEIvaDa98FgUBAA==
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

All drivers have been converted to the atomic_create_state callback
and its drm_atomic_helper_bridge_create_state() helper.

Remove the deprecated drm_atomic_helper_bridge_reset().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 23 -----------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index b99dedbc4140..29b2667ac792 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -903,33 +903,10 @@ void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 
-/**
- * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge state
- *				      to its default
- * @bridge: the bridge this state refers to
- *
- * Allocates the bridge state and initializes it to default values. This helper
- * is meant to be used as a bridge &drm_bridge_funcs.atomic_reset hook for
- * bridges that don't subclass the bridge state.
- */
-struct drm_bridge_state *
-drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
-{
-	struct drm_bridge_state *bridge_state;
-
-	bridge_state = kzalloc_obj(*bridge_state);
-	if (!bridge_state)
-		return ERR_PTR(-ENOMEM);
-
-	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
-	return bridge_state;
-}
-EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
-
 /**
  * drm_atomic_helper_bridge_create_state - default &drm_bridge_funcs.atomic_create_state hook for bridges
  * @bridge: bridge object
  *
  * Allocates and initializes pristine @drm_bridge_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 68c685ad330f..34a599c3d86d 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -104,7 +104,5 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge);
-struct drm_bridge_state *
-drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

