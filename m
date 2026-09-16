Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE4BC982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8D510ED11;
	Wed, 16 Sep 2026 18:15:01 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB07A10ED11
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:14:59 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAA3oDqe3KpqlU9vCA--.23663S2;
 Thu, 17 Sep 2026 02:14:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: andrzej.hajda@intel.com, andy.yan@rock-chips.com,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: dsi: Fix second reference leak in
 dw_mipi_dsi_rockchip_host_detach()
Date: Wed, 16 Sep 2026 18:14:26 +0000
Message-Id: <20260916181426.2091074-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3oDqe3KpqlU9vCA--.23663S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy8ZF4xCF1rKrWUZF45GFg_yoWkZrX_Kw
 1Iqr15Wr4rJ3sxZ3W8C3y3uFZIk3sF9FWIga10vFZxZa9rJr1IqrZ5Aw4YqF17Cay3AFZ7
 G3W0qryrCan3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
 4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
 I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
 6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
 W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2qqpVh2owAAsh
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

The reference to the dual-DSI partner device obtained through
dw_mipi_dsi_rockchip_find_second() is never released after removing
the partner component.  Drop it once component_del() is done.

Fixes: cf6d100dd238 ("drm/rockchip: dsi: add dual mipi support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 2c1f1c53ddda..7f2d3cd28694 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1101,8 +1101,10 @@ static int dw_mipi_dsi_rockchip_host_detach(void *priv_data,
 	struct device *second;
 
 	second = dw_mipi_dsi_rockchip_find_second(dsi);
-	if (second && !IS_ERR(second))
+	if (second && !IS_ERR(second)) {
 		component_del(second, &dw_mipi_dsi_rockchip_ops);
+		put_device(second);
+	}
 
 	component_del(dsi->dev, &dw_mipi_dsi_rockchip_ops);
 
-- 
2.34.1

