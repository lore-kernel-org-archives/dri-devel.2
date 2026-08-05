Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2783DC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4737E10EEAA;
	Wed,  5 Aug 2026 14:19:31 +0000 (UTC)
X-Greylist: delayed 8545 seconds by postgrey-1.36 at gabe;
 Wed, 05 Aug 2026 14:19:29 UTC
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [4.193.249.245])
 by gabe.freedesktop.org (Postfix) with ESMTP id D31AC10EEAA
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 14:19:29 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wCHgD9gRnNqa6ZpAA--.20506S3;
 Wed, 05 Aug 2026 22:19:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app2 (Coremail) with SMTP id zC_KCgB358xgRnNqByiTAw--.7866S2;
 Wed, 05 Aug 2026 22:19:12 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to
 avoid use-after-free
Date: Wed,  5 Aug 2026 14:18:16 +0000
Message-Id: <20260805141816.216900-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805115546.152786-1-fanwu01@zju.edu.cn>
References: <20260805115546.152786-1-fanwu01@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zC_KCgB358xgRnNqByiTAw--.7866S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?3EJdcwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfncGSG+szpQCInt5Y8rbJUI2Ta2RgZfddM+Y1FlRj8fDxb1K3cJlUE22gKRBQ9mMNwa2M
 i+f+EPnglYqAJbTSbN0=
X-Coremail-Antispam: 1Uk129KBj93XoWxuF43GFWDWw48KF47XryUCFX_yoWrXw1rpF
 4fX390yrWvq3WI9a9FyF15Ary5Awnrta1rCr1kKw1Sva4rWa1Yq34kArWjgF1akFW8J3WY
 yFs0vFy8ArWUAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
 WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==
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

The error recovery code queues reset_work from the threaded IRQ handler
and polling monitor_work. Neither device removal nor a probe failure after
requesting the IRQ drains that work before devres releases the bridge
allocation.

Keep the IRQ disabled after it is requested and enable it only after the
bridge has attached successfully. This prevents an IRQ during probe from
queueing reset_work before bridge->encoder has been initialized.

On remove and the post-IRQ probe failure path, synchronously disable the
IRQ before declaring the bridge unplugged. This prevents an asserted IRQ
from repeatedly invoking a handler which can no longer acknowledge the
device. drm_bridge_unplug() then blocks new DRM entry points and waits for
existing bridge critical sections. Finally drain monitor_work and
reset_work before devres can free the bridge allocation.

This issue was found by an in-house static analysis tool.
Compile-tested only; runtime testing is appreciated.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v2:
  - Request the IRQ with IRQF_NO_AUTOEN and enable it only after the bridge
    attaches, so it cannot fire during probe and queue reset_work before
    bridge->encoder is initialized.
  - Disable the IRQ before drm_bridge_unplug() in the teardown helper, so
    an asserted level IRQ is acknowledged by the handler while it can still
    enter the bridge instead of re-firing once the unplug barrier rejects
    it.

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..d7648b5d5636 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -296,9 +296,14 @@ static int sn65dsi83_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	int ret;
 
-	return drm_bridge_attach(encoder, ctx->panel_bridge,
-				 &ctx->bridge, flags);
+	ret = drm_bridge_attach(encoder, ctx->panel_bridge, &ctx->bridge,
+				flags);
+	if (!ret && ctx->irq)
+		enable_irq(ctx->irq);
+
+	return ret;
 }
 
 static void sn65dsi83_detach(struct drm_bridge *bridge)
@@ -997,6 +1004,19 @@ static irqreturn_t sn65dsi83_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void sn65dsi83_stop_error_recovery(struct sn65dsi83 *ctx)
+{
+	/* Stop the IRQ before the unplug barrier rejects its handler. */
+	if (ctx->irq)
+		disable_irq(ctx->irq);
+
+	/* Block new bridge users and wait for existing critical sections. */
+	drm_bridge_unplug(&ctx->bridge);
+
+	cancel_delayed_work_sync(&ctx->monitor_work);
+	cancel_work_sync(&ctx->reset_work);
+}
+
 static int sn65dsi83_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1039,7 +1056,8 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	if (client->irq) {
 		ctx->irq = client->irq;
 		ret = devm_request_threaded_irq(ctx->dev, ctx->irq, NULL, sn65dsi83_irq,
-						IRQF_ONESHOT, dev_name(ctx->dev), ctx);
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						dev_name(ctx->dev), ctx);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to request irq\n");
 	}
@@ -1061,7 +1078,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	return 0;
 
 err_remove_bridge:
-	drm_bridge_remove(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 	return ret;
 }
 
@@ -1069,6 +1086,6 @@ static void sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
-	drm_bridge_unplug(&ctx->bridge);
+	sn65dsi83_stop_error_recovery(ctx);
 }
 
-- 
2.51.0

