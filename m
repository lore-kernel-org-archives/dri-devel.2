Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B6BC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2283510E680;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2834610E43C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowAD3J0LxRpFqlvfbBg--.615S2;
 Fri, 28 Aug 2026 16:29:38 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: adv7511: Stop power-on after cache sync failure
Date: Fri, 28 Aug 2026 16:29:35 +0800
Message-ID: <20260828082935.82266-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAD3J0LxRpFqlvfbBg--.615S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kZF47Jr4rur1fuw1rZwb_yoW5Zr15p3
 y7ZFWqk3y8XrnxGFsrJF15Aa45ua95AFy5ZrZ7uw1xuw17Wr1qvrs8JryUXF17CrWkJw1j
 y3WUJFWDCFnxGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
 VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

adv7511_power_on() replays the register cache after taking the bridge
out of power-down.  If that replay fails, the function still powers on
the DSI side and records the bridge as powered, so hotplug and
atomic-enable paths can continue with incomplete hardware state.

Return the replay error, put the bridge back into power-down, leave its
cache dirty and keep powered clear.  Make the three callers stop their
follow-on work when restoration fails.

The issue was identified via static analysis and manually reviewed.

Fixes: 9c8af882bf12 ("drm: Add adv7511 encoder driver")

Assisted-by: LLM
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 26 ++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 038b852405b5..c57c566cf0ad 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -341,18 +341,31 @@ static void __adv7511_power_on(struct adv7511 *adv7511)
 				   ADV7511_REG_POWER2_HPD_SRC_NONE);
 }
 
-static void adv7511_power_on(struct adv7511 *adv7511)
+static int adv7511_power_on(struct adv7511 *adv7511)
 {
+	int ret;
 	__adv7511_power_on(adv7511);
 
 	/*
 	 * Most of the registers are reset during power down or when HPD is low.
 	 */
-	regcache_sync(adv7511->regmap);
+	ret = regcache_sync(adv7511->regmap);
+	if (ret) {
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN,
+				   ADV7511_POWER_POWER_DOWN);
+		regcache_mark_dirty(adv7511->regmap);
+		adv7511->powered = false;
+		dev_err(&adv7511->i2c_main->dev,
+			"failed to sync register cache: %d\n", ret);
+		return ret;
+	}
 
 	if (adv7511->info->has_dsi)
 		adv7533_dsi_power_on(adv7511);
 	adv7511->powered = true;
+
+	return 0;
 }
 
 static void __adv7511_power_off(struct adv7511 *adv7511)
@@ -425,7 +438,8 @@ static void adv7511_hpd_work(struct work_struct *work)
 	    adv7511->status == connector_status_disconnected &&
 	    adv7511->powered) {
 		regcache_mark_dirty(adv7511->regmap);
-		adv7511_power_on(adv7511);
+		if (adv7511_power_on(adv7511))
+			return;
 	}
 
 	if (adv7511->status != status) {
@@ -634,7 +648,8 @@ adv7511_detect(struct adv7511 *adv7511)
 	 * has to be reinitialized. */
 	if (status == connector_status_connected && hpd && adv7511->powered) {
 		regcache_mark_dirty(adv7511->regmap);
-		adv7511_power_on(adv7511);
+		if (adv7511_power_on(adv7511))
+			status = connector_status_disconnected;
 		if (adv7511->status == connector_status_connected)
 			status = connector_status_disconnected;
 	} else {
@@ -788,7 +803,8 @@ static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 
-	adv7511_power_on(adv);
+	if (adv7511_power_on(adv))
+		return;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (WARN_ON(!connector))
-- 
2.43.0

