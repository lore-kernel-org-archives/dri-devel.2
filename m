Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A83606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TBTXU1RQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3267B10ECB4;
	Wed, 18 Nov 2026 21:46:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0029311204D;
 Wed, 18 Nov 2026 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038393; x=1826574393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AfJD13lD/XUKMBDgY8w+n4waSa1mvffKMq4gvmUZKZI=;
 b=TBTXU1RQeIY9ul3Fk8d3zrBEPbCPDvOKG/TsgKykBGo4QqEa6aRXpcc3
 MdnMrk0Rg5y9qeQJuq8eRpojAXTFbmzzV2uxrYESQA/9zCcc+Y8zeCSBA
 ThdSE9u/aw+oR6OiTzoqHRM1n4iiWdoOT+Ji67Nqi0ODz9jy2fHJajqoz
 WGmTbOFA/deMvTNXnUTwIy7ZpkVAIopAuQSewQgR/sVs/OubJyRKFwF+i
 7Qy49x/kdvFZ68L438RIQq9lK4cCZrJJW9r8e4x0uYBeURVYNtdY/ySmz
 GsklgGWzuCJ446QJjQ4APdDw47sqhqLall3i0hdB7a22x28hxfv0M0msz g==;
X-CSE-ConnectionGUID: LrQO4wraSE61K8uyhV0t6w==
X-CSE-MsgGUID: O9z3mBPrSdmADjTHjJYTqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886682"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3886682"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:33 -0800
X-CSE-ConnectionGUID: 5OQkxZoXRXmZ8Pzqb/4o3A==
X-CSE-MsgGUID: QaCxWVkyRQmDF/y9fsGP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10157314"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:31 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 imagination@lists.freedesktop.org
Subject: [PATCH v4 13/20] drm/imagination: Include io-64-nonatomic-lo-hi.h
Date: Wed, 18 Nov 2026 23:45:10 +0200
Message-ID: <20261118214518.29317-14-ville.syrjala@linux.intel.com>
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

ioread64() and iowrite64() are provided by asm-generic/io.h on 64bit
architectures that use it, such as arm64, but not on all architectures.
Include linux/io-64-nonatomic-lo-hi.h, which only supplies them when the
architecture doesn't, so the driver can be built with COMPILE_TEST=y
elsewhere. There is no functional change on architectures that provide
native 64-bit accessors.

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: imagination@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/imagination/pvr_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..975b4e671418 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -19,6 +19,7 @@
 #include <linux/compiler_types.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
-- 
2.56.0

