Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98FC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B58B10E740;
	Mon, 29 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M728o4+U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AC810E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CBAB414A8;
 Mon, 29 Jun 2026 08:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C901F000E9;
 Mon, 29 Jun 2026 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721095;
 bh=n1iGt4xTz4i97lEvalU7jPAM+FZhshzUh8EL+IF8FXE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M728o4+UfBJtSEbBkeXFM0iD9m5VnEqSd7LJ8u2TvpSmLpKEJjSXOZl48cQphwxlL
 z23Wb3UUFQ3LKCPXrQbJZVakhf5gW/a2gUUvNiF6zJ+c2NnCILh8YL6qqG23ti67I2
 IFx9DbKfELB6gUb7+F1F83Bi3x1x1wQxKTK0wiNV20OWHX0mk8/69HtzyEYFn9oDlb
 V3CTJ/VfFHpDRkMaoFI65xMgc8tDLQJDpDKkU7bdU3iGpKJUEpHgnxp9XRLMWTelfT
 Px5Vz5SiYR9p/TY5Z429ezT0RZhceIRUZIhQKcUwUi7fmvxtCO/NvZLvh3R1cHEXwr
 z6oXMNhnfPv3Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:21 +0200
Subject: [PATCH v4 23/30] drm/encoder: Create atomic_sro_get_current_crtc hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-23-5966657980ed@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8L6ppmTbLT+zf1Ruc/qLKJbjCGaJ9TZ4sX1hs9mFmac=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWlxnNQpkvUIlUva5bNBY028ZsdZ1k1x11/T3jS5no
 3zm6KR2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInUMDHW19q/PqkmeKTBW6Gs
 dm/pv5WxUnN8Zq1cMM1v79lD3BO2TD+gc1PnifjD56olCwVmFPntZ2y43ioVVeNedU1lg/vsDUY
 G+6Q6Fm49ndZau8e4qG3JhG0HrGI2r+FoMUxce/h2yi2+WfkA
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
2.54.0

