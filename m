Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB4CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 20:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB0B10E3EB;
	Thu, 14 May 2026 20:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VbQD1hZX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6CD10E3DC;
 Thu, 14 May 2026 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778790741; x=1810326741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dtbv8kTIaQE/7oeeDXs5F4ySLRxkpS5kih0oNzCyfXI=;
 b=VbQD1hZXE5GFgteybdw+bVM/gj41STS3cgpJqnEMOyc9Q9TqYYer9iCY
 zfwtA6Pb+47ZK+XpSI2OT28tkMmdd3hwFhDFtnSvkuRrJV6pKUPeaIl1v
 G70vdjWsCyrshrVjdOB3FYH9LjXXCJ+dDPA6hVfOMBBSBnAusnDtvYltE
 /EvJK2pi7McqAD7RM6aE6uYkUzfsk2VZlrJ2Ir6XH97FdrUlRdQaNNoxc
 6BZYOHC3PyBmv64tFyobRMafZM1pd0LMETZpcug6z6EkNhrNhHVisPcot
 EwCfB0xrB23gYFygbYf5xo2IKOob5YwDe2bjhv8w+TwFjP5Quzk5Q9sq4 A==;
X-CSE-ConnectionGUID: K8MmzZ4TTcaj+TtNYQ258A==
X-CSE-MsgGUID: hjSgw4PaQT6M6GM6IJQhVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880179"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="78880179"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 13:32:21 -0700
X-CSE-ConnectionGUID: vTWMtmJRTtSGqHwCf/74Og==
X-CSE-MsgGUID: 5WhPTdKFTMiTpiGxBIebOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="238361183"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:18 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, maarten@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/3] DRM RAS Fixes
Date: Fri, 15 May 2026 01:58:15 +0530
Message-ID: <20260514202839.1888688-1-raag.jadav@intel.com>
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

Raag Jadav (3):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action

 drivers/gpu/drm/drm_ras.c       |  5 +++-
 drivers/gpu/drm/xe/xe_drm_ras.c | 47 +++++++++++++--------------------
 2 files changed, 22 insertions(+), 30 deletions(-)

-- 
2.43.0

