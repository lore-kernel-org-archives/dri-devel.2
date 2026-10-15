Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DFFCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F14210F8BD;
	Thu, 15 Oct 2026 15:10:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B0410F66E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A27040F16;
 Thu, 15 Oct 2026 15:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E691F000C5;
 Thu, 15 Oct 2026 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077027;
 bh=P6RVTSXFTAr6ll1mx6LZ/5JjXCUD5jLSOyr03hQWT28=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ToWgGUHyEln82Wwj/5LfsdkxaEuaAhQ19XlN2MPdmo48nHcnDwbxW9YsnPb4Wrnn2
 pIIefGpvrHRIWvCA8FMW/z8ri88V4wxVlomHFZlO1Lw04+73Ya3SoSe7NhYDB9uPgh
 gm3FurJ6Uc6MFXOeatL0XDRfljtNoi6yiGBq4RhH8yMqlB4d4zIonuF1j1INIoxMRa
 4vAQoTsGCLWV8Zv62GMA8oBitullCR+Mq838OvXM2406BFAMKib/duG55odXn6WLT0
 eAXsZCRWx8vXN9VFQqGZIzb7EhMwvNvrZ5YZkQ+Wf2AEIUJjw9JFp/T87YKcTBeCJx
 5yHe3ukfJSVCQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:12 +0200
Subject: [PATCH v6 20/28] drm/encoder: Create atomic_sro_get_current_crtc hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-20-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kxmeNe1XzXv+MMdjAc36MWyyX+wXWf7yOjECuHYk
 y9iOMWKOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmcCGcHEKwERCtBgb1q4/eu6J+MTPlgIL
 b4WwNfBw65v8qNn+/6H7P6ZHXyLe7ta9bH4jnOeMeoHrxaJDjTkXGBv+1obezdfgbrC6G85z6LD
 U/WzjxY2be6pSOMz1Qk8EXLh2ufKb+Kf9279OnOIczfGmzhUA
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

