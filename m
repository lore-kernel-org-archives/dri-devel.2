Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9CEC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184F710E50D;
	Fri, 17 Jul 2026 03:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="IIZbWGJu";
	dkim-atps=neutral
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4916210E50D;
 Fri, 17 Jul 2026 03:35:40 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f81a;
 Fri, 17 Jul 2026 11:30:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 5/5] drm/amdgpu/mes: reset full 64-bit wptr in queue
 init
Date: Fri, 17 Jul 2026 11:30:09 +0800
Message-Id: <20260717033009.649538-6-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e203b5403a1kunm4f30d1372211f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRgfVh5PTB9JSRlMHx4fTVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=IIZbWGJuumWibbF6WTwXarDaWRSfi7dFCAw8UYm56FeJ+4P9HKXrKaUaEsq7rWxgA5zjDkaM7DqN4E43LI2dIxrtaFjF5b3Yd6lzRhZQW0m1NcJ32U+YpYFvX2P/JUM0e8GE6PM+B4omGj3Zv3eVqFoKrKXLDSuS64PP0h0YGd4=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=D8BPlwy/yKNUW+N2/wdpgefyrg1G/2dIU/LMcGXI7iY=;
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

mes_v11_0_queue_init(), mes_v12_0_queue_init(), and
mes_v12_1_queue_init() clear wptr_cpu_addr in their reset/suspend paths
before reinitializing the MES queue.

Those MES rings otherwise use the same writeback slot as a 64-bit wptr
carrier. Clearing it through a 32-bit access resets only the low 32 bits
and can leave stale high 32 bits behind, so the reset path does not
necessarily produce a fully zeroed 64-bit wptr state.

Use the typed 64-bit writeback helper for the MES wptr reset so the full
carrier is cleared in all three queue-init paths.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 46f6dfd77..2d5baed0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1307,8 +1307,8 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 
 	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
-		*(ring->rptr_cpu_addr) = 0;
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write32(ring->rptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index fb6f34b06..b397f1816 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1475,8 +1475,8 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 
 	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
-		*(ring->rptr_cpu_addr) = 0;
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write32(ring->rptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b00b65090..34edb98ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1451,8 +1451,8 @@ static int mes_v12_1_queue_init(struct amdgpu_device *adev,
 
 	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
 	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
-		*(ring->wptr_cpu_addr) = 0;
-		*(ring->rptr_cpu_addr) = 0;
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write32(ring->rptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.34.1

