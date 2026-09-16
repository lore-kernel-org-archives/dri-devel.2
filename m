Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE87C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05F810E336;
	Wed, 16 Sep 2026 10:14:41 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A1C10E336
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:14:39 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowACnqTcFbKpqBe_gBw--.43129S2;
 Wed, 16 Sep 2026 18:14:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Laurent.pinchart@ideasonboard.com
Cc: adrien.grassein@gmail.com, airlied@gmail.com, andrzej.hajda@intel.com,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 linux-kernel@vger.kernel.org, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] drm/bridge: lt8912b: Fix next_bridge reference leak in
 lt8912_parse_dt()
Date: Wed, 16 Sep 2026 10:14:01 +0000
Message-Id: <20260916101401.2017498-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnqTcFbKpqBe_gBw--.43129S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jw45Aw1UXrWDtr1rurykKrg_yoW8JF18pF
 42g343KFWDGFyxKaySyF1DZ343AayDtFZ5CFWjkay09r1rX3WUA3WDZFWYqr1rAFy5Gr12
 yr4Yk3yrJF1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
 W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
 xdYxBIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQMA2qqP7mvVwAAs5
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

lt8912_parse_dt() takes a reference to the next bridge in the
pipeline with of_drm_find_and_get_bridge() and stores it in
lt->bridge.next_bridge, but neither the error paths after the lookup
nor the driver teardown release it.  Drop the reference in the
err_free_host_node label and in lt8912_put_dt().

Fixes: 31cb3cd7e714 ("drm/bridge: lt8912b: convert to of_drm_find_and_get_bridge()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 8a0b48efca58..fa6cdad3f517 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -743,6 +743,7 @@ static int lt8912_parse_dt(struct lt8912 *lt)
 	return 0;
 
 err_free_host_node:
+	drm_bridge_put(lt->bridge.next_bridge);
 	of_node_put(port_node);
 	of_node_put(lt->host_node);
 	return ret;
@@ -750,6 +751,7 @@ static int lt8912_parse_dt(struct lt8912 *lt)
 
 static int lt8912_put_dt(struct lt8912 *lt)
 {
+	drm_bridge_put(lt->bridge.next_bridge);
 	of_node_put(lt->host_node);
 	return 0;
 }
-- 
2.34.1

