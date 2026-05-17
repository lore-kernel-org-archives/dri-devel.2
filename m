Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD94CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AC310E6E9;
	Mon, 18 May 2026 07:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kendell.dev header.i=@kendell.dev header.b="b+SDDFM3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="qXjmEEvA";
	dkim-atps=neutral
X-Greylist: delayed 532 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 16:34:35 UTC
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4DF10E248;
 Sun, 17 May 2026 16:34:35 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 80A3A7A00C2;
 Sun, 17 May 2026 12:25:42 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-05.internal (MEProxy); Sun, 17 May 2026 12:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kendell.dev; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1779035142; x=1779121542; bh=o+
 EPcssOqrbPCx1pVKmqpk3V0RomYQ93fDRvzPao+sA=; b=b+SDDFM3VvODhF5YUu
 F1iK5rfvPMoHbASA+UlR3uItx5X5Y5ecoGXcOwdzHEa6ML6HKWSN19wQnP7IIIRI
 9Fg5etkWpFGCjNGVgFNRs/hKAI8W79sSlCfGLX4/r5HB6UaoGrTbZ4bv1IMskWFO
 LIH1cLpmJgFYks/nL5PMDxE6MnlxM4Fy2d2aGnppPi1HNRH5hmfU+D4Ty9BLOB5R
 QgJD751gW5w/w1GEj21ERaIjk3CDDcw71I+9mmCww2n6XvzA+6l0Vxwp5Ka/NFlu
 DxGrK2nu+KYGc48Y9a5KEulj320z/EANTNYJbF3vw+7gZ+7E9L+z4UIueWLlrkuv
 PmVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1779035142; x=1779121542; bh=o+EPcssOqrbPCx1pVKmqpk3V0Rom
 YQ93fDRvzPao+sA=; b=qXjmEEvAd0NMYvfN3eS88OHvWWkOrgMeST59tlab8KIN
 foJQL4pUdaMYbfZnUvitP8mLCQZTXZL1d6+BR3UB2pc4D6XT1B969f0wYHpASw1O
 jYCZLyc0/VSUQ9JSn9uTBhUnq+f7KuABut3DswUsiVTXsqufLxcaZGivuyYss/c9
 bQWvQsTwpZg9Ft797SD608njSTnCvb9lSEUtaSBLidKui7UC+PWW4bEIsHlN72os
 a89OVLpmD8TcdLKdQ13gdrJmc0hVIUOvd92gIMO/tvo63Qc45F12fAgfrAZI/jrH
 s3DhLGkodoUm4lwCPT0UkkKraJBy4bIDBeAMGyyWuA==
X-ME-Sender: <xms:BewJatSjxIZAfBZv9or6X8uJy2stXqvaGsMTRHvglKuhAIPRcjwURw>
 <xme:BewJahkN6ccUslEJj9ZvR0z1BusePlF_DIQnHZlxsJXXAqql9AIT9rwaA0NQCpuv-
 -un_LWZhIe18FAh5HCTDuxq2IQviUFmGEmroxgc6hGZxn53omeQqi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeigeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthejredtre
 dttdenucfhrhhomhepmfgvnhguvghllhcuoehlihhnuhigsehkvghnuggvlhhlrdguvghv
 qeenucggtffrrghtthgvrhhnpefgfeekieehteelleeikeeftedthfefveekhffgvdejud
 dttdekveejfeekffekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehlihhnuhigsehkvghnuggvlhhlrdguvghvpdhnsggprhgtphhtthhope
 dvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhs
 thhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepfhhrvggvughrvghnoh
 eslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-ME-Proxy: <xmx:BewJakm9477PwprTMGhsSd-sh8ZyManqfvrH3LPvRcfNMHmtBmEhXw>
 <xmx:BuwJaoIZ603yTQgnuuQxeLevJg9FETq3ZfhUcqkIVPpnGflO_7Ozzw>
 <xmx:BuwJahxbcYG_taMZE_IvzSVsFSCPRr6yf1H8mMOjjwZQmLpRxFsvOQ>
 <xmx:BuwJaovqwOzg80xPuy1CZXaD6AeJkw1UWSXHZ21U7P-UpTgTJHxtKA>
 <xmx:BuwJatmnj1fzDQitGRzGBqPkAN8bDbq4Y0Hpd0cyoYfc1XTpKaK5RmBx>
Feedback-ID: ie9be4849:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id DFF6E15C008C; Sun, 17 May 2026 12:25:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 17 May 2026 09:25:17 -0700
From: Kendell <linux@kendell.dev>
To: freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Message-Id: <492340a5-5894-475b-acd5-6c6b6b32c706@app.fastmail.com>
Subject: [BUG] drm/msm: WW mutex self-deadlock in msm_gem_shrinker via direct
 reclaim from msm_gem_fault
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

Hi,

I've hit a full GPU deadlock on Snapdragon X1E running the Zed editor.
The shrinker self-deadlocks when msm_gem_fault() triggers direct reclaim
while holding the VM's dma_resv.

