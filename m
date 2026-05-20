Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C38CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 17:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD53310E278;
	Wed, 20 May 2026 17:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgnUC/Ld";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DF110E278
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:15:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16778442A2;
 Wed, 20 May 2026 17:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08E1F00893;
 Wed, 20 May 2026 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779297336;
 bh=2gjZmZCviHuawBNnpoS7CFujlo9II6+xEUM9DY+wGyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NgnUC/LdPEnfJFiYR/SEI+bTM10IRj7f90WoNexvXMJmtAWbFJP3YL+V8D+ga69wq
 +7MhyghpWi8Clunff1QW5kwus27RLn50c877UhytR+2Q1FMPQqAqS0vRN7g1gRGRF5
 oUwN8mKiONEAVAhmipHvAWT+KwJpA3+T3QfPR3K0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Friedrich Vock <friedrich.vock@gmx.de>,
 Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <dev@lankhrost.se>
Subject: [PATCH 7.0 1133/1146] drm/ttm: Convert -EAGAIN from
 dmem_cgroup_try_charge to -ENOSPC
Date: Wed, 20 May 2026 18:23:03 +0200
Message-ID: <20260520162213.891807759@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 591711b32681a04b57d00c2a404658f8419a081c upstream.

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
Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>
Link: https://patch.msgid.link/20260508160920.230339-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c       |    2 +-
 drivers/gpu/drm/ttm/ttm_resource.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -740,7 +740,7 @@ static int ttm_bo_alloc_resource(struct
 		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
 		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
 		if (ret) {
-			if (ret != -ENOSPC && ret != -EAGAIN) {
+			if (ret != -ENOSPC) {
 				dmem_cgroup_pool_state_put(limit_pool);
 				return ret;
 			}
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -398,8 +398,11 @@ int ttm_resource_alloc(struct ttm_buffer
 
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


