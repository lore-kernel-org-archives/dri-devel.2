Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDF6C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB8610E00D;
	Mon,  3 Aug 2026 14:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQbQIHqT";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E075B10E00D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:12:00 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so12945015e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785766319; x=1786371119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ri6+Lm8RQVb+XPY7XH6+RgGkE3WKXcXpIGv8fON2pYg=;
 b=OQbQIHqToESUv/eqeGLkAsSazYAc+WY8ztDw6drdatTuDp98x211958diLJ9vV7tMK
 yqWQc/ro5C2kilqkFafGWIh1KQ+xJ8sLcycq3cX6Bl/AaY1eLQODaVDmNZSbaCUFI1ft
 wUDsciBASjcwdxAwdnLTO2heOnuHqdji4VEfFtjIXYd9KnUXNcKWp9j0roPYtGyDfZU3
 FeYHzhTKF+eyplLyD0qvINQPA4oCXiLyRgxkS80okqv/OIczYLwA5y1/XGT+s2LUYKfm
 Klsv6J/cnrVfR3Kv/rwGBsjr4dekBz3pCeBOTtdyTNLW6xB49g8Qs3PFD8Mcl1BH65iW
 FImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785766319; x=1786371119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ri6+Lm8RQVb+XPY7XH6+RgGkE3WKXcXpIGv8fON2pYg=;
 b=kT1OT7tRanXMdqIrCK6EpetENHMB/r4hZB91EASspSUfNYmw78GBZ/DE8/ozLnzaFK
 09Jjce4e6dVxVIsFJmyxjW8hZLjJitKKI8LxgTKlHzxxVD5g59V+XSy+hnhgNqnzWDAd
 zvuUJEe533qIBv6rJpPTTea1R2Bfn79drvpYjRRRun/bsMHR7kuYSZZyi/yj36R1E92L
 4RHhaSMl5SjfH0fETrySTgnhGM2e755kPsCfuF8J9RVJbkzUhPO4KN1w1lgqYnxHVtQb
 HnTPhDVMpnVvI1cACylNQUxhq8+plZWWE3C4lBLSFIKJzXfv6WCbIbykvr0Ih/c/roiJ
 4rdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnPfZHu/UAza9fUnuWerctxcs7iydmfHmWyBGOQiMIqZQMZQYmqfOiHRxlvYPAihsxGHJLVer1bxo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1mRgJG10J01pLl9bUuOYfQP7FEcZv7+iuuOlqOw1q7k4eC1Zs
 seGJ4jN13zCPFQAAjKh4mpnWptPLnELR78+xZ3wLrvGlSNYipAFsXZmI
X-Gm-Gg: AR+sD130DevZ5jgTNrykSh52O1IQDPOfwFil614AvpnXJCpt1ZawI7Q++8hv3DejDzi
 yd9zOTtUIxouLJgl58lxA7PbOexXaZwdrKpsn2hNzMO4if14C1wUUMu25Qrq1MHc4tvJA64meDL
 N+0hKrKea7W1D5C/FWY9oyqH/LEPTazFXJSlboBJrVCepgxUGW6uyLXpcctP7EhxaSBBZNN5LB1
 9YBXZAj99UMr51Np+N342NjPrEahHnx9QCEHftL7jE/eEd491mzKpzIgHILs48ig9GOyNyD4fO6
 RMsgC85hQ40NypeszqkxDMtwMj/lPrl/e2Pp7sCYwQp1Pm1NHDYG21LHxLJYU7S6V36U+GQLqMM
 XJlRzu1a9BucKkwD7NsaHwnP14uD1w3bSWeNA0Za0LBtHvMA4wZ1EfWnkN9lW9vYBnnlWUPySyf
 tGe8r2uuKgGx6MvTaX3Ut+4kczG5Sf+dhO1hnD4Xr/F+znd09/c6VvqhSfivwz0L1qzhj/fUyXJ
 e8lO8lG+VaxeSKlXH3J5UMX
X-Received: by 2002:a05:600c:5914:b0:495:5cda:52ec with SMTP id
 5b1f17b1804b1-4980c662d03mr200306225e9.16.1785766318949; 
 Mon, 03 Aug 2026 07:11:58 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3586:7967:eb8:8b0d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cf404sm32589557f8f.1.2026.08.03.07.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:11:58 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v3] drm/panthor: use local variables for firmware interface
 counts
Date: Mon,  3 Aug 2026 16:11:49 +0200
Message-ID: <20260803141149.68182-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803153555.70ca46de@fedora1.home>
References: <20260803153555.70ca46de@fedora1.home>
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
as loop bounds.

Read each count once with READ_ONCE() and store it in a local variable.
This avoids reading the same control section field twice and makes it
explicit that the loop uses the same value that passed validation
to protect against self-modifying control sections.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
v3:
- Add comments explaining the READ_ONCE() usage.

 drivers/gpu/drm/panthor/panthor_fw.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 8411c468bdac..b2ccb81f280c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -954,6 +954,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
 	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
 			   ((u64)csg_idx * glb_iface->control->group_stride);
+	u32 stream_num;
 	unsigned int i;
 
 	if (iface_offset > shared_section_sz ||
@@ -967,8 +968,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
 						 sizeof(*csg_iface->output));
 
-	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
-	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
+	/*
+	 * To protect against self-modifying control sections
+	 * take a single snapshot from the control section so validation and
+	 * iteration use the same value.
+	 */
+	stream_num = READ_ONCE(csg_iface->control->stream_num);
+	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	if (!csg_iface->input || !csg_iface->output) {
@@ -986,7 +992,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 		}
 	}
 
-	for (i = 0; i < csg_iface->control->stream_num; i++) {
+	for (i = 0; i < stream_num; i++) {
 		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
 
 		if (ret)
@@ -1010,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
+	u32 group_num;
 	unsigned int i;
 
 	if (!ptdev->fw->shared_section->mem->kmap)
@@ -1035,13 +1042,18 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 		return -EINVAL;
 	}
 
-	if (glb_iface->control->group_num > MAX_CSGS ||
-	    glb_iface->control->group_num < MIN_CSGS) {
+	/*
+	 * To protect against self-modifying control sections
+	 * take a single snapshot from the control section so validation and
+	 * iteration use the same value.
+	 */
+	group_num = READ_ONCE(glb_iface->control->group_num);
+	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
 		drm_err(&ptdev->base, "Invalid number of control groups");
 		return -EINVAL;
 	}
 
-	for (i = 0; i < glb_iface->control->group_num; i++) {
+	for (i = 0; i < group_num; i++) {
 		int ret = panthor_init_csg_iface(ptdev, i);
 
 		if (ret)
-- 
2.43.0

