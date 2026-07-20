Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0D4C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F57A10E19F;
	Mon, 20 Jul 2026 13:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RT6v7b8Y";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C1810E19F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:44:56 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4955adb04e8so9349315e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784555095; x=1785159895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZl1SyHTfE2VJ6SL46lxQ8jIIKDocPqnasYj5shzWDs=;
 b=RT6v7b8YApCO9PysOs9DmwxizQYNktXTha1FxeyE64SR8b8zp5rO0hZKZaOhTCAcyh
 WSC30rhv9scu2o6sItoosdazbQU8mgBtqiSxiQzF2IbN1M0Tyk2FO8m9uDarhCcyg4ps
 8TJEeNmhM8c6tWIns8Eb9ArQEqDAP604J47TrQ/qSI1ccjb0wItE5At76+ReSWwxxjFB
 JRXk7XyZtAOdgQ2ebfRfNlKgRfx5sTw1AX9uDMU6hnhcW0iXPqTseCbLPeJVIirlImKs
 Oz2+7wJCjb0PUeHkpTZ3j2mzTBfFoXCIEN4E6VOLjbt4Ot+2R7GyIM+jlNKRQiv4zl3H
 7B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555095; x=1785159895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZl1SyHTfE2VJ6SL46lxQ8jIIKDocPqnasYj5shzWDs=;
 b=a7XcE3P4vu65GUSyb3KJFKVILXxVx0GP7gH25i6Z82/h2bHhaH1XUibJKIhMguK4Gk
 zwARgubxAbKg4PLcdVMs634Rzrglz4IROAN9ZT8+ZwrO6p6obGefq/vbCupCdJgOmAGf
 ifYMcp3aQiaau1OSeZDOZFFcQ0KnucpSO41H72/lf5sRf535/zt9vvGX1XE5sLn4xyhn
 RET5fXM8HBW4SE6iUR+7WmrcRh138q3I0hZLK7Ul4a/vDpiHj2fm2iDPJZ+F9uHxtxOd
 FpCrLKUcfDXdgUzxaXgvLpBJi1/96AqZGgMB60hc6daA3wtibMgCIAHAw878u2BbpeM8
 2B5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RregwJX9PPPMlr8+cxHGtRvc8RPavtX5RaFE9wOwl7nB9gSEF5aMjGrVWs05h1P/pl/87JJVhkC+gY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyur/BI2gpVAzZbe4ir7gTLoI2ledmMox3AayiTXj+Q2+5wh4MU
 UTC6DX5o2RRQ0kPmzPPZEjcrV0wkedNeFZXasqyOVBXTn1PEWkPaxm19
X-Gm-Gg: AfdE7ckdQAX8hjhh2rmkZF9mHqWqsMEow2QlqhkimX+7evrBPMWeplbO5gIvG/UWhwy
 b87n1C+kfYqLVW6iC5rhzXLcPVpQ8HD0wGP/55wpQ2oDxldXnPVjJbtcqlzAGjP5u3T4F5mH+4k
 B9RlGfMW196limKOgyXuwz2xagqY5PhqAdnnw5R4BKkNVJEp2YMvfpVkoMU1UcZeXgJWdWQv5su
 ZODz8BFjj3cFuayLGWR84us2BiR/HenaNCLi3H8kRzDV/dVfR8J/17Gywqzy5sMp/1tf6gfD8NN
 2m8Kt5mmpK8BrfYFSU2KGANBicwLsTvDckuPRB0ivJBkTHKHZvRnQlPnQ246L7BdqYfg8h3FTZc
 9Bh9vGkwHBCAr/XtRUHpitNYDZejX91tklF5T/j8udEUZvWANEHxV2Y72STt058JPoPy+90P/qV
 6d1tdz+HA7DzID/mrfadgZ9K6Q/oJnYMuwuO3sfrE=
X-Received: by 2002:a05:600c:3b1b:b0:495:443b:1bbb with SMTP id
 5b1f17b1804b1-4954a50c473mr146050565e9.25.1784555094606; 
 Mon, 20 Jul 2026 06:44:54 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:177b:1470:c99b:b6d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm272678615e9.6.2026.07.20.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:44:53 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: fix firmware control interface bounds checks
Date: Mon, 20 Jul 2026 15:44:35 +0200
Message-ID: <20260720134435.13377-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
control interface offsets with 32-bit arithmetic and the size of the host
wrapper structures. The offsets are derived from firmware-provided strides,
so the arithmetic can wrap before the bounds check, and the host wrapper
size is not the size of the firmware control interface being mapped.

Use 64-bit arithmetic for the computed offsets and validate against the
actual firmware control interface structure sizes with subtraction-based
bounds checks. Also validate that the shared section is large enough for
the global control interface before using it.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index eee2bc7e8541..e2fcbd639c3c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
 	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
 	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
-			   (csg_idx * glb_iface->control->group_stride) +
+	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
+			   ((u64)csg_idx * glb_iface->control->group_stride) +
 			   CSF_STREAM_CONTROL_OFFSET +
-			   (cs_idx * csg_iface->control->stream_stride);
+			   ((u64)cs_idx * csg_iface->control->stream_stride);
 	struct panthor_fw_cs_iface *first_cs_iface =
 		panthor_fw_get_cs_iface(ptdev, 0, 0);
 
-	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
+	if (iface_offset > shared_section_sz ||
+	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
 		return -EINVAL;
 
 	spin_lock_init(&cs_iface->lock);
 	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
@@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
+	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
+			   ((u64)csg_idx * glb_iface->control->group_stride);
 	unsigned int i;
 
-	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
+	if (iface_offset > shared_section_sz ||
+	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
 		return -EINVAL;
 
 	spin_lock_init(&csg_iface->lock);
 	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
@@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
 static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
+	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
 	unsigned int i;
 
 	if (!ptdev->fw->shared_section->mem->kmap)
 		return -EINVAL;
 
+	if (sizeof(*glb_iface->control) > shared_section_sz)
+		return -EINVAL;
+
 	spin_lock_init(&glb_iface->lock);
 	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
 
 	if (!glb_iface->control->version) {
-- 
2.43.0

