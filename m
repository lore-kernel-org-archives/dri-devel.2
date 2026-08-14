Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0266C5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6583D10E30B;
	Sun, 16 Aug 2026 14:05:17 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BEC10F422
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-01 (Coremail) with SMTP id qwCowACnffHXy35q_MOeBQ--.48866S2;
 Fri, 14 Aug 2026 16:03:36 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] drm/nouveau: validate legacy BIT table bounds
Date: Fri, 14 Aug 2026 16:03:35 +0800
Message-ID: <20260814080335.22263-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnffHXy35q_MOeBQ--.48866S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45Zw18ZrW5ur13WryfJFb_yoW5JryUpF
 W7WasrAr4rtr4agr4Iyr45Aa4fZws3Wr9rGFy3KryY9ryftF10k3W8Ar1Yg345JryDuryY
 yF4DKa4Uur45t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
 yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
 IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

The legacy BIT parser finds the BIT signature and then reads the
entry shape and entry array directly from the VBIOS image. The signature
does not prove that the complete header, entry array or referenced table
payload fits in the image.

Validate each extent before use. Preserve the legacy zero-offset meaning
for zero-length entries, but reject non-empty entries with a null or
out-of-range offset.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260706093856.81984-1-pengpeng@iscas.ac.cn/
- validate the complete BIT header and entry array
- validate each referenced payload extent
- preserve zero-offset semantics for zero-length entries only

The legacy BIT and ROMPTR contracts were reviewed statically; no malformed
VBIOS image was exercised.

 drivers/gpu/drm/nouveau/nouveau_bios.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 38032bb95826..a4ef62928ba3 100644
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
+			if ((bit->length && !offset) || offset > bios->length ||
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
2.50.1 (Apple Git-155)

