Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1834C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB3710E359;
	Wed, 16 Sep 2026 07:20:48 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFE310E359
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:20:46 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAC3wkBIQ6pq3w3fBw--.65491S2;
 Wed, 16 Sep 2026 15:20:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alim.akhtar@samsung.com, dri-devel@lists.freedesktop.org,
 inki.dae@samsung.com, krzk@kernel.org, kyungmin.park@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, seanpaul@chromium.org, simona@ffwll.ch,
 sw0312.kim@samsung.com, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH 10/20] drm/exynos: dpi: Fix OF node leak in
 exynos_dpi_parse_dt()
Date: Wed, 16 Sep 2026 07:20:12 +0000
Message-Id: <20260916072012.1967169-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3wkBIQ6pq3w3fBw--.65491S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xZw4DCrWUCrW3Wr17ZFb_yoWkZrg_CF
 1xZFyxXr15uryvvrsrAF1fZr929Fn7uan3CayIvFWayw15Ar4YyFW3ur18ZrW7uFW7W3sr
 G3Wjv3W7tr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JUCNtxUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7kPgAAAsL
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

In exynos_dpi_parse_dt(), ctx->panel_node is obtained using
of_graph_get_remote_node(). However, when "display-timings" child node
is present, the driver uses display timings directly and ignores the
panel node without releasing the acquired reference count.

Call of_node_put() on ctx->panel_node and set it to NULL when
"display-timings" is present to prevent reference leaks.

Fixes: 86418f90a4c1 ("drm: convert drivers to use of_graph_get_remote_node")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 0dc36df6ada3..0b64d1031951 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -168,6 +168,8 @@ static int exynos_dpi_parse_dt(struct exynos_dpi *ctx)
 		int ret;
 
 		of_node_put(np);
+		of_node_put(ctx->panel_node);
+		ctx->panel_node = NULL;
 
 		vm = devm_kzalloc(dev, sizeof(*ctx->vm), GFP_KERNEL);
 		if (!vm)
-- 
2.34.1

