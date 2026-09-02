Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAAAC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE5310E516;
	Wed,  2 Sep 2026 21:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wnnv8T/h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F78A10E079;
 Wed,  2 Sep 2026 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788385446; x=1819921446;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D1ZVCoLCHbfakll2oeEtpkPIBc4ICoHzc/DRrdV7d+w=;
 b=Wnnv8T/hL8TdeZasty+a+e/OiLk2dmvI1O86kvd7Nfp7bCV7oYXZPqBP
 uteBfdkoNd22D+vqTkwhoiNPQtt/RytTbcrMf85uOfydekjylCCjqI73r
 hQZF7fVzgA2mh7vPt2Ko76VJ5oRgbvnTLVVpnzSGiSPL0jRd9iJflnMJC
 Q+m6j1KXGc4vzTdmuGvUlKL6TGTsmIIxdBmnTtd7Ckp1TKKB/tqOnTdMd
 vrShDMemc3nZEFxx1DBhUT20xCRbuUnAGtMO1gBODibsIKEtar9sM/fzy
 /2z/IfaSR0StMBvzwKEjrz9ncJTqR2V7f9jmHXxLjgfH1IMqRRXnZaIOu Q==;
X-CSE-ConnectionGUID: aMQbvdPYS2CyYdyYGMe9Ng==
X-CSE-MsgGUID: 1A//74YlQkuWLrqmGoNQgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87997773"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="87997773"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:05 -0700
X-CSE-ConnectionGUID: FxczQ9hjQFStbMwqQwn3yQ==
X-CSE-MsgGUID: z7aqw4TxRmi7XoVYg1mfnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266929172"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:01 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Rodrigo.vivi@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Subject: [PATCH v7 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Thu,  3 Sep 2026 05:43:56 +0800
Message-ID: <20260902214358.348399-1-jonathan.cavitt@intel.com>
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

v7:
- Various formatting fixes

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

