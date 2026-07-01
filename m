Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C52CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD210E2A1;
	Wed,  1 Jul 2026 03:22:27 +0000 (UTC)
X-Greylist: delayed 490 seconds by postgrey-1.36 at gabe;
 Wed, 01 Jul 2026 03:22:25 UTC
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EA410E1DE
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 03:22:24 +0000 (UTC)
Received: from localhost (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXO9QEhkRqZno0BA--.17275S2;
 Wed, 01 Jul 2026 11:14:12 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 jonas@kwiboo.se, Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/rockchip: dw_hdmi: Fix error handling for
 drm_atomic_get_bridge_state()
Date: Wed,  1 Jul 2026 11:08:35 +0800
Message-Id: <20260701030835.2662123-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXO9QEhkRqZno0BA--.17275S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWUJF17uFWrur4fCrW5GFg_yoWDCrg_K3
 W3Xr97WryrGFn0y3W7Cay3JFZ2v3W2grW8Wa1F9FWfAFWkAryIq3s7Kr15G3W7Z3ySyFnr
 K3W2qr4jkrn3CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
 xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
 0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
 IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
 6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUyEEU
 UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
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

The drm_atomic_get_bridge_state() function returns an error pointer on
failure, not NULL. Fix the check to use IS_ERR() to correctly handle
allocation failures.

Fixes: dc70272cc184 ("drm/rockchip: dw_hdmi: Propagate bus format to display driver")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index cffc0af5190f..766cf21a4be7 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -287,7 +287,7 @@ static u32 dw_hdmi_rockchip_get_bus_format(struct drm_encoder *encoder,
 		return 0;
 
 	bridge_state = drm_atomic_get_bridge_state(conn_state->state, bridge);
-	if (!bridge_state)
+	if (IS_ERR(bridge_state))
 		return 0;
 
 	if (bridge_state->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)
-- 
2.25.1

