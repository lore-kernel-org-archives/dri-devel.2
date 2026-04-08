Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650DFFD5F98
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1A410E5BF;
	Wed,  8 Apr 2026 08:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lcEDiLQE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB7B10E5BF;
 Wed,  8 Apr 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638688; x=1807174688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nItMGEZjAanGeTV8IKsQQshbl/Vk98mzbv7NyX3QNDI=;
 b=lcEDiLQESfe0ELfMHpwYjFK+Po0DQTYWw4C5RtPfccQmUiWrYH5DXXGs
 b1rxTyvRbCBI+UBO8jKciXd7iH3khlqec4N6Tjpxpol9wKkquyycDvblZ
 BkKlNmt8hQNiR/LANnf3YOgLVItLJSYfsfMgSqKme7ppyM2b8UZOpGl2q
 V4kC1H1MmdmiG+pzD5DntWJOTw4MsQFKdUfsXjdFe7hzmexRp+ICE+ki6
 Vk9sXaRYlYG3Lk8BjixXE9i180N+qSYHSUbZXR5zBBm05BFDazuxpuWIg
 Nnxhrfhr7XpwahahoO6MgIvG6x+T4Nd4OHpIO/pZyy5CBs9f9Cjqr1K2M A==;
X-CSE-ConnectionGUID: 3w5W/VSTSh+HFOr1sxQnng==
X-CSE-MsgGUID: xKwNqK7hT6+qQ/3uQfmNQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516659"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516659"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:08 -0700
X-CSE-ConnectionGUID: +F4o5YeOS5OOt+OJKRmAVQ==
X-CSE-MsgGUID: JYzxlA9CROKe+25RWmhaQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572557"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:06 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 12/26] drm/i915/dp: Skip AS SDP for DP branch devices
Date: Wed,  8 Apr 2026 14:12:24 +0530
Message-ID: <20260408084239.1295325-13-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

Currently, VRR is not implmented for DP branch devices.
So skip sending AS SDP for them.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3d0ea074e610..095bde8e97ef 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3130,6 +3130,12 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	if (!intel_dp->as_sdp_supported)
 		return false;
 
+	/*
+	 * #TODO Implement AS SDP for DP branch device.
+	 */
+	if (drm_dp_is_branch(intel_dp->dpcd))
+		return false;
+
 	return crtc_state->vrr.enable;
 }
 
-- 
2.45.2

