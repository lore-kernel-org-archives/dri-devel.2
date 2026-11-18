Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440B606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ThBsci/q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA0B11205B;
	Wed, 18 Nov 2026 21:46:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5AD112059
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038388; x=1826574388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=85MO5QHDvAciZphg0emjzSvADqfM1RF3tb6K8saGXJA=;
 b=ThBsci/q75f9XEVLQ+CXEl6b7rYbwZBxuUQEeWOebUajcTp7aExtOlDx
 DyCWWqSpU0kI8UFvm2QwtUEI787VRqPNdRuA8mQ523a79+Qm9C0axrA+X
 413cH/In6JLnDVvaEPmBeZR2/me15auqngAzlPhHGgS9TpFB4ga+iT/sV
 ENLE4oLBUNA0YvzeSKH2z1CVZCw6K3Pld/wPwrIXT36NmPpe/WT1L6Spd
 tlJNtGiKJ5tWn46fXLVX/3jGdz4/3CiuHUnd5E0F74Tb7/SfEtgG1257o
 b3FwNd4T956ku3cBDywTXOTavgJTXza7OyZjJ4QDWM//PTuoUVadwfQc5 Q==;
X-CSE-ConnectionGUID: b4uNtsFLQ8Wi0689t/vGhw==
X-CSE-MsgGUID: c9CtBjILQTONIn8xJBrwAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886675"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3886675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:28 -0800
X-CSE-ConnectionGUID: 9Xvmue9aSrCRleNq7yjZ/Q==
X-CSE-MsgGUID: gRy+kUZkQDuaGA2b5jc2Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10157289"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:26 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>,
 asahi@lists.linux.dev
Subject: [PATCH v4 12/20] drm/adp: Allow build with COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:09 +0200
Message-ID: <20261118214518.29317-13-ville.syrjala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Allow adp to be built with COMPILE_TEST=y for greater coverage. Builds
fine on x86, x86_64, arm and arm64 at least.

Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/adp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/adp/Kconfig b/drivers/gpu/drm/adp/Kconfig
index acfa21ee06d2..6073aa6b46a4 100644
--- a/drivers/gpu/drm/adp/Kconfig
+++ b/drivers/gpu/drm/adp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR MIT
 config DRM_ADP
 	tristate "DRM Support for pre-DCP Apple display controllers"
-	depends on DRM && OF && ARM64
+	depends on DRM && OF && (ARM64 || COMPILE_TEST)
 	depends on ARCH_APPLE || COMPILE_TEST
 	select DRM_KMS_HELPER
 	select DRM_BRIDGE_CONNECTOR
-- 
2.56.0