System info
-----------
Kernel: 7.0.0-32-qcom-x1e #32-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 21 00:33:58 UTC 2026
Hardware: Qualcomm X1E (Snapdragon X Elite), Adreno GPU (msm_dpu)
Distro: Ubuntu (linux-qcom-x1e package)

Trigger
-------
Running Zed editor, which uses WebAssembly language servers (multiple
/memfd:wasm-memory-image allocations) and DMA-BUF GPU interaction.

Deadlock sequence
-----------------
1. msm_gem_fault() locks the GEM object (via msm_gem_lock_interruptible).
   For NO_SHARE objects, obj->resv IS the VM's dma_resv.
2. get_pages() -> drm_prime_pages_to_sg() -> sg_kmalloc() -> alloc_pages()
   with GFP_KERNEL (unconditional in drm_prime.c).
3. CMA is nearly exhausted (3.2 MB / 128 MB free), so the page allocator
   enters direct reclaim.
4. Direct reclaim calls msm_gem_shrinker_scan(), which calls evict().
5. evict() -> with_vm_locks() tries dma_resv_lock(vm->resv, ticket) on
   a NON-NO_SHARE object attached to the same VM.
6. vm->resv is already held by the same thread from step 1. Deadlock.

The code comment in with_vm_locks() is relevant:

    "Since we already skip the case when the VM and obj share a resv
     (ie. _NO_SHARE objs), we don't expect to hit a double-locking
     scenario..."

The check skips ww_mutex locking when resv == obj->resv (the NO_SHARE case
for the object being evicted). But the deadlock is cross-object: a NO_SHARE
object caused the fault, locked the VM resv, and the shrinker tries to evict
a different non-NO_SHARE object whose VM resv is the same - but whose
obj->resv is different. The skip doesn't trigger, and the lock is already
held by the same thread via a different ww_acquire_ctx, so -EALREADY can't
be returned.

Dmesg traces
------------
[ 6390.715487] INFO: task zed-editor:27479 is blocked on a mutex likely
               owned by task zed-editor:27479.
[ 6513.594800] task:zed-editor      state:D stack:0     pid:27479
[ 6513.594830]  __ww_mutex_lock_slowpath+0x20/0x48
[ 6513.594835]  ww_mutex_lock+0xe8/0x178
[ 6513.594839]  with_vm_locks+0x78/0x1a8 [msm]
[ 6513.594884]  evict+0x70/0xc8 [msm]
[ 6513.594927]  msm_gem_shrinker_scan+0x1a4/0x538 [msm]
[ 6513.594975]  do_shrink_slab+0x164/0x640
[ 6513.594988]  shrink_one+0x9c/0x1d8
[ 6513.595004]  do_try_to_free_pages+0xe0/0x5a0
[ 6513.595015]  __alloc_pages_slowpath.constprop.0+0x25c/0xb18
[ 6513.595048]  sg_kmalloc+0x44/0x60
[ 6513.595054]  sg_alloc_append_table_from_pages+0x238/0x480
[ 6513.595065]  drm_prime_pages_to_sg+0xac/0x150
[ 6513.595113]  msm_gem_fault+0x48/0x170 [msm]
[ 6513.595155]  __do_fault+0x44/0x200
[ 6513.595179]  do_page_fault+0x1fc/0x870

System memory pressure (at time of deadlock)
---------------------------------------------
CMA total: 32768 pages (128 MB)
CMA free:  810 pages (3.2 MB)
allocstall (normal):  519
allocstall (movable): 3387
compact_fail:   7151
compact_success: 886
direct reclaim pages scanned: 1,194,389
Shmem: 2.5 GB (likely WASM memfds)

Root cause
----------
The unconditional GFP_KERNEL in drm_prime_pages_to_sg() (via
sg_alloc_table_from_pages_segment) permits direct reclaim while the
calling thread holds the VM's dma_resv. When memory is constrained,
the shrinker re-enters the dma_resv lock path on the same VM, causing
a self-deadlock.

Proposed fix
------------
Suppress direct reclaim during the fault path's page allocation by
wrapping get_pages() with memalloc_noreclaim_save/restore:

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
+#include <linux/sched/mm.h>

 #include <drm/drm_dumb_buffers.h>
 #include <drm/drm_prime.h>
@@ -282,6 +283,7 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
        struct page **pages;
        unsigned long pfn;
        pgoff_t pgoff;
+       unsigned int noreclaim_flag;
        int err;
        vm_fault_t ret;

@@ -300,8 +302,13 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
                return VM_FAULT_SIGBUS;
        }

+       /* Disable direct reclaim while holding GEM/VM locks to avoid
+        * self-deadlock in the shrinker (drm_prime_pages_to_sg uses
+        * GFP_KERNEL unconditionally).
+        */
+       noreclaim_flag = memalloc_noreclaim_save();
        pages = get_pages(obj);
+       memalloc_noreclaim_restore(noreclaim_flag);

        if (IS_ERR(pages)) {
                ret = vmf_error(PTR_ERR(pages));

This is the standard approach used across DRM drivers to prevent reclaim
while holding dma_resv locks.

Notes
-----
- Bug report assisted by Kimi K2.6 (language model).
- The original hung task traces above timestamp 6390 were not captured;
  the ring buffer may have wrapped.
