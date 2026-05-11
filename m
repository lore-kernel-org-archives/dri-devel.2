Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E8CD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49C210E861;
	Mon, 11 May 2026 17:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hLwNod4F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310E710E85A;
 Mon, 11 May 2026 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778520660; x=1810056660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D4EknCkaHCNIg8p5sLeL9NZg/F8aPtj1hSM+njyxWqg=;
 b=hLwNod4FKwqjFe0HmQ/s49t2W/zK237aIQN2mC89ZUm2oXQ/S22WaPXq
 jWih0ymPdEA+id2OSuruNNkc6mSycqMjQRD8OIDvhN9SZekv1S7mXeRb/
 NHQGplwdNQLiqRHb4wbnBkLn8Kz2tql2MZF9Io83aq7E11LwYT6jn8zjp
 vs4o+jH6Kb90HoB2z2kxvPRNq0Z0DITAN7Rje5ToNbaQ/Js4hlO9Sfdxj
 dU/KJOWESFTY2oija5rB07q2Uh8RRdrZdW8mkPKkDAmo3ZoyIJcFsATeP
 RCI0PlZvWycAd1e0iwffw3+XAzD/WVguDxnjFY/mEC/soZXj6wvhIEdZL w==;
X-CSE-ConnectionGUID: 1QCLsK6ERiW5KHn7XuQSjg==
X-CSE-MsgGUID: SQAWeBCBTYORs+2sHTiV8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314217"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="79314217"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 10:30:58 -0700
X-CSE-ConnectionGUID: mZBnCvj3TlG9ul2tPZ5/0g==
X-CSE-MsgGUID: sUW8LuzDQ7KgesZFC0Eyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="261000443"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.248])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 10:30:53 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] drm/xe: Wire up dmem cgroup reclaim for VRAM manager
Date: Mon, 11 May 2026 19:30:07 +0200
Message-ID: <20260511173008.36526-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511173008.36526-1-thomas.hellstrom@linux.intel.com>
References: <20260511173008.36526-1-thomas.hellstrom@linux.intel.com>
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

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 5fd0d5506a7e..1bdcb3fee901 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -303,13 +303,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
-	if (mem_type != XE_PL_STOLEN) {
-		const char *name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
-		man->cg = drmm_cgroup_register_region(&xe->drm, name, size);
-		if (IS_ERR(man->cg))
-			return PTR_ERR(man->cg);
-	}
-
 	man->func = &xe_ttm_vram_mgr_func;
 	mgr->mem_type = mem_type;
 	mutex_init(&mgr->lock);
@@ -318,6 +311,18 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	mgr->visible_avail = io_size;
 
 	ttm_resource_manager_init(man, &xe->ttm, size);
+
+	if (mem_type != XE_PL_STOLEN) {
+		const char *name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
+		struct dmem_cgroup_region *cg =
+			drmm_cgroup_register_region(&xe->drm, name, size);
+
+		if (IS_ERR(cg))
+			return PTR_ERR(cg);
+
+		ttm_resource_manager_set_dmem_region(man, cg);
+	}
+
 	err = gpu_buddy_init(&mgr->mm, man->size, default_page_size);
 	if (err)
 		return err;
-- 
2.54.0

