Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C53606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TBo9Rpma
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6456110ECB5;
	Wed, 18 Nov 2026 21:46:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21FC10ECB5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038359; x=1826574359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0eTuPOaLO48KbuzJRjmws2CEf2aqrKiDMKPLERTtV7Q=;
 b=TBo9RpmaoPqs14m70hAGG6X9NLhqNDBSLuSurH0+LEZAEi8N0h44VauZ
 q26spT7nfahPfLnLZA5ggJ+kNMGAhUK+VSk6ag3k2wLIm0Xtjb/A7kijs
 qFEbTgUgS6lY4eaRQZXnwya2iXWiD1c1vhwEjcDlwsBGVaexMza/ueh22
 5JI9XqAwdB/rElkwl0tN54VfutZiz9yM+TJnmZeWPzszlevP/LMbtvEE4
 oPLdPq3a6QVQJtQnZq0W+8kjS7owqXvIXE55AcK8PxiSELYxUS/V0kx+u
 bLIqMNIfseuv34rVFaFXhFYJEHOuqCcLrC0r1gmwth4Fl2+btbV//Khsz g==;
X-CSE-ConnectionGUID: Ci5kgLUOQKyVzQ2YQBl5zg==
X-CSE-MsgGUID: i1jXxrwxRhSeqru7uQ7TTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3758160"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3758160"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:58 -0800
X-CSE-ConnectionGUID: 126mACbrTxO2Huz+AjXRlw==
X-CSE-MsgGUID: DtYQdrvJRE2JI8eF36tVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10647065"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:58 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 06/20] drm/armada: Fix printk arguments
Date: Wed, 18 Nov 2026 23:45:03 +0200
Message-ID: <20261118214518.29317-7-ville.syrjala@linux.intel.com>
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

../drivers/gpu/drm/armada/armada_gem.c: In function ‘armada_gem_pwrite_ioctl’:
../drivers/gpu/drm/armada/armada_gem.c:367:27: warning: format ‘%u’ expects argument of type ‘unsigned int’, but argument 2 has type ‘size_t’ {aka ‘long unsigned int’} [-Wformat=]
  367 |                 DRM_ERROR("invalid size: object size %u\n", dobj->obj.size);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~
      |                                                                      |
      |                                                                      size_t {aka long unsigned int}

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/armada/armada_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index da7335cbe82d..8a8f4da6f44f 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -365,7 +365,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 
 	if (args->offset > dobj->obj.size ||
 	    args->size > dobj->obj.size - args->offset) {
-		DRM_ERROR("invalid size: object size %u\n", dobj->obj.size);
+		DRM_ERROR("invalid size: object size %zu\n", dobj->obj.size);
 		ret = -EINVAL;
 		goto unref;
 	}
-- 
2.56.0

