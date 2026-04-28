Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCAFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B823C10EA5E;
	Tue, 28 Apr 2026 07:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bC9Ge2DD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D3610EA5B;
 Tue, 28 Apr 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363177; x=1808899177;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pgnMgeFHgcdZiD+QYScLixA3JIcWgj6imfhAqT2uDiA=;
 b=bC9Ge2DDe+MAU2FyPBxB7anL12CC/2W0ZVv4RyHkqAsXnI5hwy2iDvas
 Ob8LzWn7+SGVFF9X0Y0U3NZQsRU+AsFDp8kBNINRzTEnc9e5Fy166mg/A
 UfijZP/CRa/73Toy1T3OeDBTSRh7MnefJxlsChpOedSzrXwPwr/K9jKxT
 hNvf9wPD4TyFeriE61YuI73lNiEp1u/gE+efCgRDW+W6erYsQgSScKzMW
 3ajh0y/rOThqmDx2/XHd+Fw0n6QDbeMETV1hL/G2kgzN+PL6hSdnokqQH
 ixTxM8R1n5XkTKQ5S9eJt/n8fz+A/E1/X9wYnCRlgp6Ki0YNtLHuPmaPD w==;
X-CSE-ConnectionGUID: bCeC8k29RXul+n1MALeYhw==
X-CSE-MsgGUID: kIFEcZZkSDmTVyYOinQBsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82115895"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82115895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:37 -0700
X-CSE-ConnectionGUID: waNo1va1ShqjsYYaC3I+Dw==
X-CSE-MsgGUID: 2brYyKAVSMmHUJfupgwqyQ==
X-ExtLoop1: 1
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:35 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 0/9] AS SDP cleanups and additions for Panel Replay + VRR
Date: Tue, 28 Apr 2026 13:14:48 +0530
Message-ID: <20260428074457.3566918-1-ankit.k.nautiyal@intel.com>
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

This is a subset of patches separated from the series at
https://patchwork.freedesktop.org/series/164512/ for merging.

These are drm-core (drm/dp) patches that clean up and extend the
Adaptive Sync SDP definitions and helpers in preparation for
Panel Replay + VRR support.

Rev2:
 - Refactor SDP logging to use space-separated field and
   drm_printf_indent. (Ville, Jani)

Ankit Nautiyal (9):
  drm/dp: Rename and relocate AS SDP payload field masks
  drm/dp: Clean up DPRX feature enumeration macros
  drm/dp: Add bits for AS SDP FAVT Payload Fields Parsing support
  drm/dp: Add DPCD for configuring AS SDP for PR + VRR
  drm/dp: Refactor AS SDP logging to use space-separated field names
  drm/dp: Store coasting vtotal in struct drm_dp_as_sdp
  drm/dp: Add a helper to get the SDP type as a string
  drm/dp: Add target_rr_divider field in AS SDP logging
  drm/dp: Use drm_printf_indent for DP SDP logging

 drivers/gpu/drm/display/drm_dp_helper.c | 69 ++++++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_dp.c |  4 +-
 include/drm/display/drm_dp.h            | 20 ++++---
 include/drm/display/drm_dp_helper.h     |  1 +
 4 files changed, 68 insertions(+), 26 deletions(-)

-- 
2.45.2

