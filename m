Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2702ECD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC5A10E492;
	Mon, 15 Jun 2026 15:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HMShIIhH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E601610E492
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781537395; x=1813073395;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qMiCD7f7DEha9iarnk5tO2wyrY1CeFuUdrW8YX53JaE=;
 b=HMShIIhH6rx7OQVDANBIb8kr0CWUPR+juyDKH74G8zPCgUZsUNPGJt9S
 ou9msKWpKVEUzYGR7c5X077ACad2ikV0eaXisFUK4+lVidc6YSEhStGl8
 EtOJoJTYsr18dYRMG91frafz0Sape4zZ/eSptPNa+Z7MTS9evWkREqmHp
 WfiXIbn23C/kjBnfD9ewWZnU+gIFnSfYZCF73Fch50kG07TDBzDwTBpIl
 Wnj/Wzq3RH19h3ktyoawLCUBUqymCo/NTBqV5mTd4SCqWW6qnqwAlzq+W
 VOxu3veu41J21mAWFIzHhYWeRmWN95Dh0KgnZq4C6xfdM0C9iNiZL8M7y Q==;
X-CSE-ConnectionGUID: t8F0Ca67SRmrTrx6B1jJbg==
X-CSE-MsgGUID: tvgLcmlKRLa/CjaJdBtUmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86181297"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="86181297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:29:54 -0700
X-CSE-ConnectionGUID: Q4pGCgPwR8Wla7BGUwNyEA==
X-CSE-MsgGUID: z3toVH4TSPKICfiE7My17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="243335835"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:29:52 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Riana Tauro <riana.tauro@intel.com>,
	jani.nikula@intel.com
Subject: [PATCH] drm/ras: include linux/types.h in drm_ras.h
Date: Mon, 15 Jun 2026 18:29:49 +0300
Message-ID: <20260615152949.1899358-1-jani.nikula@intel.com>
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

drm_ras.h uses u32. Include linux/types.h for it.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/drm/drm_ras.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..0beede3ddc4e 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -6,6 +6,8 @@
 #ifndef __DRM_RAS_H__
 #define __DRM_RAS_H__
 
+#include <linux/types.h>
+
 #include <uapi/drm/drm_ras.h>
 
 /**
-- 
2.47.3

