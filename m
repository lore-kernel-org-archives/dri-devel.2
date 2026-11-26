Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29118606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lEH68soD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99C112160;
	Thu, 26 Nov 2026 08:40:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72D410E329;
 Thu, 26 Nov 2026 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682422; x=1827218422;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=ynA5QmrvlDsoKZxKK7KgVLoTKrKmtS37JsyD0szy2bw=;
 b=lEH68soDht6NIFQ3eG4WCv2XvrVz83n5LHLZW1C7QXGw3/8zpWrEvYsr
 zkFwnbNQH4SeQExZJ3JrGMrF8RvQWrUjdWBJkR7FshkmlZ1LKdhQYI38h
 pQfrDmEaYYkdmu6XqXLX/S5YeYfGaMP/kYc3/9+Ptht6/DzbF3DFElV5T
 cV7+08xpJYrkPYy4WE7UiOZI2UnYcRWzKr4suCyPe6i6RnlOcmXojdA9O
 z5hCjZ7O1c/XqRW4XEy3cwCp/u5A0WzbAyFGnKpunpYlzE9oT4y6hB7i2
 rTlYpYGZ6HzQXYxvEbnVAiPQ3CrfqX4dO2kegOqt3/ItRxZyzYcMzx3TD g==;
X-CSE-ConnectionGUID: SvMuS+HwQBe2JLj1qQ+wZA==
X-CSE-MsgGUID: uKNTRNwjQlaXKAjWd7EDwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488523"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488523"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:22 -0800
X-CSE-ConnectionGUID: b81yjgVyQi+c8PiSL/wh/g==
X-CSE-MsgGUID: WkM9/DK/TN2McSPIfk7nrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125677"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:20 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:04:59 +0530
Subject: [PATCH v6 04/13] drm/i915/display: Add HAS_DP_SYMBOL_TG()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-4-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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

Add a macro for the display versions with the DP link layer (LL) symbol
based timing generator.

Bspec: 68849, 69961
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 7121e7cd95124f3df88fa39f4307db4a209feea1..6fab652621d1b837b76ff607f4141de4f078793d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -170,6 +170,7 @@ struct intel_display_platforms {
 #define HAS_DP20(__display)		((__display)->platform.dg2 || DISPLAY_VER(__display) >= 14)
 #define HAS_DPT(__display)		(DISPLAY_VER(__display) >= 13)
 #define HAS_DP_MST(__display)		(DISPLAY_INFO(__display)->has_dp_mst)
+#define HAS_DP_SYMBOL_TG(__display)	(DISPLAY_VER(__display) >= 35)
 #define HAS_DSB(__display)		(DISPLAY_INFO(__display)->has_dsb)
 #define HAS_DSC(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_dsc)
 #define HAS_DSC_3ENGINES(__display)	(DISPLAY_VERx100(__display) == 1401 && HAS_DSC(__display))

-- 
2.25.1

