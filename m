Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF7FC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CC510F30A;
	Thu, 16 Jul 2026 13:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fjcj0wKU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5559710F30A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D905406C3;
 Thu, 16 Jul 2026 13:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203D01F00A3A;
 Thu, 16 Jul 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208174;
 bh=L+Qfhlq4xwysPexdfFJf5KIJTB/NMjzfR9VynMGaWqM=;
 h=From:To:Cc:Subject:Date;
 b=fjcj0wKUz8w3+KPlGVgy0Ru6AC7j48ae9oMTowGt5qUtD5GnO/uwkfONNgUV+E+4B
 IW2UW4PM1wVZ649TqxO9PYzUVcUJ/QPQc6iVTjF7ckaGvaTs3AnE4TBd9LKHKWXBYh
 uu9ET/pBVZrSC+nCNUI4V3MMFDtIgmvivzs3/L5eKusGwJIGwE3NkJ9VOEaCvboVkR
 THVCu/M6Oc/UfYqalJnITGB7KZbJc60UbBuryWTtqqTNvtMbuIkH15c21p7tDg0q/3
 3YFYAF3V//MBJhtJ0lkjFHhnoqDuRSHXp2NNj2TCffFzJWm9cIa424wvj3Q/mfW7r6
 7g+o46uPldVKg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkM39-00000006ZA5-3s56;
 Thu, 16 Jul 2026 15:22:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Douglas Anderson <dianders@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] drm/panel-edp: take i2c adapter module reference
Date: Thu, 16 Jul 2026 15:22:45 +0200
Message-ID: <20260716132245.1565121-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index aa27d6cd932e..1606b50513d1 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -873,7 +873,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
-		panel->ddc = of_find_i2c_adapter_by_node(ddc);
+		panel->ddc = of_get_i2c_adapter_by_node(ddc);
 		of_node_put(ddc);
 
 		if (!panel->ddc)
@@ -938,7 +938,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 	pm_runtime_disable(dev);
 err_finished_ddc_init:
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
+		i2c_put_adapter(panel->ddc);
 
 	return err;
 }
@@ -983,7 +983,7 @@ static void panel_edp_remove(struct device *dev)
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
+		i2c_put_adapter(panel->ddc);
 
 	drm_edid_free(panel->drm_edid);
 	panel->drm_edid = NULL;
-- 
2.54.0

