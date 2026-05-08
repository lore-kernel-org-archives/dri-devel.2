Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD80CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 16:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA9F10F510;
	Fri,  8 May 2026 16:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UQxpINYa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DD410F512;
 Fri,  8 May 2026 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778256586; x=1809792586;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Pw89MZSsx4bacdYuTC5zAh+6l0iElYL9UiZ16rDQxZc=;
 b=UQxpINYaO0aV4oM/WR0f6vb6ylP4cGTYYqLsngvhgi4COMLSAl7yjWUi
 DnDVPY6JG6Z9TC4aeL6uHhDWuzsVa2EXecE682zkcRvrho16mstjBd3nP
 oU7SNASehLklEOJDnQ8Pp7WlHNkJ5DqB1ssnDz0/CBfSCSSm7qfDo9vda
 kLUAZLOyFj1+K45WXtPEqIwJC7uAmCJyMZCTXAuvGC+3GcNFs5mvMGTUd
 FR+jUgiVRR8nM7q/y99Hrd9wTZlpPFMUYRcK/LwJCnfXQzIyD2zkpsnkq
 6xniOwa4NF4eyZe1Ec1ssqQO4L1s8mr5WGjP/SRSGyjrLniGIfWFD03G/ g==;
X-CSE-ConnectionGUID: DDq4P0fvQtG1TPZ0QVb7ww==
X-CSE-MsgGUID: hNGhiBmQSFe1g5TYw+TR5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="89539875"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="89539875"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 09:09:45 -0700
X-CSE-ConnectionGUID: FJAc6G/QQyy1fPCAC7AGUg==
X-CSE-MsgGUID: aH38HiWrQ4C3m41TPr42Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="274916674"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.34])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 09:09:43 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to
 -ENOSPC
Date: Fri,  8 May 2026 18:09:20 +0200
Message-ID: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
hit and the charge fails. TTM has no concept of -EAGAIN from resource
allocation; -ENOSPC is the canonical error meaning "no space, try
eviction". Convert at the source in ttm_resource_alloc() so no caller
needs to handle an unexpected error code, and clean up the now-redundant
-EAGAIN check in ttm_bo_alloc_resource().

Without this, -EAGAIN escaping ttm_resource_alloc() during an eviction
walk causes the walk to terminate early instead of continuing to the
next candidate.

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.14+
Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 2 +-
 drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d85f0a37ac35..cee3828df655 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
 		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
 		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
 		if (ret) {
-			if (ret != -ENOSPC && ret != -EAGAIN) {
+			if (ret != -ENOSPC) {
 				dmem_cgroup_pool_state_put(limit_pool);
 				return ret;
 			}
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 9f36631d48b6..b0efffe5a526 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -385,8 +385,11 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
 
 	if (man->cg) {
 		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
-		if (ret)
+		if (ret) {
+			if (ret == -EAGAIN)
+				ret = -ENOSPC;
 			return ret;
+		}
 	}
 
 	ret = man->func->alloc(man, bo, place, res_ptr);
-- 
2.54.0

