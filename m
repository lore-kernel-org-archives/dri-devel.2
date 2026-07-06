Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0149C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB9B10F3FE;
	Thu,  9 Jul 2026 07:25:20 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B81F10E328
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-01 (Coremail) with SMTP id qwCowAAnxs7md0tqtLLxBA--.35425S2;
 Mon, 06 Jul 2026 17:39:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: validate MXMS descriptor bounds
Date: Mon,  6 Jul 2026 17:39:49 +0800
Message-ID: <20260706093949.82126-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAnxs7md0tqtLLxBA--.35425S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy3GryDAw1rCr4kCw45KFg_yoWxZF1rpF
 4DGF90yr4jy3WSgrZ7Cr4rCFnIy3y8tayIkrWqgr909wn3tryruFWjyw1Yk3sYgr17Cr1a
 qF4Dtw1xC3y5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

MXMS data can be provided by the ROM, DSM or WMI paths. The parser only
kept the data pointer, so later validation and descriptor iteration had no
record of the actual provider buffer length. The ROM path also read a
short temporary header before deriving the declared MXMS size.

Keep the provider buffer size with the MXMS data, fetch the complete fixed
header before reading the declared structure length, and validate each
MXMS descriptor header and record array against the remaining MXMS buffer
before dumping or handing the descriptor to consumers.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../gpu/drm/nouveau/nvkm/subdev/mxm/base.c    | 24 ++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/mxm/mxms.c    | 47 +++++++++++++++----
 .../gpu/drm/nouveau/nvkm/subdev/mxm/priv.h    |  1 +
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
index 26ec50b66e66..ad74a216a201 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
@@ -47,7 +47,8 @@ mxm_shadow_rom(struct nvkm_mxm *mxm, u8 version)
 	struct nvkm_bios *bios = device->bios;
 	struct nvkm_i2c *i2c = device->i2c;
 	struct nvkm_i2c_bus *bus = NULL;
-	u8 i2cidx, mxms[6], addr, size;
+	u8 i2cidx, mxms[8], addr;
+	u32 size;
 
 	i2cidx = mxm_ddc_map(bios, 1 /* LVDS_DDC */) & 0x0f;
 	if (i2cidx < 0x0f)
@@ -56,22 +57,32 @@ mxm_shadow_rom(struct nvkm_mxm *mxm, u8 version)
 		return false;
 
 	addr = 0x54;
-	if (!mxm_shadow_rom_fetch(bus, addr, 0, 6, mxms)) {
+	if (!mxm_shadow_rom_fetch(bus, addr, 0, sizeof(mxms), mxms)) {
 		addr = 0x56;
-		if (!mxm_shadow_rom_fetch(bus, addr, 0, 6, mxms))
+		if (!mxm_shadow_rom_fetch(bus, addr, 0, sizeof(mxms), mxms))
 			return false;
 	}
 
 	mxm->mxms = mxms;
+	mxm->mxms_size = sizeof(mxms);
 	size = mxms_headerlen(mxm) + mxms_structlen(mxm);
+	if (size < mxms_headerlen(mxm) || size > U8_MAX) {
+		mxm->mxms = NULL;
+		mxm->mxms_size = 0;
+		return false;
+	}
+
 	mxm->mxms = kmalloc(size, GFP_KERNEL);
 
 	if (mxm->mxms &&
-	    mxm_shadow_rom_fetch(bus, addr, 0, size, mxm->mxms))
+	    mxm_shadow_rom_fetch(bus, addr, 0, size, mxm->mxms)) {
+		mxm->mxms_size = size;
 		return true;
+	}
 
 	kfree(mxm->mxms);
 	mxm->mxms = NULL;
+	mxm->mxms_size = 0;
 	return false;
 }
 
@@ -113,6 +124,8 @@ mxm_shadow_dsm(struct nvkm_mxm *mxm, u8 version)
 	if (obj->type == ACPI_TYPE_BUFFER) {
 		mxm->mxms = kmemdup(obj->buffer.pointer,
 					 obj->buffer.length, GFP_KERNEL);
+		if (mxm->mxms)
+			mxm->mxms_size = obj->buffer.length;
 	} else if (obj->type == ACPI_TYPE_INTEGER) {
 		nvkm_debug(subdev, "DSM MXMS returned 0x%llx\n",
 			   obj->integer.value);
@@ -188,6 +201,8 @@ mxm_shadow_wmi(struct nvkm_mxm *mxm, u8 version)
 	if (obj->type == ACPI_TYPE_BUFFER) {
 		mxm->mxms = kmemdup(obj->buffer.pointer,
 				    obj->buffer.length, GFP_KERNEL);
+		if (mxm->mxms)
+			mxm->mxms_size = obj->buffer.length;
 	}
 
 	kfree(obj);
@@ -220,6 +235,7 @@ mxm_shadow(struct nvkm_mxm *mxm, u8 version)
 				return 0;
 			kfree(mxm->mxms);
 			mxm->mxms = NULL;
+			mxm->mxms_size = 0;
 		}
 	} while ((++shadow)->name);
 	return -ENOENT;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/mxms.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/mxms.c
