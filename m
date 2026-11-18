Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D7606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nZFyGRYB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86D511205E;
	Wed, 18 Nov 2026 21:46:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9AD112056
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038383; x=1826574383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fmGCYydggi6/pw14GpOKh+8TnEMcL+rruKPQvLKl0ag=;
 b=nZFyGRYBgpGmFZSftTB6xiImDjZEsND3Mc59Pe5i5/k3HZc26gzW0xQW
 SpI5oBNitsvklq3isKXAr4riFaz/6COZc0kRGuL1tuaUS7vK6aBGAR5bU
 IyhgS8S4gk7AaEa+F2n1YqqFYV2IWksYc5QGpDB7k2D8Tr84KYvlLoF3z
 mKnN9Vg6NjpPoeY/3LPpBf10XGRG6AY4ZRbafEQxQP63SupRVat0DUWJj
 GlvKwkFVRSS0ocAke0P4788sMckfJZHXfnz8LPJL4sxLsMLwK89SM8l6a
 KCiE8J/fLWVT2qdN2fWzmDaQVoK0xG2LtE1p8jN7zZnLfyZDUkUvfsK7X A==;
X-CSE-ConnectionGUID: WliIfWbIQESShniHpx8Zig==
X-CSE-MsgGUID: 0v+QLC9xQTCFRdDU4WxIzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886667"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3886667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:23 -0800
X-CSE-ConnectionGUID: MNFJ9UuDSyaAj9EA3Tlfdg==
X-CSE-MsgGUID: Lk9NsYEZSqqjq4KYuuo95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10157286"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:20 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>,
 asahi@lists.linux.dev
Subject: [PATCH v4 11/20] drm/adp: Include linux/bitfield.h
Date: Wed, 18 Nov 2026 23:45:08 +0200
Message-ID: <20261118214518.29317-12-ville.syrjala@linux.intel.com>
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

adp_drv.c uses FIELD_GET() but doesn't include linux/bitfield.h,
relying on an indirect include that isn't present on all
configurations. Include it explicitly so the driver can be built
with COMPILE_TEST=y on other architectures.

Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/adp/adp_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index fdf0e6316175..21257612f5d0 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/component.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
-- 
2.56.0

