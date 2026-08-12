Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3225FC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822EB10E464;
	Wed, 12 Aug 2026 21:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="tAgVcEJU";
	dkim-atps=neutral
Received: from smtpout2.mo539.mail-out.ovh.net
 (smtpout2.mo539.mail-out.ovh.net [51.210.91.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307F910E3CA
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:02:00 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hL1Bs3dNvz4LdM;
 Wed, 12 Aug 2026 21:01:57 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <rppt@kernel.org>; Wed, 12 Aug 2026 21:01:57 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.54.185])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hL1Bs1GNbz7tBb; Wed, 12 Aug 2026 21:01:57 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.5])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 541D5B81AA5; 
 Wed, 12 Aug 2026 21:01:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00206f6ca3f-fd1e-48bc-897c-a2e8049964fc,
 8BEE3CEBAAF7878994F6346FE83F56AB2EFF9D65) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <d5ea3344-24e7-4834-b743-4dec812ada70@pixelcluster.dev>
Date: Wed, 12 Aug 2026 23:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Natalie Vock <nat@pixelcluster.dev>
Subject: userfaultfd wp-async support for (GPU) special mappings?
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 16088265245785350599
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTENcapTGTz/DtMtzR+tulh/8IgOfyIAy0E7ZgGfgzt0x74nGHh+Af3SCltyISvAhYfN6Z7W2WI2lZ3YF0HhjPH8NaVRVJWyLTlPnSkCyvKLSsrgx8uQSSEYJmqvFhv9doqO1afN+znBMTHSLsSPTRbm3L40g5TnT0RiDSV2tTBsPCZPvK1g6U+c3VRFTZ8rn7ubQ+L3LBwKIik4bISvuP8+brxWUKsr/gAuWiH8s4gdYxTqJgseIC2pJP/jCh2K+U0UrqM96Whd9X/P8jww509uNsZZpw28RiTl8wYkI6JXilvJ3F1h52e65djX8/xuAvMbzEqdSWOLaKQ5GPiaz65dlwA2Wy64PKJJmFRbPPWRx2i4afiKZ4I+3E90qbeWK9TDyHM9afmrxASKpwfBkQq3Hm6s8ZL1KmZgharmd90YcIHRGvFW6KufR5nr5lc4BSRLfol4pNeefqHmySjGiWXfAdYEFJNBtqKWvdhhOSDtrf0TJWGbH2jVSh621iCYOGFs7vaMAYPjVSGy91UDPiGfQpq/w3Uc8Q9s3oZ/8D9WTyHySxgo35FEtiX6vUfobicwzrFFr6X++cdJ1u+iXaSJaekySfcul/BNAaVMsGSTlbN5FuyC3wZcyMA35dQk8Zci2Hyh8aIxNXJlpERVDIqQh+mvTgs+xX4wd+iIEjq1og
DKIM-Signature: a=rsa-sha256; bh=T9TIIVYfyP1hghPMhmTqChfXDcPUAairEBLRBsUqb64=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1786568518; v=1;
 b=tAgVcEJUgwum9/qzkJD9U/EPxozVngErwQYmskct11W/P4U/l8s4hfu6xmNtfV2PysHPtAgX
 9ZdbcxPMWdNJQ8Ub+m8e4AMGWOSrHVPN10ewceX+VHgqYp+cZhO1SQvamUstEa8q1jdzKBY2zlc
 AyL9PTdtuvjW8TZwl4P0JFEHPbiEpdd+yXB81+g+lcXjgtfCxBdvedn7KUtehh2F0tVzgF+ejeX
 yZ5W/6d/9iwC38svX9Dha4JFCLe2w2eWRv8zhtHvyTSWBQXk29UEVkmm9ugphTWDQQ/Tl4TLEEg
 hSawDqVce05rpx62adpjrEQnfz/7/FIVTkQgWI3LR0zmA==
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

Hi all,

lately I've been investigating some ways to efficiently query for 
whether particular memory has been written to or not. The functionality 
I'm looking for is pretty much exactly what userfaultfd's wp-async mode 
exposes, but with a twist: The memory I'm interested in is GPU memory 
mapped into users' address spaces.

The broader context here is writing a "capture/replay" tool for the 
Vulkan graphics API: The tool lives in a .so that is injected into some 
app at runtime (LD_PRELOAD style). All graphics API calls (rendering 
commands etc.) are then intercepted, making a copy of any call 
parameters and writing ("capturing") them to disk. Later, these calls 
can be read back from the file and "replayed", reproducing the exact 
same sequence of rendering commands again (hopefully leading to the same 
rendering output, too).
However, one of the commands is a simple wrapper over mmap(), where the 
input is a GPU resource and the output is a mapped pointer for free use 
by applications. To correctly reproduce the behavior of apps using this 
command, the capture/replay tool needs some side-channel to know which 
parts of this mapped memory have been overwritten by the CPU, so that it 
can perform the same modifications when replaying API calls.

