Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A29CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDEF10F513;
	Mon,  8 Jun 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nKz7gRKR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA8910F512
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01AAD601E1;
 Mon,  8 Jun 2026 14:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B661F00893;
 Mon,  8 Jun 2026 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929587;
 bh=+WHJyEGvk2Lr7fDEn9KhXG5naAcCmbkpg2nBZz36MqI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nKz7gRKRrBJw+mvnSt+hnx4Ae1l6EqMEQdul92aZ8GxFiF37aYR8csDNUKDc4RMAg
 w20icSuYSWfsoWpooFGkiQJSaA0SETAJ1hd0JZtlaZ7/jb6rdj0fL+KyYjKvw8jelj
 wmrzw3aM/7bHSnt0LUde4y7f7gN/8nV7XyHBN6xJEyHH3LsXyOPSzcO/cRBBZftWnk
 aipywARUF0HeKSnqkhiEQCTIOyJYCAAt4HEwaNkm8kcUNbA0ZrYtDDixznPN/7YkL/
 UHzkUl50pTdgekmIC2/cdDNzsZcBID/3g/fXDv3y7sP3orUebUoP1aiLBJ6+tdXE/V
 EGHKMaMn18+uw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:57 +0200
Subject: [PATCH v2 75/78] drm/bridge: cdns-dsi: Use
 __drm_atomic_helper_bridge_state_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-75-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rwib2BNoN6dIiY1L77gaMP9r4dcfoFscgveG/FHO6iY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql9O4znVG/GDJ5yi9XGW69632LJ1vnJN25y01KHzNs
 Ft07z6mjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARBi3GhsMfDXWYinVP79zV
 86Xmd/+X2WdD7vWf3uPU9bHjZsWcHtP+UwmtR7zdrJ8p1DwIEHqlwljNEnLq8RrWuQeO9jN8+zs
 t03P5t5zQtAmx1/7VrDzq9vnZ67Pzzi9nOy8078lz5mV+MrGJAA==
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

The cdns-dsi bridge open-codes the bridge state initialization with
a memset and a manual assignment of the bridge pointer.

The memset is redundant since the state is already kzalloc-ed, and
__drm_atomic_helper_bridge_state_init() exists for exactly this
purpose.

Switch to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 344c3f466018..ca946e755818 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1015,12 +1015,11 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
 		return ERR_PTR(-ENOMEM);
 
-	memset(dsi_state, 0, sizeof(*dsi_state));
-	dsi_state->base.bridge = bridge;
+	__drm_atomic_helper_bridge_state_init(&dsi_state->base, bridge);
 
 	return &dsi_state->base;
 }
 
 static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {

-- 
2.54.0

