Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A35BC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14B710EBD7;
	Wed, 22 Jul 2026 00:59:17 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02E310EBD7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:59:16 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmLIl-000000000x8-1oIs; Wed, 22 Jul 2026 00:59:11 +0000
Date: Wed, 22 Jul 2026 01:59:08 +0100
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
Subject: [PATCH v4 1/5] drm/bridge: it6505: quiesce event sources and work on
 remove()
Message-ID: <a56e30751b6660c5a7e1c4cb1d8e50581a4847dd.1784681487.git.daniel@makrotopia.org>
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

Cancelling the work items alone would not be enough: the threaded IRQ
handler and the extcon notifier both stay live until devres teardown
after remove() returns, and both can requeue a work item right after
it was cancelled. Remove the DRM-facing interfaces first, then
quiesce the scheduling sources by unregistering the extcon notifier
and disabling the interrupt, and only then cancel the work items.

Unregistering the extcon notifier on remove() means
it6505_remove_notifier_module() can now run twice, from .detach() and
from remove(), while devm_extcon_unregister_notifier() WARNs when the
notifier is not registered. Track the registration in
event_nb.notifier_call to make the helper idempotent.

Initialise extcon_wq in probe rather than in
it6505_use_notifier_module(): cancel_work_sync() on a work item that
was never INIT_WORK()'d trips WARN_ON(!work->func) in __flush_work(),
which would fire when unbinding a device whose bridge was never
attached.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * retitled from "drm/bridge: it6505: cancel outstanding work before
   teardown in remove()"
 * quiesce the scheduling sources (extcon notifier, threaded IRQ)
   before cancelling the work items, and cancel only after the
   DRM-facing interfaces are removed, closing the requeue race
   flagged by Sashiko AI review
 * make it6505_remove_notifier_module() idempotent so both .detach()
   and remove() can call it
 * initialise extcon_wq in probe instead of relying on
   cancel_work_sync() coping with a zeroed work_struct, which would
   trip WARN_ON(!work->func) in __flush_work(); flagged by Sashiko AI
   review and confirmed by Chen-Yu Tsai

v3: new patch

 drivers/gpu/drm/bridge/ite-it6505.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8ecb43611dba..7873ae6df3af 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2935,11 +2935,11 @@ static int it6505_use_notifier_module(struct it6505 *it6505)
 	struct device *dev = it6505->dev;
 
 	it6505->event_nb.notifier_call = it6505_extcon_notifier;
-	INIT_WORK(&it6505->extcon_wq, it6505_extcon_work);
 	ret = devm_extcon_register_notifier(it6505->dev,
 					    it6505->extcon, EXTCON_DISP_DP,
 					    &it6505->event_nb);
 	if (ret) {
+		it6505->event_nb.notifier_call = NULL;
 		dev_err(dev, "failed to register notifier for DP");
 		return ret;
 	}
@@ -2951,13 +2951,14 @@ static int it6505_use_notifier_module(struct it6505 *it6505)
 
 static void it6505_remove_notifier_module(struct it6505 *it6505)
 {
-	if (it6505->extcon) {
-		devm_extcon_unregister_notifier(it6505->dev,
-						it6505->extcon,	EXTCON_DISP_DP,
-						&it6505->event_nb);
+	if (!it6505->extcon || !it6505->event_nb.notifier_call)
+		return;
 
-		flush_work(&it6505->extcon_wq);
-	}
+	devm_extcon_unregister_notifier(it6505->dev, it6505->extcon,
+					EXTCON_DISP_DP, &it6505->event_nb);
+	it6505->event_nb.notifier_call = NULL;
+
+	flush_work(&it6505->extcon_wq);
 }
 
 static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
@@ -3615,6 +3616,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
 	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
+	INIT_WORK(&it6505->extcon_wq, it6505_extcon_work);
 	init_completion(&it6505->extcon_completion);
 	memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
 	it6505->powered = false;
@@ -3647,6 +3649,12 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	drm_bridge_remove(&it6505->bridge);
 	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
+	it6505_remove_notifier_module(it6505);
+	disable_irq(it6505->irq);
+	cancel_work_sync(&it6505->link_works);
+	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
+	cancel_delayed_work_sync(&it6505->hdcp_work);
+	cancel_work_sync(&it6505->extcon_wq);
 	it6505_poweroff(it6505);
 	it6505_remove_edid(it6505);
 }
-- 
2.55.0
