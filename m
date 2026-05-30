Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6CFCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A27112840;
	Sat, 30 May 2026 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W8jyXIR1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712D411283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A0BF43621;
 Sat, 30 May 2026 14:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A361F00893;
 Sat, 30 May 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149799;
 bh=FSRadvpeVyPPcnj0pD1SN9sml2imDuTeAxNig6IYNSE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=W8jyXIR10pkHdlo1Q477BbGMuyrCxEp4B8pvTjAjM5+fL/5qBzN9X1u98QfZkI8j7
 0p61/GVjKld0JJnZGDpkIchaBxIl0vEXQCSlku+80yMnuO54ub9Gz51lksgSZhsWjy
 SQUn8wSOne4wQrFVoHfLRIaTaglID+ycsWegvXbOcPLV0730JQnin776KHRpW786l3
 ViNL2vAXvxF6ksQhI22xdloVwKASXAq/Uff6g1t4XC9gIuVEuszHqxddfdT7UmeALt
 jzS4WHvWvyCoWyww9g/JAMAjAXRY9SEcBJoUi9KpRtNyXjk4taMTk38Q0dWhJLn0VZ
 xIgZ0vb9tbJOQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:21 +0200
Subject: [PATCH 76/76] drm/bridge: Remove atomic_reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-76-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oInsdHMOSn3/YXRPS86iw2HZhohgqqouAE4/FU/4oRk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb8MezRfmeDedQXTtPtcX12o/fLbfvDf4gLfojZX+M
 U52nc+9O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE1ksxNkxyato/d4mJ69wF
 nCIRNR8s/X/ENk+qlz+p17+mfRIra4j9/nl7xYru/+NzObHpf7fgY8aG/S/FJcuf3fy/QNhpqfO
 qH1pZ0vYCwTMtLlncjI7ilzuvbK5fubXQ2erNx1IG/l0dbiEA
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

There are no remaining users of the atomic_reset hook. Remove it
from the core.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index ef06c1aa509a..945c48a985a4 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -498,14 +498,11 @@ static struct drm_private_state *
 drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
 {
 	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
 	struct drm_bridge_state *state;
 
-	if (bridge->funcs->atomic_create_state)
-		state = bridge->funcs->atomic_create_state(bridge);
-	else
-		state = bridge->funcs->atomic_reset(bridge);
+	state = bridge->funcs->atomic_create_state(bridge);
 	if (IS_ERR(state))
 		return ERR_CAST(state);
 
 	return &state->base;
 }
@@ -516,12 +513,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
-	return (bridge->funcs->atomic_create_state ||
-		bridge->funcs->atomic_reset);
+	return bridge->funcs->atomic_create_state != NULL;
 }
 
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *

-- 
2.54.0

