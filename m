Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A59CDE003
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B49B10EDCE;
	Wed, 24 Jun 2026 07:47:58 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1542010E021
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-03 (Coremail) with SMTP id rQCowACHf7Yqcjtq3TKtFQ--.63770S2;
 Wed, 24 Jun 2026 13:59:07 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Kees Cook <kees@kernel.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/bridge: cdns-dsi: Propagate resume reset and clock
 failures
Date: Wed, 24 Jun 2026 13:59:06 +0800
Message-ID: <20260624055906.53195-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHf7Yqcjtq3TKtFQ--.63770S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyrArWrWF1rWryrKFyDJrb_yoW8WFyrpF
 n7W3yFkrW8ZrZY9a93JF4DJrZ0van3KFWfGrWakwn7ZwsxAa4jvryYy3W5XFnxtr1IyFy7
 Jw4ktrykuF40yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0pRc6p9UUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

cdns_dsi_resume() ignores reset_control_deassert() and
clk_prepare_enable() failures for resources that probe treats as
required.  The host can then appear resumed even though the DSI reset or
clock transitions failed.

Propagate resume failures and unwind transitions that already succeeded.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..0cbb8528350c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1233,12 +1233,27 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 static int __maybe_unused cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(dsi->dsi_p_rst);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dsi->dsi_p_clk);
+	if (ret)
+		goto err_assert_reset;
 
-	reset_control_deassert(dsi->dsi_p_rst);
-	clk_prepare_enable(dsi->dsi_p_clk);
-	clk_prepare_enable(dsi->dsi_sys_clk);
+	ret = clk_prepare_enable(dsi->dsi_sys_clk);
+	if (ret)
+		goto err_disable_p_clk;
 
 	return 0;
+
+err_disable_p_clk:
+	clk_disable_unprepare(dsi->dsi_p_clk);
+err_assert_reset:
+	reset_control_assert(dsi->dsi_p_rst);
+	return ret;
 }
 
 static int __maybe_unused cdns_dsi_suspend(struct device *dev)
-- 
2.50.1 (Apple Git-155)

