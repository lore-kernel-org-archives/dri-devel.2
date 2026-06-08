Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C7ACD8CA8
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4271910F2F7;
	Mon,  8 Jun 2026 12:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gZ78Ni39";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC2810F2F9;
 Mon,  8 Jun 2026 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780921454; x=1812457454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RPGknN476mpSDzo4eSzXO6AZ6wxYTVDDvZ8PYBgF/zY=;
 b=gZ78Ni39Gbh2G7BVQNAmN91b+Dl++YstiFWzJoMWXHYBU25RdDJVBY7C
 XvVtzkK0cYNZmxVyKMhr0y4VWVHpyEEnE1Gz82vPbXFjSMif/I2pREmU9
 hA6VIJ/kMR3ZXoihhEz11LH9x7sjay4KkWlmLFc5n88Lg/CIFO0Qg/KBZ
 lLZZ+G+sunJ75E/g72bjasZrTaqb+ChpZT0/LxQsFrZxx2kAGRf/z8q+V
 D7ovoeOH40MPwwUL4LyrinE1lUJWF34xy85p5a3eexSCb2ugTZOtR79QU
 6H+eS6/I7jXarVwum90Mrt9Ycygs+Zin+v84laTiy47ShTbBNYIGHMfj+ w==;
X-CSE-ConnectionGUID: 9idnzwskQLGPTFvipZvLVA==
X-CSE-MsgGUID: nqnBf3/9RwCAKh8c/9IqZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81700936"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81700936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 05:24:14 -0700
X-CSE-ConnectionGUID: akw0P5UeTpGv+wP7tzx5iQ==
X-CSE-MsgGUID: hXEMbi4QSKmGVKshVWZQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="241090626"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa006.fm.intel.com with ESMTP; 08 Jun 2026 05:24:13 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: check individual moved list instead of
 invalidated
Date: Mon,  8 Jun 2026 14:23:16 +0200
Message-ID: <20260608122316.3131299-2-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260608122316.3131299-1-michal.grzelak@intel.com>
References: <20260512162711.51118-4-christian.koenig@amd.com>
 <20260608122316.3131299-1-michal.grzelak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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

Checking `invalidated` field causes build to fail since it is absent in
struct amdgpu_vm. Replace it with &vm->individual.moved identically
as did commit 59720bfd8c6d ("drm/amdgpu: restart the CS if some parts of
the VM are still invalidated").

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: 40396ffdf612 ("drm/amdgpu: restart the CS if some parts of the VM are still invalidated")
Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 548a4f14a9f8..5d8f5848bc0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1323,7 +1323,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		e->range = NULL;
 	}
 
-	if (r || !list_empty(&vm->invalidated)) {
+	if (r || !list_empty(&vm->individual.moved)) {
 		r = -EAGAIN;
 		mutex_unlock(&p->adev->notifier_lock);
 		return r;
-- 
2.45.2

