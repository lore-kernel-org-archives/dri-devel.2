Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2233CD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8110EA62;
	Tue, 19 May 2026 06:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jhur0M4p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CCD10EA62
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:12:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DE3640611;
 Tue, 19 May 2026 06:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8DFC2BCB3;
 Tue, 19 May 2026 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171124;
 bh=FIaIskFhiZr23kgzdN5o6EsUcf6PX3xFesCK2oC89Kg=;
 h=From:To:Cc:Subject:Date:From;
 b=Jhur0M4pmjI025/Mym4UtEuMZ32f4gNSwkkt5KUV7mHDAeChAd/AzYeNo17n3M2YN
 kOe85MGMY5GrXWpIgVlms1w9Xy7LheozHI20p9n0F/J62uiiuEmobV9gnUeeoLxClz
 AqjGinbJuzZC5TOwDg+EFP+YDPu0Y27D77XyuAckuD4r37atmBH0vH7RhAznelCO3K
 E+8f9D5uQEFXJJJH1jdjMbdHbVOCkLlmr3OPSu1MIBvxOYdxikH+JwjHGTOW6Y+nbo
 Xmt74MQM0VWxZ7FVAHddRs2r3VQZEtJa5visfOvpxB7FkVzdmYVHVNTJievsalvIcx
 LtVFkT6ocI3nQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel: Use LIST_HEAD() to initialize on stack list head
Date: Tue, 19 May 2026 13:52:58 +0800
Message-ID: <20260519055258.13102-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
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

Use LIST_HEAD to initialize on stack list head. No intentional
functional impact.

Change generated with below coccinelle script:

@@
identifier name;
@@
- struct list_head name;
+ LIST_HEAD(name);
  ... when != name
- INIT_LIST_HEAD(&name);

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 4 +---
 drivers/accel/ivpu/ivpu_ipc.c            | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 361cff577381..0e47e243ce42 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -2752,7 +2752,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	struct hl_vm_hash_node *hnode;
 	struct hl_vm *vm = &hdev->vm;
 	struct hlist_node *tmp_node;
-	struct list_head free_list;
+	LIST_HEAD(free_list);
 	struct hl_mem_in args;
 	int i;
 
@@ -2785,8 +2785,6 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 
 	mutex_unlock(&hdev->mmu_lock);
 
-	INIT_LIST_HEAD(&free_list);
-
 	spin_lock(&vm->idr_lock);
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid == ctx->asid) {
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..74f5afe5be46 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -467,9 +467,7 @@ void ivpu_ipc_irq_work_fn(struct work_struct *work)
 	struct ivpu_device *vdev = container_of(work, struct ivpu_device, irq_ipc_work);
 	struct ivpu_ipc_info *ipc = vdev->ipc;
 	struct ivpu_ipc_rx_msg *rx_msg, *r;
-	struct list_head cb_msg_list;
-
-	INIT_LIST_HEAD(&cb_msg_list);
+	LIST_HEAD(cb_msg_list);
 
 	spin_lock_irq(&ipc->cons_lock);
 	list_splice_tail_init(&ipc->cb_msg_list, &cb_msg_list);
-- 
2.53.0

