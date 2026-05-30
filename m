Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4451ECD6E55
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA32E112809;
	Sat, 30 May 2026 14:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VJFSOEhX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A81710E370
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E29660154;
 Sat, 30 May 2026 14:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4262F1F00899;
 Sat, 30 May 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149632;
 bh=la1wXL0MpUf/jb0mCcXgYFvOUBl3cwpOa3EkWLAE2ic=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VJFSOEhXRB/L0N9VPMVnw0rWSkdJpG+k2RH7sH5zDJdorYeMljQ6p6UFxsK01X0rD
 n5u+9HtDk+/hwEItDK8+WqmNEkDaN4/eFNDmVoTZKUvXlLN31cmu5nG6QRWfmy4QTr
 aSby4NCnXQAuQM2h258HbeThAllbT2jvr3FdiRQOdgJF2EtBL3LWZLsBq+SKwenQCA
 s1gtMAVuOa+9RvFB6IMJOV9y6chgNcevyeCufIao3TVgw7PpiwmtypUaQ/cFTyzYES
 hL8fRmOF0ke8waLG19Blp7sgITcgPJWL+xRzB3tb4/fS2wwSSMAf/ec7iKLrwmtKTk
 eeeV4NraX4XCQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:19 +0200
Subject: [PATCH 14/76] drm/bridge: imx8qxp-ldb: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-14-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4w/t/3x1vOEbJrJK9fobc9qUEiptQgAGLTiSTxIPA3Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb60jBW5eePW4QemHFddUvb9n0/MYOrwVr0rt+H4t1
 4xn4RnfjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRneqMDR8+Tfw1TTK+6+op
 HQ9T/7PH2fROT5wX89S/Ppt5+qNtPt1VZgVbFj74X6Nx1kjj0KE0T8aGbycnyPq36ZkVcivrGXK
 mfPtVURt/ZoZp/rwMXt6Jh770mCixbNz79BKT0i27gG0uX+cDAA==
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Liu Ying <victor.liu@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
index a7906314ade1..1c71697a2083 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
@@ -402,11 +402,11 @@ imx8qxp_ldb_bridge_mode_valid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs imx8qxp_ldb_bridge_funcs = {
 	.destroy		= imx8qxp_ldb_bridge_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.mode_valid		= imx8qxp_ldb_bridge_mode_valid,
 	.attach			= ldb_bridge_attach_helper,
 	.atomic_check		= imx8qxp_ldb_bridge_atomic_check,
 	.mode_set		= imx8qxp_ldb_bridge_mode_set,
 	.atomic_pre_enable	= imx8qxp_ldb_bridge_atomic_pre_enable,

-- 
2.54.0

