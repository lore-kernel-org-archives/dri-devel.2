Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01545CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BC310E505;
	Mon, 15 Jun 2026 15:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XEOFy69t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDC310E505
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781537418; x=1813073418;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Iaelrjq9SNSXs8lCe8XbvPXpZ+DAO/pr/zcJFupzamU=;
 b=XEOFy69tyZW/XPfFjaofDvSiUDNym1I0IJsa37XE41Wvq5SoEs3vvkA/
 fuvmucWI3rMxlWsSfXN30dkx8pbxXI1wbK9GWeuraKgPFG7hZSoWSLilc
 2UnU/9Chp/Nhlg64dby+5OQ7INf4v6w+jOXDqTMP5YCDgreSQ3s7CvcyG
 ThyT30BM3npyw5J9UrqqsQrFAJh9xiAYHCMYHc0gzV5qOXktaFSGbOh1P
 5QDdLA90ees5rUg/SfQXs7JTwNUWdV1CgcnCDT1F3w4YQV2OMY5+kQ/Qc
 wi6qnZFFc8fKqn6phrSNzdZV2ezdmxktZew3IE5ozu+c5ls/0GytsSXaY A==;
X-CSE-ConnectionGUID: OvR6kb80T9mrarFqIcN8XA==
X-CSE-MsgGUID: oVsTCFV8Ql6xYG2wk1OjEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86181410"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="86181410"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:30:17 -0700
X-CSE-ConnectionGUID: mV9rW+QkQaazRBqe13S92g==
X-CSE-MsgGUID: 46v5PRrBThmYH6Z81JGpeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="271198011"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:30:16 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH] drm/fixed: fix kernel-doc for drm_sm2fixp()
Date: Mon, 15 Jun 2026 18:30:12 +0300
Message-ID: <20260615153012.1899576-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

Fix the kernel-doc comment for drm_sm2fixp().

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/drm/drm_fixed.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 33de514a5221..21d822aeed55 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -79,7 +79,8 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
 #define DRM_FIXED_ALMOST_ONE	(DRM_FIXED_ONE - DRM_FIXED_EPSILON)
 
 /**
- * @drm_sm2fixp
+ * drm_sm2fixp() - convert signed-magnitude to fixed point
+ * @a: 1.31.32 signed-magnitude fixed point
  *
  * Convert a 1.31.32 signed-magnitude fixed point to 32.32
  * 2s-complement fixed point
-- 
2.47.3

