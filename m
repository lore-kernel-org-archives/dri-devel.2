Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BB7CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 21:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6872C10E564;
	Tue, 26 May 2026 21:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AByw5OS1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E56010E564;
 Tue, 26 May 2026 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779831894; x=1811367894;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iStcPGhC2vRWtyMISC18kDTunTbzDgKpRXlDpsW95iY=;
 b=AByw5OS18Q6ZR22dIkmanmjWPY2dU9MzcoJheNL3IKf5289ycG3NfjnV
 Q25CfgV89281tQ1561XpiwvmVmCmj+JrUsgQxQfFIoicpg06UdHyd5OJT
 AAoQfOeJ6lEeTYid2f/8Ruqx6oCI4lhDDENYzKwv09CqK1VcpVLULSpTn
 J0uQbL00mGMYgjPZ2+WuEGnj03Yb8pqNt6/flXZucwT/7T8awwc2hc39I
 hxr+WOOxMOxQ+nEF4fP/v4X1brfXPiMEbXCHuvr+vqL+ntn6oT0pOjloM
 2/WHJ0PG/5UwSE5YbdSw3RsV+8HUIiOlOviitQvbRkj0wErB1Yh9dGnuH A==;
X-CSE-ConnectionGUID: 6XNdjgbWSDaWNGLzqcCgmg==
X-CSE-MsgGUID: 5D67TEuHT1Odyff5+zjW9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80843889"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80843889"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:44:53 -0700
X-CSE-ConnectionGUID: vDnT0xmUTB25UtGOH+/60w==
X-CSE-MsgGUID: 1GkjmqFdT46p0UNhLR4Inw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="242110100"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:44:49 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Date: Wed, 27 May 2026 05:44:44 +0800
Message-ID: <20260526214446.3638616-1-jonathan.cavitt@intel.com>
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

Jonathan Cavitt (2):
  drm/xe/pagefault: Add SRCID to pagefault struct
  drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  1 +
 drivers/gpu/drm/xe/xe_pagefault.c       |  6 ++++--
 drivers/gpu/drm/xe/xe_pagefault_types.h |  4 +++-
 drivers/gpu/drm/xe/xe_vm.c              | 11 +++++++++--
 drivers/gpu/drm/xe/xe_vm_types.h        |  2 ++
 include/uapi/drm/xe_drm.h               |  4 ++--
 6 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.53.0

