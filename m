Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00476C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3709110E3A2;
	Fri, 26 Jun 2026 13:29:00 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F7910E3A2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-05 (Coremail) with SMTP id zQCowABHntGSfj5qhXFqFQ--.43105S2;
 Fri, 26 Jun 2026 21:28:52 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 WenTao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] fix: drm/mediatek: mtk_drm_probe: of_node_get in loop
 overwrites previous node references without release
Date: Fri, 26 Jun 2026 21:28:49 +0800
Message-Id: <20260626132849.38694-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHntGSfj5qhXFqFQ--.43105S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8ur4ktF43Ar4xCF4fGrg_yoW8XryfpF
 WUKFWYyry0gr4xKFyvyF1Uuryay3WIqayxWa12ga1xZws5tFyUXFyFqay7KFZ2yFy8CF13
 JFn8AFyfur17AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUUU==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwKA2o+TTuTHAAAsv
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

In the for_each_child_of_node loop, private->comp_node[comp_id] and
  private->mutex_node are assigned via of_node_get without first releasing
  any previously stored reference for the same index. When the same comp_id
  or mmsys_id matches multiple nodes, earlier node references are
  overwritten and permanently leaked.

Cc: stable@vger.kernel.org
Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..2c0d8db9ade2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1138,6 +1138,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 			id = of_alias_get_id(node, "mutex");
 			if (id < 0 || id == private->data->mmsys_id) {
+				of_node_put(private->mutex_node);
 				private->mutex_node = of_node_get(node);
 				dev_dbg(dev, "get mutex for mmsys %d", private->data->mmsys_id);
 			}
@@ -1153,7 +1154,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 		if (!mtk_drm_find_mmsys_comp(private, comp_id))
 			continue;
-
+		of_node_put(private->comp_node[comp_id]);
 		private->comp_node[comp_id] = of_node_get(node);
 
 		/*
-- 
2.39.5 (Apple Git-154)

