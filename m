Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1A4C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9000410E942;
	Mon, 20 Jul 2026 13:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2wUoyn/";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660FF10E942
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:55:43 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495437bb891so30662795e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784555742; x=1785160542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N1G6MUTItawGdl9kT6xgYXezu1UMlR9b+KB/O0a8o3c=;
 b=U2wUoyn/Z2tl01rXoyOAnmOLRwPIsNSX72szhE/QNxtLn/zmLYsj9arFZARPi1OUie
 SEkJUyMMZ2JrvQYxWJ66KpzyR6K/sVcgHnoFpCfLvdDrcFRqTYd3CgY974jM6kVIooRT
 lvLZj4vpwO/FMuS/SvE7eWvaMlQ/Df8xUaTd8mjxxHiQAtYRHzqDX1/m4u1ngur4jsPt
 FW1mr2xsqzuqAdXBDtMT6n8PGbH+dNvW5gO+Xlpucz1g0rbl/cNDdIypiNoRkvvlr7jq
 w9sVcMxQQd4YLa8/GOkoreYOiZpLHs6zI2zJEi5Oqe01vCBXZYPn2mnKXFusKKBtIGBr
 lygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555742; x=1785160542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N1G6MUTItawGdl9kT6xgYXezu1UMlR9b+KB/O0a8o3c=;
 b=TnxJAmKlB3m8Ox6ooJoWTBwWbGDg9FQhbP+3FxZLh5S2fulrBpjmjIXoCcRcuIuv4U
 34CuOHj59ZZZHFYPQmtne9JL91nienC7mt/C/wEHcjWqLakqwoApj4w5oN3+UwSld3hy
 ZTm08YicnnHE3rLsxOtqp+1G/ACf5ShMHhGyjDt56JfoM2D4fwhY4AYHWRgmquLMHSal
 YZXBKV0ADHDvqElkGtTFCfjofpLd9HgCBGmMNHrIIFtOPBj9C5f6g27b+FejEAHZZfex
 /Ewkb6rRSTotjx9TisK7Tpk7lfvamlz9QGYrs4Y7iAKaumSlqlARqzgnHuaoGr3xOlfR
 4Vcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4yOkV0NTZlVPdu36xQblw2Thgt58QtA62WJBeZDvdp6acOFnL5ZMZx1xXjJoFlVr4r4FVeXPwMjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyo4fTaVgIdlZATXsINsm7JCJWCX++opYcKu9x3noP+nF1Q2TtY
 a+gVJHbWYhnaDGuIICWiYBMa5SMdoQzoE43eeTj+kcentri1y11Kq4Tt
X-Gm-Gg: AfdE7cnk3o+6kIIdFOiRqvos0sl3kP9dmlsyrWokGHWYtmZBbtLTc4g/JWnbCClcnjL
 Y2K3VttinjawpB3WCjFRyIHNqYPC8iTsl9gHBLNgFN/4Z6m4dx9CyYWcHKiwtVu/KLDmfYTEoNn
 AmUcCJfj+B3kyPXTjkhbvcNmQson7fxFfelLMDB2bPrja1+75tKKvMfzTiiT2uXtN+JnSvE4vIW
 N9sewzi2VkGviLzR3PIE7UhBPVCWPDjMhRFwp1zb2CtrG/BF8A0mZXSayODg5q9YFzbHwEF6mnl
 MoY0wi7gVzTp4tNGSfOaBfDFg305ydXnZmSWi44XWIi2bOf1RDYqJ5VSiI9EhBe88pWa0yWHprz
 TysZvgUCP1Quel7Je8EBL2rszMIAAW60wQ3FrrXQnEX7ohqBnYN3naKJxfv5feDh5840N/mFxDX
 12qsuopc0Doxu5ueLipweRvH47Bykt1n6iqyAC+RfJTniVQdno/Q==
X-Received: by 2002:a05:600c:6289:b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-4954a33dc26mr146084685e9.13.1784555741410; 
 Mon, 20 Jul 2026 06:55:41 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:177b:1470:c99b:b6d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b87c6sm512521655e9.7.2026.07.20.06.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:55:40 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: snapshot firmware interface counts before loops
Date: Mon, 20 Jul 2026 15:55:18 +0200
Message-ID: <20260720135518.17927-1-osama.abdelkader@gmail.com>
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

The firmware exposes the global group count and per-group stream count in
the shared control interface. These values are validated before being used
as loop bounds, but the memory is shared with the MCU firmware and can be
changed after validation.

Read each count once with READ_ONCE() and use the validated snapshot as the
loop bound. This keeps the loop bounds consistent with the validation and
prevents the compiler from reloading a firmware-controlled count during
iteration.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index e2fcbd639c3c..6e6da98d795e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
 	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
 			   ((u64)csg_idx * glb_iface->control->group_stride);
+	u32 stream_num;
 	unsigned int i;
 
 	if (iface_offset > shared_section_sz ||
@@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
 						 sizeof(*csg_iface->output));
 
-	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
-	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
+	stream_num = READ_ONCE(csg_iface->control->stream_num);
+	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	if (!csg_iface->input || !csg_iface->output) {
@@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 		}
 	}
 
-	for (i = 0; i < csg_iface->control->stream_num; i++) {
+	for (i = 0; i < stream_num; i++) {
 		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
 
 		if (ret)
@@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
+	u32 group_num;
 	unsigned int i;
 
 	if (!ptdev->fw->shared_section->mem->kmap)
@@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 		return -EINVAL;
 	}
 
-	if (glb_iface->control->group_num > MAX_CSGS ||
-	    glb_iface->control->group_num < MIN_CSGS) {
+	group_num = READ_ONCE(glb_iface->control->group_num);
+	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
 		drm_err(&ptdev->base, "Invalid number of control groups");
 		return -EINVAL;
 	}
 
-	for (i = 0; i < glb_iface->control->group_num; i++) {
+	for (i = 0; i < group_num; i++) {
 		int ret = panthor_init_csg_iface(ptdev, i);
 
 		if (ret)
 			return ret;
 	}
 
 	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
-- 
2.43.0

