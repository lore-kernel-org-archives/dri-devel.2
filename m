Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F65F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379BF10F039;
	Thu, 23 Apr 2026 10:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0oxVR7c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E8710F036
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E58BA60121;
 Thu, 23 Apr 2026 10:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4310BC2BCB2;
 Thu, 23 Apr 2026 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938847;
 bh=8+FNfWxwQ20fsMj5oozQYABCMKlCSVOCkN7bV3C8s+Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=M0oxVR7c1MdKB4Xcjsm9fV21NYkn0g1Xn3LUotxaRIPDU1bJJkn0Glaz0i1Ogpykh
 R++AHwfstyQ5S4fAY6KvjkoYTX6V1Z9yGvU9d0hHMkdJInprcaFhspKi6TFJXKsDSl
 ez5bcBwXhA4z5A6O7CC28A8DWUhp5ZSdNY0qPz87BmHHcnC55O+QTAcfzr5wcdiIxD
 bTYODRuakS108nOmIzIl5tmbHBe7bUynGv27o7n7HJR1z2xUDP1xVR+d7NmGbu8OJI
 X62NWKBK/jHPKE40SNvZeE/paHbdUlM2CvRjvvsbx1dAx5N3wxwIqMmwhc+h7iPBho
 zF7hLO55GROIw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:41 +0200
Subject: [PATCH v2 03/28] drm/atomic_state_helper: Remove memset in
 __drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-3-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv37vLynV47L7Dozkh7+JUBqVbzUtKEo7Kih7fsK4j6
 e6/uC39HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAieZmM9WWsF++tZdx9fpvt
 vvStiyfdZ1/73X2ZZeq+x3YFYlfzkp0vHbxx+vHUY0vvyHzolz7OKcnY0PZzbY0+D2PuJ85SpzX
 v5r17/3B7yrdGg6kb3BpXxbz7Kv9s8qnkA/FXHwrdbrk6m+uoDQA=
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

