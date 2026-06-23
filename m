Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB5CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BED10EA47;
	Tue, 23 Jun 2026 09:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g8zwurp4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0255610EA46;
 Tue, 23 Jun 2026 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782207979; x=1813743979;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wVEox0YyHQcIxIkbeNtw9mu/DqwnstiMpMbLwxA5XKE=;
 b=g8zwurp4L1v4vEAAL0tvPdvbRAe92M/01P2sVqhG9y2H0NEOyAXJV6ds
 mngDRUTFf0UEAMONlq+x8uLFXYv3CsZmOt4sTewbYwchCJDKAt/p/Bg/a
 IKtUKWzWmHZiTnnJr+jZSaBdBMl8lQUHq/u9xjbTkeC2RkKAIlyEjVMHD
 GDCbLsW0whuW17SWaQHxPUmKp0WbZRAT7Jwn3YW5oo88MAGfTQjaf5GLS
 +w8B4+9ta2OnMhc9/mpvQ8YhNBJ4quZTJ1/3JV6ZB6Vv41A5XzM4redoM
 hKju0h48Fvi+d4xRdC3QSaiq4h2m7so0ZjelH3vlG3aNM1D4Tmzde8dv7 g==;
X-CSE-ConnectionGUID: GwunXDCnQgSnDM2vdVYbqQ==
X-CSE-MsgGUID: mrTO/M/nSkixZQP4mAmL6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94336266"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94336266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:46:19 -0700
X-CSE-ConnectionGUID: 3zYVkYdSQM+vtJJM7BI71w==
X-CSE-MsgGUID: ezOWAgEeTjW5sAvMlEzy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="247130346"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 02:46:17 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 0/4]  DSC max delta bpp support
Date: Tue, 23 Jun 2026 15:12:32 +0530
Message-Id: <20260623094236.1586318-1-nemesa.garg@intel.com>
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

Resending this series again as missed to send v4 to
dri-devel.

Nemesa Garg (4):
  drm/dp: Add DP_DSC_MAX_BPP_DELTA register
  drm/dp: Rename YCbCr420 bpp delta mask to native
  drm/dp: Add max bpp delta computation constants
  drm/i915/dp: Decode dsc max delta bpp from sink dpcd

 drivers/gpu/drm/i915/display/intel_dp.c | 43 +++++++++++++++++++++++--
 include/drm/display/drm_dp.h            | 13 ++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.25.1

