Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055B0CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A1410F35F;
	Tue,  6 Oct 2026 18:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k26vzr7B";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721D710E3DA;
 Tue,  6 Oct 2026 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791309788; x=1822845788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YXPfZpxvcom/0moo9ssNPYnNi6JVpIWGlmc+zK+XMHQ=;
 b=k26vzr7Bs4INrnFlt52svvg078h6sBlJo/d/DgFPIh5GbsMZCDRONysC
 2tl2JGjUtoMYt1XVK6pEpJwX3ghrdEz3eewQyAbirgJcz2Xnc+q2m51Tf
 1fLlK3UY2byLXx0op6rXzU6KyCxh/0/I4xDpB+ST/SOY1rgBlB9ILh4cD
 Q9/w+m3eweiSdHnE954GtlSHFWf9+C4hy0FGDZGUCrcwwIbAAGUgZK09O
 YnLrmzt8CU9p3jDPXPqXZQwyz5SbuTUig2aVyob4sO7iTtgmZ/eIb9r6I
 W+j2szl13zBfHljENXrAVs9ZnhroyUVBHZ0KFvk8pQhswMvvJ2Qr7rA3m w==;
X-CSE-ConnectionGUID: ZLDDOjSNRWKc5c/m4qYBjQ==
X-CSE-MsgGUID: tXjahomZSuCCZFxxwZepyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="66037"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="66037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 11:03:07 -0700
X-CSE-ConnectionGUID: H6lK1LV8SDG8mPZVPZESNQ==
X-CSE-MsgGUID: 0l4pNXSuRemCL8Qy9Fp+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280456011"
Received: from fvishwan-4tb.jf.intel.com ([10.54.67.207])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 11:03:07 -0700
From: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@google.com>
Subject: [PATCH 2/2] RFC: drm/xe: Prevent pinned_link double add
Date: Tue,  6 Oct 2026 10:57:41 -0700
Message-Id: <20261006175741.3582911-2-fnu.vishwanatha@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
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

From: Kornel Dulęba <korneld@google.com>

When running CtsCameraTestCases on a memory constrained, 4GB device the
following list corruption oops was consistently observed:

list_del corruption. prev->next should be ffff9ebe1ce42ea8, but was ffff9ebdf741fea8. (prev=ffff9ebe1ce43aa8)

After adding printfs in multiple places it was concluded that
bo->pinned_link was already a part of a list when xe_bo_pin_external
tried adding it to xe->pinned.late.external.
To fix this add a list_empty check and a WARN_ONCE in case the list is
in fact not empty.
With this addition the CtsCameraTestCases can now complete with no
kernel crashes.

Test: atest CtsCameraTestCases
Signed-off-by: Kornel Dulęba <korneld@google.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index c5989db950f7..cc5a4ff64791 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2762,7 +2762,14 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 		}
 
 		spin_lock(&xe->pinned.lock);
-		list_add_tail(&bo->pinned_link, &xe->pinned.late.external);
+		if (list_empty(&bo->pinned_link)) {
+			list_add_tail(&bo->pinned_link,
+				      &xe->pinned.late.external);
+		} else {
+			WARN_ONCE(true,
+				  "pinned_link already added to a list, bo->ttm.pin_count: %d\n",
+				  bo->ttm.pin_count);
+		}
 		spin_unlock(&xe->pinned.lock);
 	}
 
-- 
2.34.1

