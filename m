Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42718606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4vO78vv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94DC10E4EB;
	Wed, 28 Oct 2026 21:08:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9D010E401;
 Wed, 28 Oct 2026 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793221711; x=1824757711;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JSqLMD0yJ9BsT8A5GHlX4cdSlzeO148Z4xyTPyvPHbg=;
 b=L4vO78vvgc9NhfJSIIXgVnX4kHCG8kRDGyAUosO9cUWAonztHfGdZ7Li
 bYI0TNCSSVWsO4DOW5mubUNarLiMP38+W8MLtqgzURdzeifYdW3rlAFSA
 j0Nxy/fH+yiGi2ZznEwbZ7lB1qFYwncbKkTZmZ54Vjd1WCg5IZTIoxWVQ
 RJfqrXOvFnonV2LQmR/wyF9s2X2gBb2fhPMmRedxgmcXqRUlUGB6bTjED
 zCdSPci+dXWn15ZhyuSqqi/mfC0o6ZqZkTW2GEuPuLLoCqvdIC/ZUOXYU
 uGSClCMeg1yHyt8vLNZ+sDIED9GIxGvW5voq/oS+molM8T2KRtF1ZJ4nd Q==;
X-CSE-ConnectionGUID: Y1p9/FqaQCqi5XATJqIGtw==
X-CSE-MsgGUID: RoLR0IR6ShiKtduztLr23Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1848661"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1848661"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 14:08:30 -0700
X-CSE-ConnectionGUID: +eg4jCc8TpWyGBl8bRlklg==
X-CSE-MsgGUID: FCTXz6KBSCeuIiMdf93UvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4811349"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa008.jf.intel.com with ESMTP; 28 Oct 2026 14:08:30 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/1] drm/i915: Fix OOB access of reset_engine_count for
 compute class
Date: Wed, 28 Oct 2026 14:08:25 -0700
Message-ID: <20261028210828.433225-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MAX_ENGINE_CLASS is the highest valid engine class value (COMPUTE_CLASS
== 5), not the number of classes. reset_engine_count[] was sized with
MAX_ENGINE_CLASS entries, so resetting a CCS engine incremented (and
i915_reset_engine_count() read) one element past the end of the array,
aliasing the adjacent field in drm_i915_private (suspend_count).

Size the array as MAX_ENGINE_CLASS + 1, consistent with other per-class
arrays such as intel_gt.engine_class[].

Fixes: cf9cb028ac56 ("drm/i915: Use internal class when counting engine resets")
Cc: <stable@vger.kernel.org>

Assisted-by: LLM
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 26970c5e291e..e53139cb77ea 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -225,7 +225,7 @@ struct i915_gpu_error {
 	atomic_t reset_count;
 
 	/** Number of times an engine has been reset */
-	atomic_t reset_engine_count[MAX_ENGINE_CLASS];
+	atomic_t reset_engine_count[MAX_ENGINE_CLASS + 1];
 };
 
 struct drm_i915_error_state_buf {

base-commit: fbed42265ffde9b162e21ed7ff0cfce070e19aaa
-- 
2.43.0

