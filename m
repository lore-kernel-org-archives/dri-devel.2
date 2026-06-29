Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1043AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B4A10E753;
	Mon, 29 Jun 2026 08:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kNTAFZRn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D12710E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4F4A600AB;
 Mon, 29 Jun 2026 08:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0762A1F000E9;
 Mon, 29 Jun 2026 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721047;
 bh=jTEg1i9C6k/FQCRgSdTfcQAlG89OP2wgDOTmFHi/i10=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kNTAFZRnB8ky2ScKPgU8C/j9AxePPYKJio2e97+V1R4G6WDMGGV0ch+Z0Ma3jsZoL
 9O6r7RP2rfgiDj64en5MCmGzu6NsGaHali1vNF0VJ/o9cCcrFzJ+WkGwv2jkqX0ggQ
 OQxNL+5nM0G03QMuTk+qUc5UhFovfhbJvaZhWIwyVOovZY00qoe+TM82VZchM9FcDo
 VDS6QRFEobJlY/mS62UkMNXFuBy3C5du0W19UVkqbRLXXQjNc0sa9G+1xAVAOhV0dO
 foArRH6UujQKVz+WAnwk65m5+LrFLj8rkAVrof8owMXPslwrm++jfyw8m8b4/vE1h7
 uzWVunUiqN7CQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:01 +0200
Subject: [PATCH v4 03/30] drm/atomic-state-helper: Remove memset in
 __drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-3-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c5JbIUPj1AZJsevwerl2q2VRj8L0q2qHLlUJssw727s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWoyScRsW+DCdOs8nPzXys4tzQlLR9bjQU9tCjmXKC
 niWzEromMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABP5s4CxPuJKg36Wu3eKpk+N
 UfC36Xm7LkxWWzpPwGRTWcOnudPf33xyaHYN44aFyQYafouyknKtGRsep7jpfXqSvfT5/zRXfdu
 I9/nVIirP1Y/yKXl9s/NObQy+6vJam2/L+yvaCX4ls5SthQA=
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
index 07686e94aae0..71a02ba78f2f 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -892,15 +892,16 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
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
2.54.0

