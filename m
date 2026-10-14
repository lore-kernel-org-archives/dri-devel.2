Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C6ECC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C8C10FEF5;
	Wed, 14 Oct 2026 17:30:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F2410FF13
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 732E344781;
 Wed, 14 Oct 2026 17:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E91F000C5;
 Wed, 14 Oct 2026 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999043;
 bh=7R/UujzdlkHZUl2pa3+Ny38x0csYsO2mqxSiJYN24f8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FrjkMmiXwH1cJoO4QiT7c9Xf65Z+Hm4aEvvjoZfQOUBK6pugmTRkHBqGr9E65zslB
 l5x8Y275WLBfrK6Y91ZxzIEkBNFdEtUUHss11rNmFQCbXrS1a0k854fCQVu970HDFm
 kLfwFZMu6BGjAk92u1+IZh8TYcM4YlhJHpJ+M/kwzdo7TP/yQ4g57kLntRz49My/oR
 YjTnnqh6FOkXKyLpDZsYM+4Rv0cGgUbj6C9Qb/AgkgAR5mdIwIX7emBBVr4jaRYe+7
 v1HbOK+Jy76LFPniTMq1AxTDHQ8/ZgA+5MIBPDjezLwk06K9/5ZXCAvb+1Tj0zSRHD
 evDRqwrA5ysgQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:21 +0200
Subject: [PATCH 58/75] drm/meson: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-58-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4Aof8z3qpDFgdWxPTO9gWRMfppFmEHKKmxOj0ZdhSBA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndycnWMS83ySuzdXq3eO1r1e8OXdKn/72ezv833/f+
 +1l3CGBjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRnYGM9RHzWX+9vP/p849p
 63orMyaW5/2cnf7/mW56GjuPfNjsplibWT5KxdfSTlT+qpS24ju4i7HhsSbfmgWJMs534u4Ifrk
 7bWoEH4tES5xCkKzF5DuqF+4+kgr5qyw/c3ef0Bejlh97f68EAA==
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

The meson HDMI encoder calls drm_atomic_helper_connector_reset()
during connector creation to allocate an initial connector state
needed by drm_connector_attach_max_bpc_property(). However, the
driver only needs to allocate a pristine state, which is exactly
what atomic_create_state provides.

Convert to drm_atomic_helper_connector_create_state() with proper
error handling.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index c4355c5cc340..c04e381b2c10 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -446,11 +446,21 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
 	 * connector to have a state.
 	 */
-	drm_atomic_helper_connector_reset(meson_encoder_hdmi->connector);
+	if (!meson_encoder_hdmi->connector->state) {
+		struct drm_connector_state *conn_state;
+		
+		conn_state = drm_atomic_helper_connector_create_state(meson_encoder_hdmi->connector);
+		if (IS_ERR(conn_state)) {
+			ret = PTR_ERR(conn_state);
+			goto err_put_node;
+		}
+
+		meson_encoder_hdmi->connector->state = conn_state;
+	}
 
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
 	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
 	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
 		drm_connector_attach_hdr_output_metadata_property(meson_encoder_hdmi->connector);

-- 
2.55.0

