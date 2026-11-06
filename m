Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73044606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWZmuPMw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C934A10EE4D;
	Fri,  6 Nov 2026 13:16:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B3D10F1AC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AC89437C3;
 Fri,  6 Nov 2026 13:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87E21F0089F;
 Fri,  6 Nov 2026 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970987;
 bh=WZ7dSRSEB17YuKwMWrQ1WfiRz+rCQMp65g8eEzNUfyM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GWZmuPMw3ueGtNEvL7yfBgSyVNf1FXLX+c4p7kVutsfszaYyo5tZRmQTJB+IeVssF
 Mg/accjelTlp8kIk9mb3y7X13GyYo/DchTHUncHRoxfyL6vVALwHLN0a25EK1fPKM2
 j1WrDTffPwt0OtYCPJtjOTtE+kQ6oPwFWQto4uJI1s7yadaccqmGKk5ElA7WT49HwE
 /o/Ii6xfG2WYQAIiYoBVKof7s1fMtxR/ggE3nwl1sFnIDw4uudlYzwRJThO6N2y0MB
 0qzwyw0duo2i6e1gH5knlOZIz08tAYmZJPSN3HsSddr+3lo8HIZkMnVVdEUG79aK4i
 tlnkCHVjRApOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:42 +0100
Subject: [PATCH v8 29/39] drm/encoder: Create atomic_sro_get_current_crtc hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-29-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ovr6j9mDWoFlktNq4EaYYQbUzj/qZYUJQQAxiqnxwxM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+38u2mj4++ve4JU+tffuv5Cc6ekcLGowYedMVyzE
 qOMdHes75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+WXD2PBkokXtTBn+j3Pj
 +2fut7s+zZPBZ6e4dHzZGWuZbMPSpETf5rYpO7UZM9ruutotnSX+nbHhafmNA2fbWA8tbv+z8MO
 fN5yrlycl/Xmd/uBv34y8c/M3sET+DJxhtLeEVSZ2wnajN+tvAQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_encoder.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index eded7c34481a..7f41ec0a68dc 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -90,4 +90,22 @@ struct drm_encoder_funcs {
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
 

-- 
2.55.0

