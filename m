Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U4ld8tPx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A261710E0A7;
	Fri, 30 Oct 2026 17:17:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3029D10E0A7;
 Fri, 30 Oct 2026 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793380660; x=1824916660;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DwTwSNt37ko0ZzpsS+HdByt1AHsSJoAoiLtZSJq22jo=;
 b=U4ld8tPxGS8QS56QKVs3lT0p8NCCuGkrFlNyvwVUP+l0q8n74fAVUUDy
 /K66YIN0EfwDsOVMxfgeRuGpY9ZfeL2q3V302xlEVUQWCilWZFKH2H9lt
 RAT/4cftNn2YTLK5FfM5ChNtmRyBnjwp02rCkpR/LacwQOhixfFHvoM1t
 WgzUlgg+MegwowJ9UY6bkdPWZkqpJNlzqRvDqBsb9zyIG3+4Knd2oPgR0
 cxLsBjvZbY3ZJUHCq4zoyXdlp7OI3ZKj1UjB46LUPc7v/ykXL3hfMlVWb
 clPrxE4YrKEzbXOZ+NWoLb7DUrWByX7qJZp+WUlIkCkPg5Q1XuLC36fhU w==;
X-CSE-ConnectionGUID: WcpU2XviS8W7R77vechxkg==
X-CSE-MsgGUID: pdkCik6XSUqt21Ua0C+MhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2183087"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2183087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:17:39 -0700
X-CSE-ConnectionGUID: D9w3yjQKSjmosKm3LVEdsA==
X-CSE-MsgGUID: inysc06uTs+Z1cgFZPqQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5455494"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa001.jf.intel.com with ESMTP; 30 Oct 2026 10:17:39 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Date: Fri, 30 Oct 2026 10:17:38 -0700
Message-ID: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When user requests to enter survivabilty via configfs, or if
check_boot_failure is hit inside xe_survivability_mode_is_requested,
no indication is published. This patch adds some awareness in dmesg.

 v3 : Limit message to xe_survivability_mode_is_requested. (Riana)
 v2 : Remove / modify messages to reflect underlying behavior. (Sashiko)

Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_survivability_mode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
index d73cdad0b3a9..344b402eb728 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -413,13 +413,19 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
 
 	survivability_mode = xe_configfs_get_survivability_mode(pdev);
 	/* Enable survivability mode if set via configfs */
-	if (survivability_mode)
+	if (survivability_mode) {
+		xe_log_info(xe, SURVIVABILITY, "Boot mode requested.");
 		return true;
+	}
 
 	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
 	survivability->boot_status = REG_FIELD_GET(BOOT_STATUS, data);
 
-	return check_boot_failure(xe);
+	if (check_boot_failure(xe)) {
+		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
+		return true;
+	}
+	return false;
 }
 
 /**

base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
-- 
2.43.0

