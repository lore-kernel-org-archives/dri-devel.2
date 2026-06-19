Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07A2CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51CC10F561;
	Fri, 19 Jun 2026 12:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l9JCx4fA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B2110F55E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:24:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BC9F40B34;
 Fri, 19 Jun 2026 12:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFAB1F000E9;
 Fri, 19 Jun 2026 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871892;
 bh=VPZVYhHP/cQ1eBlDVji/7lDyhA+z5kEhrgakhUfzrRc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l9JCx4fAiYymh4hD7umi4wzYss6IH80dlhokMVaHtlT737O5J4sb3OBVUGVcAwmGU
 uo0THx7vg9sC04UlSXDFuKVsW3xLU3UQv1JTdBYjv4AsJq40nhqm+9xQq+yfhae88C
 a9HtYiJ+BTYZ6DiW6M5NIN31HCcfNwCPpDQvTNuuBaVWqkSjqd6Ve6ZMs+cMPl15bh
 cml7vPy8cQ6YcavKeRF5jhNy1mYe1j95mIhJj/3/rNTvsonn8Iyt2losfVFW2HxrLs
 YsTvhE7PsZlcUN7prffbAdNTtipBC93ayhj6ybmhVGLoLXY56dc175BacVHp9w0+hx
 RrehKA6yyLP0g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:07 +0200
Subject: [PATCH v3 02/78] drm/bridge: cdns-mhdp8546: Return an error
 pointer on allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-2-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=mripard@kernel.org;
 h=from:subject:message-id; bh=o2xDCWjW1twhK//6pjmakyXETwNE5DYET5omRyvihwM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJq+aN4qd2+J+ge1v8Jp5PzWe5KpKP4nbOEVL+vdZW
 Zlph61DOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEzDoZG27v01NMXLXk1PYu
 JdbcLS9fL71qoJL1NpH92aKrzhu/NX6I2TfnmobptUj7oEUu/j6nlBgbZuvvtLgobiYe2qK4dMe
 HE8ln55tPffRkpyPT9qIM05uLl5QsXTfLNPK584mviu/jL2yaBwA=
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

The drm_bridge_funcs.atomic_reset documentation states that the hook
must return either a valid drm_bridge_state object or an ERR_PTR().

The cdns_mhdp_bridge_atomic_reset() callback returns NULL when the
allocation of its state fails, violating this contract.

Return ERR_PTR(-ENOMEM) instead.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71fe04..46779b49545b 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1925,11 +1925,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_bridge_state *cdns_mhdp_state;
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
 
 	return &cdns_mhdp_state->base;
 }

-- 
2.54.0

