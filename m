Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82645C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E5E10E544;
	Tue, 28 Jul 2026 09:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JjWy0zdt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC71F10E812;
 Tue, 28 Jul 2026 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785229400; x=1816765400;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uYXE00ZDNZg6McXWLG6zrQgvAbtT0UyrMHagh+XWbjM=;
 b=JjWy0zdtxHQJMZIU7/RGPdgQ5oAZgS/IfbB1+LnC3jlzfUVjmZsqbzoP
 1jwN9tEoeDKMSX7X5UJA6xSTDNX2rEYIYY1skmC76WNOYj3zFrf5lLt6J
 8Jdu7fMmBjJkAjEUzHmtdEOf0JytuEJwb0qT8pEfn3jFN+P+tsvuiVa4X
 4t3m7zXtXeyzsn9vByY49N5kDqNZso8EzpXPDzXmkrahSW23Ra18wvKU4
 T2BvElumI/zrEWccGRbPHWly76XMtQfxzKXF2pgTJcxgSqDTwalGh413R
 rgdsBw5uvzfjfVvdKMrn51p+nFBT0FEpbSTSEANXSi2TslykRgZ+vbfCE Q==;
X-CSE-ConnectionGUID: vtPzBt6vRDKBSMAMbnVgSw==
X-CSE-MsgGUID: ugxEy0NDS2C+nxGuSVGlPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96467714"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="96467714"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 02:03:19 -0700
X-CSE-ConnectionGUID: Bi42+ACIRWSEixkxN1wDDg==
X-CSE-MsgGUID: wAwgQ9n3QgWzF+/kKoD6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="284196203"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 02:03:15 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: simona@ffwll.ch, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [PATCH] drm/pagemap: Reset migration page count on eviction retry
Date: Tue, 28 Jul 2026 14:33:04 +0530
Message-ID: <20260728090304.1264759-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

drm_pagemap_evict_to_ram() may retry eviction, but mpages retains
the count from the previous attempt. A retry can therefore continue
to the copy path even when no RAM pages were populated.

Reset mpages at the retry label so it reflects only the current
attempt.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 4a794544b7dc..7faba4acd59f 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1122,7 +1122,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 {
 	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
 	struct drm_pagemap_iova_state state = {};
-	unsigned long npages, mpages = 0;
+	unsigned long npages, mpages;
 	struct page **pages;
 	unsigned long *src, *dst;
 	struct drm_pagemap_addr *pagemap_addr;
@@ -1133,6 +1133,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	npages = devmem_allocation->size >> PAGE_SHIFT;
 
 retry:
+	mpages = 0;
 	if (!mmget_not_zero(devmem_allocation->mm))
 		return -EFAULT;
 
-- 
2.43.0

