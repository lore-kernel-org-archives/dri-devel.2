Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F8FC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107CF10E819;
	Mon,  7 Sep 2026 13:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRccdlz8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEC810E81B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3887941B74;
 Mon,  7 Sep 2026 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881111F00A3A;
 Mon,  7 Sep 2026 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787532;
 bh=P6RVTSXFTAr6ll1mx6LZ/5JjXCUD5jLSOyr03hQWT28=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lRccdlz8crZqIG9i6A0nm8cAH0808aQzN7Rsjpn+dJer15d2bMSZg8bcHTYbWdQx5
 6ZjLU2klvUX6M2T0BdNmwB8Vw+EMgjRmkKl1ZNFhQJElVUWuL5wSc7vDjIDVA+Z55S
 z2684xRIM2Qt9lXiPI5noNuFfXNms1TvDhkRM1Q5nsUvgz1u/7Yq/r8y7CLA539hkh
 imhgUJW6Xs4nbNcP4jGPebpgpeZfJfvAGW8fMx3fAR3nW2p+y1MN9us5xKLHZnN6+N
 TS9dyNsYBqQK1CdnAAx61XTJq5WeNUmm97/jW3LKY4rr4NX0F2xp87KygRDurnozK9
 JIXit+xylyUFg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:24:00 +0200
Subject: [PATCH v5 24/33] drm/encoder: Create atomic_sro_get_current_crtc hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-24-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QnW3179gOx2QMiiOb1DSxXGcDLNTFhvwAZREnJfdfoI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdr2Ye7VH0nnhbcll+wK79A9X6rHdCQwU+HwkSlbgy
 9pGli0nOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvCcz1go+iXh68c3Txz8D
 v7hGaMnOsMmd9eC/Q6Oj67WFyrl6IpJdjIfCN1Y3vtv/PZCj4GbRUcb60vTwSo5uBp2D3HfUucs
 mN1Z2vFBkfSnuq5b4t0O7Jko4vunIAZ+c19WnZU9cdJgT3gwA
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

In order for drivers to implement drm_connectors
atomic_sro_readout_state hooks, they need to query the hardware and
lookup the CRTC to set drm_connector_state.crtc.

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
2.55.0

