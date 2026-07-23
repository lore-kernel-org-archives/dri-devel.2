Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED8BC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C2610EFDB;
	Thu, 23 Jul 2026 07:08:44 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1F610E505
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-03 (Coremail) with SMTP id rQCowAD3AUCOfmFqOX_WAA--.51661S2;
 Thu, 23 Jul 2026 10:38:07 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Douglas Anderson <dianders@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] drm/bridge: ps8640: propagate AUX transfer register errors
Date: Thu, 23 Jul 2026 10:38:06 +0800
Message-ID: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3AUCOfmFqOX_WAA--.51661S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4DAw18uF1xKr1xZF43Wrg_yoW5WF4Upa
 y7uF4SvrsrXw12vr4fAF40qFn0kaykGa93C3srGrWIvF129r9FvF45ua4Fq3Z5JryxJw4U
 JF1UCFW5C3Wa9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
 IYCTnIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

ps8640_aux_transfer_msg() programs the AUX address registers, starts the
AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX status
register. Several of those regmap operations have return values, but the
function only checks a stale ret after the status read.

Propagate failures from the address write, transfer start, completion
poll, and status read. This avoids returning a transfer length when the
bridge register transaction or AUX completion wait failed.

Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260623060635.16064-1-pengpeng@iscas.ac.cn/
- include the AUX address and length in the address-write diagnostic
- describe poll failures without assuming that every error is a timeout
- add the Fixes tag suggested by Doug
- rebase onto the current drm-misc-next tree

 drivers/gpu/drm/bridge/parade-ps8640.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 96332721cb69..56b48f8feab6 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -257,8 +257,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	addr_len[PAGE0_SWAUX_LENGTH - base] = (len == 0) ? SWAUX_NO_PAYLOAD :
 					      ((len - 1) & SWAUX_LENGTH_MASK);
 
-	regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
-			  ARRAY_SIZE(addr_len));
+	ret = regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
+				ARRAY_SIZE(addr_len));
+	if (ret) {
+		DRM_DEV_ERROR(dev,
+			      "failed to write AUX address %#x, len %zu: %d\n",
+			      msg->address, len, ret);
+		return ret;
+	}
 
 	if (len && (request == DP_AUX_NATIVE_WRITE ||
 		    request == DP_AUX_I2C_WRITE)) {
@@ -274,13 +280,22 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 		}
 	}
 
-	regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
+	ret = regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to start AUX transfer: %d\n", ret);
+		return ret;
+	}
 
 	/* Zero delay loop because i2c transactions are slow already */
-	regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
-				 !(data & SWAUX_SEND), 0, 50 * 1000);
+	ret = regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
+				       !(data & SWAUX_SEND), 0, 50 * 1000);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to complete AUX transfer: %d\n",
+			      ret);
+		return ret;
+	}
 
-	regmap_read(map, PAGE0_SWAUX_STATUS, &data);
+	ret = regmap_read(map, PAGE0_SWAUX_STATUS, &data);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n",
 			      ret);
-- 
2.50.1 (Apple Git-155)

