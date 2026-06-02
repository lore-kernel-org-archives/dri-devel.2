Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AB3C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E2710EBCF;
	Tue,  2 Jun 2026 05:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EWm+v6Wp";
	dkim-atps=neutral
Received: from mail-m9343.xmail.ntesmail.com (mail-m9343.xmail.ntesmail.com
 [103.126.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FE410EBD4
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 05:04:26 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40b387ce5;
 Tue, 2 Jun 2026 13:04:23 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kenneth.feng@amd.com,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu/mes12: fix queue init wptr reset
Date: Tue,  2 Jun 2026 13:03:54 +0800
Message-Id: <20260602050354.2237095-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
References: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e86b7f5ff03a1kunmb7f79aef178c11
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkJJVkIfHkgeTUIdSk5LSVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
 hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=EWm+v6Wp4FQK2zA0zKjBoe6WZIbg1GLxC77rp9x4rOA7jma/PQApAPonjXeJxRjIhW3h9+rqihkc7+SGMXo1yVBo6927wrOhGwcEyCCxlKvEhEzkzfKzNv/Rrw+/KOWitjp99jh5BGxmwZBKZzz6yV0ZL5HBVbNCjTSOwE4yjFo=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=D3xcZv25/w2ySOWXApKK8LTp/+QDmMdOM7MaVAFD9Og=;
 h=date:mime-version:subject:message-id:from;
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

mes_v12_0_queue_init() resets ring->wptr_cpu_addr with a plain 32-bit
store in the reset/suspend path even though the same carrier is
accessed with atomic64_set()/atomic64_read() and support_64bit_ptrs is
enabled.

This is not just a missing atomic annotation. The MES queue write
pointer is a shared 64-bit carrier, and *ring->wptr_cpu_addr = 0 only
clears the low 32 bits. A later atomic64_read() can then observe stale
high 32 bits instead of a real zeroed reset state.

Use atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0) so the reset
path updates the full 64-bit wptr with the same access family as the
existing readers and writers.

Build-tested by compiling mes_v12_0.o.

No AMDGPU hardware was available for end-to-end runtime testing.

Fixes: 785f0f9fe742 ("drm/amdgpu: Add mes v12_0 ip block support (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345e..22ed7bb51 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1476,7 +1476,7 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 
 	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		*(ring->rptr_cpu_addr) = 0;
 		amdgpu_ring_clear_ring(ring);
 	}
-- 
2.34.1
