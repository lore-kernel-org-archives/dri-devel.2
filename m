Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EDEC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA7E10E047;
	Wed,  2 Sep 2026 21:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ExefP2p5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84F810E047;
 Wed,  2 Sep 2026 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788384355; x=1819920355;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9plz0XMHhAyOu2ZX1hqD1SDBlhuggjIuIAitC4JszVY=;
 b=ExefP2p5y1vBDK5KjF+sdLILPK1v5/TTAKfRtSNGojeAr/rYeXhdzGy1
 KeEpv7IAOwQ/wiKPzHWWt5xPmKn0CHHFvJhAhc6zQ/E+xZxMMJoI5vQcf
 /MQBfOqNLkWMm/NTQ6cGsFii96VwYWAhDMGAMMEffD5nKAZ6dffqP3j4K
 tOjcDQjXolEiUo9cPKULlbf9xk1hJRyAuWAqx4EqQOY57u+BmWeI/uGnS
 o+7Bgn/jnfgFL6oI6klY8IqVSN3jYOLUvlvgj/S4ouYaCwRXZkeNVzTXT
 GcObtC2HLD8yjm1kTcTAVdIbBAVlCVm4PQN+Z7YDs0V8ldfKBpeKBk8Y0 w==;
X-CSE-ConnectionGUID: 7P+6HzBSQe2CDsL9ehJ/CA==
X-CSE-MsgGUID: poo1vHMMRm6/eCRQjeewqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111629915"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="111629915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:25:54 -0700
X-CSE-ConnectionGUID: GozhQi6dRBC5wsqgsYHdEg==
X-CSE-MsgGUID: 6u0LtjKlR4e62Cr8+nXZjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="273682838"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:25:52 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Rodrigo.vivi@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Subject: [PATCH v6 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Thu,  3 Sep 2026 05:25:47 +0800
Message-ID: <20260902212549.347805-1-jonathan.cavitt@intel.com>
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

v6:
- Rebase

Jonathan Cavitt (2):
  drm/xe/pagefault: Add SRCID to pagefault struct
  drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  8 +++++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 24 +++++++++++++++---------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 drivers/gpu/drm/xe/xe_vm.c              |  8 ++++++++
 drivers/gpu/drm/xe/xe_vm_types.h        |  2 ++
 include/uapi/drm/xe_drm.h               |  4 ++--
 6 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.53.0

