Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C83A105D9B9
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E05510E678;
	Wed,  8 Apr 2026 14:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LaRbhP9P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C693E10E678;
 Wed,  8 Apr 2026 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775656908; x=1807192908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sj0bJFhLUKd5S3V9MnFKRV5ekCEI4Kjbr33EGYWA0HA=;
 b=LaRbhP9Pt/AYxQdCIxP6KPIm0b9vRXXhnkUqj8AEOGL0RTaTJISblFkN
 CxalTyV9ZpYKUS5jKOU0o3hXditO5vuhjNy4ZmbOdzPcs7qKbhUTC59xq
 MD3VYV1QNCTfXYhFpbpNo1VSew0a0oRbflfxShDR5Eoel82SqlHPDwLZ8
 nOvb9JkrlCTMR+sujkv++HSsONcu5BncR2x+kzsY4fA1qex+RO98pqMde
 9bTN+Vz0Bf88my/1gaV/5bnoZm4/cdYu+QK71JmN0G5Lwz53BpPc/GG8Y
 1fY9EePYR3O56smgIS51nAVw6F12uIDYpGWj7fys5qpmhDxl8k4vTJC5Q g==;
X-CSE-ConnectionGUID: yHmg3xFpTqWxA+OsW3Aj2g==
X-CSE-MsgGUID: drHbHcVxQWuYb+8CQ0woDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75811529"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="75811529"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 07:01:24 -0700
X-CSE-ConnectionGUID: Alic1PWlRku5Io90y4350A==
X-CSE-MsgGUID: mQANnXLbSPyxyL30DYQ8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228726676"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO
 jhogande-mobl3.intel.com) ([10.245.244.251])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 07:01:23 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/7] drm/dp: Include PSR2 granularity registers into PSR
 capability size define
Date: Wed,  8 Apr 2026 17:00:55 +0300
Message-ID: <20260408140059.252067-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408140059.252067-1-jouni.hogander@intel.com>
References: <20260408140059.252067-1-jouni.hogander@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

Currently EDP_PSR_RECEIVER_CAP_SIZE contains only DP_PSR_SUPPORT and
DP_PSR_CAPS register. Include also granularity registers into this size to
avoid need to read them separately.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 include/drm/display/drm_dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8b15d3eeb716..9af87c88b9c4 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1691,7 +1691,7 @@ enum drm_dp_phy {
 #define DP_RECEIVER_CAP_SIZE		0xf
 #define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 through 0x6F */
 #define DP_DSC_BRANCH_CAP_SIZE		3
-#define EDP_PSR_RECEIVER_CAP_SIZE	2
+#define EDP_PSR_RECEIVER_CAP_SIZE	5
 #define EDP_DISPLAY_CTL_CAP_SIZE	5
 #define DP_LTTPR_COMMON_CAP_SIZE	8
 #define DP_LTTPR_PHY_CAP_SIZE		3
-- 
2.43.0

