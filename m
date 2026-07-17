Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D647C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B8C10F58A;
	Fri, 17 Jul 2026 14:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TCtKBw7W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A33210E47D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:32:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABD7C60A59;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCC91F000E9;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298742;
 bh=EWJ6GGiCe+HmzuKwuv1zPKCZtQLuNomeRk/0qeAVPxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TCtKBw7Wd/yj5F+ULu9tBSU6+NyHSFDIh4edpYvBVlEk88YPz1ihn4hdIeeKP6Vhf
 LhKhKDcq7HXEkCkC5ubC9jSS3tvjdbr7POHjhzY9n04o/wdMkzRzRzlrWEoyioAxfp
 C2L+unCba2r/ae6cl679PNBIPFuZomMvQ7THtpyyZDwXrb8AIT10df3InvGR/9Njnl
 xSWhHlhbg9L7sxed0m4tJ0WcPNaHm5gHInBuD7XqyL58Dxib5BzpaK6rWt4TpA4Cal
 pgNYGsx/SEbYjdHcrUpoNBzEFsO9bnvny70wuLjEbMeRfUQ/L520xKvS9a0sD6GkNd
 qvS/wDOfd08Tg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkjbw-00000007cDF-0rVX;
 Fri, 17 Jul 2026 16:32:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] drm/panel-edp: take i2c adapter module reference
Date: Fri, 17 Jul 2026 16:31:19 +0200
Message-ID: <20260717143119.1815106-3-johan@kernel.org>
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index ac815729aa83..522bc665a11a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -835,7 +835,7 @@ static void panel_edp_put_adapter(void *_adap)
 {
 	struct i2c_adapter *adap = _adap;
 
-	put_device(&adap->dev);
+	i2c_put_adapter(adap);
 }
 
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
@@ -880,7 +880,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
-		panel->ddc = of_find_i2c_adapter_by_node(ddc);
+		panel->ddc = of_get_i2c_adapter_by_node(ddc);
 		of_node_put(ddc);
 
 		if (!panel->ddc)
-- 
2.54.0

