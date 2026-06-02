Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F039FCD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF6510EBDC;
	Tue,  2 Jun 2026 05:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LuX5yeVa";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 05:09:12 UTC
Received: from mail-m8382.xmail.ntesmail.com (mail-m8382.xmail.ntesmail.com
 [156.224.83.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C66A10EBDC;
 Tue,  2 Jun 2026 05:09:11 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40b387cd3;
 Tue, 2 Jun 2026 13:04:05 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kenneth.feng@amd.com,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [PATCH 0/2] drm/amdgpu: fix MES queue init wptr reset on atomic64
 carriers
Date: Tue,  2 Jun 2026 13:03:52 +0800
Message-Id: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e86b7aeb903a1kunmb7f79aef178b0e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTExKVhpLHkIdQx1NGE5CHVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
 hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=LuX5yeVaeVplufiL3Ru4Rfo1I7zpi60gEnc7bKVZCGgMXjiS5XLabZLqRW38Tg6g3mWXqWiwyoeTOyQE2BaeAb16R6G9uLT1iIKAqV/d0knE6qwonxwPQ3EguOY8WWsN3dkCh8pPHt1S0JgZBnXj0jPmmgP2jZJ42RBFSX30WQU=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=3ozlCg70KuW0KiVNXBM6eYw1cpJ5baIR8QH2ZWdJFlU=;
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

This series fixes two MES queue-init reset paths that still clear
ring->wptr_cpu_addr with a plain 32-bit store even though the same
carrier is accessed with atomic64_set()/atomic64_read() and
support_64bit_ptrs is enabled.

This is not just a missing atomic annotation. The write pointer carrier
is used as a shared 64-bit value, so a plain *ring->wptr_cpu_addr = 0
only clears the low 32 bits. A later atomic64_read() can then observe
stale high 32 bits instead of a real zeroed reset state.

Use atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0) in both reset
paths so the full 64-bit MES wptr is cleared with the same access
family as the existing readers and writers.

This issue was first flagged by our static analysis tool while scanning
for 64-bit atomic write pointer carriers mixed with plain reset stores,
then manually audited on Linux v6.18.21.

It was further confirmed with a QEMU no-device stand-in that preserved
the same access contract: atomic64_set() write, plain low-32 reset, and
atomic64_read() readback. In that stand-in, a buggy reset turned
0x12345678abcdeff0 into 0x1234567800000000, while replacing the reset
with atomic64_set(..., 0) read back 0x0.

Build-tested by compiling mes_v11_0.o and mes_v12_0.o.

No AMDGPU hardware was available for end-to-end runtime testing.

Runyu Xiao (2):
  drm/amdgpu/mes11: fix queue init wptr reset
  drm/amdgpu/mes12: fix queue init wptr reset

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1
