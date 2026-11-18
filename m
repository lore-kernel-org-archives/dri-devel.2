Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE39606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiO31FJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290F710EC87;
	Wed, 18 Nov 2026 21:45:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A3010EC87
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038338; x=1826574338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+fY/5xKLQJdAX9XjUoK4MFkwzUeU0EW/+pnSjLjv6T0=;
 b=hiO31FJreUvg72E9cLmROKtNpCSKeLtCmegPAJSywbcR2PThcH5I/6Mc
 1RJ/9LT3euc886UEa8fgSRTgJeCTKhBr98w7yvDO1RNaj1w+5BbzcSdeP
 6fmZceawJEKo+260laCRHEOEBzLZjeSICCCnlgbIq1LaDrDgXkNMVjiIC
 PaBBSbUm6Sc2w5hwtzxZ1MK74Shy/A8QcDlDvWp/KCa2Nuel9rSEMMI0K
 RTRiGkfAIppQAjPq8W5/s4RKUFD2uh74/cIkNVDtpUHIQIV8ZYgNo7w3s
 XfQcZJptfWVQRMIbeAG0RB7q2Rs8PtgFIYxUaD8RsPQAPB6A156fcj7Yc w==;
X-CSE-ConnectionGUID: OMGSDVYpR0udQvol8HOWxQ==
X-CSE-MsgGUID: mGE12qeXQ4+06sgaYRJilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3915791"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3915791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:38 -0800
X-CSE-ConnectionGUID: WcQLlMz4SpWD6cKvDHfoLA==
X-CSE-MsgGUID: FfBPAAXmSrmjHM0D/MX8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10340779"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:36 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 02/20] drm/tilcdc: Drop volatile from the mmio pointer in
 tilcdc_write64()
Date: Wed, 18 Nov 2026 23:44:59 +0200
Message-ID: <20261118214518.29317-3-ville.syrjala@linux.intel.com>
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

The address is passed to iowrite64() when the architecture provides
a native one. On some architectures (eg. alpha and parisc) that
takes a plain void __iomem *, so passing a volatile qualified
pointer discards the qualifier. This triggers -Wdiscarded-qualifiers
from gcc and a "different modifiers" warning from sparse. It is not
visible on ARM or arm64, where iowrite64() takes a volatile pointer.

The volatile on the pointer variable is not needed. The fallback
path already uses an explicit volatile cast for the actual access.

Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
index 55fe598fe770..23746b134c42 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -120,7 +120,7 @@ static inline void tilcdc_write(struct drm_device *dev, u32 reg, u32 data)
 static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
 {
 	struct tilcdc_drm_private *priv = ddev_to_tilcdc_priv(dev);
-	volatile void __iomem *addr = priv->mmio + reg;
+	void __iomem *addr = priv->mmio + reg;
 
 #if defined(iowrite64) && !defined(iowrite64_is_nonatomic)
 	iowrite64(data, addr);
-- 
2.56.0

