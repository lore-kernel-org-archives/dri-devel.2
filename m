Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122CBC4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5945710E51E;
	Fri, 17 Jul 2026 03:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="K+IteHO9";
	dkim-atps=neutral
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1436B10E4C1;
 Fri, 17 Jul 2026 03:35:37 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f816;
 Fri, 17 Jul 2026 11:30:31 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 4/5] drm/amdgpu: make ring rptr_cpu_addr and
 wptr_cpu_addr typeless
Date: Fri, 17 Jul 2026 11:30:08 +0800
Message-Id: <20260717033009.649538-5-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e20300a03a1kunm4f30d13722115
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUtJVk4ZQkJNTR1KQkNDSFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=K+IteHO96TA/jtzLRGHfWj7JFafaFXa+P4/HLZ9TrsQqAkLaWY1LyDzQihj37V6yS/EcCagp1I+h6x2d770gZbWagylk8muK032A4sQGesOP1oYOECFM96R9qEwLVdk8thnhmeKFHYbzrImLT/fbifPfJsx+5APd9qDNIXIlvnU=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=r/Sx2cj8IHzv2nslld9rwfz/flY291ew0h6CMjs3lkc=;
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

Now that all ring writeback slot accesses go through typed helper
wrappers, the stored CPU pointers no longer need to pretend that every
slot is a u32-based carrier.

Change rptr_cpu_addr and wptr_cpu_addr in struct amdgpu_ring from u32 *
to void *. The actual access width is now chosen at the call sites
through the typed 32-bit and 64-bit helpers, which better matches how
the writeback slots are used across different ring implementations.

This patch just removes the misleading static type from struct
amdgpu_ring after the call site conversions. No functional change is
intended.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 82c6bc782..ced27dd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -316,7 +316,7 @@ struct amdgpu_ring {
 	bool			reemit;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
-	u32			*rptr_cpu_addr;
+	void			*rptr_cpu_addr;
 
 	/**
 	 * @wptr:
@@ -396,7 +396,7 @@ struct amdgpu_ring {
 	 * This is the CPU address pointer in the writeback slot. This is used
 	 * to commit changes to the GPU.
 	 */
-	u32			*wptr_cpu_addr;
+	void			*wptr_cpu_addr;
 	unsigned		fence_offs;
 	u64			fence_gpu_addr;
 	u32			*fence_cpu_addr;
-- 
2.34.1

