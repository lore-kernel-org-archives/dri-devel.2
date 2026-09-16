Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CEC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3466A10E8A4;
	Wed, 16 Sep 2026 09:56:09 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819B410E898;
 Wed, 16 Sep 2026 09:56:06 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowACnrTu0Z6pqUb3gBw--.42600S2;
 Wed, 16 Sep 2026 17:56:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Lang.Yu@amd.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 simona@ffwll.ch, Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
Date: Wed, 16 Sep 2026 09:55:36 +0000
Message-Id: <20260916095536.2010601-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnrTu0Z6pqUb3gBw--.42600S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWDtFykWr1fGrW5Gr4rKrg_yoW8XryUpF
 WfGF17K3yDZr4xtw4UZF18ZFyqkw47XFyFkr4qkr1fWw1rJwnakry5ZrW8Wr97CFZ5AFW3
 tr1DA3y8XF1qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
 W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
 UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7miUQAAs3
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

amdgpu_vm_init() initializes vm->last_update, vm->last_unlocked and
vm->last_tlb_flush with references to the stub fence taken via
dma_fence_get_stub().  The error label at the end of the function
releases the last_unlocked and last_tlb_flush references with
dma_fence_put(), but the reference stored in vm->last_update is never
dropped, so whenever the page table root creation, the reservation of
the root BO or the PASID registration fails, the stub fence reference
leaks.

Drop the vm->last_update reference together with the other stub fence
references on the error path.

Fixes: 187916e6ed9d ("drm/amdgpu: install stub fence into potential unused fence pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fccd758b6699..494197ac20e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2693,6 +2693,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:
+	dma_fence_put(vm->last_update);
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
-- 
2.34.1

