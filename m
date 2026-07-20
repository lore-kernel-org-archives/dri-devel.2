Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24EAC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D3A10E8CA;
	Mon, 20 Jul 2026 11:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J9iVctUv";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAFD10E8CA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:49:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-472326ca506so7714798f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784548161; x=1785152961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qNwj0cy3My+7S0Jfbfh0/9yw10VBWKnPBk+HsO2GxKY=;
 b=J9iVctUvGYSB2/XJuYbiFpF7+1cwBweo9FEX6eOhxzUp7lxo9TDhGV98tiunbrEi18
 ANcllBQAi55p45G2xCNiDXglnHhVO6bqM9y4PKK9VFrIWqVxKA1madBt23jbszgxAGz0
 m58O6/nXFXl6uuESppY+qNtaol4cidpYQqy5WdwUXquLi79JgrTo+yqmv29nEeUnjId6
 /T5d87pj6XYScjV8akFnE7hyeAwgOuNmULcMpfvQyzGXgAxkRItT9VZ66OzNM9Bbv0EY
 0OcXBZnAM1DZs561gb4AM2l1S5KRb07Hh1sY4li0Ub921fQyxp6wUNwWGCO+oaba7JTn
 iD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548161; x=1785152961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qNwj0cy3My+7S0Jfbfh0/9yw10VBWKnPBk+HsO2GxKY=;
 b=RDUmD+3QdCT9t/24NFSCFoVAHzlhGHzBlQGOvmV7uDQEcd6sqH8FP7JL/CdkhRlSyh
 coTBCHxMa+OV6ffqU7hIaQXLJ3PPkKbNrAWe/enK3negM6SOfO1b3SdfHBRAvG+v0BPp
 aql46BQK19fIC7lEprwOIpSDqVpd0mKPDI8aO55wYKxq2kB/WUPcy9/+NQmuiaZEP6Ub
 +qkJNBkhjNUYt9Q6U6ulPTriuopS2wpnPt9RxnFRAxd8q0mi24JTvTOLaMie6IvmRrdZ
 8gYvR8fKMim+WWefeOPGcmQSA0z+5Qs6vrnEv5JTHsE5XLI9aLQl+D13EnY37//DRWNX
 6Tsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKxxh6qefTZlsJGQBDGv5hnkfO3/aziKoMv7QTc2JSRKNoKV1rDD2fdUUzYrGwaYL/Xg7TWCxkvDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjpaWxUyn7CHHLImtsWnsY3xI4KE/5k0zLMKshgGygSVkUy3Ff
 YrtVq1rd8OjlKULRRELUFwvBF17qsDRxA9r2blopIdmwJSn3q+DbSIvw
X-Gm-Gg: AR+sD13gYuJZ9rMNX0BzwDdxVzq8mjtDzCsuXSb5f6Sacp0euLipFR4Eq77mxNUK2i2
 wXtiU+FUw8fmLvx2RJlUravRLLOcT78paPl0IA+ugGxxaKqxZZtY0lLncCGp/J5pDTRT1CRXnLn
 gwL7jerll98f7J1TkZsCe/G07UFoKf+EgaEJfwD9lSGob6vm8DGiJ+1TDrwkbdeVYvZnBqHZHtW
 nUIRU7XOhEGr309bMcwJM0T3ZlJeuzxMK3/hKS9LTS9mTP0j8ooClGi3HveSFo+k4tmDaSujht8
 2kvOUbzV3q5EKDXPUZl9AuQDwYORoqIRip0lcPF0fdZEwcnZFJofmU7QYJEcMvodR1nIzy3q9zA
 vUXe3Wk/nN9AetsbjFHPipHBWU8TY6exULU5QrGI5T+P3RA3Blz+gr1mhPaOUJylKpfFvraNDnj
 xcxBCZ/v4YjBGXrYZ49a76s+HIoJe22gK/uHeIM8GHQJGjjjwZs5C9J/oQ2x4=
X-Received: by 2002:adf:eb8d:0:b0:478:77c1:7876 with SMTP id
 ffacd0b85a97d-47f6233d208mr13018808f8f.57.1784548161324; 
 Mon, 20 Jul 2026 04:49:21 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm27588500f8f.4.2026.07.20.04.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:49:20 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: validate firmware interface structure sizes
Date: Mon, 20 Jul 2026 13:49:17 +0200
Message-ID: <20260720114918.15973-1-osama.abdelkader@gmail.com>
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

iface_fw_to_cpu_addr() only checks that the firmware-provided MCU virtual
address points inside the shared section. The returned pointer is later
used as a full firmware interface structure, so accepting an address near
the end of the shared section can still lead to out-of-bounds accesses.

Pass the expected object size to iface_fw_to_cpu_addr() and reject ranges
that do not fit entirely in the shared section.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 30 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 9d0e1fafdce2..eee2bc7e8541 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -870,18 +870,24 @@ static int panthor_fw_load(struct panthor_device *ptdev)
  * iface_fw_to_cpu_addr() - Turn an MCU address into a CPU address
  * @ptdev: Device.
  * @mcu_va: MCU address.
+ * @size: Size of the object pointed to by @mcu_va.
  *
- * Return: NULL if the address is not part of the shared section, non-NULL otherwise.
+ * Return: NULL if the object is not part of the shared section, non-NULL otherwise.
  */
-static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va)
+static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va, size_t size)
 {
 	u64 shared_mem_start = panthor_kernel_bo_gpuva(ptdev->fw->shared_section->mem);
-	u64 shared_mem_end = shared_mem_start +
-			     panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	if (mcu_va < shared_mem_start || mcu_va >= shared_mem_end)
+	size_t shared_mem_size = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
+	u64 offset;
+
+	if (mcu_va < shared_mem_start)
+		return NULL;
+
+	offset = mcu_va - shared_mem_start;
+	if (offset > shared_mem_size || size > shared_mem_size - offset)
 		return NULL;
 
-	return ptdev->fw->shared_section->mem->kmap + (mcu_va - shared_mem_start);
+	return ptdev->fw->shared_section->mem->kmap + offset;
 }
 
 static int panthor_init_cs_iface(struct panthor_device *ptdev,
@@ -906,8 +912,10 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
 
 	spin_lock_init(&cs_iface->lock);
 	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
-	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va);
-	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va);
+	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va,
+					       sizeof(*cs_iface->input));
+	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va,
+						sizeof(*cs_iface->output));
 
 	if (!cs_iface->input || !cs_iface->output) {
 		drm_err(&ptdev->base, "Invalid stream control interface input/output VA");
@@ -957,8 +965,10 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 
 	spin_lock_init(&csg_iface->lock);
 	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
-	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va);
-	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va);
+	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va,
+						sizeof(*csg_iface->input));
+	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
+						 sizeof(*csg_iface->output));
 
 	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
 	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
@@ -1015,8 +1025,10 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 		return -EINVAL;
 	}
 
-	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va);
-	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va);
+	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va,
+						sizeof(*glb_iface->input));
+	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va,
+						 sizeof(*glb_iface->output));
 	if (!glb_iface->input || !glb_iface->output) {
 		drm_err(&ptdev->base, "Invalid global control interface input/output VA");
 		return -EINVAL;
-- 
2.43.0

