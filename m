Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00B606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kXMTrA8o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C09112056;
	Wed, 18 Nov 2026 21:46:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50FE11201C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038378; x=1826574378;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o7yXrj8op+qn7M6JwfT387/zs11sK1fuVTudq53FtoI=;
 b=kXMTrA8oE13w3GRGKnfRrouuIwZQBb6VEiIHQF07WH9Wq3yNs07GAlly
 bbfiVbil+rcankzUnptDwREatu+tDPtqwlQsOiWkXzVJbX2+xeEKM5tAA
 FaBYuwGQLNVsuN/gMey4bQTZU4YJxfejQ+leBrrikTbeNI6jky0LdthAH
 G5vPx917naUOsXIDNX6Du56qF9uqBxeSYe9049sepb+jflZEKFwLl8nTF
 HFkIbz0cyvaCn0W4BpDrx/DtVsAKC5/4D3qQTmeseU+5SYUVok0C5IFO+
 SUqAK56J81M3tYwG43PrF9bBy90bHTei69x8WLbbS++h2Cwry+yhPoVf/ A==;
X-CSE-ConnectionGUID: 47uXOSQvQ6ydA08KBqsEeg==
X-CSE-MsgGUID: pZ5mJoVOTXefiGoU3mqGpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886663"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3886663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:18 -0800
X-CSE-ConnectionGUID: +ecb4fnyQl6Jjfyv4K7DnA==
X-CSE-MsgGUID: V4CPqJyYSWa2V2PgyOp6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10157283"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:15 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>
Subject: [PATCH v4 10/20] drm/fsl-dcu: Allow build with COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:07 +0200
Message-ID: <20261118214518.29317-11-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Allow fsl-dcu to be built with COMPILE_TEST=y for greater coverage.
Builds fine on x86, x86_64, arm and arm64 at least.

Cc: Stefan Agner <stefan@agner.ch>
Cc: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/fsl-dcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index 0e0f910ceb9f..ef7fd7fc9fd6 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_FSL_DCU
 	tristate "DRM Support for Freescale DCU"
-	depends on DRM && OF && ARM && COMMON_CLK
+	depends on DRM && OF && COMMON_CLK && (ARM || COMPILE_TEST)
 	select BACKLIGHT_CLASS_DEVICE
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_DMA_HELPER
-- 
2.56.0

