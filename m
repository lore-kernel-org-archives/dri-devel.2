Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AdhEYihb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFF3112042;
	Wed, 18 Nov 2026 21:45:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E21E112048
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038343; x=1826574343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xe/gllvGRjhcPxAkyrjE/xDnvKPLSAJiXK5l6Ug3n8Y=;
 b=AdhEYihbfGXYDQDCIKlqwy1NWueLNW3l8mR871mhhj0O2QnYvTknpU3q
 q6OqWvT77KKDkO9hDQ03/RJMIld182XT2HzgeAUHcpN9+oNOHSztjmMKI
 r7R8n2OALhvThYhGAcXcQSqwhMYwlpbGdZDbsumFcsoChdmNW3W+TRWak
 k9UsFW+fXtYe4/uaMFU5G0+5HcYUKf155/iM50vlBQf0rgxuazNpGOb5+
 s1oRqXoTxQXtHXTc2S6pisPSiEfA1VuFc/gASy1pIl217BdsgTFr8andV
 MhSFtaracXiimTDZHV0KhcuecZ7wnYiattWpw9m3IYCg4PP91QPfyG087 w==;
X-CSE-ConnectionGUID: KR2NPgWhRB+p0qxyotomDg==
X-CSE-MsgGUID: vvufq6eLQ86RindqdWr3xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3915800"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3915800"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:43 -0800
X-CSE-ConnectionGUID: 67HYeFy5SxKA1RHTubZp+g==
X-CSE-MsgGUID: HYRShVUaQSKPkqRSUa0iRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10340790"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:41 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 03/20] drm/tilcdc: Use __le64 for the fallback 64bit write
Date: Wed, 18 Nov 2026 23:45:00 +0200
Message-ID: <20261118214518.29317-4-ville.syrjala@linux.intel.com>
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

The fallback path in tilcdc_write64() stores the result of
__cpu_to_le64() through a volatile u64 pointer. That assigns a
__le64 to a plain u64 and makes sparse complain about the differing
base types. Use a volatile __le64 pointer for the store instead, so
the types match.

Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
index 23746b134c42..9dc3e1b9e20e 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -130,7 +130,7 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
 	__iowmb();
 #endif
 	/* This compiles to strd (=64-bit write) on ARM7 */
-	*(volatile u64 __force *)addr = __cpu_to_le64(data);
+	*(volatile __le64 __force *)addr = __cpu_to_le64(data);
 #endif
 }
 
-- 
2.56.0

