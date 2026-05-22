Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93CACD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560AC10E64F;
	Fri, 22 May 2026 09:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aFquR0e3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9205410E277;
 Fri, 22 May 2026 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779441987; x=1810977987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=drAOgkSCOpci7XA/wV7u+sd99NUI4AHo9Xp2YycE4n0=;
 b=aFquR0e3SSZlv5x4VaDETLWbWl6zGpR8Q5AHZdgtny5RWOCrO7aD3qwA
 O9yRNZLt98uGinUBHpo+q11wx9i/HCT74CU7H7h5k3Jf4E+crBX8y9k1z
 p/xCV3zqZLtC781+Pne+KkPPKKPbFyNN1OVjqFq4a3wBWn0RoRMSAfZxk
 DmhdFsJSJSSIbfuArRS/rM5zbRRb2RorVa/gcdtzRhHwfYYvNoT0riO8g
 PwZOiEQFq1qlvJKPkXKR6anA5s3tfVQU/0VUMVx+HZEhBX8lrbwpXiqad
 pyB0oMfOeih4O1QxAUy+zvrgnjUMkybPdeeaQxvTFryw0ci2t43AEwQfQ Q==;
X-CSE-ConnectionGUID: LnwNeKzzTRGBTuspQBq8Kw==
X-CSE-MsgGUID: VEckCQXUQ16Vf0/iy6JwPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67895303"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="67895303"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:27 -0700
X-CSE-ConnectionGUID: es8BgaBwSkCG7xKYdJjlCg==
X-CSE-MsgGUID: qud4P3UvQfiPUDepg2xpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="237830299"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.244.230])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:26 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Arunpravin.PaneerSelvam@amd.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 2/5] gpu/buddy: Remove redundant condition in
 alloc_from_freetree() error path
Date: Fri, 22 May 2026 11:25:29 +0200
Message-ID: <20260522092600.32818-3-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522092600.32818-1-francois.dugast@intel.com>
References: <20260522092600.32818-1-francois.dugast@intel.com>
MIME-Version: 1.0
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

The err_undo label in alloc_from_freetree() is only reachable via a
goto from inside the `while (tmp != order)` loop, which means tmp is
guaranteed to differ from order at that point. The surrounding
`if (tmp != order)` guard was therefore always true and can be dropped
without any behavioral change.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/buddy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dac2027bb64a..9f6696f47f89 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -849,10 +849,8 @@ alloc_from_freetree(struct gpu_buddy *mm,
 	return block;
 
 err_undo:
-	if (tmp != order) {
-		rbtree_remove(mm, block);
-		__gpu_buddy_free(mm, block, false);
-	}
+	rbtree_remove(mm, block);
+	__gpu_buddy_free(mm, block, false);
 	return ERR_PTR(err);
 }
 
-- 
2.43.0

