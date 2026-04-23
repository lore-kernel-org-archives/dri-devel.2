Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB8F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C77410F063;
	Thu, 23 Apr 2026 10:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qLVV4Zrc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB0610F063
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EDD5443F1;
 Thu, 23 Apr 2026 10:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C0FC2BCB2;
 Thu, 23 Apr 2026 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939519;
 bh=8+FNfWxwQ20fsMj5oozQYABCMKlCSVOCkN7bV3C8s+Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qLVV4ZrcJJxIgxMUb/6u1Gu7N79KI9Tq/0WROokKjlgzk+lqesIilRSmr5kXosD2G
 pV1ge5ZGwF2eLWpLVAMBUy/6jp6g9ZgwPzRhvH3HHJawZBooG44VCDUOLpBpMvGN0c
 1SXPSRW1ZR4jZN7Yug48R4jLiuGUvfRehira1iYmXbmKjM2bDNPQUp72s2mqiaRVoq
 0xH5PRFtS+Y7Iyu8e8VidjUw1CF+2UCzXcL7w7ETBmFBLj/FgZ5vIJp3EUHooutaCR
 dL83HavpzumGf2lSFb29Z8WlScQlsQ1OqsCkIiSa0mejRMKMINoNNFxpfKNcaIXOxa
 V/DvHCVUpbpNQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:16 +0200
Subject: [PATCH v2 03/28] drm/atomic_state_helper: Remove memset in
 __drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-3-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8+FNfWxwQ20fsMj5oozQYABCMKlCSVOCkN7bV3C8s+Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP778b9bYW8IdkJB7+PA1p9LbcvXfFvqWrFZsrm4sm
 9k4V0G/YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkxhrGWuHjPWvl3s/yWB94
 /uTCbbXbmu7dboiwZj/2103SSWLLAS83+bxnp7oPXu3K2+e42/15DGMNd/G8wvwJAYHVp1i+Lg+
 0lnroyhI4YU1kcwiXzJ8OjpcB2i+2LS549lrh/t+fewOXr98IAA==
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

The general consensus is that reset helpers shouldn't call memset
directly because the object it initializes is supposed to have been
zeroed out.

Remove the memset call from
__drm_atomic_helper_bridge_reset() and document the expectation.

It should not have any impact on the current code base since there's
only two callers: drm_atomic_helper_bridge_reset() and
cdns-mhdp8546-core's cdns_mhdp_bridge_atomic_reset(), both allocating
the object using kzalloc_obj().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index c7eb3ce8c282..1a6f55329fee 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -952,15 +952,16 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
  * @state: bridge state to initialize
  *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
+ *
+ * The object @state points to is assumed to have been initialized to zero.
  */
 void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state)
 {
-	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
 

-- 
2.53.0

