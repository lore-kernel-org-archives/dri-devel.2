Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FDF99357
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D64210EFE2;
	Thu, 23 Apr 2026 08:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="lZspk4wK";
	dkim-atps=neutral
X-Greylist: delayed 556 seconds by postgrey-1.36 at gabe;
 Wed, 22 Apr 2026 12:43:23 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F57310E9F8;
 Wed, 22 Apr 2026 12:43:23 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [112.10.250.117])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3bb9ba587;
 Wed, 22 Apr 2026 20:38:17 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, 220245772@seu.edu.cn,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: avoid double drm_exec_fini() in userq validate
Date: Wed, 22 Apr 2026 20:38:17 +0800
Message-ID: <20260422123817.1940-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9db532c6f903a1kunm7eb60d492426
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk8YVhhDSExDTBhKGUMeGFYeHw5VEwETFhoSFy
 QUDg9ZV1kYEgtZQVlKSklVSktVSU5LVUpKTFlXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=lZspk4wK6YMyq6qyPLONzxsl2WFyxmfrochGEfwUZ/wExadUb+d1bPBVISU1RMDNZoED+GN6oOzU+crna3dlDWr7s8dsf7MrmMF4Z0k6Uq0gFzLWTIUm1l4rlzoqgdA+0C9fiHmAi8tjpwJBK8LY6YcZ68zRbFS6+NwGQ3HvwlY=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=dfYTW/RukwJufC/jwZrraJiVVcRI03xOMxKQGV1Op4Y=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:38 +0000
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

When new_addition is true, amdgpu_userq_vm_validate() calls
drm_exec_fini(&exec) before iterating over the collected HMM ranges and
calling amdgpu_ttm_tt_get_user_pages().

If amdgpu_ttm_tt_get_user_pages() fails in that path, the code jumps to
unlock_all and calls drm_exec_fini(&exec) a second time on the same
exec object. drm_exec_fini() is not idempotent: it frees exec->objects
and may also drop exec->contended and finalize the ww acquire context.

Route that error path directly to the range cleanup once exec has
already been finalized.

Fixes: 42f148788469 ("drm/amdgpu/userqueue: validate userptrs for userqueues")
Issue found using a prototype static analysis tool
and confirmed by code review.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9d67b770bcc2..fe49108fabbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1193,7 +1193,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 			bo = range->bo;
 			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
 			if (ret)
-				goto unlock_all;
+				goto free_ranges;
 		}
 
 		invalidated = true;
@@ -1220,6 +1220,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&exec);
+free_ranges:
 	xa_for_each(&xa, tmp_key, range) {
 		if (!range)
 			continue;
-- 
2.50.1.windows.1

