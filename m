Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B8CC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E6D10E1A8;
	Tue,  4 Aug 2026 16:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TYVCxiP5";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47EE010E1A8
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 16:00:54 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so24259645e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785859252; x=1786464052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=39LYywLmPcXSkKCIulhHDm7OS4Hd0MM7+1BesXcpx0I=;
 b=TYVCxiP5lzGdxODS2xrZD5gFtRe+IUSwNXRm6DWcbPU8TOKk3bZtCPxoHE2b7Hi/2M
 XZm8gfDG/Rj/2C4syOBq4+hEoq3NLcuvn3T4G5ufzN3ARCCg6Ui3qfs828jxb06YEBIH
 B3IXO0zWKN56kYNTJPOvtraMvMrNvflVmRa2QRUsGHI2zNsyUciJAGOmHU7JyXnDvT4o
 cAuc3hL+QxMhKEn3AXArlJyImJlKQR42oa4V+QSQ6eYWvHcs9k5Vvr03CGsTAotOI3rE
 Q0cCGPhvioajDp+k/e62ZUcgOoUdIfmNBInBXqRnY3oYBrUFLq+MANbz3qcWyp/+SZnk
 2t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785859252; x=1786464052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39LYywLmPcXSkKCIulhHDm7OS4Hd0MM7+1BesXcpx0I=;
 b=RV43mI8cohGfUAA0gKtU3n0pwRPPubVpOi1fymU/wqZt2qnrYqAxMcoo/27SZp1StX
 T2gRGApid8sXDnkLi0JGKwOBtVHlFEDwMuIRMTiFa1eJXNtt1BX7B40s2DZi5fkDE1KU
 M4RMmW9Vu+wjRS3nz6ZJJlHXshlLRWlni+kD6onM3EGRg22OprfCrMLnmP0ZTy0mpcC1
 wyGezWOLWS9dnnYBunX+7J0INYO/KLI1Es6PWZ75YMbDf56ti8qX9PEW3ZtsM/XVIylN
 hSZ5Spdllew7TM2NIl+N0l0eD9ZIdlz/DNrLrIWMU4fMhWF1e6eBHH8Ao76xB/CmoyMl
 lr3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgM6sDZ4b19ptc0XgaJUwcXYem3dJxnZJnfPBDe25fc87UtZcXq2OCNtEgOdMyYuLhcZ5ppPDGx5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0YN/05c8xc7VoB/utEJ0vIWdENKEiweuD90RcVsrxw+OyL8Qu
 vus/SfNWys36roOHv0siehvJ+rTZ4BzTV6V0uG3cyc6BsnV8NdLe1Wd8
X-Gm-Gg: AR+sD13u/cRhNQDV1dZaLeuZiTkH9p8PHe4u1LJ3t4CkJSebUx5lm9v9IOIjs1mzKOI
 F5YLGMyfPz4HcPRoZMwXA8TyM/x73WO3+zM8zx5/UlMn/D7iiIgJExXX4y3sI9nEJnvfpFGbAnQ
 I+H7ZJ4ru22Rns/bx6ozQGy/7drjA2l72qDedtyf4UxlxOTv+htEvgzCqZTQ3ebWbgU64N9ouGo
 7VLbZiBeJnEYGLFBUVf471cqFkPhtTNuWNNHEy2FEriObbgcMsGuceNRFFhk/JQmMqecD58Q5rn
 NGmrAn0ZIjVevmb0Je6Cr6WY8OV0LCXq31ZqjkoNwIpIiQaQ3aNLEANrEUhZ8dYcGOa7A2kOeES
 UFXMsIGcru6ApPxEeiUsNAW7L6BexQZvLRfWQuBhtpBH40SHLca10hXltnsfONbx+95Q8oSnT+1
 j2M6WWXuB2qsQ4WVsS34mGLmsXHziauF6pdb41+LY3yDSWMC4aYZ4n9HbYtP2fmrK2cQiN7bZP9
 eP+aD23k/t7UwTLfUcicCwRDw==
X-Received: by 2002:a05:600c:1992:b0:498:28b:1045 with SMTP id
 5b1f17b1804b1-4980c645611mr301569525e9.3.1785859252122; 
 Tue, 04 Aug 2026 09:00:52 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b6d0:3270:8423:f239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807ba6abesm260913495e9.2.2026.08.04.09.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:00:51 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count
Date: Tue,  4 Aug 2026 18:00:47 +0200
Message-ID: <20260804160048.174148-1-osama.abdelkader@gmail.com>
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

In panthor_drv.c:panthor_ioctl_group_create(),
the queue count is validated against the hardcoded maximum:

	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
		return -EINVAL;

However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
panthor_fw_init_ifaces() will only initialize that smaller number of
stream interfaces.

If unprivileged userspace requests more queues than the firmware reported
(but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
uninitialized stream interface and may crash when dereferencing
cs_iface->input->ringbuf_base.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..64749750e6ee 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3673,6 +3673,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > sched->cs_slot_count)
+		return -EINVAL;
+
 	group = kzalloc_obj(*group);
 	if (!group)
 		return -ENOMEM;
-- 
2.43.0

