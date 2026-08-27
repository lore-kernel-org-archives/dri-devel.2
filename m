Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D7BC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D21610E3AF;
	Thu, 27 Aug 2026 07:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xr12vXzH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01BD10E3AF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787817073; x=1819353073;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hJEqGcOCNh9WQnSOy8AYFNTwlD46CkALQ/k/6sDlDwo=;
 b=Xr12vXzHpMpNljmrds/fJnzn+7o4iUk6aIvkfuOTUAlz7AyDIBHhzqJR
 Up5X0gArHVEVnNUGPC92oTxrRYNPJFl10cnY8UijvVsru0CPGSSusM4Qh
 uWHfJIwDc3q3nO4MJOZCmfTBv9HaXugYKf43SRccMi0NibhS6EM9pKXQL
 raZ3NtXHCp0A7/PIcGl1tGcdx7CEm51BjQ/9MLmv2JOFtpBat8j2HWKMx
 brSw/J46fDQJyDAKe50wMhttm55E4mRtILiLwRTPxCccOwZuOZPqMpBN7
 xVK+j7kZSrbhFMAyxt11byXmrYXrnMxWyjRetK5WX4Cvhy0fW4dPRQFeU w==;
X-CSE-ConnectionGUID: R+DCl8tmR8KYm5ORiF/RAA==
X-CSE-MsgGUID: qdUOYl10SaaAIeEfa1X0iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105684917"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="105684917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:51:12 -0700
X-CSE-ConnectionGUID: 0VXC2qQrTWO7XF3x1uZkSg==
X-CSE-MsgGUID: 19/KKI7HTeSED1qHuGtnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306019861"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:51:11 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Ghimiray@freedesktop.org,
	Himal Prasad <himal.prasad.ghimiray@intel.com>,
	David Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Honglei Huang <honghuan@amd.com>
Subject: [PATCH] drm/gpusvm: Assign maintainers to the DRM GPUSVM helpers
Date: Thu, 27 Aug 2026 00:51:06 -0700
Message-Id: <20260827075106.2052472-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Document maintainers and reviewers of the DRM GPUSVM helpers

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Ghimiray, Himal Prasad <himal.prasad.ghimiray@intel.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dri Development Mailing List <dri-devel@lists.freedesktop.org>
Cc: Honglei Huang <honghuan@amd.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com>
Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

---

v2:
 - Add Honglei as reviewer as he is driving AMD efforts on GPUSVM
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c508bda61d5..dfb0d36f0ae2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8991,6 +8991,21 @@ F:	include/drm/drm_gpuvm.h
 F:	rust/helpers/drm_gpuvm.c
 F:	rust/kernel/drm/gpuvm/
 
+DRM GPUSVM
+M:	Matthew Brost <matthew.brost@intel.com>
+R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
+R:	Ghimiray Himal Prasad <himal.prasad.ghimiray@intel.com>
+R:	Honglei Huang <honghuan@amd.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/drm_gpusvm.c
+F:	drivers/gpu/drm/drm_pagemap.c
+F:	drivers/gpu/drm/drm_pagemap_util.c
+F:	include/drm/drm_gpusvm.h
+F:	include/drm/drm_pagemap.h
+F:	include/drm/drm_pagemap_util.h
+
 DRM LOG
 M:	Jocelyn Falempe <jfalempe@redhat.com>
 M:	Javier Martinez Canillas <javierm@redhat.com>
-- 
2.34.1

