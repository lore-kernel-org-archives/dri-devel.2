Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE05FC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBB910E039;
	Mon,  3 Aug 2026 12:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MwhTNfmN";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0782010E039
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 12:48:13 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso24410685e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785761291; x=1786366091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VGjGkq5L6MDjlfKKy2P7J8KhfuvXYKdXAT9JWAbQVl4=;
 b=MwhTNfmNCN2swkBYbcG5xav4+TteSmq9887YD0ZT3rVYIJw6/vMKSB3dd+Bu87IAgD
 TtJDrPDuG6iZZ0+U9Vmlo+8MBoAJXdyKSLS+cExq8VzBc1Y0Bs2We7XPUTnZbiW1rhgF
 jZayG32RUlOZV+cBDLhR84QGuvxnzIWAO9Dbfib+R7CMvu5ozBcl02kZ1PAYoeH0dgIR
 tM1yt4/HdFHimmVI7G1TfQhA/GLsLqKo/3HKQhZovPb2TfpvWstzqs2j2kzO74orCl6S
 7WxIt4a5jBPV5y3nQJkIOd2J1sWkb0dX5qXG04sFxKbyMU3vcUf8BKaih3fBx8szRBwH
 YRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761291; x=1786366091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VGjGkq5L6MDjlfKKy2P7J8KhfuvXYKdXAT9JWAbQVl4=;
 b=F9PwUaSKCWlohDdZ3MKU2wAZBZyVwKoI0DhM173itpEIQt3andgSavY2r9pZsRwNst
 ZEqzpvlNdhKb9Z8WfkyltQqN4p9ByNgeJK3bpKTQBrafJfOwFoqEf7DSaxxrKTQGSzz1
 oB7o9AHqyJKLFinVyXCjaWMCnzFapDZ41cyrDg4q0wJQWe56aPCrJFTl/om8fDog63mU
 4jJHW1CVIDbLAP1BhSqTh3c6vph6EIE2JS6BkHlGuE6k6ZiOzxBrTTeymBk4P/6w25Fj
 F2fc0WDPKR9yiUOd3owSZFekr+MijlAWxse+d7qUbxyyM3fIAe81NQbBKtXLdVU2V6IU
 Q9gA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptxt0kid1UJSgAy/34ulMWApFJh1FQoNawwYNoTM0qP68BRMNEe80e82N810MDuKUjiWbR/cio7FQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl/WXpln8IfT/brOO3PphGdKKr/QZf6AYVzL+bLB3jj3CaCtvq
 M0K6qUTUs20469YddNxCQv0PTSOiZM9BZeblGsnmfkRSDczGs7z/FTAF
X-Gm-Gg: AR+sD1263Ydrs5k4a0z+lZSfWchJED/z1g1ZG4qbqx40WPVX0JMPH4TPVIT/v3/8D/i
 bBJTOWwd8/h3pDZskzBuKmGFcF6MnN8kCLHgs5++7x0CSQQXTvC9ImDKfwyOamZ3O780k7UXS1w
 S8xV2A5FLj4Ir+2XRwZXOtECTBImlldO2K0n7EDDtaWh7laN1A98dbQzGj+uFldM3dAyQKLOIs7
 YkiBqlEmTLXTEczzpDahwLfq9/3rPCWr4WTBtsWXbs+CkYG9P6osjJyA2qLQPe4rfneLySlpGG8
 cdsin4HJ9JlcPbotdYJyCslI1FzjIcLImLoGBkIJjGe48STU+Yz/6yDcLPzO6vDFkyhAFTO6oIl
 KSePcSzbjlmzMidmMguSThYTutP7rX16PCF1Mr+H1cJSwB/KHMIR/HzucdY3Qe/dGL+bNAjiAKg
 Blz68ns3l5pQXkN/90sxZoOdL3snXMXl7SNX7BziuBUCljh0fG65/h/CgsoWQA52oqPwRmkp5m3
 kYgCRf3VwTREurJ+sO7O9Mv
X-Received: by 2002:a05:600c:3b01:b0:493:f0f5:f2d7 with SMTP id
 5b1f17b1804b1-4980c66c90fmr179358945e9.7.1785761290518; 
 Mon, 03 Aug 2026 05:48:10 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:d656:7858:1438:5d8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562a38sm32378263f8f.21.2026.08.03.05.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:48:09 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] drm/panthor: use local variables for firmware interface
 counts
Date: Mon,  3 Aug 2026 14:48:06 +0200
Message-ID: <20260803124807.27094-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2125ea5a-d878-4032-9338-d0cd0970ccfa@arm.com>
References: <2125ea5a-d878-4032-9338-d0cd0970ccfa@arm.com>
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

panthor_fw_init_ifaces() validates the firmware interface group count
before iterating over the CSG interfaces. panthor_init_csg_iface() does
the same for the per-group stream count before iterating over the CS
interfaces.

Store those validated counts in local variables and use the locals as the
loop bounds. This avoids reading the same control interface fields twice
and makes it explicit that the loops use the values that were just
validated.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
v2:
- Reword as an optimization/cleanup instead of a firmware trust-boundary fix.
- Drop the Fixes and stable tags.

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

