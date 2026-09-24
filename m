Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53EC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7665310E565;
	Thu, 24 Sep 2026 18:40:20 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC1510E565
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:40:19 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x9oMa-000000007Gh-3ehi;
 Thu, 24 Sep 2026 18:40:08 +0000
Date: Thu, 24 Sep 2026 19:40:05 +0100
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
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v7 01/14] drm/bridge: it6505: quiesce event sources and work
 on remove()
Message-ID: <6f2f7bd3e6b259266bde53b3396a1ef87633bc85.1790275151.git.daniel@makrotopia.org>
References: <cover.1790275151.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790275151.git.daniel@makrotopia.org>
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

struct it6505 is freed by devres right after remove() returns, but
remove() cancels none of the driver's work items, so link_works,
hdcp_wait_ksv_list, hdcp_work and extcon_wq can still run afterwards
and dereference freed memory. Cancelling alone would not be enough:
the threaded IRQ and the extcon notifier stay live until devres
teardown and can requeue the works.

Unregister the extcon notifier and disable the IRQ first, then cancel
all work. Make it6505_remove_notifier_module() idempotent, tracking
the registration in a flag under extcon_lock, as both .detach() and
remove() call it now. The notifier_call pointer is left intact:
extcon traverses its raw notifier chain without holding a lock, so a
traversal racing with the unregistration may still invoke the
callback. Also initialise extcon_wq in probe: cancel_work_sync() on a
never-initialised work item trips WARN_ON(!work->func).

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: no changes

v6: track registration in a flag instead of clearing notifier_call,
    which an unlocked chain traversal racing the unregistration
    could have called as NULL

v5: serialise notifier registration state with extcon_lock

v4:
 * quiesce event sources before cancelling work; retitled
 * initialise extcon_wq in probe to avoid WARN_ON(!work->func)

v3: new patch
---
 drivers/gpu/drm/bridge/ite-it6505.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e136ac71edbb..e980cc6d5760 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -443,6 +443,7 @@ struct it6505 {
 	struct drm_display_mode source_output_mode;
 	struct drm_display_mode video_info;
 	struct notifier_block event_nb;
+	bool extcon_registered;
 	struct extcon_dev *extcon;
 	struct work_struct extcon_wq;
 	int extcon_state;
@@ -2934,11 +2935,15 @@ static int it6505_use_notifier_module(struct it6505 *it6505)
 	int ret;
 	struct device *dev = it6505->dev;
 
+	mutex_lock(&it6505->extcon_lock);
 	it6505->event_nb.notifier_call = it6505_extcon_notifier;
-	INIT_WORK(&it6505->extcon_wq, it6505_extcon_work);
 	ret = devm_extcon_register_notifier(it6505->dev,
 					    it6505->extcon, EXTCON_DISP_DP,
 					    &it6505->event_nb);
+	if (!ret)
+		it6505->extcon_registered = true;
+	mutex_unlock(&it6505->extcon_lock);
+
 	if (ret) {
 		dev_err(dev, "failed to register notifier for DP");
 		return ret;
@@ -2951,13 +2956,16 @@ static int it6505_use_notifier_module(struct it6505 *it6505)
 
 static void it6505_remove_notifier_module(struct it6505 *it6505)
 {
-	if (it6505->extcon) {
-		devm_extcon_unregister_notifier(it6505->dev,
-						it6505->extcon,	EXTCON_DISP_DP,
+	mutex_lock(&it6505->extcon_lock);
+	if (it6505->extcon && it6505->extcon_registered) {
+		devm_extcon_unregister_notifier(it6505->dev, it6505->extcon,
+						EXTCON_DISP_DP,
 						&it6505->event_nb);
-
-		flush_work(&it6505->extcon_wq);
+		it6505->extcon_registered = false;
 	}
+	mutex_unlock(&it6505->extcon_lock);
+
+	flush_work(&it6505->extcon_wq);
 }
 
 static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
@@ -3613,6 +3621,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
 	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
+	INIT_WORK(&it6505->extcon_wq, it6505_extcon_work);
 	init_completion(&it6505->extcon_completion);
 	memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
 	it6505->powered = false;
@@ -3645,6 +3654,12 @@ static void it6505_i2c_remove(struct i2c_client *client)
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
