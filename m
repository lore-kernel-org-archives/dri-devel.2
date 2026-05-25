Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBECD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 04:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DC010E06F;
	Mon, 25 May 2026 04:50:41 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24110E06F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 04:50:40 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowADXeGQa1RNqFJ2DEQ--.8881S2;
 Mon, 25 May 2026 12:50:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: fix of_node reference leak in
 of_mipi_dsi_device_add error path
Date: Mon, 25 May 2026 04:50:28 +0000
Message-Id: <20260525045028.3895931-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADXeGQa1RNqFJ2DEQ--.8881S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3Xw1rCFW8KryDGFyrtFb_yoW8CF13pF
 W3Ga45ZrWkKrsrCry8ZF18uFyY93Waya95ur4kJ3W2kwn5Za4UtryUtFyDK345JrWxAF1a
 qr9rJ34UCrn7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
 UU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRESA2oTokfJWAAAsE
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

of_mipi_dsi_device_add() acquires an of_node reference via
of_node_get() before passing it to mipi_dsi_device_register_full().
However, when mipi_dsi_device_register_full() fails (e.g.,
mipi_dsi_device_add() returns an error), the acquired reference is
never released, causing the device_node to leak.

device_set_node() merely stores the fwnode pointer without taking
an additional refcount, so the reference from of_node_get() is the
only one the device holds on the success path.  On the error path
the reference must be released by the caller that acquired it.

Fix this by checking the return value of
mipi_dsi_device_register_full() and calling of_node_put() on error.

Fixes: c63ae8a9686b ("drm/dsi: Use mipi_dsi_device_register_full() for DSI device creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..b54c10d92c57 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -163,6 +163,7 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
 	struct mipi_dsi_device_info info = { };
 	int ret;
+	struct mipi_dsi_device *dsi;
 	u32 reg;
 
 	if (of_alias_from_compatible(node, info.type, sizeof(info.type)) < 0) {
@@ -179,8 +180,10 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 
 	info.channel = reg;
 	info.node = of_node_get(node);
-
-	return mipi_dsi_device_register_full(host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
+	if (IS_ERR(dsi))
+		of_node_put(node);
+	return dsi;
 }
 #else
 static struct mipi_dsi_device *
-- 
2.34.1

