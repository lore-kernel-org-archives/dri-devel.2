Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F673C61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D0210E393;
	Thu, 27 Aug 2026 09:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="AbsTb/lI";
	dkim-atps=neutral
Received: from smtpout8.mo540.mail-out.ovh.net
 (smtpout8.mo540.mail-out.ovh.net [51.210.91.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B50910E393
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:18 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hVwVM2kbnz4481;
 Thu, 27 Aug 2026 09:01:15 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <rppt@kernel.org>; Thu, 27 Aug 2026 09:01:15 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.149])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hVwVM1mc9z47ld;
 Thu, 27 Aug 2026 09:01:15 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 5578C781AA9;
 Thu, 27 Aug 2026 09:01:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005274fb7cd-4520-4c59-a96d-bafdc18ff095,
 F479AFC6405D7EE93EC47B32B82D502C87CDF03D) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <b75359de-56c7-481f-9ce5-10f9ce0bb075@pixelcluster.dev>
Date: Thu, 27 Aug 2026 11:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd wp-async support for (GPU) special mappings?
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, linux-mm@kvack.org, dri-devel@lists.freedesktop.org
References: <d5ea3344-24e7-4834-b743-4dec812ada70@pixelcluster.dev>
 <aoNGR04WaFkqde8a@x1.local>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <aoNGR04WaFkqde8a@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 18220156719306727879
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG0kBmYL0V4dZBJOcFc5VYyAOLiwpykFwH5HtWGFQyT9PZtBFbNMuq+mm80fuOlLkc9DfH9S4QAeMsem+qrc//SMoBlJaSfCft3bgmFlOByXaSdBAQ9Jy7IQAr+z4Gd7rgzHI9EhrE42BTHKFuyDh5wuRXKEnFJWZB/lPaMAZk2rdZ/pAOXYz/aSzHiEKF26cYw9KjXhbgfTBr/BpF/2y4ma+KnHGvh7VDnE+Ya1j/J2S8P4FRCz0EcajPO1mgdLIDP2P4YcERXElLNtySbqPrMm684RJNSSkSMIc5LES5Wqbx78HoezLJFt1mI8j5h3cfZ1NCX8A0cfGro67ePJeObZB+GmLShFyFGW2UrHHZUTqCtnyVL4aMyM4d0BTBf3sVnhGnYrvzNoogSF2yrF4sEbfVK4SjW7fBnyEX15CzVTTjQcXqXS748ez19dyRI4LAUJKjmQSAp0ut0oow+Ps2BmbMF+ai/h06qwtYoXkw629lA8om2zG23Lp5pBF+3oAl0znUX59AluWWswUgzIcEsVmhL2ybWNLYWBWFV/lLnvSWorJTMYCMI+FtB0OebN1FUF1wXHWKFDoG13RhzywBkhsf9sl7odNRWN99UXE5eq0PUx7KkbohWTgMsoCjSvx1DpsReiirzc5+KckClKc0m9Rr+Bmvcq9kwBQr+gh8Wqg
DKIM-Signature: a=rsa-sha256; bh=xF8jVyrOFp9EpIAZTMTAKQHAXFEZm/Mc9X0eoiaqEwI=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1787821276; v=1;
 b=AbsTb/lI3b4z6UpWj9+sD7zBNiRVTfCTXt0NnrQgyDJ1GlKOrjaEbFt5+Q2czCaEUt+AuK9p
 V+F1ZFbjNrUXAbcuDBcRoSW1jd8JtbsBpPejZruRTdYDQHFpfXJPDihtDvdxaB+LsnT31h17FQX
 3SpDCU0R/QP3TWOpa3yUXmnQAh1T9ujO/Qm0kd49vpp7LmhoZhcta1/Do6GUag2B2Xj4xfupENX
 NEwxnXn73OUp1/XserzR6W0OwLljyN3MyjAYzAvEvTT1PaNxqw4i6LxXvbQsh9dw2I7rQ+svs7s
 67MAe4aCW1It1YwjOLgytX74PLJZ518T/110xlpVMkmSA==
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

sorry for the late reply! I had to put out some fires in other areas and
only now had the time to get back to this.

