Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0270606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dmLi3E7l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014BB112060;
	Wed, 18 Nov 2026 21:47:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98717112061;
 Wed, 18 Nov 2026 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038424; x=1826574424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MxglsjaFRqvtjDiBpvLwHx/EjmicyoelLQmhk/aEwNo=;
 b=dmLi3E7lYUO81W34j5oi3hOzPPYY5vGjN/zEVguCdQXqhvJyA3VRwK3n
 hfs4GBXgzcU5fWylncrpC+sKF9uJpol1ihcXTV8Rqwd/U7HGy762Rvx2B
 DjB6U5kMPZ8uFs2C69HUKCkkkSVQvSAQxQFinATB915BMTLk6tSZNY9Dw
 UAD63+5x8dPOVmacgmbifw0oC1rW01G0vNwlJyX3GBPT0tSvcxuQMXRwz
 DWzmJAvSBNJyMQXCI1c/QuVxOinhfA/Q/AHM7mr8t51SHcr9wcVdoPjuu
 sefkePz/ibC5avKKh8RUeGBZVe6M6hDgqkPa6glzmE8PRBPcgRztBgxKp g==;
X-CSE-ConnectionGUID: 1EktzJ8fTwW69ut+MCsrxg==
X-CSE-MsgGUID: RKzv/2XHR16Zeol7sV3hRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3763821"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3763821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:47:04 -0800
X-CSE-ConnectionGUID: vHq9TMyES5eiTUcQGiUkLA==
X-CSE-MsgGUID: n5Gr4rwkRp2EBYFOfRYw7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10142851"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:47:02 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org
Subject: [PATCH v4 19/20] drm/nouveau: Allow platform driver build with
 COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:16 +0200
Message-ID: <20261118214518.29317-20-ville.syrjala@linux.intel.com>
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

Allow NOUVEAU_PLATFORM_DRIVER to be built with COMPILE_TEST=y for
greater coverage. Builds fine on x86, x86_64, arm and arm64 at least.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3b5757aed9c8..d7b432c839e5 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -34,7 +34,7 @@ config DRM_NOUVEAU
 
 config NOUVEAU_PLATFORM_DRIVER
 	bool "Nouveau (NVIDIA) SoC GPUs"
-	depends on DRM_NOUVEAU && ARCH_TEGRA
+	depends on DRM_NOUVEAU && (ARCH_TEGRA || COMPILE_TEST)
 	default y
 	help
 	  Support for Nouveau platform driver, used for SoC GPUs as found
-- 
2.56.0

