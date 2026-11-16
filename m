Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA4606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFmXEw50
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061F710EDA8;
	Mon, 16 Nov 2026 10:31:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E8510ED7C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4013414A2;
 Mon, 16 Nov 2026 10:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B5C1F0092A;
 Mon, 16 Nov 2026 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825098;
 bh=BFTz8j9I1oP4jWbFG4RWd9aapoMhFvIa9NTIa899S0Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NFmXEw50If152Mv5owo7kHnuRUXc4nsSqvl9N+Ot7HGLigXhX4cVGvO9o9f4PUV77
 O3I/UOuMekV97fYZ2AICmkUkCjlvnuE5vQMNUupOgvEeUUKvUWYyh/crmyJufW1cnw
 UWaVT1rEyh/YHD+DMlreX7pRy+fCXcM+Qs/qwByzyTN0VoTd/XGvfii00w1iPiMlZE
 p6pt2v/HzFelZDF0tXYnz1jKpb7kGPnbalXrBecRwJwQh6yBqPZ/Sdwj5lOkculfOR
 ZygVNcjN887ycO3sT15RmAjLNdfb6Zqg9EUogJncHuoE531u+zjwCsX9YghOtfhWbF
 bH5fLHync/dXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:29 +0100
Subject: [PATCH v2 13/64] drm/ingenic: Move the private object creation
 before the reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-13-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2930; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YXCDfjEDBNiU11YDtCcUeZsNmdebGWgFzFNobJl32ro=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brv+erA/5OHD2UrKoX/lzLyfajAJ7Xlz8XLDIRlXp
 XlaARzJHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiwqsY6yuOdM+sWHKkqWYf
 y910t+6cpDOrT72W3nc77qb1tLjOOSKLs/Smp/ZmCrq6lv/ZMl95IWO9V+vDXZEL51lav90uOGX
 y9Yr2LVP+VS5nbBJeZyXwS7xjq1Hy6/jtpx9nnLNeXXi7ZecvAA==
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

ingenic_drm_bind() calls drm_atomic_private_obj_init() late in the
bind sequence, without checking its return value.

drm_atomic_private_obj_init() registers the object on the
drm->mode_config.privobj_list and then allocates its initial state
through the atomic_create_state hook. If that allocation fails, it
returns an error but leaves the object registered with a NULL state.
Since the return value isn't checked, the probe would continue and
the first atomic commit would then crash in
drm_atomic_get_private_obj_state() -> ingenic_drm_duplicate_state(),
which does a kmemdup() of that NULL state.

Check the drm_atomic_private_obj_init() return value, and move it and
its drmm cleanup action before drm_mode_config_reset().

This will also be needed when drm_mode_config_reset() gets replaced
by drm_mode_config_create_initial_state(), which creates the initial
state of the drm_private_obj instances registered so far: the private
object will already have its state by then, so
drm_mode_config_create_initial_state() will skip it.

Fixes: 8e46b1ebf3704 ("drm/ingenic: Switch private_obj initialization to atomic_create_state")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-199703@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 625ec76cf04d..6acb7d2f25b9 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1352,10 +1352,20 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	if (ret) {
 		dev_err(dev, "Failed calling drm_vblank_init()\n");
 		goto err_drvdata;
 	}
 
+	ret = drm_atomic_private_obj_init(drm, &priv->private_obj,
+					  &ingenic_drm_private_state_funcs);
+	if (ret)
+		goto err_drvdata;
+
+	ret = drmm_add_action_or_reset(drm, ingenic_drm_atomic_private_obj_fini,
+				       &priv->private_obj);
+	if (ret)
+		goto err_drvdata;
+
 	drm_mode_config_reset(drm);
 
 	ret = clk_prepare_enable(priv->pix_clk);
 	if (ret) {
 		dev_err(dev, "Unable to start pixel clock\n");
@@ -1399,18 +1409,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	if (ret) {
 		dev_err(dev, "Unable to register clock notifier\n");
 		goto err_devclk_disable;
 	}
 
-	drm_atomic_private_obj_init(drm, &priv->private_obj,
-				    &ingenic_drm_private_state_funcs);
-
-	ret = drmm_add_action_or_reset(drm, ingenic_drm_atomic_private_obj_fini,
-				       &priv->private_obj);
-	if (ret)
-		goto err_clk_notifier_unregister;
-
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "Failed to register DRM driver\n");
 		goto err_clk_notifier_unregister;
 	}

-- 
2.56.1

