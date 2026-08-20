Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4407AC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A2210E18F;
	Thu, 20 Aug 2026 10:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BeBvZoQL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492B610EFD8
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787223210; x=1818759210;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EbzhRscn3+7t32VncWlttdncyd9LiAWi2C0RKLaqz8c=;
 b=BeBvZoQL2bE1l3yifAtqzf6zPnbNmvGveGGiKkhNC3YI3QNRiRru/HZj
 yW8xxj4Vy1srmXuVCY7Ul4An+47K1QkQ/pn/xPRIqfszGKcbGJOTiYh10
 iI5M8R/axSVKZXSiP9AUvgydYPzjlvq1W/f/7PcfLO2wzXUrauV3LGT4P
 EZWbL+VMdU3STnqON0GLzR3SjwhVd0jNt35edVzCC9F9+ZuviWrrhubZZ
 JSkWZkptQ2ontswyxBeBosbklytKnGU6sPAIxWZKSBbDCElOLvqzbTfTq
 nKAG5n5AGoJyIv9FIwJkumJve+i+skn1UeV+1owcaILlHcNgWt2WOgMJZ Q==;
X-CSE-ConnectionGUID: gLXWYoRLSlyVqPpJrXP+eQ==
X-CSE-MsgGUID: VAM+IO+YQKKPzCuCy3qHvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87624625"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87624625"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:29 -0700
X-CSE-ConnectionGUID: xQUpmE0uT0OYDpvkbVMjMQ==
X-CSE-MsgGUID: PniyslSiRIOgiV6dg7HerA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="267909050"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:27 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH RESEND 0/2] drm: add drm_warn_ratelimited() and convert ivpu
 to use it
Date: Thu, 20 Aug 2026 12:48:09 +0200
Message-ID: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
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

This patch set adds drm_warn_ratelimited() to the DRM print helpers
and updates the ivpu driver to use the warning-level variant instead
of err-level logging. The new helper matches the existing rate-limited
logging pattern and gives drivers a consistent way to emit warning
messages without spamming the kernel log.

This change improves logging correctness and consistency for drivers
that need rate-limited warnings.


Dawid Osuchowski (2):
  drm/print: add drm_warn_ratelimited logging macro
  accel/ivpu: Use drm_warn_ratelimited macro

 drivers/accel/ivpu/ivpu_drv.h | 2 +-
 include/drm/drm_print.h       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)


base-commit: 063019ac51afffda4ab3d658701b086caa0c8e9e
-- 
2.43.0