On 8/17/26 19:35, Peter Xu wrote:
> On Wed, Aug 12, 2026 at 11:01:55PM +0200, Natalie Vock wrote:
>> Hi all,
> 
> Hi, Natalie,
> 
>>
>> lately I've been investigating some ways to efficiently query for whether
>> particular memory has been written to or not. The functionality I'm looking
>> for is pretty much exactly what userfaultfd's wp-async mode exposes, but
>> with a twist: The memory I'm interested in is GPU memory mapped into users'
>> address spaces.
>>
>> The broader context here is writing a "capture/replay" tool for the Vulkan
>> graphics API: The tool lives in a .so that is injected into some app at
>> runtime (LD_PRELOAD style). All graphics API calls (rendering commands etc.)
>> are then intercepted, making a copy of any call parameters and writing
>> ("capturing") them to disk. Later, these calls can be read back from the
>> file and "replayed", reproducing the exact same sequence of rendering
>> commands again (hopefully leading to the same rendering output, too).
>> However, one of the commands is a simple wrapper over mmap(), where the
>> input is a GPU resource and the output is a mapped pointer for free use by
>> applications. To correctly reproduce the behavior of apps using this
>> command, the capture/replay tool needs some side-channel to know which parts
>> of this mapped memory have been overwritten by the CPU, so that it can
>> perform the same modifications when replaying API calls.
>>
>> The only part I'm interested here are writes done by the CPU. The GPU may
>> also write to the mapped memory itself, but there's no need to track where
>> it wrote.
>>
>> userfaultfd wp-async tracking would be a pretty great match for this, if
>> only it could be made to work with GPU mappings, too. I've been hacking
>> around in the kernel and I did get my use case working fairly well with only
>> a few modifications:
>>
>> First, I mostly-reverted commit 3c58f641e81 ("userfaultfd: prevent
>> registration of special VMAs") for rather obvious reasons :)
>> Then, all I had to change to get things to work was add handling for
>> encountering uffd-wp marker PTEs on a read fault inside insert_pfn(), and
>> allow the PM_SCAN ioctl for /proc/<pid>/pagemap to process vmas marked with
>> VM_PFNMAP if ioctl only does uffd wp-async bookkeeping.
>>
>> I included a complete diff of these changes at the end of this email, but
>> their quality is very much proof-of-concept only; it's not remotely in an
>> upstreamable state.
>>
>> Is this something upstream would consider supporting at all? I'm not
>> familiar enough with memory management to judge whether there are
>> fundamental pitfalls making this whole idea impossible (but for what it's
>> worth, it worked really well on every program I tried capturing/replaying
>> :P)
> 
> I believe the VM_FAULT_NOPAGE path was used to be overlooked.. bypassing
> finish_fault() completely.  It's good to see that we have forbidden SPECIAL
> mappings for now.
> 
> On the use case alone, it looks like a valid one. Said that, I think it'll
> be slightly more involved than what you have proposed below.
> 
>>
>> Best,
>> Natalie
>>
>> ---
>>
>> Here's the diff for my dirty hacks making uffd work with GPU mappings, based
>> on commit f5098b6bae ("Linux 7.2-rc5"):
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index d32408f7cd5ed..7ac75ac0a7794 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -2426,6 +2426,19 @@ struct pagemap_scan_private {
>>   	struct page_region __user *vec_out;
>>   };
>>
>> +static bool pagemap_exclusively_mark_wp(struct pagemap_scan_private *p)
>> +{
>> +	return (p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out;
>> +}
>> +
>> +static bool
>> +pagemap_exclusively_mark_and_query_wp(struct pagemap_scan_private *p)
>> +{
>> +	return !p->arg.category_anyof_mask && !p->arg.category_inverted &&
>> +	       p->arg.category_mask == PAGE_IS_WRITTEN &&
>> +	       p->arg.return_mask == PAGE_IS_WRITTEN;
>> +}
>> +
>>   static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>>   					   struct vm_area_struct *vma,
>>   					   unsigned long addr, pte_t pte)
>> @@ -2689,7 +2702,9 @@ static int pagemap_scan_test_walk(unsigned long start,
>> unsigned long end,
>>   		 */
>>   	}
>>
>> -	if (vma->vm_flags & VM_PFNMAP)
>> +	if ((vma->vm_flags & VM_PFNMAP) &&
>> +	    !(pagemap_exclusively_mark_wp(p) ||
>> +	      pagemap_exclusively_mark_and_query_wp(p)))
>>   		return 1;
>>
>>   	if (wp_allowed)
>> @@ -2844,7 +2859,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned
>> long start,
>>
>>   	lazy_mmu_mode_enable();
>>
>> -	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
>> +	if (pagemap_exclusively_mark_wp(p)) {
>>   		/* Fast path for performing exclusive WP */
>>   		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
>>   			pte_t ptent = ptep_get(pte);
>> @@ -2860,9 +2875,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned
>> long start,
>>   		goto flush_and_return;
>>   	}
>>
>> -	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
>> -	    p->arg.category_mask == PAGE_IS_WRITTEN &&
>> -	    p->arg.return_mask == PAGE_IS_WRITTEN) {
>> +	if (pagemap_exclusively_mark_and_query_wp(p)) {
>>   		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>>   			unsigned long next = addr + PAGE_SIZE;
>>   			pte_t ptent = ptep_get(pte);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index ff338c2abe923..a06a31f7f45cc 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2698,6 +2698,10 @@ static vm_fault_t insert_pfn(struct vm_area_struct
>> *vma, unsigned long addr,
>>   			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>>   			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
>>   				update_mmu_cache(vma, addr, pte);
>> +		} else if (pte_uffd_wp(entry)) {
>> +			entry = pte_mkspecial(pfn_pte(pfn, prot));
>> +			entry = pte_mkuffd_wp(entry);
>> +			goto out_set_pte;
>>   		}
> 
> I don't think I understand how this current patch works so far at least
> here..  Logically this path should need to at very minimum take care of pte
> markers, which async uffd-wp tracking requires.  I think it means we may
> need to pass *vmf over to check orig_pte, atomically install the pte with
> the knowledge of what is orig_pte, especially if it was a marker.
> 
> Maybe in your case the pfnmap VMA doesn't dynamically do .fault()s, but
> install the pgtables either with remap_pfn_range(), or something always
> populated in mmap() time?

The VMA should dynamically fault(). The relevant handling for this is in
ttm_bo_vm_fault_reserved() in drivers/gpu/drm/ttm/ttm_bo_vm.c.

TTM's fault handler also does some prefaulting inside the handler itself
- I'm not sure I've seen many other fault handlers do that? Not sure if
that influences anything here.

For what it's worth, I observed a lot of applications already working 
with no changes to any fault handling at all. This was probably only by 
chance, and I noticed that sometimes, reading some address in the 
uffd-wp'd vma would simply cause the program to essentially "halt".
I traced this to insert_pfn() effectively doing nothing when there is a
uffd-wp marker page installed.

pte_none() returns false for uffd-wp marker ptes, and mkwrite was false 
as well, so execution reached the goto out_unlock; without ever
installing any new pte.

After the fault handler finished, the retried access would just fault
again (after all, no pte was ever altered) and that repeated ad
infinitum. That's what this insert_pfn() hack was supposed to work
around.

> If all the entries were populated at pte level
> properly, uffd-wp could have worked all fine indeed even for pfnmap.
> However it may not work fine with pfnmaps that either allow ptes to be
> dynamcally faulted in, or being zapped and repopulated somehow.
> 
> Currently, for any holes that are tracked (e.g. pfnmaps that can lazily be
> faulted into the pgtable with fault()s), the async uffd-wp tracking relies
> on the pte markers installed in the pgtables when wr-protection happened
> without a mapping.
> 
> To support pfnmap with uffd-wp async in a generic way, IIUC we need to make
> sure all VM_FAULT_NOPAGE users be able to properly process pte markers with
> uffd-wp bit set, then install a RO+UFFD_WP pte instead, leaving the rest
> processing to do_wp_page().

This sounds more or less like what I tried to do here in insert_pfn(), 
but I guess this may not be the right place to do it? If handling of
uffd-wp markers should be done inside the actual fault handlers instead
of insert_pfn(), what would these fault handlers need do to actually
install the correct pte? Or would insert_pfn() need to receive some
changes after all?

> 
> That's why the current change of insert_pfn() doesn't look like to have
> achieved what is needed to me.  The other thing is, insert_pfn() may also
> not be the only path that can be used by pfnmaps.  E.g. I saw at least
> insert_page_in_batch_locked() that may need similar care.
> 
> So supporting pfnmaps with uffd-wp async tracking might be more challenging
> to be done in one shot, and that may need careful look.  We need to make
> sure all paths like that to be properly covered, and AFAIU it's not easy,
> because VM_FAULT_NOPAGE can be randomly used in special drivers.. unlike
> the other normal case where __do_fault() will bring back a page within
> vmf->page, then finish_fault() will do the pgtable job in one place.
> 
> Nowadays, with vm_uffd_ops, maybe one viable approach is to allow drivers
> opt-in with uffd-wp on pfnmaps, that might be slightly easier to achieve
> with a custom .can_userfault() after justifying the driver works, either
> the driver should make sure all pfnmaps will be populated upfront and never
> zapped, or the driver should be able to identify things like pte markers
> when injecting pfnmaps.

This generally sounds fine to me. I could take a stab at implementing
that properly (though I'd probably need an answer to the insert_pfn()
question above).

Thanks,
Natalie

> 
> Thanks,
> 
>>   		goto out_unlock;
>>   	}
>> @@ -2710,6 +2714,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct
>> *vma, unsigned long addr,
>>   		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>>   	}
>>
>> +out_set_pte:
>>   	set_pte_at(mm, addr, pte, entry);
>>   	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index c3adedaaf7d54..aa1553ec5a3bb 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -2114,8 +2114,8 @@ static bool vma_can_userfault(struct vm_area_struct
>> *vma, vm_flags_t vm_flags,
>>   	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
>>   		return false;
>>
>> -	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
>> -		return false;
>> +	//if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
>> +	//	return false;
>>
>>   	vm_flags &= __VM_UFFD_FLAGS;
>>
>> -- 
>> 2.55.0
>>
>>
> 

