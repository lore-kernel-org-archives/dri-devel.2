Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F9606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mf2yPZx+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B4F10E2E3;
	Wed, 21 Oct 2026 08:46:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B544610E2E3;
 Wed, 21 Oct 2026 08:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792572405; x=1824108405;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Jjuwx9ARMFdR4PdJdOhnBCXsug8WT423elVugN7nRJw=;
 b=mf2yPZx+wLErxJDm0heGe6KbYj1q1Gr+sehNLQYI2BYZVYxA4yYw12Ot
 Ly2ur7W/NWVyluGGR8b6MiRH9Pb/MM6meDDeHEuCNuruSdltjXPaIFOub
 dH3v/4xgMODd5X8ZW+mMrDstOkawL3whWi4TJQWy1R2vF9E5WuLMFQci9
 hLzgIodjVnndTzZ2ei7m0nHTyTPxlV+3iFDNGIjqGbWPB7jySQoOLa5Tk
 r9noxIsIhRhLz9jlOKP/Fz0nfusmya4/zK13IwIg6gJJGME78O8aUTFaa
 Eq1F49McEWw5FsmblQSRU/tzAtneEbAxUxiFXX6l1p9xPswLimiKZLWlb A==;
X-CSE-ConnectionGUID: xfqf7hRUQE+h3kKc6O1XSg==
X-CSE-MsgGUID: 34bKZBxaRj6+SjW3YSq3lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1179542"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1179542"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:46:44 -0700
X-CSE-ConnectionGUID: +6taVgm4Q72o2/VoXIX2LA==
X-CSE-MsgGUID: UCK8kT6BRz+H0i9o3WwDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3352944"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2026 01:46:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 452CA99; Wed, 21 Oct 2026 10:46:41 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/amdkfd: Do not use internal implementation of
 tolower()
Date: Wed, 21 Oct 2026 10:46:39 +0200
Message-ID: <20261021084639.251366-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ctype.h provides tolower() macro specifically for the cases
that might be architecture-optimised. Using __tolower(),
which is internal implementation, needs a good justification,
as this driver is the only user of that and there is no evidence
it's required.

Note, currently it's no difference as the macro always defined
to the internal implementation, but it might change in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 35b3abe57b80..1ef4d26a0ac6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2091,7 +2091,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 * needed for the topology
 	 */
 	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
-		dev->node_props.name[i] = __tolower(asic_name[i]);
+		dev->node_props.name[i] = tolower(asic_name[i]);
 		if (asic_name[i] == '\0')
 			break;
 	}
-- 
2.50.1

