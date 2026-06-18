Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5316CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD36B10F323;
	Thu, 18 Jun 2026 15:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CWVHpvd8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7626F10EDDE;
 Thu, 18 Jun 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781796800; x=1813332800;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QVoBv4uWnk0KMqpi4FMolMtUPKeY/LymTNKkLstSFKM=;
 b=CWVHpvd8+/WGPRaCgcY2OptzYMmf6CweEnywN/Y2Fnp/Kwkac3SJ9Kp1
 LHbYnkOszvetWHvr/4dPollZNjKigUGOsxBUhFU/90bSXMyq3RSxnnwnG
 pDo4Kthkez1yt0T9c6/8nIS21D4+NvASA7uCgh2UJ9kbG5qVRabPoZ7sz
 lYTvaeLdZv1cqDs6zLFRbXpp99z5k4FF+X+S09GM4LJfyPwW8eXfEkNoJ
 KQC/o2p9ew+u0qHzEf55WSaHtx5/OluZerInnJAPUXhSU5Ms4u76Oy88a
 fvBAdEzYs2HVy4AHAs7JcFYKoUZ+4KpUBr0mXl2H6uVu8tLlRmQO/Jt7t A==;
X-CSE-ConnectionGUID: RtyVAo2aTCO8wYkD7j3prw==
X-CSE-MsgGUID: D93xATutRdiTwlyw+tPkPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82403578"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82403578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:33:19 -0700
X-CSE-ConnectionGUID: iD0GXV0AQ+GVsPk4128nUw==
X-CSE-MsgGUID: Wzb9jpuXRlGBXGSUu8ZzKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244045797"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:33:15 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v4 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Thu, 18 Jun 2026 23:33:10 +0800
Message-ID: <20260618153312.877948-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
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

Add SRCID to the xe_pagefault struct, which reports the ID of the
faulting hardware unit.  This will be passed on to the
xe_vm_get_property_ioctl for reading per-vm faults and will assist in
diagnosing pagefaults.

v2:
- Readd pad check, as the pad in the ioctl struct was not changed
  (jcavitt)

v3:
- Rebase

v4:
- Squash SRCID with ASID to keep the struct compact (Matthew)

Jonathan Cavitt (2):
  drm/xe/pagefault: Add SRCID to pagefault struct
  drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  5 ++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 drivers/gpu/drm/xe/xe_vm.c              |  8 ++++++++
 drivers/gpu/drm/xe/xe_vm_types.h        |  2 ++
 include/uapi/drm/xe_drm.h               |  4 ++--
 6 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.53.0