The only part I'm interested here are writes done by the CPU. The GPU 
may also write to the mapped memory itself, but there's no need to track 
where it wrote.

userfaultfd wp-async tracking would be a pretty great match for this, if 
only it could be made to work with GPU mappings, too. I've been hacking 
around in the kernel and I did get my use case working fairly well with 
only a few modifications:

First, I mostly-reverted commit 3c58f641e81 ("userfaultfd: prevent 
registration of special VMAs") for rather obvious reasons :)
Then, all I had to change to get things to work was add handling for 
encountering uffd-wp marker PTEs on a read fault inside insert_pfn(), 
and allow the PM_SCAN ioctl for /proc/<pid>/pagemap to process vmas 
marked with VM_PFNMAP if ioctl only does uffd wp-async bookkeeping.

I included a complete diff of these changes at the end of this email, 
but their quality is very much proof-of-concept only; it's not remotely 
in an upstreamable state.

Is this something upstream would consider supporting at all? I'm not 
familiar enough with memory management to judge whether there are 
fundamental pitfalls making this whole idea impossible (but for what 
it's worth, it worked really well on every program I tried 
capturing/replaying :P)

Best,
Natalie

---

Here's the diff for my dirty hacks making uffd work with GPU mappings, 
based on commit f5098b6bae ("Linux 7.2-rc5"):

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d32408f7cd5ed..7ac75ac0a7794 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2426,6 +2426,19 @@ struct pagemap_scan_private {
  	struct page_region __user *vec_out;
  };

+static bool pagemap_exclusively_mark_wp(struct pagemap_scan_private *p)
+{
+	return (p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out;
+}
+
+static bool
+pagemap_exclusively_mark_and_query_wp(struct pagemap_scan_private *p)
+{
+	return !p->arg.category_anyof_mask && !p->arg.category_inverted &&
+	       p->arg.category_mask == PAGE_IS_WRITTEN &&
+	       p->arg.return_mask == PAGE_IS_WRITTEN;
+}
+
  static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
  					   struct vm_area_struct *vma,
  					   unsigned long addr, pte_t pte)
@@ -2689,7 +2702,9 @@ static int pagemap_scan_test_walk(unsigned long 
start, unsigned long end,
  		 */
  	}

-	if (vma->vm_flags & VM_PFNMAP)
+	if ((vma->vm_flags & VM_PFNMAP) &&
+	    !(pagemap_exclusively_mark_wp(p) ||
+	      pagemap_exclusively_mark_and_query_wp(p)))
  		return 1;

  	if (wp_allowed)
@@ -2844,7 +2859,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, 
unsigned long start,

  	lazy_mmu_mode_enable();

-	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
+	if (pagemap_exclusively_mark_wp(p)) {
  		/* Fast path for performing exclusive WP */
  		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
  			pte_t ptent = ptep_get(pte);
@@ -2860,9 +2875,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, 
unsigned long start,
  		goto flush_and_return;
  	}

-	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
-	    p->arg.category_mask == PAGE_IS_WRITTEN &&
-	    p->arg.return_mask == PAGE_IS_WRITTEN) {
+	if (pagemap_exclusively_mark_and_query_wp(p)) {
  		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
  			unsigned long next = addr + PAGE_SIZE;
  			pte_t ptent = ptep_get(pte);
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe923..a06a31f7f45cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2698,6 +2698,10 @@ static vm_fault_t insert_pfn(struct 
vm_area_struct *vma, unsigned long addr,
  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
  			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
  				update_mmu_cache(vma, addr, pte);
+		} else if (pte_uffd_wp(entry)) {
+			entry = pte_mkspecial(pfn_pte(pfn, prot));
+			entry = pte_mkuffd_wp(entry);
+			goto out_set_pte;
  		}
  		goto out_unlock;
  	}
@@ -2710,6 +2714,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct 
*vma, unsigned long addr,
  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
  	}

+out_set_pte:
  	set_pte_at(mm, addr, pte, entry);
  	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c3adedaaf7d54..aa1553ec5a3bb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2114,8 +2114,8 @@ static bool vma_can_userfault(struct 
vm_area_struct *vma, vm_flags_t vm_flags,
  	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
  		return false;

-	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
-		return false;
+	//if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
+	//	return false;

  	vm_flags &= __VM_UFFD_FLAGS;

-- 
2.55.0

