Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D1CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A98810F079;
	Wed, 17 Jun 2026 18:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H3LEppdX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A4E10EACE;
 Wed, 17 Jun 2026 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781720335; x=1813256335;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=20VQmPzAJOum3oxerNietNBUT+H2HlnVMRxPE37hgRU=;
 b=H3LEppdXNHq5R13RMqPTA1yW/5H6FOJjsX/GUal/AKwUGhKl9KlC9BKJ
 fHw7NUGnFuSynRUqpe7u3b8xtn0Vp6G8gbqCcm3aU6Zv/lqrJDty8NZYS
 tFOoq0+NL6foJi8NkD1IiaINV6L0WDyvmlzq5BeG0CZP7WcdQZSCzIcLg
 MEO3WGNADPt4IOWw59BTbNSN30W2QlVPwku2JMf7LXCst53QTaE6XcJDB
 XBRRy/0kc+8FSAQutcQ5USddO9DyL9HtnIfyselJRsf1g/0kbf06vS3EN
 2VKlB+p3cTV+7BN2Prv2l+A3YDdxqlOxKRAXuRhfeqJNKdNTNsTtzOy8D w==;
X-CSE-ConnectionGUID: J6PATXM+TVa/Lmj6HM1Ijg==
X-CSE-MsgGUID: 9qdcue+IQla316YE62ccxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82634302"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="82634302"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 11:18:55 -0700
X-CSE-ConnectionGUID: psS/OCEERAaCCqOSXD6kGg==
X-CSE-MsgGUID: FysfeP9STg6H4/PWpdIQxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="243968437"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 11:18:51 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v3 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Thu, 18 Jun 2026 02:18:46 +0800
Message-ID: <20260617181849.769247-1-jonathan.cavitt@intel.com>
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

Jonathan Cavitt (2):
  drm/xe/pagefault: Add SRCID to pagefault struct
  drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

 drivers/gpu/drm/xe/xe_guc_pagefault.c   | 1 +
 drivers/gpu/drm/xe/xe_pagefault.c       | 6 ++++--
 drivers/gpu/drm/xe/xe_pagefault_types.h | 4 +++-
 drivers/gpu/drm/xe/xe_vm.c              | 8 ++++++++
 drivers/gpu/drm/xe/xe_vm_types.h        | 2 ++
 include/uapi/drm/xe_drm.h               | 4 ++--
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.53.0

