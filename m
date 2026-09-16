Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA977C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844C310EA4E;
	Wed, 16 Sep 2026 10:06:29 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4606C10E389
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:06:27 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowABnbDoXaqpqntngBw--.42358S2;
 Wed, 16 Sep 2026 18:06:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Laurent.pinchart@ideasonboard.com
Cc: airlied@gmail.com, andrzej.hajda@intel.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 sam@ravnborg.org, simona@ffwll.ch, tomi.valkeinen@ti.com,
 tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/bridge: display-connector: Fix DDC adapter leak in
 display_connector_probe()
Date: Wed, 16 Sep 2026 10:05:47 +0000
Message-Id: <20260916100547.2012828-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnbDoXaqpqntngBw--.42358S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fWryrWFy7WFyrZr45GFg_yoW8AFy3pa
 yDtFyftrWkZFnYk3yDAFn7ury5CrZ7JFyFkr4UWwn3u3Z5XFW7Za95Jr1YqF18CFykGa9Y
 yw4DXFZ7JF1DCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
 W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
 IYCTnIWIevJa73UjIFyTuYvjTRMPfQDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkMA2qqPpSx0QABsL
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

display_connector_probe() takes a reference to the DDC I2C adapter
with of_get_i2c_adapter_by_node() and releases it only in
display_connector_remove().  When the probe continues after obtaining
the adapter and then fails, e.g. because the ddc-en GPIO or the HDMI
power regulator cannot be obtained, or when the regulator cannot be
enabled, the function returns without dropping the adapter reference,
leaking it.

Drop the DDC adapter reference with i2c_put_adapter() on those error
paths before returning.

Fixes: 0c275c30176b ("drm/bridge: Add bridge driver for display connectors")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/display-connector.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..926d7638c1a7 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -352,18 +352,22 @@ static int display_connector_probe(struct platform_device *pdev)
 
 		if (IS_ERR(conn->ddc_en)) {
 			dev_err(&pdev->dev, "Couldn't get ddc-en gpio\n");
+			i2c_put_adapter(conn->bridge.ddc);
 			return PTR_ERR(conn->ddc_en);
 		}
 
 		ret = display_connector_get_supply(pdev, conn, "hdmi-pwr");
-		if (ret < 0)
+		if (ret < 0) {
+			i2c_put_adapter(conn->bridge.ddc);
 			return dev_err_probe(&pdev->dev, ret, "failed to get HDMI +5V Power regulator\n");
+		}
 	}
 
 	if (conn->supply) {
 		ret = regulator_enable(conn->supply);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to enable PWR regulator: %d\n", ret);
+			i2c_put_adapter(conn->bridge.ddc);
 			return ret;
 		}
 	}
-- 
2.34.1

