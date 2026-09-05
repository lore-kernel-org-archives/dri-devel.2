Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A19CC79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5E910E60C;
	Sat,  5 Sep 2026 15:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="cucbROWx";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6EF10E10A;
 Sat,  5 Sep 2026 02:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vE
 zmrB5MeuSiRL/5kGaj4D0jLgiYVOzfWaAYz/uOVNM=; b=cucbROWx88pqC2EWHY
 4hQZ5tBjzjM+lv1YjQLT3MPvv2Hy+XxLzMxod+rhZV3yrYgPoIwdel8sm//yMANg
 t900v+9izRkLj6YOBlOX+MAYHHunJf/gUrsOeqYk0xz9UNV1usVvmsS3Hyq1fXbo
 DGcnyjC0nDGq6PxSCUlA5t/8E=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3_1gbf5tq0ootAw--.50391S2; 
 Sat, 05 Sep 2026 10:32:04 +0800 (CST)
From: oushinnyo <oushinnyo@163.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Harish.Kasiviswanathan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, oushinnyo <oushinnyo@163.com>,
 stable@vger.kernel.org
Subject: [PATCH v1] drm/amdgpu: keep freed VM mappings on clear failure
Date: Sat,  5 Sep 2026 10:31:51 +0800
Message-Id: <20260905023151.90699-1-oushinnyo@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_1gbf5tq0ootAw--.50391S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryfJw15CF4DGF45Kw1DGFg_yoW8AFWrpF
 WrGFs5K3yUXa4jqw1DCF1jva4Yyw4xXFW09r4UuwsF9w15AF93tFn8Aa18JryDGrWkuFW7
 XrWkt3yUu3WqvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWSo9UUUUU=
X-Originating-IP: [240e:804:dec:ed90:c41a:ce0e:8ab0:b9da]
X-CM-SenderInfo: xrxvxxpqq10qqrwthudrp/xtbC4wRqt2qbfyT7wwAA3o
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

amdgpu_vm_clear_freed() removes a mapping from vm->freed before
clearing its page table entries. If amdgpu_vm_update_range() fails,
the mapping is currently freed even though the PTE update might not
have completed.

This is particularly problematic with CPU VM updates. Waiting for an
earlier submission is interruptible, so a signal can abort the wait
before any PTE is cleared. The old mapping then exists neither in the
VA tree nor on the freed list, allowing a later VM update to reuse the
virtual address while an earlier submission still references it.

Put the mapping back on vm->freed on every update error. This keeps the
pending clear operation alive and makes later VM updates retry it before
installing new PTEs. It also covers partial CPU or SDMA updates
conservatively.

Fixes: b4d42511b7f2 ("drm/amdgpu: Support page table update via CPU")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: oushinnyo <oushinnyo@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde5459469..e20905d2d90c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1606,11 +1606,12 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
-		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
+			list_add(&mapping->list, &vm->freed);
 			dma_fence_put(f);
 			goto error_free;
 		}
+		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 	}
 
 	if (fence && f) {
-- 
2.25.1

