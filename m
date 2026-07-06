Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FBCC44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F0510F3DE;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDB610E32B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-01 (Coremail) with SMTP id qwCowADnitOxd0tqha3xBA--.35434S2;
 Mon, 06 Jul 2026 17:38:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: validate legacy BIT table bounds
Date: Mon,  6 Jul 2026 17:38:56 +0800
Message-ID: <20260706093856.81984-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnitOxd0tqha3xBA--.35434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45Xw4xWFy3GF4DZrW5KFg_yoW8ZrWfpF
 W7WFyqyr4Fyr4Sgr4Iyr4YyFyrZw4kWrZrGFy7Kr1Yqrn3t3W8K3W8Ar1Yg345JryUurWY
 yFn8Ka4UWF4UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
 IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

The legacy BIT parser finds the BIT signature and then reads the entry
size, entry count and entry array directly from the VBIOS image. The
signature only proves that the magic bytes are present. It does not prove
that the fixed BIT header, every directory entry, or the referenced table
range fits inside the VBIOS image.

Validate the BIT header, entry array and referenced table ranges before
returning a legacy BIT entry to the individual table parsers.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 38032bb95826..93b035905ca2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -972,24 +972,39 @@ bit_table(struct drm_device *dev, u8 id, struct bit_entry *bit)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvbios *bios = &drm->vbios;
-	u8 entries, *entry;
+	u32 entry_size, entries, offset;
+	u8 *entry;
 
 	if (bios->type != NVBIOS_BIT)
 		return -ENODEV;
 
+	if (bios->offset > bios->length || bios->length - bios->offset < 12)
+		return -EINVAL;
+
+	entry_size = bios->data[bios->offset + 9];
 	entries = bios->data[bios->offset + 10];
-	entry   = &bios->data[bios->offset + 12];
+	if (entry_size < 6 ||
+	    entries > (bios->length - bios->offset - 12) / entry_size)
+		return -EINVAL;
+
+	entry = &bios->data[bios->offset + 12];
 	while (entries--) {
 		if (entry[0] == id) {
 			bit->id = entry[0];
 			bit->version = entry[1];
 			bit->length = ROM16(entry[2]);
 			bit->offset = ROM16(entry[4]);
+
+			offset = bit->offset;
+			if (offset > bios->length ||
+			    bit->length > bios->length - offset)
+				return -EINVAL;
+
 			bit->data = ROMPTR(dev, entry[4]);
 			return 0;
 		}
 
-		entry += bios->data[bios->offset + 9];
+		entry += entry_size;
 	}
 
 	return -ENOENT;
-- 
2.43.0

