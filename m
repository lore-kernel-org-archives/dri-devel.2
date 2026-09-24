Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5999C98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9D710F8ED;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="WLezWYFL";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC35710E543;
 Thu, 24 Sep 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PE
 PnVVexH+hFXfSPkcaX+kZ98oVF8UZaUHBxwCAYz/I=; b=WLezWYFL5Ag+IBoTaE
 mIIAveOeVxAYekHqcmfWs3ZhrUacI41HOo5CmMz+6E+h6luX+7Ig4uT5Qd5RLPfv
 uKCQwOpufHtQi610oCg4Eyi4Tfs7NMmaRqBFWwEqz0PIqafmjOxv/YoMgSdUX1qx
 yvNi7Cnnf+4oHHrHaHIC6ITrE=
Received: from pc.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAXhnqMGbVqI5arBA--.27527S2;
 Thu, 24 Sep 2026 20:37:34 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/qxl: validate client monitor index before access
Date: Thu, 24 Sep 2026 20:37:30 +0800
Message-Id: <20260924123731.803007-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAXhnqMGbVqI5arBA--.27527S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4ktrWkXw4xGF4xtw4Dtwb_yoW5Gw4rpr
 Z8tFy5Kr1kJFyaya1DAa4xWF4rC34qyFWI934fG3WavFyqkrWYyFyDtrn8uF9xJF98AF18
 uw1FgFZFvF1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAwIDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A5xq2q1GY5e-QAA3P
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

client_monitors_config is allocated with space for count heads, while QXL
creates qxl_num_crtc outputs whose indexes range from zero to
qxl_num_crtc - 1.  The monitor count may be smaller than qxl_num_crtc, but
qxl_update_offset_props() and qxl_conn_get_modes() use the output index to
access heads[] without checking it against count.

Starting QEMU with "-device qxl-vga,xres=1024,yres=768" provides one
client monitor while the driver creates four outputs by default.  KASAN
reported the first out-of-bounds access during probe, with
qxl_update_offset_props() inlined into its caller:

  BUG: KASAN: slab-out-of-bounds in
  qxl_display_read_client_monitors_config+0x2379/0x2e30
  Read of size 4 at addr ffff88810403e170 by task swapper/0/1
  Call Trace:
   qxl_display_read_client_monitors_config+0x2379/0x2e30
   qxl_modeset_init+0x6a6/0x7b0
   qxl_pci_probe+0x150/0x2d0

The same configuration reaches the unchecked access in
qxl_conn_get_modes() when userspace enumerates connectors.

Skip offset updates for outputs that have no corresponding client head,
and retain the default preferred mode dimensions in qxl_conn_get_modes()
when its output index is outside the client head array.

Fixes: 7dea0941f880 ("drm/qxl: use suggested x/y offset properties to pass guest prefs")
Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..25f786ab7f1b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -158,6 +158,9 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		output = drm_connector_to_qxl_output(connector);
 
+		if (output->index >= qdev->client_monitors_config->count)
+			continue;
+
 		head = &qdev->client_monitors_config->heads[output->index];
 
 		drm_object_property_set_value(&connector->base,
@@ -1056,7 +1059,8 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 	unsigned int pheight = 768;
 	int ret = 0;
 
-	if (qdev->client_monitors_config) {
+	if (qdev->client_monitors_config &&
+	    output->index < qdev->client_monitors_config->count) {
 		struct qxl_head *head;
 		head = &qdev->client_monitors_config->heads[output->index];
 		if (head->width)
-- 
2.34.1

