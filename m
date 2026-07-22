Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3402C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4041910EBE7;
	Wed, 22 Jul 2026 00:59:31 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D460410EBE7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:59:29 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmLIy-000000000yY-1plf; Wed, 22 Jul 2026 00:59:24 +0000
Date: Wed, 22 Jul 2026 01:59:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v4 2/5] drm/bridge: it6505: disable runtime PM on remove
Message-ID: <59d6066b37a33878c8673bf1659e16fd2624cae4.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784681487.git.daniel@makrotopia.org>
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

it6505_i2c_probe() enables runtime PM but it6505_i2c_remove() never
disables it, leaving the device with an unbalanced disable depth
after unbind. Binding the driver again then triggers the "Unbalanced
pm_runtime_enable!" warning.

Disable runtime PM in remove() after all work items have been
cancelled (the extcon work calls pm_runtime_get_sync() and
pm_runtime_put_sync()) and before powering the chip off manually.

Fixes: 10517777d302 ("drm/bridge: it6505: Adapt runtime power management framework")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: new patch

 drivers/gpu/drm/bridge/ite-it6505.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7873ae6df3af..2a8298ee6c03 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3655,6 +3655,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
 	cancel_delayed_work_sync(&it6505->hdcp_work);
 	cancel_work_sync(&it6505->extcon_wq);
+	pm_runtime_disable(&client->dev);
 	it6505_poweroff(it6505);
 	it6505_remove_edid(it6505);
 }
-- 
2.55.0
