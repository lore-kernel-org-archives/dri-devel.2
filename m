Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F17FD5F6A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A5C10E5D1;
	Wed,  8 Apr 2026 08:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bh1LbXtk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B9610E5CF;
 Wed,  8 Apr 2026 08:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638703; x=1807174703;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7NGU4UJ8anmfYJvqAJbL07MUA7gCiTLcH+e32DqqY90=;
 b=bh1LbXtkZQHoOmCfULzD15cBfckDWzNKQ6vAQe593cGU7lcY7QL4Y9bm
 J/cDuOUh7lHMb1Ksgf5bhxU+8Vxq0i3PAXwDKI0SvJa9PFjHLsByMj8to
 t4NTMhgTb2li372KMhdwI+lzKkAn/KDI8GRkiU6KzV0eLt3Go0IKvTwre
 b4WsHo0NYPXi6gs7QHzodseN7vW2AqgoAj9kL0wJJiEJpxu7jMtIPBU05
 S1cQxnFBSUrebm7kCcDYoWKQGK6PowQi59JogBtBrA+oUkjpQeRnojVfp
 Kgmn++kslfO3H/RAv/dHreXpKq0nxrcv6zmydkF2d6M7LV9z/MoTu+3ln g==;
X-CSE-ConnectionGUID: GlMkR/VfQ+W8NMYF20XUIw==
X-CSE-MsgGUID: y7i2Cc6ETS6AeZKcx1p4Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516686"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516686"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:23 -0700
X-CSE-ConnectionGUID: BXOuuGU4QFK1rw30tQjopw==
X-CSE-MsgGUID: YylJBlm/QPeUUbna+BJbig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572610"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:21 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 18/26] drm/i915/dp: Allow AS SDP only if v2 is supported
Date: Wed,  8 Apr 2026 14:12:30 +0530
Message-ID: <20260408084239.1295325-19-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

We do not support AS SDP version 1, so allow AS SDP only if AS SDP v2 is
supported.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index aa035cb2fcc5..e280b4eea03f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3127,7 +3127,7 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
 static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 				  struct intel_crtc_state *crtc_state)
 {
-	if (!intel_dp->as_sdp_supported)
+	if (!intel_dp->as_sdp_v2_supported)
 		return false;
 
 	/*
-- 
2.45.2

