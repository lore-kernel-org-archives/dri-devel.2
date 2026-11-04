Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B84606D812
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F9910F98A;
	Wed,  4 Nov 2026 02:53:48 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6437610F988
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:53:44 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowABXgvwunupq_uQ+AA--.10086S2;
 Wed, 04 Nov 2026 10:53:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: it6505: put the endpoint node after using it
Date: Wed,  4 Nov 2026 02:53:43 +0000
Message-Id: <20261104025343.1527475-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXgvwunupq_uQ+AA--.10086S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDWF13Zry3tw47ZFy3XFb_yoW8Kr45pr
 srGayY9FsrGFZ7KrWUJr1fAr1Fya1UXFWrCFyxGw4Svan5X3WkAFsI9F90qF18CFn7Zw1Y
 yr4qkFnF9r1ruw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
 v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lFIxGxcIE
 c7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82
 IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxU
 HgAzUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgBA2rqZFjiRQAAsW
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

it6505_parse_dt() obtains an endpoint node with
of_graph_get_endpoint_by_regs() and drops that reference with
of_node_put() right away, before the node is checked and passed to
it6505_get_data_lanes_count(), of_property_read_u32_array() and
of_property_read_variable_u64_array().

The reference from of_graph_get_endpoint_by_regs() is the only thing
keeping the endpoint alive, so releasing it first leaves the following
property lookups operating on a node that another of_node_put() can free
concurrently, for instance when a device tree overlay providing the
endpoint is removed.

Keep the reference until the properties have been read and only then
call of_node_put(), for both endpoints parsed by the function.

Fixes: 380d920b582d ("drm/bridge: add it6505 driver to read data-lanes and link-frequencies from dt")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e136ac71edbb..228a0861919b 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3342,8 +3342,6 @@ static void it6505_parse_dt(struct it6505 *it6505)
 	}
 
 	ep = of_graph_get_endpoint_by_regs(np, 1, 0);
-	of_node_put(ep);
-
 	if (ep) {
 		len = it6505_get_data_lanes_count(ep, 1, 4);
 
@@ -3355,14 +3353,14 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			*max_lane_count = MAX_LANE_COUNT;
 			dev_err(dev, "error data-lanes, use default");
 		}
+
+		of_node_put(ep);
 	} else {
 		*max_lane_count = MAX_LANE_COUNT;
 		dev_err(dev, "error endpoint, use default");
 	}
 
 	ep = of_graph_get_endpoint_by_regs(np, 0, 0);
-	of_node_put(ep);
-
 	if (ep) {
 		len = of_property_read_variable_u64_array(ep,
 							  "link-frequencies",
@@ -3381,6 +3379,8 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			dev_err(dev, "error link frequencies, use default");
 			*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
 		}
+
+		of_node_put(ep);
 	} else {
 		dev_err(dev, "error endpoint, use default");
 		*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
-- 
2.34.1

