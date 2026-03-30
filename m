Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D84FF4940
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0CF10E2AF;
	Mon, 30 Mar 2026 04:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RZHOcjhw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0945C10E2B8;
 Mon, 30 Mar 2026 04:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844532; x=1806380532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5cW2FCibFvSHNgBH78UGUtxwxJ658xGT7zSnghT/zeo=;
 b=RZHOcjhwMsjHNNPjJhd6EPx5V1R0PuGHmG/eDT4Z/Z1MhP+lc9unc1NZ
 UHBQZvvrOOyNWdPivG8eQhz+/WcppNm7+ZVOtsFbHl2VWUpgv7dzEAVVv
 TCNcGUNEBYPyLjYdT1ncOciguPX+OHgorpW+JA1UvHLtJAuUdQPCpcyh8
 fhXikZ0btFSLJlsuQVYqzOk1sdMu3Yz/dbeJ/xIMftNzGrgkfGZSxJE8W
 MBw4xu5f9oqzn9RzIWSgWD0IuWq285bPsJ6tWDHpu2C5OphtiqQN68IC/
 9eu4sEB2U8eXoSjOKDVTnlMbhLg4OGcXFQxCzCv7gsxDlYhZLOKPHUceb g==;
X-CSE-ConnectionGUID: Aq+sd7HERu6au3qnwTJmfg==
X-CSE-MsgGUID: LTu+hGB2SDOe/8wbXxpRxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218224"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218224"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:12 -0700
X-CSE-ConnectionGUID: /h78MnstQq63S6n3p1iZoQ==
X-CSE-MsgGUID: Rm9mqv1jRHK97CLxWB1ynQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871130"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:09 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Subject: [PATCH 05/19] drm/i915/dp: Fix readback for target_rr in Adaptive
 Sync SDP
Date: Mon, 30 Mar 2026 09:36:42 +0530
Message-ID: <20260330040656.4116502-6-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

Correct the bit-shift logic to properly readback the 10 bit target_rr from
DB3 and DB4.

v2: Align the style with readback for vtotal. (Ville)

Fixes: 12ea89291603 ("drm/i915/dp: Add Read/Write support for Adaptive Sync SDP")
Cc: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 602efaf500bd..49eeb35973a1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5298,7 +5298,7 @@ int intel_dp_as_sdp_unpack(struct drm_dp_as_sdp *as_sdp,
 	as_sdp->length = sdp->sdp_header.HB3 & DP_AS_SDP_LENGTH_MASK;
 	as_sdp->mode = sdp->db[0] & DP_AS_SDP_OPERATION_MODE_MASK;
 	as_sdp->vtotal = (sdp->db[2] << 8) | sdp->db[1];
-	as_sdp->target_rr = (u64)sdp->db[3] | ((u64)sdp->db[4] & 0x3);
+	as_sdp->target_rr = ((sdp->db[4] & 0x3) << 8) | sdp->db[3];
 	as_sdp->target_rr_divider = sdp->db[4] & 0x20 ? true : false;
 
 	return 0;
-- 
2.45.2

