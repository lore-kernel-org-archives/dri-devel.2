Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB708CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 11:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0D110E152;
	Wed, 27 May 2026 11:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fDGLHJPf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AC010E152;
 Wed, 27 May 2026 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779880356; x=1811416356;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1SgRiBg7cwUrr3CnzQdg8ztHpnIbw5xFcKA1QkSscQM=;
 b=fDGLHJPfgrACQBiMW+2AwY3jDzh29kDkO0EgLpkwk1K5U1k3fWUdWoSK
 /Eli2NrefBm+HgeFicGwlt2OmfC30jLAIni9KTkjazgqQlSnS7jw/SvaV
 QLW2ChPct2NpIjrb8BrkfS90MiNqoDoXSVAH6wGU8rt7vUWGppHPuEqQE
 0xkOg3SBVrzTx1BbEslgLNUdJU+ChrKUjhIJhnSoHX3rHlLP3aBIFBjYO
 lFrGZI86CQbUIfXyuaFp+mJSLSuxvT2orCzKwQOh5MljdLpbknGNqDRyD
 erCBqmVu4uOByrggklVx5MR66TZdbaZnIwjciKkuii5nQ/OS+lacXXq07 w==;
X-CSE-ConnectionGUID: lPnFHBS1Q/KDki23CmEzDg==
X-CSE-MsgGUID: 7IhejN1mRF2fzfVMwuegjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80818507"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80818507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 04:12:35 -0700
X-CSE-ConnectionGUID: SlcG4pg0THuQupOCVg1/Uw==
X-CSE-MsgGUID: s+Tt5ySdSmCZZHk8gDc27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="265803129"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa002.fm.intel.com with ESMTP; 27 May 2026 04:12:34 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 0/4]  DSC max delta bpp support
Date: Wed, 27 May 2026 16:38:45 +0530
Message-Id: <20260527110849.3943338-1-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
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

 Some sinks exposes DSC max bpp through delta based
DPCD fields. To support those sinks, add DP DPCD field
field and logic to decode the delta value in bppx16
format.

Nemesa Garg (4):
  drm/dp: Add DP_DSC_MAX_BPP_DELTA register
  drm/dp: Rename YCbCr420 bpp delta mask to native
  drm/dp: Add max bpp delta computation constants
  drm/i915/dp: Decode dsc max delta bpp from sink dpcd

 drivers/gpu/drm/i915/display/intel_dp.c | 41 +++++++++++++++++++++++--
 include/drm/display/drm_dp.h            | 12 ++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.25.1

