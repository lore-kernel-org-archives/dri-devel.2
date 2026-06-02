Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27C3CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD2810EBB6;
	Tue,  2 Jun 2026 04:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m2DVViLj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342A810EBB3;
 Tue,  2 Jun 2026 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780376003; x=1811912003;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TZYrvbjldw+1KIlBDi/TDmjZVFVUX58xridHRA60fD8=;
 b=m2DVViLjTJQrV/H2xZP6lspnJQ7cYuJbQZSFThGYCScM6e6ge9lT5ZK2
 IACkof6SzSNcfBY1HJ527lt3ZCNm8Vf8vhAvW6Ov4pDbE9FKSQjDP84WB
 eToH9aCZP8rhRyrPvGXUdmu9KWqWeCZaiUwDNSYKhVwEDPONwgDZKyT09
 dBB0fKusVJ3aizsRrMFCagkXsnjYJKmlas0QXgDogZxDuffhGFCS+A+Oy
 j+uLGuDRmxfkMwPIqHExuCV8iAQB0BODalEmaqsgt9AqKT11ihljvar3C
 JW97ypwVQ4qvnxX8lEum002fOkSt0WJFw4h6UkcRtP41kDjSBNzHjj3Te Q==;
X-CSE-ConnectionGUID: HxAcxOS5QtCL5OzWf+7EkA==
X-CSE-MsgGUID: QnoWgZ5qTPa15VaUZfoX9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120458"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81120458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 21:53:22 -0700
X-CSE-ConnectionGUID: t1GAsqJ3SMm08A3nJzDtnA==
X-CSE-MsgGUID: xRbz/FeRRKS4WmDZjFvF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="245604097"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:19 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/4] DRM RAS Fixes
Date: Tue,  2 Jun 2026 10:18:40 +0530
Message-ID: <20260602044919.702209-1-raag.jadav@intel.com>
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

Detailed description in commit message.

v2: Use goto (Riana)
    Retain info as NULL on failure (Riana)

v3: Prevent double free on drmm_add_action_or_reset() failure (Riana)

Raag Jadav (4):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action
  drm/xe/hw_error: Use HW_ERR prefix in log

 drivers/gpu/drm/drm_ras.c        | 19 +++++-----
 drivers/gpu/drm/xe/xe_drm_ras.c  | 61 +++++++++++++-------------------
 drivers/gpu/drm/xe/xe_hw_error.c | 12 +++----
 3 files changed, 41 insertions(+), 51 deletions(-)

-- 
2.43.0

