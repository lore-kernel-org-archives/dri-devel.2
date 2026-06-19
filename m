Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98774CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE89410F57A;
	Fri, 19 Jun 2026 12:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k+dGAZTZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C54F10F578
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F35D2601E2;
 Fri, 19 Jun 2026 12:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B41F000E9;
 Fri, 19 Jun 2026 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871946;
 bh=JEdJ3cV/ycSxwZZkjYclNVKtLrBS4MiQcVVcJBc6cMM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k+dGAZTZGIyILJ787dG1DwQlLzaeWbYsQjPNulOdZeh09jjS9OxhAKbk2R2gfnVY3
 bq4kkVh6IcH+exsoRpih+F6oVBlkP4cYObFid/fkLpw5b/JI+j+V6NmNqySxaLDMuJ
 O3Y0JAZsC/PlHbN4qB+B+KtG0Jxczi9grtkQ08+KrhuE2q1psrKLJ6I7YmGRFn2Mhv
 fWg/gOM03/soT10BVi7bjwwKaXwOffde6677wyd3664tVkUCpbWg4gbJcXJqZHO1qc
 R3kUxz3EKH5yRM35P17y6zoDy52eyOUIIMe8R1h0E+pLFcNKCUN/MND33D8ACbX22G
 0/+m3a88Stu6Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:27 +0200
Subject: [PATCH v3 22/78] drm/bridge: ite-it6505: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-22-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BZfxGyuHU5nIL6AYmGHNphL4aLKdM2HnL+3TsXt3nIA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJp+Liq2LoyJCjjIe//PqtUFSLPOe9zYytgLcbv1qJ
 y8ynfjdMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACby6gdjw/LHJx+c2C6yPKlz
 xm6Bo2+tyxK23o36tSaCr6NUv2SKywGOE6esgy9fuvltW/idBVwfnzLWmX7c5FSuU9v9MiNp2yu
 mogeCd3Rt/k5i5z5kkCgqWRwZfNzx+zsrFbd5FuWLM5okixUB
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 6b7cb132a437..8ecb43611dba 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3237,11 +3237,11 @@ static const struct drm_edid *it6505_bridge_edid_read(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6505_bridge_attach,
 	.detach = it6505_bridge_detach,
 	.mode_valid = it6505_bridge_mode_valid,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,

-- 
2.54.0