index 9abfa5e2fe9f..895a1d76b80f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/mxms.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/mxms.c
@@ -60,14 +60,21 @@ mxms_headerlen(struct nvkm_mxm *mxm)
 u16
 mxms_structlen(struct nvkm_mxm *mxm)
 {
-	return *(u16 *)&mxms_data(mxm)[6];
+	if (mxm->mxms_size < mxms_headerlen(mxm))
+		return 0;
+
+	return ROM16(mxms_data(mxm)[6]);
 }
 
 bool
 mxms_checksum(struct nvkm_mxm *mxm)
 {
-	u16 size = mxms_headerlen(mxm) + mxms_structlen(mxm);
+	u32 size = mxms_headerlen(mxm) + mxms_structlen(mxm);
 	u8 *mxms = mxms_data(mxm), sum = 0;
+
+	if (size < mxms_headerlen(mxm) || mxm->mxms_size < size)
+		return false;
+
 	while (size--)
 		sum += *mxms++;
 	if (sum) {
@@ -81,7 +88,13 @@ bool
 mxms_valid(struct nvkm_mxm *mxm)
 {
 	u8 *mxms = mxms_data(mxm);
-	if (*(u32 *)mxms != 0x5f4d584d) {
+
+	if (mxm->mxms_size < mxms_headerlen(mxm)) {
+		nvkm_debug(&mxm->subdev, "header too short\n");
+		return false;
+	}
+
+	if (ROM32(mxms[0]) != 0x5f4d584d) {
 		nvkm_debug(&mxm->subdev, "signature invalid\n");
 		return false;
 	}
@@ -97,15 +110,21 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 	     bool (*exec)(struct nvkm_mxm *, u8 *, void *), void *info)
 {
 	struct nvkm_subdev *subdev = &mxm->subdev;
+	u32 remaining = mxms_structlen(mxm);
 	u8 *mxms = mxms_data(mxm);
 	u8 *desc = mxms + mxms_headerlen(mxm);
-	u8 *fini = desc + mxms_structlen(mxm) - 1;
-	while (desc < fini) {
-		u8 type = desc[0] & 0x0f;
+
+	if (mxm->mxms_size < mxms_headerlen(mxm) + remaining)
+		return false;
+
+	while (remaining) {
+		u32 desclen;
+		u8 type;
 		u8 headerlen = 0;
 		u8 recordlen = 0;
 		u8 entries = 0;
 
+		type = desc[0] & 0x0f;
 		switch (type) {
 		case 0: /* Output Device Structure */
 			if (mxms_version(mxm) >= 0x0300)
@@ -119,6 +138,8 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 			headerlen = 4;
 			break;
 		case 4: /* GPIO Device Structure */
+			if (remaining < sizeof(u32))
+				return false;
 			headerlen = 4;
 			recordlen = 2;
 			entries   = (ROM32(desc[0]) & 0x01f00000) >> 20;
@@ -128,6 +149,8 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 			break;
 		case 6: /* Backlight Control Structure */
 			if (mxms_version(mxm) >= 0x0300) {
+				if (remaining < 2)
+					return false;
 				headerlen = 4;
 				recordlen = 8;
 				entries   = (desc[1] & 0xf0) >> 4;
@@ -136,6 +159,8 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 			}
 			break;
 		case 7: /* Fan Control Structure */
+			if (remaining < 2)
+				return false;
 			headerlen = 8;
 			recordlen = 4;
 			entries   = desc[1] & 0x07;
@@ -145,8 +170,13 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 			return false;
 		}
 
+		if (headerlen > remaining ||
+		    (recordlen && entries > (remaining - headerlen) / recordlen))
+			return false;
+
+		desclen = headerlen + entries * recordlen;
 		if (mxm->subdev.debug >= NV_DBG_DEBUG && (exec == NULL)) {
-			static const char * mxms_desc[] = {
+			static const char * const mxms_desc[] = {
 				"ODS", "SCCS", "TS", "IPS",
 				"GSD", "VSS", "BCS", "FCS",
 			};
@@ -171,7 +201,8 @@ mxms_foreach(struct nvkm_mxm *mxm, u8 types,
 				return false;
 		}
 
-		desc += headerlen + (entries * recordlen);
+		desc += desclen;
+		remaining -= desclen;
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h
index fcacb6c6a7f7..ad93a7ceac29 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h
@@ -9,6 +9,7 @@
 struct nvkm_mxm {
 	struct nvkm_subdev subdev;
 	u32 action;
+	u32 mxms_size;
 	u8 *mxms;
 };
 
-- 
2.43.0

