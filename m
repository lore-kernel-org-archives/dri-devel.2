Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBBCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A885410E11D;
	Thu,  1 Oct 2026 11:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JxpXMWn9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A07E10E11D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790852991; x=1822388991;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FhugRreKo1d3l7je//gzOhkCwjWm5bt60Gv0vmxiNOw=;
 b=JxpXMWn9Bp/YT8K6VxLw/lcnjXZGsWDkJ3Uwn/tUXQQIM227WjQHqkXQ
 Ie7NxnaJZaxfBoElMIr6fPRLLOh+a8cp4i5YIyQM17nqcxzNfSbx+ma/k
 Rk6e80N7O325B3jCwsdMB+qbHU44qA2S9r4MrDi/577abP1x1LcQsT46e
 R736/Tps/fPkyG3qp+vNfQYl1tyGfnN8wuHIAxpFtf2UOt8boRV1x9ml+
 8+vrBICMymfi6bR20Agq7VxxLtliBc6ztrZ3dHsep40gn+Vl/xZf65FCF
 CNwZIUh4oRmyFHbuvLBQ2U9gij8tnvZPfvigoZ4G+yaULLg8gF3pgXCjF A==;
X-CSE-ConnectionGUID: 2pbK5BDzSlmd/ckLnQo7Xg==
X-CSE-MsgGUID: ZfkG4HDvR3i6ADRCCwgz2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90465554"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90465554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:09:50 -0700
X-CSE-ConnectionGUID: xkA4OxR0SJKXfrG7kwmRuA==
X-CSE-MsgGUID: pUGPg43vT5Cq7r9+is878Q==
X-ExtLoop1: 1
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:09:47 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 0/3] accel/ivpu: Rework HW IP generation detection and dispatch
Date: Thu,  1 Oct 2026 13:03:58 +0200
Message-ID: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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

This series reworks how the driver determines the HW IP generation and
buttress version, and how it dispatches on them.

Today ivpu_hw_ip_gen() and ivpu_hw_btrs_gen() run a switch over the PCI
device ID on every call, and an unknown ID only triggers a WARN() while
probe continues with an undefined generation. Patch 1 resolves both
values once during device init and fails probe with -EINVAL on an
unrecognized device ID.

With that guarantee in place, patch 2 changes the stored values and their
accessors to the real enum types and drops the default: labels from the
switches that dispatch on them, so -Wswitch flags a generation that is
added later but not handled.

Patch 3 splits the remaining per-generation dispatch in
ivpu_hw_ip_soc_cpu_boot() and pwr_island_delay_set() into helpers that
return directly from each case, removing the locals that were left
uninitialized on the path past the last case.

No functional change is intended beyond failing probe on an unknown PCI
device ID and logging the SOC CPU boot mode even when the boot fails.

Andrzej Kacprowski (1):
  accel/ivpu: Improve HW IP gen and buttress version checks

Dawid Osuchowski (1):
  accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types

Karol Wachowski (1):
  accel/ivpu: Split HW IP generation dispatch into helpers

 drivers/accel/ivpu/ivpu_drv.c   | 69 +++++++++++++++++++-------
 drivers/accel/ivpu/ivpu_drv.h   | 65 +++++++++----------------
 drivers/accel/ivpu/ivpu_hw.h    |  1 -
 drivers/accel/ivpu/ivpu_hw_ip.c | 86 ++++++++++++++++-----------------
 4 files changed, 117 insertions(+), 104 deletions(-)

-- 
2.43.0

