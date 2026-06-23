Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D528CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF0C10EBF8;
	Tue, 23 Jun 2026 16:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RwG8lsC7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD46F10EBF3;
 Tue, 23 Jun 2026 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233178; x=1813769178;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d4PaTbnL99LwzEC8KpKwgzrLGAWNnLDrznARblZtR4M=;
 b=RwG8lsC7VGlKb1gc8vJ4wUh+XI4SToYMbUYFimJfqSBVhLazisjuZUmc
 4Aw3zD0tyPi/q483/dZgX0Prsqcs/3MMln6kZuuCksp9UkjnRapIL61v2
 akRRT16WYLEe3t8foft6ogjT/cAvuJtr628Cnzpp0iwJGobHnN/5oWxaZ
 L8/fA2w7oHtQwHh75CjFlUIkMubsRFKEEfUYH/IuVq4xeejyhGkJG73Zi
 nfeYf0rBgIBZuOHOciGhvpvN8y6MXm6MDaK33BFUuOgNg0h1VfUM+WAPb
 6cWTKHhZKQJNsD/8zFxsTE26+1NuncYFzJjIKmq3QHHEgLHtMPl1HAsaR g==;
X-CSE-ConnectionGUID: 4QqyQ/4YRUGT3zWFmWITIQ==
X-CSE-MsgGUID: kx6mXc4aT5+ysCb5+rR2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82089353"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="82089353"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:46:17 -0700
X-CSE-ConnectionGUID: Sg/fVvRfSEep97BXEPIQmQ==
X-CSE-MsgGUID: m6d5vYchQC2MOOr4Ant6ZA==
X-ExtLoop1: 1
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:46:14 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v5 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Wed, 24 Jun 2026 00:46:08 +0800
Message-ID: <20260623164610.1019512-1-jonathan.cavitt@intel.com>
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

v5:
- Use BUILD_BUG_ON and move ASID definition in one function (Matthew)

Jonathan Cavitt (2):
  drm/xe/pagefault: Add SRCID to pagefault struct
  drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  8 +++++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 drivers/gpu/drm/xe/xe_vm.c              |  8 ++++++++
 drivers/gpu/drm/xe/xe_vm_types.h        |  2 ++
 include/uapi/drm/xe_drm.h               |  4 ++--
 6 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.53.0

