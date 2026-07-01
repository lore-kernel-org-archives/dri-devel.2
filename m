Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C149C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2F210E3F0;
	Wed,  1 Jul 2026 17:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LLA7bDaX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2654510F088
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782926704; x=1814462704;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ympMIIZM9+k3tJ/2m23PbDeDXtK8Iyz3+cVVZHmxmhM=;
 b=LLA7bDaXaPnBEmEaBWqdnlLQB/kWZLZPNfihoIBFnQxPR+WBANCIRfef
 UjeByGlbyyIDBkQZ2GwWyPvTFqXvjmeO2vajOAUjr0B7y1jghT5Dzu10t
 fn4HnhqXaAFRqrzCU68VjTEZyVDsXceHr5xFRc6Ec7qaq4LCRqCQNavN5
 IcVwsyMN66IcnKQ1eCmveUCoiRfFb8v6CiobfcYg8F0oQwFm5ftxQHsm3
 a1H9/xP4dpySNMShhmhbEMoeBEC3e0iGZsrWoBEZ2ZBCTZlLxlLs1Dva/
 6XwOg4FMxXitHBcsKSJcdclIS6PYauf3x2UR/A/4f4p8ktms01OSTqcOO A==;
X-CSE-ConnectionGUID: Nz9YVMs+RgKvWtBIsMC6qg==
X-CSE-MsgGUID: qg1f5WtEQVC+XaBT6yQG+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83542220"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="83542220"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 10:25:03 -0700
X-CSE-ConnectionGUID: Kgegkl2HR5mXDJ9/0s1Bcw==
X-CSE-MsgGUID: VaTa8WmISK+0S0w2V1CSFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="250907831"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 10:25:02 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, robdclark@chromium.org,
 christian.koenig@amd.com
Subject: [PATCH] drm/exec: Use kvmalloc_objs for exec->objects
Date: Thu,  2 Jul 2026 01:24:58 +0800
Message-ID: <20260701172458.1416930-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use kvmalloc_objs instead of kvmalloc_array when initializing
exec->objects in drm_exec_init.

Concern caught by static analysis.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 7988f5e7d56a..fa923852fae4 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -79,7 +79,7 @@ void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr)
 		nr = PAGE_SIZE / sizeof(void *);
 
 	exec->flags = flags;
-	exec->objects = kvmalloc_array(nr, sizeof(void *), GFP_KERNEL);
+	exec->objects = kvmalloc_objs(*exec->objects, nr, GFP_KERNEL);
 
 	/* If allocation here fails, just delay that till the first use */
 	exec->max_objects = exec->objects ? nr : 0;
-- 
2.53.0

