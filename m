Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E52CC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307E710F12F;
	Thu,  2 Apr 2026 08:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iDMZV5aB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B54C10F129;
 Thu,  2 Apr 2026 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775117993; x=1806653993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mMTkym0jb274U7nC0lb57WjiKlRKAPwi76v556VJiXk=;
 b=iDMZV5aBX/kp7rE7D578jXS1KBDMjNxmIUWz0Cb7LsNAcjaysFKPYRYV
 BgMhUGbZkIjA2IOEHViSxLsBCoqUCzVHWx0O3ahykpxq6xRgErUgjMu5o
 t/9knOEWKwO8x+5W4sgQl0eYjB+0YvpA2OgxjqZ2pytf+S3SGGVHIqWJH
 nRkV1fU6Aifipv0V6ZoiglIOTQLnMNJsK08OEYz31eV5i1i508+B/FThx
 UGykBoydJ8pGmFAmAKG68BzX/0DwUZtxnMguP7vW63a/xkUq0/RS66rQ2
 h9iz2gSCyATTuitMoN1DQw7JZhahCNAVGpw/ZqhBNCIvcAMZVFxytEha6 g==;
X-CSE-ConnectionGUID: b0Iwu0K2SOaPJ0KAYeAIQQ==
X-CSE-MsgGUID: 3DSQHAUSTwSuUrUpjVa9sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060458"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:53 -0700
X-CSE-ConnectionGUID: zCAzkFVZRJmVFguJ9QyJ0A==
X-CSE-MsgGUID: 4pSZMeVuR0Gut+sRX3xPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776123"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:51 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 07/23] drm/i915/vrr: Avoid vrr for PCON with HDMI2.1 sink
Date: Thu,  2 Apr 2026 13:34:07 +0530
Message-ID: <20260402080425.548702-8-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
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

Currently we do not support VRR with HDMI so skip vrr compute
config step for all DP branch devices.

v2: Restrict VRR on all DP branch devices instead for checking only for
    HDMI. (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 8a957804cb97..160e1c24aa4b 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -55,6 +55,16 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		if (connector->mst.dp)
 			return false;
 		intel_dp = intel_attached_dp(connector);
+		/*
+		 * Among non-MST DP branch devices, only an HDMI 2.1 sink connected
+		 * via a PCON could support VRR. However, supporting VRR through a
+		 * PCON requires non-trivial changes that are not implemented yet.
+		 * Until that support exists, avoid VRR on all DP branch devices.
+		 *
+		 * TODO: Add support for VRR for DP->HDMI 2.1 PCON.
+		 */
+		if (drm_dp_is_branch(intel_dp->dpcd))
+			return false;
 
 		if (!drm_dp_sink_can_do_video_without_timing_msa(intel_dp->dpcd))
 			return false;
-- 
2.45.2

