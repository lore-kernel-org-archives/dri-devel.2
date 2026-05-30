Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B411CD6E55
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFACE112821;
	Sat, 30 May 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OlUF3+M2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4494811281A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC61B600BB;
 Sat, 30 May 2026 14:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4401F00893;
 Sat, 30 May 2026 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149686;
 bh=hiYFl4SFUWvuwJNnaJSpvPIik2l7jcco5rcBEQKI+94=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OlUF3+M27nx/GoE7cQJyIz45FXKVjtErpeTnEZi8t1wkE2Kr1UhcKl4tIZWheA6JW
 0w+4HQDnqBAAWK+cODZpo9kcSJVUCTiyYySGq2X9P/Su+nnTCbHCOFV+Ytifxc5qTy
 dwCVUTdeMLHX9JVe76pavfS6ar2FgSNdraA4rp8KDLwTOdnV9FX+QRz/ZgGPlOR0SE
 iQiDQeGoJGjcoSYgfzkbkJL8H5aHJKuvgsJ4DGI3nw+405EYrFDwo3HiYlbRQxiF3l
 hhW4AbACfFC5jrq2s1fMvZ9DkgY5Xl8R7/hM7uVQyCpwIUj0D9HYb0jsLEnooy6vwp
 T7AUcq1m40m/Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:39 +0200
Subject: [PATCH 34/76] drm/bridge: dw-mipi-dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-34-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wbvxscuc2OyDmMun+jvDV695tH8AFS+7FgMngmU9B6o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb12ypmhEfVfbbS1Yef/csimhO484tD6Z/n5p09NI+
 S19IisLO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFi1irK8TEcivK0iOs71v
 vPdsEet7lqv7ftz1dpCe2SjJcX/Nrz/rFrvNkniuW6m3ab/htcmHpjLW1yn/3sQ27ZTVpcala4p
 D7dseeyovrOtN6/HlDXTxUYs2b9s0MTlqx7ajlzfbe7wTWMEAAA==
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
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index af176e136f85..5dd475fcaacf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1093,11 +1093,11 @@ static int dw_mipi_dsi_bridge_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = dw_mipi_dsi_bridge_atomic_get_input_bus_fmts,
 	.atomic_check		= dw_mipi_dsi_bridge_atomic_check,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= dw_mipi_dsi_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi_bridge_mode_set,
 	.mode_valid		= dw_mipi_dsi_bridge_mode_valid,

-- 
2.54.0

