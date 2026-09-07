Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF16FC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1F510E4D1;
	Mon,  7 Sep 2026 13:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OfGfckfx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1AE10E4D9
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4DA460AB5;
 Mon,  7 Sep 2026 13:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF31B1F00A3A;
 Mon,  7 Sep 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787452;
 bh=ODMnJcGBI+J6E4khSQo1GD4vsv4tOSf0QwXd7nG8WNs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OfGfckfx0+D/zJSHNhTKoabY/4Ga++WBeEPeAWGP7OpdJ+bLgvlTX9h5sshLapdRt
 0gY5wz5r4p2Sn/bf4wlanqFOwF4x32I/RRgjLtcK8zcrl0JycJ5OPx/1uJMZqGnFcL
 LaAVr5hO3c2tBiXM2HEENm2UDlReD2WVY1uIK57FGzQ7i5frGRNSQCJtYVTXfSoLM5
 53lNpWN7xXwRRIX0ZbGpjpODXgfbIiMRLYPwuq7Y9aF9CDOYUGfPha6+cAFIwIJxjr
 kbLPJ4lG9nFdZZoS1A1XhGpyrhd9L9CQZL+wKSXM3Ou49VJQo///G7EayNmxSXTVdW
 aKManA8fRPXkw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:39 +0200
Subject: [PATCH v5 03/33] drm/atomic: Convert drm_priv_to_bridge_state to
 container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-3-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Io7EXAvwCtQkGEQZkpo7yBkj1w1gisR4JI8ihisGItA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdt0/l2bMpqL1OCYp+sUzqYPO3i96snV9wxvKg0/ff
 th0Pte8YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEZBpjw8q/m0pOtt5bxMp7
 6Mbz02VatSsOm/7YlL7X6T3vrRM28Zd/uTbH6U1Kl41pkZnO/3jTKsb6sjmzeO1r3qiHnxT3DuT
 Wt/U/8KpsXvK2kx+2zlczPK+z4FC1Ql3FhurX0vIHU4XWF7YDAA==
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

container_of_const is more flexible than container_of when
it comes to mixing pointers constness. Switch to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 1d05d5d7162e..def18b60a106 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1379,15 +1379,12 @@ struct drm_bridge_state {
 	 * @output_bus_cfg: output bus configuration
 	 */
 	struct drm_bus_cfg output_bus_cfg;
 };
 
-static inline struct drm_bridge_state *
-drm_priv_to_bridge_state(struct drm_private_state *priv)
-{
-	return container_of(priv, struct drm_bridge_state, base);
-}
+#define drm_priv_to_bridge_state(priv)		\
+	container_of_const(priv, struct drm_bridge_state, base)
 
 struct drm_bridge_state *
 drm_atomic_get_bridge_state(struct drm_atomic_commit *state,
 			    struct drm_bridge *bridge);
 struct drm_bridge_state *

-- 
2.55.0

