Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDF010FC456
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96F710E6F9;
	Wed,  8 Apr 2026 23:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V1tcvX7o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B131610E6F9;
 Wed,  8 Apr 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775691354; x=1807227354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=61t6eMU8OwF6eYqeLLaW7tXVgwtqanITNR4jCcGc8oQ=;
 b=V1tcvX7oZ6f/6pNFoCJWX0sUgo53CRbJFB9yVcZkwvSGA/JFy0s0W1Qh
 XkK2D/0l3F+HRFtFBmArejaDIibK8Yrd6l2YyfCQiSBAi8HG9xG3rh7JX
 8K4/+z838Qe+NxgNQSFkvIN0p42haMLfrBjr5tTFgioGD5pc0mwP5aaWx
 1555V9D+sTWw/53+0YIJofMSGZvt46+8WOOMsvheMrvJz9mzKTfTNKK13
 4fDZsZYTfIiq5W7xBHMCqs3Vm77DKMiUgK23uftWV6Xa1eMj8lKDcpuXR
 h7oAVNH5NvbzBKES0pkjrq6t3dlkSMnsVS2dEp2oBs10MVnBjy0Qn6GuJ w==;
X-CSE-ConnectionGUID: 9ZoXdSPZQ561aOq0d2w1GA==
X-CSE-MsgGUID: DuOKhdrDS0yoZeQsVZDfzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87388274"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="87388274"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 16:35:53 -0700
X-CSE-ConnectionGUID: vWR3+m6xSB+ifLhXVJ/ApA==
X-CSE-MsgGUID: qMV3RA5hTram9OS3lyOQig==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.73])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:35:50 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 6/6] drm/i915/display: Make fence timeout infinite
Date: Thu,  9 Apr 2026 02:34:58 +0300
Message-ID: <20260408233458.22666-7-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
References: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Switch from the 10s default fence timeout on i915 to an
infinite timeout like xe.

I'm not actually convinced we want an infinite timeout here because
the fence could be from an entirely different device/driver, and
I'm not sure it's a good idea to allow our driver to get
completely stuck due to other peoples' bugs. So I'm thinking we
should probably have a sensible timeout also on xe. But I want to
at least see what CI says about this new reset_fence thing with
an infinite timeout...

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 83ccf13c4b16..a9d0e1241642 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7169,7 +7169,7 @@ static void intel_atomic_commit_fence_wait(struct intel_atomic_state *intel_stat
 			continue;
 
 		ret = dma_fence_wait_any_timeout(fences, reset_fence ? 2 : 1, false,
-						 i915_fence_timeout(), NULL);
+						 MAX_SCHEDULE_TIMEOUT, NULL);
 		if (ret <= 0)
 			break;
 
-- 
2.52.0

