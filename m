Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C42C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4610E47D;
	Fri, 17 Jul 2026 14:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c8td4nUK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE1910E47D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9728C43EEB;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E311F00A3D;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298742;
 bh=9e3obeHSY8HRaZ6EcfLjnYIVQchvEOlgGb8kG32Ajkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c8td4nUK7DFtkSGo+eOM1wpgNsRE5Vge+fb6YkTM6Fyfg0QayTXHYNwnOoSKsiK3x
 WvoKYoq8qh0iSFfXStsANMmjcvRngKDYQJqfllIk1UmymlN1EpJhMJO1uviplU8fn1
 UW30ONCjhE1u+CM45O27/Q3Ktag4rLnglHuA39+ZFL7LjL1JgIRyDT6IFV893UBVhm
 NHIOUpqNsZXdLbreP/8U9MYh1kzyimEl3g/3Aaet8gX82jhdGVjILKuPJOPRpzX5ya
 lXxQDvUJhquY7pL74r7/3tyEIb2s0Ixo6f/jxHjXi+OJzNpGQiU7T2hcEFTwdn3e4f
 zgkqKfz+L+eVQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkjbw-00000007cDD-0oss;
 Fri, 17 Jul 2026 16:32:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe failure
Date: Fri, 17 Jul 2026 16:31:18 +0200
Message-ID: <20260717143119.1815106-2-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717143119.1815106-1-johan@kernel.org>
References: <20260717143119.1815106-1-johan@kernel.org>
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

Make sure to drop the i2c adapter reference on probe failure (e.g.
probe deferral) and on driver unbind also if a devicetree redundantly
uses the 'ddc-i2c-bus' property to point to the aux ddc bus.

Fixes: cc5a3fc041f0 ("drm/panel: panel-simple: Stash DP AUX bus; allow using it for DDC")
Cc: stable@vger.kernel.org	# 5.15
Reported-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index aa27d6cd932e..ac815729aa83 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -831,6 +831,13 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	return 0;
 }
 
+static void panel_edp_put_adapter(void *_adap)
+{
+	struct i2c_adapter *adap = _adap;
+
+	put_device(&adap->dev);
+}
+
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 			   struct drm_dp_aux *aux)
 {
@@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 		if (!panel->ddc)
 			return -EPROBE_DEFER;
+
+		err = devm_add_action_or_reset(dev, panel_edp_put_adapter,
+					       panel->ddc);
+		if (err)
+			return err;
 	} else if (aux) {
 		panel->ddc = &aux->ddc;
 	}
@@ -889,7 +901,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	err = drm_panel_of_backlight(&panel->base);
 	if (err)
-		goto err_finished_ddc_init;
+		return err;
 
 	/*
 	 * We use runtime PM for prepare / unprepare since those power the panel
@@ -936,9 +948,6 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 err_finished_pm_runtime:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-err_finished_ddc_init:
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
 
 	return err;
 }
@@ -982,8 +991,6 @@ static void panel_edp_remove(struct device *dev)
 
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
 
 	drm_edid_free(panel->drm_edid);
 	panel->drm_edid = NULL;
-- 
2.54.0

