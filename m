Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6B6C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E09810E435;
	Wed, 16 Sep 2026 17:52:20 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5660610E435
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:18 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAA3pD5L16pqMvNuCA--.22793S2;
 Thu, 17 Sep 2026 01:52:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: architt@codeaurora.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, treding@nvidia.com,
 tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: Fix device node leak in of_mipi_dsi_device_add()
Date: Wed, 16 Sep 2026 17:51:43 +0000
Message-Id: <20260916175143.2089466-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3pD5L16pqMvNuCA--.22793S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47ZF15Jr1UJw15Jr4fXwb_yoW8WFyxpF
 W3Ga45ArWkKrsI9ry8ZF18ur1aga1ayas5ur4kJ3W2k3Z5Z345tF90qFyDGw15J397AF1Y
 qr9rJry8Grs7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
 7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
 rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
 0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2qqpVhtHQAAsE
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

of_mipi_dsi_device_add() takes a reference on the DSI device node with
of_node_get() and hands it to mipi_dsi_device_register_full() via the
device info. On success the reference is transferred to the newly
created device, but if mipi_dsi_device_register_full() fails, for
instance because the channel number is invalid, the DSI device cannot
be allocated or device_add() fails, the reference is never dropped and
the device node leaks.

Drop the reference when mipi_dsi_device_register_full() returns an
error.

Fixes: c63ae8a9686b ("drm/dsi: Use mipi_dsi_device_register_full() for DSI device creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..16c0682f8a99 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -162,6 +162,7 @@ static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
 	struct mipi_dsi_device_info info = { };
+	struct mipi_dsi_device *dsi;
 	int ret;
 	u32 reg;
 
@@ -180,7 +181,11 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 	info.channel = reg;
 	info.node = of_node_get(node);
 
-	return mipi_dsi_device_register_full(host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
+	if (IS_ERR(dsi))
+		of_node_put(node);
+
+	return dsi;
 }
 #else
 static struct mipi_dsi_device *
-- 
2.34.1

