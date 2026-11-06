Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20E606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKeNrXOJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D79210E9FF;
	Fri,  6 Nov 2026 13:14:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C66810E3BC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14317403B8;
 Fri,  6 Nov 2026 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696241F0089F;
 Fri,  6 Nov 2026 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970886;
 bh=DpfPGjSisl2kh3YcX2NC4/1RMR+84fhFf+0ep5c/5rM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AKeNrXOJUxno5qTXomDCCdTlpPwYXtYNLuRkSXqAKFee7dckTh0ce49QiFdBakFLU
 njhPi3Y1N/lFATe+ZJbkMSL15UyNsMvnhlGRbpftY8zBqKSPAPQffsMX+Hgf3R3S8D
 K7OlXFJcA8ulgtjACZ3oyGaIKShGAb1lnuiswpwbsA+4WlFM3U5mY1gECrrum1sHjV
 SF8Fz+OHl2UHro9bw5QfRQTcUembxkV8X/PfNRx1SuBdnq8roQLla2+3kWS5UaGIfi
 n9inac7StSc9hshqf6vYgPGdM/o6KWRPCtp42m49IRomKE+St3hZbwAr5d+kj6P2tw
 coOnYbKnrjawg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:14 +0100
Subject: [PATCH v8 01/39] drm/ingenic: Convert to devm_drm_bridge_alloc()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dfSjFnNRd5Ny2meNQ6LQG2lYj3olzofKK1qwaOV6C+Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL62Ni7fl1bos983zCc954z2KblFJ4uV6W15LC9jd3
 7It3fBFx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI3WLGWqlPMx5pewv2hxps
 liq846L85uXE1uh7r6es7+I7dvePR65nd0KE8+a3HHWTeGu04nncGRuen+K8cvlCxIM1+cwF5+W
 O2PztYg59y/MsRdV00dI9pofqTjOGHgxZnfY2SKFvTusxpXwA
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

The ingenic driver allocates a structure holding both the DPI encoder
and the source bridge of its pipeline, and allocates it as a whole
through drmm_encoder_alloc(). The bridge is thus not known to
devm_drm_bridge_alloc(), which drm_bridge_attach() already warns
about.

The bridge private object also gets its name from the devm bridge
allocation, and drm_bridge_attach() will soon report a failure of
that initialization instead of ignoring it, so a bridge allocated any
other way would prevent the driver from probing.

Allocate the structure through devm_drm_bridge_alloc(), making the
bridge the primary object of the allocation, and initialise the
embedded encoder in place with drmm_encoder_init(). Both objects
stay in the same structure, so the container_of() conversions keep
working, and the bridge funcs assignment moves into the allocator
call.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Paul Cercueil <paul@crapouillou.net>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 63198fd59498..8cad8dcfae60 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1304,18 +1304,25 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		}
 
-		ib = drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
-					NULL, DRM_MODE_ENCODER_DPI, NULL);
+		ib = devm_drm_bridge_alloc(dev, struct ingenic_drm_bridge,
+					   bridge, &ingenic_drm_bridge_funcs);
 		if (IS_ERR(ib)) {
 			ret = PTR_ERR(ib);
-			dev_err(dev, "Failed to init encoder: %d\n", ret);
+			dev_err(dev, "Failed to allocate bridge: %d\n", ret);
 			goto err_drvdata;
 		}
 
 		encoder = &ib->encoder;
+
+		ret = drmm_encoder_init(drm, encoder, NULL,
+					DRM_MODE_ENCODER_DPI, NULL);
+		if (ret) {
+			dev_err(dev, "Failed to init encoder: %d\n", ret);
+			goto err_drvdata;
+		}
+
 		encoder->possible_crtcs = drm_crtc_mask(&priv->crtc);
 
 		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
 
-		ib->bridge.funcs = &ingenic_drm_bridge_funcs;
 		ib->next_bridge = bridge;
 

-- 
2.55.0

