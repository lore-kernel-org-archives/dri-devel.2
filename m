Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3959910E35B;
	Thu, 16 Jul 2026 14:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUAyU1kI";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7121F10E35B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:40:34 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493b1710405so37304455e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212833; x=1784817633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mpcBzLLGhgmpRm2ChWHisnZOSJCjUEDvDGQ4AxFAGiU=;
 b=XUAyU1kIOk+8je8hPxLz8CWaX6ZtKUPlspo8TAv3cQNxnSPFw7G7UrEwjLXpzAmwuf
 0RHfhXf8sI6IzwSTvdLhBqMoXYDFKMJQnSEb1r0LV1EXl7+TXZDesFe7w6pyHW01pjtg
 VpSQXU5IKbw0iA4QiiK/1cNOVDelzkJraHXPvBl7gGwkavb15P4Cd/bbn+gh6o5gRdiU
 hfrnGMsdb2UalIYbNDscnZwf0a6J7mnkbJMuo5YqBbffRcV+Wn83g7WcjgrlTdNBlgau
 WU+PS3ggWxP53LMYXZF0Cvk46ljmTSuq7NP/LaALvRw+T9zNLUmzFDbtCYdWRT+C5Vl8
 C8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212833; x=1784817633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mpcBzLLGhgmpRm2ChWHisnZOSJCjUEDvDGQ4AxFAGiU=;
 b=ZlQ0e3j0oi22u2GbTzXnUZtjiGfWwspQD9XWehHJ+b9PEy5eaJxIXh4zNTWwZ3Gpii
 ZuhTZiM35stXbyZidPm7KKebQyrA29/ajbv0bZfriwvSk+p2Ab+XegD3VDeV16duAsQx
 lQ9MPHEXceE0KwfV5BE2Jt9rDg/2KomzD3aImdeC//0fbXKzs9H5F/+xvT5lFyiyITVV
 M6+nCinUywFP/3VddWbI12EJB94T9HO5UArV+vAPOYAJ5BQsPvLkAHmiFJnsz8wdoCUX
 6yC7WVkE2Q701riI2t6nLJMAQwobix1my7yNTeXdjsqd/y0jFvR5IlhQ5RR3BttfXUIK
 pPRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOoF5t4AW1asEu+NkFVsWB3z1tJWyAjmIqsiZ9TIDHosVbzGBSbwf0sy+C21mPvTkR0B2JsUg/2GA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8XwfM7joVEz5Y08fH8ubbTjQXLGukdeBp6GtD4D3XsGM0m5Hh
 wHTKHRMedO4er1BK6+PYG3tybsMwQ6wzQTAbsaDtfLhrlhfDIZwnNQfE
X-Gm-Gg: AfdE7cnF+Uo2ralcrn28bYfd66WLaiw4xPuSF30oE1JhXIUgWQ3AtY6ab26Bdtr4gH+
 06AwlJTBM1dly3VkVHvTOf39QAdbDaSSh1fBXjByJYNeAfys3EaKdsdZ7Q3sBEBc+dCT2qpN9yk
 Bu1Qkg0h3TDDEX0aDkoXjFinrq8epTyf2gI5o9FtBXWIqMCYR9zWE5lKQmnt/DynEH/DxLFcJxq
 s6UA6TPFsq1wzCkFWwNNMZZPF3RopvP8iKm1woMcqfop6er9DTZMlsXojAlIQz7Qe7VP7nCti3Q
 B80rAokfcIEETgLeQopjvEgexJSea/SUd4MJ6zaAG0XMRS2HaTgM7/RzayAwLtIgeII3ipYtxRf
 NnqIal6WeNWNI4qIjEqBnjwaIa2lsp3Kj+jB/UFBMVDXBHAlLn4pMmEIDmuTEmXzvHm/jcw402s
 ItbD9JoRItIUbS5xgb17ForbpyvTff5VjRwrHb
X-Received: by 2002:a05:600d:6443:10b0:493:f762:45d4 with SMTP id
 5b1f17b1804b1-495158c693bmr120308635e9.2.1784212832541; 
 Thu, 16 Jul 2026 07:40:32 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:8529:198:eaf9:708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541eb7372sm85145815e9.13.2026.07.16.07.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 07:40:32 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: reject firmware sections with oversized data
Date: Thu, 16 Jul 2026 16:39:38 +0200
Message-ID: <20260716143939.21903-1-osama.abdelkader@gmail.com>
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

In panthor_fw_load_section_entry(), the data size to copy is calculated
without validating it against the allocated section_size:

    section->data.size = hdr.data.end - hdr.data.start;

If a crafted firmware sets data.size larger than the allocated memory,
this could cause a heap buffer overflow in panthor_fw_init_section_mem()

    memcpy(section->mem->kmap, section->data.buf, section->data.size);

Additionally, if the section->data.size exceeds the BO size, could this
memset underflow the size calculation, leading to a massive out-of-bounds
zeroing of kernel memory?

    memset(section->mem->kmap + section->data.size, 0,
           panthor_kernel_bo_size(section->mem) - section->data.size);

Reject section entries whose initial data is larger than the section size.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..a338c4f0a7f5 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -545,6 +545,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	struct panthor_fw_binary_section_entry_hdr hdr;
 	struct panthor_fw_section *section;
 	u32 section_size;
+	u32 data_size;
 	u32 name_len;
 	int ret;
 
@@ -595,6 +596,13 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
+	section_size = hdr.va.end - hdr.va.start;
+	data_size = hdr.data.end - hdr.data.start;
+	if (data_size > section_size) {
+		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
+		return -EINVAL;
+	}
+
 	name_len = iter->size - iter->offset;
 
 	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
@@ -603,7 +611,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 
 	list_add_tail(&section->node, &ptdev->fw->sections);
 	section->flags = hdr.flags;
-	section->data.size = hdr.data.end - hdr.data.start;
+	section->data.size = data_size;
 
 	if (section->data.size > 0) {
 		void *data = drmm_kmalloc(&ptdev->base, section->data.size, GFP_KERNEL);
@@ -626,7 +634,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		section->name = name;
 	}
 
-	section_size = hdr.va.end - hdr.va.start;
 	if (section_size) {
 		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
 		struct panthor_gem_object *bo;
-- 
2.43.0

