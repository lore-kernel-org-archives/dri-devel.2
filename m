Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4D2FE51FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC33910F483;
	Fri, 24 Apr 2026 09:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kJYageSc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8220410F480;
 Fri, 24 Apr 2026 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777024150; x=1808560150;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=08D5P+AyE7rGBQ7qwlWONRGL+2cm5LGWwy2TbXsuL/U=;
 b=kJYageSc5msFV0Opt+VejWQSx6ft7xKnHWSx3c5OP8w6qHCz12SL/IdB
 ejFLFxarD9joFUrr/R1l3sEjm2ay0xmf9fwyXhfd8Xys6tgpmNtATMe6G
 A2/E1UF1jRZYPjTYn4HeG/unFuSc2cNkikcgOBRPE8uXNtk4IQvquoEQ8
 4QVww/SzDWmbdLyitwO/Irexol1HCaMsPaXjumbpSyjgRtAlqXDns/TUs
 Wqwc2dfoVTqxSf7UpXilX9Ojsj2sIR7pBPsoCplxFSv9rWAy75HivzalG
 /gje18tjTbJ9wt7cGskSveOjRmDyUZnhuU3E+2t6P58T3PSbHhAAmA0aM w==;
X-CSE-ConnectionGUID: pqFDo30FRJO6IExpSVBS3A==
X-CSE-MsgGUID: 5hM4MZPnSlepZCXAvj+QQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88612845"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="88612845"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:49:09 -0700
X-CSE-ConnectionGUID: xpFE9/6MQNurQHal6LZvUQ==
X-CSE-MsgGUID: d0DZqdiaQHKJ5AcaoMTkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="228575629"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:49:08 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [RESEND PATCH 0/7] AS SDP cleanups and additions for Panel Replay +
 VRR
Date: Fri, 24 Apr 2026 15:04:17 +0530
Message-ID: <20260424093424.3060805-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
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

Resending with dri-devel added to the recipients, which was
missed in the original submission.

This is a subset of patches separated from the series at
https://patchwork.freedesktop.org/series/164512/ for merging.

These are drm-core (drm/dp) patches that clean up and extend the
Adaptive Sync SDP definitions and helpers in preparation for
Panel Replay + VRR support.

Ankit Nautiyal (7):
  drm/dp: Rename and relocate AS SDP payload field masks
  drm/dp: Clean up DPRX feature enumeration macros
  drm/dp: Add bits for AS SDP FAVT Payload Fields Parsing support
  drm/dp: Add DPCD for configuring AS SDP for PR + VRR
  drm/dp: Store coasting vtotal in struct drm_dp_as_sdp
  drm/dp: Add a helper to get the SDP type as a string
  drm/dp: Add target_rr_divider field in AS SDP logging

 drivers/gpu/drm/display/drm_dp_helper.c | 39 ++++++++++++++++++++++---
 drivers/gpu/drm/i915/display/intel_dp.c |  4 +--
 include/drm/display/drm_dp.h            | 20 +++++++++----
 include/drm/display/drm_dp_helper.h     |  1 +
 4 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.45.2

