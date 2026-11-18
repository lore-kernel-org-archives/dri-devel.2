Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCC606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRyoM8eZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F63811205A;
	Wed, 18 Nov 2026 21:46:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB1311205D;
 Wed, 18 Nov 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038404; x=1826574404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wgmmevpvciO3TALN22bqXWZZlVD3kmslflfBeIvdbu8=;
 b=mRyoM8eZj1PBq6oBkSRNEjePnhMlQmt1babNE6nNtg3ZU29Rg4Agb7vP
 K2OaMjdYUgtxzN6UEk9vol499WckFiXljSrc9k4xHfgDphBrzYt9naH0G
 hmkviF40bQHwswdg0wmMeSQfKRNskwf1AbgE4zIwfWZWK6aWnehXUIjtq
 GH6Jxpcv6KmW5sFqXDgT9ZK6WGSxqR8VyBN5KX6ceSLWbzrbBKkeZUsLi
 0RWpJ6azlgD+G5Vn3m1VHw9SW64OHqAUUoJUf2YHBww++YHDF2VrO0DXH
 1Wccxx9sSEP46rsagLHQeGmGhXYskaf8zgGpu0WW2nnByylNkhYItvMJM w==;
X-CSE-ConnectionGUID: lLj4Lub/RLKjfQLm1DZ/tA==
X-CSE-MsgGUID: fCkfoAQZR4u3VRuBbuv6Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3788566"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3788566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:43 -0800
X-CSE-ConnectionGUID: bANmRAISTcW6Utjv6yggRA==
X-CSE-MsgGUID: A52yDMGyQ7+DiKwF5G9RvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10258553"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:42 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 imagination@lists.freedesktop.org
Subject: [PATCH v4 15/20] drm/imagination: Allow build with COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:12 +0200
Message-ID: <20261118214518.29317-16-ville.syrjala@linux.intel.com>
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

Allow powervr to be built with COMPILE_TEST=y for greater
coverage. The driver only supports 64bit, so keep requiring
64BIT explicitly; previously that was implied by the
(ARM64 || RISCV && 64BIT) dependency. Builds fine on
x86_64 and arm64 at least.

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: imagination@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/imagination/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 1fd4c635c2c9..a048d3c85938 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,7 +3,8 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on (ARM64 || RISCV && 64BIT)
+	depends on ARM64 || RISCV || COMPILE_TEST
+	depends on 64BIT
 	depends on DRM
 	depends on MMU
 	depends on PM
-- 
2.56.0

