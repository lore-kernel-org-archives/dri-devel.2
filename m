Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C6FF99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3AB10F07A;
	Thu, 23 Apr 2026 10:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/md34P7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA9010F07E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A82B260132;
 Thu, 23 Apr 2026 10:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F9C2BCB5;
 Thu, 23 Apr 2026 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939587;
 bh=Z8riGyhf3Bz4GzgecgLlN1izPrFfKBgKdgftTPMMNag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=I/md34P7N5U8/pvYGYXfRg7xgV0JpvhZCQopXZUVkQpxQydqqfu+Dvf67DKFvJVZv
 cc9P1EjbsNnuW8s9g5Ms8g+qgXTFdEiq2ooo00vSOJasPA1VD36DWZTX0TdqiBH8ix
 egCvLkQVdPCO/VGuYqbT1twAwMIpItprrGaaJufpAF7eHW5ZUOFI0hDB5swY66SAc0
 XIs7SoL93fKWujVglmjCN2ceKhmGp2+wWGuqEgsPYhdO6P49dWYViXDpRqgY/FTj0Y
 ibChMQnRfvPMxwF8RMcY2hCZkM+8uJmovRo/WPbSuIrqXvarGxrHElxcyx56y53L15
 87rD0A5D/S5yA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:40 +0200
Subject: [PATCH v2 27/28] drm/tidss: encoder: Implement
 atomic_sro_get_current_crtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-27-8549f87cb978@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z8riGyhf3Bz4GzgecgLlN1izPrFfKBgKdgftTPMMNag=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP372Xyuff6AzxpipQD5yQw7L5SilnRyrVwvPYlH/e
 SzLwyG8YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEfRJjnY4MD3O34/W3ryXD
 3t2dqZrEb1ecMKVY48bf66tPrKiUCeaKcNgsYWX6cAtT1F35K4KnGBu+X74kscND/eHq6rKYeM7
 zv++tY7e9+Hbx9/VzG3fXHAizixScMcl29smexvq/tUabTuoCAA==
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

The tidss driver doesn't really implement anything with encoders, it
just relies on simple encoders, bridges and drm_bridge_connector.

In order to figure out the CRTC -> connector association from the
hardware state, we do need encoder support though, through the
get_current_crtc callback.

Since the tidss encoders are always connected to a single CRTC, we don't
really need to read the hardware state though, we can simply return the
one we know we are always connected to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index a20d7826e3cc..7883f5ec6d41 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -92,10 +92,29 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_sro_readout_state	= tidss_readout_state,
 	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
+static struct drm_crtc *tidss_encoder_get_current_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *crtc;
+
+	WARN_ON(hweight32(encoder->possible_crtcs) > 1);
+
+	drm_for_each_crtc(crtc, encoder->dev) {
+		if (encoder->possible_crtcs == (1 << drm_crtc_index(crtc)))
+			return crtc;
+	}
+
+	return NULL;
+}
+
+static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.atomic_sro_get_current_crtc = tidss_encoder_get_current_crtc,
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
 {
 	struct tidss_encoder *t_enc;
@@ -106,12 +125,13 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	t_enc = devm_drm_bridge_alloc(tidss->dev, struct tidss_encoder,
 				      bridge, &tidss_bridge_funcs);
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_encoder_funcs,
+			       encoder_type, NULL);
 	if (ret)
 		return ret;
 
 	t_enc->tidss = tidss;
 	t_enc->next_bridge = next_bridge;

-- 
2.53.0

