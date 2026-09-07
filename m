Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D334C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7984E10E83C;
	Mon,  7 Sep 2026 13:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="APLt3pz2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1363010E833
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:26:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D411A447F2;
 Mon,  7 Sep 2026 13:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F011F00A3D;
 Mon,  7 Sep 2026 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787562;
 bh=SPEO8/kOBmQuC0kErJSms70HjQspFJbY8FZH7tt11p4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=APLt3pz2gfmbLqmFTLS/Fj2bGjysIKs/DcGP9e/Ma6E+QEMKOs6XwdhZwXCm+fdb0
 gxrq84o/e9W/turrjGLL9dpBmOhdvVKqETAs3ugJlLAZ5wJ95JRxP0vOjalc1D3ORI
 Vi/BpuOKSXztzZERatwLdlic4c7Zg/boUSCWj6ll5NunaeQKWKaQ5fTsssK8Zpr2pN
 QKuSd4W+ulbGkeXaDoTLkoDZcf/SWbbCAev8Zd8nJmSZr32HNcyfeoyL4WT0hShafU
 2BUqbBcEnzvpFOdQg21n3Rg3JKLGxysTEFmBLYIYj4zvynlCtokp0FYTMtN/f3umub
 YtJBUNerH+Ryg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:24:08 +0200
Subject: [PATCH v5 32/33] drm/tidss: encoder: Implement
 atomic_sro_get_current_crtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-32-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+pVbVwdlCvDiSzBb0dvHg2XJCgEw9Rk2ihi2oD0Vv68=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdr3ZuJtV7lXe0rk3p9WqLf6htFNvzjEtndBA9vzD6
 9/ot2t87JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATqZrH2LDcXvpFaPzGKsX5
 q1PClu1LmphgwJr/cxrToZl9Ya//MAqsO77mloDVtoWHNQrMBRiDShkbbpenLotYlKb6Pm45h3r
 i7qCvCvNdTuaqfFQNS+zY+8WhurZL+vmyvQeq9097U5Q04cR9AA==
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
 drivers/gpu/drm/tidss/tidss_encoder.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index cb4b8feb90d2..ec995335953b 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -121,11 +121,26 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
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
 static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.atomic_sro_get_current_crtc = tidss_encoder_get_current_crtc,
 	.destroy = drm_encoder_cleanup,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,

-- 
2.55.0

