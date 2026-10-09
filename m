Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8584FCA9EC5
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4A010E567;
	Sat, 10 Oct 2026 11:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="L6+PFKcs";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913B811214A;
 Fri,  9 Oct 2026 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y+
 ePeBrDalH4ot+RGsdcB0s9bmc/mBJjEtJvv7GUvmI=; b=L6+PFKcsbvh6J35Vbm
 977RGwxynajGUjvp6qLHitQPBAELWHktpXeJH66JQ/DOkgY92Gk3IoaVhTDvP7bP
 LhT0u3kTvYi3rCvocGMEJrsnpzbxI0Fg4dtCSIUx5uI4yfliRcau0MpqNjS8+cFI
 hjexNpfkZwt1IcWpK02nIqnhg=
Received: from colol4bi5.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD338uI68hqzoRZDQ--.36286S2; 
 Fri, 09 Oct 2026 21:26:33 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] drm/amdkfd: Fix use-after-free in the process creation
 error path
Date: Fri,  9 Oct 2026 21:26:19 +0800
Message-ID: <20261009132619.40151-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD338uI68hqzoRZDQ--.36286S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur47Wr1rXF15uryDKF45Wrg_yoW5Gw4rpa
 yrWF1jvr1kC3Z7K343Zay8ZryfJw4UAF47Grn7Kr9xWw15AFy5XrZxGryj9F95Cr1F9a43
 t3WDWr4UGr9Fvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1uWXUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4AnpzWrI64kgAAAA3t
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

create_process() publishes the new process in the global hash table
before the steps that can still fail:

	/* alloc_notifier needs to find the process in the hash table */
	hash_add_rcu(kfd_processes_table, &process->kfd_processes,
			(uintptr_t)process->mm);

If a later step fails (mmu_notifier_get() with a pending signal, or
kfd_process_alloc_id()), the error path removes and frees it:

err_register_notifier:
	hash_del_rcu(&process->kfd_processes);
	svm_range_list_fini(process);
	...
	kfree(process);

hash_del_rcu() only unlinks the node; readers that entered an SRCU
read-side critical section before the deletion can still be walking
the hash bucket and using the node.  The unconditional kfree() that
follows is not covered by any SRCU grace period, so such a reader can
obtain and dereference freed memory.

The readers are the GPU interrupt and ioctl lookup helpers, which run
under srcu_read_lock(&kfd_processes_srcu) only:
kfd_lookup_process_by_pasid() iterates the whole table with
hash_for_each_rcu and dereferences p->pdds[] of every entry;
kfd_lookup_process_by_id() and kfd_lookup_process_by_mm() match and
return the process for further use.

The normal removal path (kfd_process_table_remove()) already executes
synchronize_srcu(&kfd_processes_srcu) after hash_del_rcu(); only the
error rollback path misses it.  The race is reachable by an unprivileged
GPU compute user: a thread whose process creation fails (e.g. ioctl
interrupted by SIGKILL at mmu_notifier_get) while another thread is
servicing a GPU interrupt that walks the process table.

Fix this by waiting for an SRCU grace period in the error path after
unlinking the process, before the object is freed.

Fixes: 0029cab3146a ("drm/amdkfd: fix a use after free race with mmu_notifer unregister")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da95..8d0e70a256f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1747,6 +1747,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	kfd_process_free_id(process);
 err_register_notifier:
 	hash_del_rcu(&process->kfd_processes);
+	synchronize_srcu(&kfd_processes_srcu);
 	svm_range_list_fini(process);
 err_init_svm_range_list:
 	kfd_process_free_outstanding_kfd_bos(process);
-- 
2.43.0

