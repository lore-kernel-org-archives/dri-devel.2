Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B45CCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F223410E3DA;
	Tue,  6 Oct 2026 18:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C5MC/t8Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535EC10E280;
 Tue,  6 Oct 2026 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791309788; x=1822845788;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7vSBnfMCI48yAxzm0aSG5XNSKSOyOeUFtsnyjm1w0t0=;
 b=C5MC/t8YCtiO75ks6D5Xb9gRsMWo/j8SpdSOnVl3N+oc9N1/aVWHgl2M
 NXaR55qptUW09DWX+bWXIThaHEXu5BheeEf5p+Ao8dJRwDmCkpPNtxaFf
 4PqX8vfEP3mQdzuDcNVco5E73dAJjD0ihjC5p7Hsp2NQ0KlMWXF6/77Kc
 H0OIMVkNPEVUJMorL0WBrRuU5l1/iEU6Au/IWRQib7pvdkEfA/uginLZF
 CT10jZ9hgAy6kgac012gHYZEcPDM60GZgELK9INuoY+fNX07yU2PLAlf1
 FzkHGVTHF6ZQU8894r7OeUsKmWb6SkJpfHBS0EE1T1Gwc+1Cb7XSiTyfY g==;
X-CSE-ConnectionGUID: qdbg9vhkQjedyV8g+Fe7BQ==
X-CSE-MsgGUID: N/h0QJT+TX6c35nWCYdmOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="66034"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="66034"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 11:03:07 -0700
X-CSE-ConnectionGUID: yd+5alKsTZqdESi/fmcmVg==
X-CSE-MsgGUID: s9xcPfS6QM6wZblPEBiXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280456010"
Received: from fvishwan-4tb.jf.intel.com ([10.54.67.207])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 11:03:07 -0700
From: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@google.com>
Subject: [PATCH 1/2] RFC: drm/xe: Fix pinned list UAF panic
Date: Tue,  6 Oct 2026 10:57:40 -0700
Message-Id: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
X-Mailer: git-send-email 2.34.1
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

A kernel panic caused by a list corruption was observed when the IPU6
driver is running under heavy load. The panic would reproduce
consistently within a few minutes of the test suite running, though
never during the same test. The corruption would always happen in
list_add_tail called from xe_bo_pin_external:

list_add corruption. prev->next should be next (ffff8bb9862912c8), but was ffff8bb9e811e2a8. (prev=ffff8bb9e811e2a8)

Having prev->next == prev, suggests that node was re-initialized without
being removed from the list first. This indicates that the BO might have
been destroyed while it was still pinned.
Looking into xe_ttm_bo_destroy and its caller ttm_bo_release, reveals
that the latter supports a case where bo->pin_count > 0, albeit with a
WARN_ON_ONCE. Since ttm_bo_release sets bo->pin_count to 0 in that case,
add a complementary change to also remove bo->pinned_link from the list.
With this applied, the test progresses much further, with the newly
added warning seen in dmesg.

Test: atest CtsCameraTestCases

Signed-off-by: Kornel Dulęba <korneld@google.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f2634d048cd4..c5989db950f7 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1688,6 +1688,11 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 	if (bo->parent_obj)
 		xe_bo_put(bo->parent_obj);
 
+	spin_lock(&xe->pinned.lock);
+	if (WARN_ON_ONCE(!list_empty(&bo->pinned_link)))
+		list_del_init(&bo->pinned_link);
+	spin_unlock(&xe->pinned.lock);
+
 	mutex_lock(&xe->mem_access.vram_userfault.lock);
 	if (!list_empty(&bo->vram_userfault_link))
 		list_del(&bo->vram_userfault_link);
-- 
2.34.1

