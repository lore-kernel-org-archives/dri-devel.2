Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FDBC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E7B10E5C5;
	Thu, 20 Aug 2026 04:48:55 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3C2B910E5C5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:48:52 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wA38z0ph4Zq5P+rAA--.1783S3;
 Thu, 20 Aug 2026 12:48:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app1 (Coremail) with SMTP id yy_KCgBHl58ph4ZqoT0CBA--.40164S2;
 Thu, 20 Aug 2026 12:48:41 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/bridge: anx78xx: fix potential use-after-free on device
 removal
Date: Thu, 20 Aug 2026 04:47:46 +0000
Message-Id: <20260820044746.3087-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yy_KCgBHl58ph4ZqoT0CBA--.40164S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gbqewwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfnVCjTgEH9dVomQuWcozCBBHHYRxHJM7g4r1VIOGUvIO1duR0dLd7GrvyLtvOGt4K6CNS
 iK+Oo5rExaLy3VbWv8ip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyrCryDKFy5WrWDCFW8Xwc_yoW8Kr1Upr
 WfKF4Y9ry8GF17tw47Z3WUJFy8ZFykWr4rCa47K347t3WYyFnF9F9avFyYyan8Cr4rJF4x
 Wr1jqryDt34UZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
 WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ructUUUUU==
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

The HPD and INTP interrupts are requested with
devm_request_threaded_irq(), so they stay armed until the devm cleanup
runs after ->remove() has returned.  anx78xx_i2c_remove() unregisters
the dummy i2c clients and frees the cached EDID before that, and both
threaded handlers access those clients through their regmaps, so a
handler running in this window can cause a use-after-free, or a
double-free of the EDID when a cable is unplugged.

Free both interrupts with devm_free_irq() before the dummy clients are
unregistered.  free_irq() waits for a running threaded handler to
finish, so the handlers can no longer race with the teardown.  The
probe error path taken when the INTP request fails unregisters the
dummy clients with the HPD interrupt still armed; free it there too.

This issue was found by an in-house static analysis tool.

Fixes: 0647e7dd3f7a ("drm/bridge: Add Analogix anx78xx support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index ba0fc149a9e7..a5f4ecb96498 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1304,6 +1304,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client)
 					"anx78xx-intp", anx78xx);
 	if (err) {
 		DRM_ERROR("Failed to request INTP threaded IRQ: %d\n", err);
+		devm_free_irq(&client->dev, pdata->hpd_irq, anx78xx);
 		goto err_poweroff;
 	}
 
@@ -1327,6 +1328,14 @@ static void anx78xx_i2c_remove(struct i2c_client *client)
 {
 	struct anx78xx *anx78xx = i2c_get_clientdata(client);
 
+	/*
+	 * The threaded IRQ handlers access the dummy I2C clients through
+	 * regmap and may free the cached EDID, so stop them before those
+	 * resources are freed below.
+	 */
+	devm_free_irq(&client->dev, anx78xx->pdata.hpd_irq, anx78xx);
+	devm_free_irq(&client->dev, anx78xx->pdata.intp_irq, anx78xx);
+
 	drm_bridge_remove(&anx78xx->bridge);
 
 	unregister_i2c_dummy_clients(anx78xx);
-- 
2.34.1

