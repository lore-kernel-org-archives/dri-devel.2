Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0FCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8715310FF8C;
	Wed,  3 Jun 2026 15:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FxcumjBb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536F010FF8C;
 Wed,  3 Jun 2026 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780499314; x=1812035314;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fnB8VnRgz3X22ryvcvDMmVEWNb4yhm0NOb+yQ/sLCjk=;
 b=FxcumjBbUOPLqsZ46V7s0aUes0qy7+jlQhYGsPbaf10mLM71LscjwFxd
 5DTOeFJ5UpyXdQfOuInZ6kcz5Qh+I/u6Lf5tbSuKoVgrNVflPcA53q1OB
 O3BWc9IReQ5MZbJR8QhrWNB4aLf84hwy7T+DDo62p/BJuVoCAsn9xnTAt
 d1Ekqca+PUdpOp5b/BW2RaSEe7kwIH8qWNiz6BkZbfGQtdl46qBBLiL33
 1IWDUhXRmaOMJWT5TXJnrxmyI6OcSUDwr1v1Lt68wcnMU3zI4aFcDWgUk
 B4cwU15N+EenfW8Ivg467bfrO+ntc2QZsUm0dzdSJ+zXLRI3E+9QZkiPB w==;
X-CSE-ConnectionGUID: PYSSt3vgRqmui2E9kwZI+Q==
X-CSE-MsgGUID: 1p2HC3JjSdCOi1h/wTW1pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91996212"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="91996212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:08:34 -0700
X-CSE-ConnectionGUID: j9VHohN7SIOh2U8fEWvT0Q==
X-CSE-MsgGUID: Sd6oiNFdQtiIJjKwpWYCDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="241280676"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:08:31 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v2 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Wed,  3 Jun 2026 23:08:26 +0800
Message-ID: <20260603150828.3751112-1-jonathan.cavitt@intel.com>
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

