Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C96F99369
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F180910F079;
	Thu, 23 Apr 2026 10:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TsVQhUkU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B58410F076
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E4AF760125;
 Thu, 23 Apr 2026 10:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A43BC2BCAF;
 Thu, 23 Apr 2026 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939573;
 bh=uB5xmdpILRqtr7ie2wAJSDfl4DRIQL7izi7RXOkv5fA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TsVQhUkUoZathoW0Wn0YV2eikNrHH0cx9oZ2nshUi//d55NizWD711A6/gn4pkPfm
 ZYiLyFk3m1gheTDFAS1bG4F+vqwVVDOzQ8jpozHQn92y2lVrjlpbI11fifmO1EjzeM
 wgt5eWZwS2VvnLuNZuJgLIVuulg6kpQVxz9/82XdM/8pf9MeM72ZKRDzfyWw6Fsse8
 M1cLUCQqahDUYE0YkpLRhwiUzxHwoqiFDYnTfYBdxstFkrv1DyI5bQL0KRvT6rAk5E
 d1twp5pBje/HXsrLkgapwm0erLtErbpoxpk8c8yVv3fyzuqR1hVVo3Kwyg+/7CcmW/
 WUCCq8fTrqLXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:35 +0200
Subject: [PATCH v2 22/28] drm/encoder: Create atomic_sro_get_current_crtc hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-22-8549f87cb978@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uB5xmdpILRqtr7ie2wAJSDfl4DRIQL7izi7RXOkv5fA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP34U/MduUMT/avoRPx7t9LUv/71LU4zO3XCg23GtF
 FP38in8HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAimd8YG5atXvJkpW8L6yTv
 Ox2tml3zS/03mZ8QvNkfn5a6s2p1o8NEqYV5pxY8X+49x6cz18dwE2N96pWoWwt9T/a+/CS/8fX
 vz9+lr2isrb3kdymW+Xd2wdH9fRUKzOLz92yp3bGPL/3oK/e/AA==
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

In order for drivers to implement drm_connectors atomic_state_readout
hooks, they need to query the hardware and lookup the CRTC to set
drm_connector_state.crtc.

It should be easy enough for drivers that are tightly integrated from
the CRTC to the connectors, but if the driver uses bridges, there's no
coupling between the CRTC and encoder, and the bridge driver.

The only thing the bridge has access to is the encoder, but the
relationship between a CRTC and an encoder isn't a fixed mapping at the
framework level, and thus the bridge can't deduce which CRTC is feeding
its encoder.

Create a new hook for encoders to implement to return the
CRTC they are currently connected to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_encoder.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index eded7c34481a..7f41ec0a68dc 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -87,10 +87,28 @@ struct drm_encoder_funcs {
 	 * @debugfs_init:
 	 *
 	 * Allows encoders to create encoder-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_encoder *encoder, struct dentry *root);
+
+	/**
+	 * @atomic_sro_get_current_crtc:
+	 *
+	 * This optional hook is called during hardware state readout
+	 * to determine which CRTC is currently driving this encoder.
+	 *
+	 * It is needed by the bridge connector readout code to
+	 * establish the CRTC-encoder-connector association from the
+	 * hardware state, since the relationship between a CRTC and
+	 * an encoder is not a fixed mapping at the framework level.
+	 *
+	 * RETURNS:
+	 *
+	 * The CRTC currently associated with the encoder if enabled,
+	 * NULL otherwise.
+	 */
+	struct drm_crtc *(*atomic_sro_get_current_crtc)(struct drm_encoder *encoder);
 };
 
 /**
  * struct drm_encoder - central DRM encoder structure
  * @dev: parent DRM device

-- 
2.53.0

