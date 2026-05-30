Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4562CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054FE11283B;
	Sat, 30 May 2026 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cl6bl6Tc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C907811283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A82064356F;
 Sat, 30 May 2026 14:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4E1F00893;
 Sat, 30 May 2026 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149796;
 bh=nzkFZDz+SBJ/4UERdPZHaPmK3DSMZ26Epx7hP80Q1nM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Cl6bl6Tcww2JDvFkxCt84zP+FtiqpGV9Dq6zPy5xocJ1z8F1LuHOYRtxa5XwqdHj0
 6tt/1DDh3ueJcy5kcUphac0QME1H75SXDLnOAX5xhb8BEc4FqN5rO3UFyT/3Rl+1xx
 sGQlEnZJzfZUNWEicM/r75ELZvSUnmTpmDz4WykbxzH9pF9fpNVVDaoS1Xnd0aov5g
 0MjbUdQtuGJK7JtozgX2Dnu7F4qVpDmJ4XqdeLM7TFkSwkX/+sat+/adHB3NToMiSF
 meHqHrJb/Usp7hQRjxjTjA8PhvVA5jJaYUyre4lvEXrI2LwsOz2tsjePqOoAYfaXSX
 ByWI0Z7bt7RSw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:20 +0200
Subject: [PATCH 75/76] drm/bridge: cdns-mhdp8546: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-75-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YMrFwUG6LPHgD6DaLNQxFv6edGHrubYA/yThIElRHBU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb8NYUxqvHzonxzlNaMbyN5djJ6Y2MPZFsub9Tfx1+
 nDoAsGAjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR82LG+gixtS2Hkm48dWdY
 Gbtnwk5G73eCz5gD9yT7+zZEbrTS17nz5OQ/cyHx3ZP1Nl9bt7Z5JmPDXfb2MMYXmSdaJh5h/pv
 Qm+LnuI6R4Zj9zyJRRYuNNyU4nJlWfddZd3jeM1vm388ZeoIB
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

The cdns-mhdp8546 bridge atomic_reset implementation is semantically
an atomic_create_state: it allocates and initializes a pristine state
without side effects.

However, it returns NULL on allocation failure instead of an error
pointer.

Switch to the atomic_create_state callback, rename the function
accordingly, and return ERR_PTR(-ENOMEM) on failure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 063f073034c1..504a3186ebb3 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1919,17 +1919,17 @@ cdns_mhdp_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 
 	kfree(cdns_mhdp_state);
 }
 
 static struct drm_bridge_state *
-cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
+cdns_mhdp_bridge_atomic_create_state(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_bridge_state *cdns_mhdp_state;
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
 
 	return &cdns_mhdp_state->base;
 }
@@ -2049,11 +2049,11 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.atomic_check = cdns_mhdp_atomic_check,
 	.attach = cdns_mhdp_attach,
 	.detach = cdns_mhdp_detach,
 	.atomic_duplicate_state = cdns_mhdp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = cdns_mhdp_bridge_atomic_destroy_state,
-	.atomic_reset = cdns_mhdp_bridge_atomic_reset,
+	.atomic_create_state = cdns_mhdp_bridge_atomic_create_state,
 	.atomic_get_input_bus_fmts = cdns_mhdp_get_input_bus_fmts,
 	.detect = cdns_mhdp_bridge_detect,
 	.edid_read = cdns_mhdp_bridge_edid_read,
 	.hpd_enable = cdns_mhdp_bridge_hpd_enable,
 	.hpd_disable = cdns_mhdp_bridge_hpd_disable,

-- 
2.54.0

