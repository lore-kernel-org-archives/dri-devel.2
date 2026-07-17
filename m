Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD524C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB4B10E4C4;
	Fri, 17 Jul 2026 03:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="RuBEk2AQ";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 03:35:32 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A5B10E4C1;
 Fri, 17 Jul 2026 03:35:32 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f810;
 Fri, 17 Jul 2026 11:30:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 1/5] drm/amdgpu: add typed helpers for ring writeback
 slots
Date: Fri, 17 Jul 2026 11:30:05 +0800
Message-Id: <20260717033009.649538-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e20160a03a1kunm4f30d13722103
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEwZVkwaHU5JTEkeGk0ZHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=RuBEk2AQwCCam9Ql4/eNNqnjDJfFv0zaIz4jM9Af5KPAUkKauIxbxZPUGu8yQKNwtX8bROiXaYaEPAiyuTeoTVvlpTC/Ogx3hzyxMZ3R8BEf/pJEonfg3hbicg2NYmFFrucPJ67CpwcQngtwL+NtQgNaHLFzvnrkqsb71lBjnCE=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=+08RE8+0l+DwEGex02C6rnD7fObZ5N8xnzFLQGWDlfA=;
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

AMDGPU ring writeback slots are currently accessed with a mix of direct
pointer dereferences, casted u64 accesses, READ_ONCE()/WRITE_ONCE() on
casted pointers, and atomic64_t casts.

Add small typed helpers for reading and writing 32-bit and 64-bit ring
writeback slots. This makes the intended slot width explicit at each
call site and provides a single access model for the later cleanup
patches in this series.

This patch only introduces the helpers and does not change any existing
call site behavior.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd7..cdc855285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -457,6 +457,26 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
 #define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
 
+static inline u32 amdgpu_ring_wb_read32(const void *cpu_addr)
+{
+	return READ_ONCE(*(const u32 *)cpu_addr);
+}
+
+static inline void amdgpu_ring_wb_write32(void *cpu_addr, u32 value)
+{
+	WRITE_ONCE(*(u32 *)cpu_addr, value);
+}
+
+static inline u64 amdgpu_ring_wb_read64(const void *cpu_addr)
+{
+	return READ_ONCE(*(const u64 *)cpu_addr);
+}
+
+static inline void amdgpu_ring_wb_write64(void *cpu_addr, u64 value)
+{
+	WRITE_ONCE(*(u64 *)cpu_addr, value);
+}
+
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
 void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
-- 
2.34.1

