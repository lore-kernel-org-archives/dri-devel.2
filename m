Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED614C44520
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494D210E1BA;
	Tue, 21 Jul 2026 02:26:29 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D74110E1BA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:26:25 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wm0BX-000000000D4-2tJm; Tue, 21 Jul 2026 02:26:19 +0000
Date: Tue, 21 Jul 2026 03:26:16 +0100
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
 Allen Chen <allen.chen@ite.com.tw>,
 Hermes Wu <hermes.wu@ite.com.tw>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/4] drm/bridge: it6505: cancel outstanding work before
 teardown in remove()
Message-ID: <91b40322b07b967fcf286b3e4bd11e5f821bff1c.1784600387.git.daniel@makrotopia.org>
References: <cover.1784600387.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784600387.git.daniel@makrotopia.org>
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

it6505_i2c_remove() tears down the bridge and frees its state without
cancelling any of the driver's background work. struct it6505 is
allocated with devm_drm_bridge_alloc(), so devres frees it as soon as
remove() returns; link_works, hdcp_wait_ksv_list, hdcp_work and
extcon_wq can all still be pending or running at that point and will
then dereference freed memory.

link_works and extcon_wq are flushed in it6505_bridge_detach(), but
that only runs if DRM core calls the bridge's .detach() before the
i2c client is unbound -- not guaranteed if the i2c driver is unbound
independently of the DRM device that consumes it. hdcp_wait_ksv_list
and hdcp_work are never cancelled anywhere.

Cancel all four synchronously in remove() itself so teardown is safe
regardless of ordering. cancel_work_sync() on extcon_wq is safe even
when it was never INIT_WORK()'d, since it6505 is zero-allocated and a
zeroed work_struct is reported as not pending.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: new patch, split out to fix a pre-existing use-after-free flagged
    by automated review of v2's audio series; needed before that
    series adds another cancel_delayed_work_sync() call next to the
    ones this commit is adding.

 drivers/gpu/drm/bridge/ite-it6505.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8ecb43611dba..2f349aefb705 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3644,6 +3644,10 @@ static void it6505_i2c_remove(struct i2c_client *client)
 {
 	struct it6505 *it6505 = i2c_get_clientdata(client);
 
+	cancel_work_sync(&it6505->link_works);
+	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
+	cancel_delayed_work_sync(&it6505->hdcp_work);
+	cancel_work_sync(&it6505->extcon_wq);
 	drm_bridge_remove(&it6505->bridge);
 	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
-- 
2.55.0
