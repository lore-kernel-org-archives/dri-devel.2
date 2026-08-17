Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC84C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150A310E8C1;
	Mon, 17 Aug 2026 17:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="E8aUfmqK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A7210E8C1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786988118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dFdQfkrF9IWQwBtpGMM2MAg+txMnWXxTBIf2qu+5h6w=;
 b=E8aUfmqK2/DSVHmQ65kfAGltdWTSRWcSx9b841+MFN+rbL/LFty89KBYPh+QhWO34+PJLj
 1BgRhG9aQTsdTbXKETpgukQflSKlivxa1TZyaMTka0uRfrD9dlkKzUcBSIdU0QGNZ/JyH0
 Mr+k3CkgtgQ9ak1cyzxP0LeLbJlpYhs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-n023J8A_PmOwpPXl1xK9zw-1; Mon, 17 Aug 2026 13:35:17 -0400
X-MC-Unique: n023J8A_PmOwpPXl1xK9zw-1
X-Mimecast-MFC-AGG-ID: n023J8A_PmOwpPXl1xK9zw_1786988117
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso16498785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 10:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786988117; x=1787592917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dFdQfkrF9IWQwBtpGMM2MAg+txMnWXxTBIf2qu+5h6w=;
 b=P3ZQwCiUFC7quOcSYYtdZNosIMDfw5oPdNfC25cUoTchxf4E2FbA+AdvkJAxN3+OoZ
 WBNvwnhOMoD2DApdnjJmrmngODD3gNl53a03jNeEB4FH0lgdklkHBe0xl4VCRpoldDv6
 HMRFjfNRRDHmMfBGcHnF/NHL0s4TDwugH8eBiyO8Tk2ZuETnkHmUADZyQRDipAag+8M5
 JQHU4rPC6fgn624cSqKsmHQM7ywUk+9vYvhGA4QP0TycO6CmI02t9cd8bkt62Fxxp9DI
 Q2BJqBFOGxhPchhaPkgAG9eH6Lum1HpCNSP935L/Rb6JrsALWjEX3vb+Bq1lIlzD2zT0
 f5Pw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo19WwhLAeIqFKChC+dPv7RQ9SKi++zQSzt/FYSOH/9NTuMG1Mbl5L5OmGDtBU82dsMUCnRRJfxWQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpmqNmiBslJeWm7yXE/vD1Kks7JZ8ztiKYMmpo+HqwWy3YUg4r
 ECtG/JV9lfv/RqoXEnbK6xW/M1V/gJmocmJIlfxcZnsPzx++ZCO4TqZCd11hGs5xWV2Gcm85WVD
 pgANlzzhkYe/wIQoVu7dL/wybofjwJdZxjk6rMJj9nEJydrWVM8/YSGE1GURX89zeA2evpw==
X-Gm-Gg: AR+sD12sHcULx9z8aVAC0AwZh1K/fyO/bsFsAD7zbmfKB7DfLk0zfzpPwbPW/WkUDCn
 ii8JXH6jwCeYQ16Jxq4/UhOQkU2wyqDDn9y3biFSFbL+ppawWA+czQS6i7KRE2SviqSCbcZ0NCR
 1KT6GNZMhs1oiqR/8JKoEN4htY0BHBXPL06ImCHGe4ThmyDB27IGPjrn994+9Ohmqa2oiRHh1ox
 5v4eCAEcJ9uOekaUWlTEHTQedhwEqtBgv2jhNNfdC+42Sjco2bgMJ2u0UW64Sr7C48esdOcyK54
 7uHg5bdUJFvSKL+5lzxd2fIYrhupYrJLSVNB3fSq5vhcc+w3e4lZ3P8sWnrAayn6K8+0
X-Received: by 2002:a05:620a:8514:b0:915:9f30:23cb with SMTP id
 af79cd13be357-937063c9670mr75002585a.0.1786988116241; 
 Mon, 17 Aug 2026 10:35:16 -0700 (PDT)
X-Received: by 2002:a05:620a:8514:b0:915:9f30:23cb with SMTP id
 af79cd13be357-937063c9670mr74995585a.0.1786988115555; 
 Mon, 17 Aug 2026 10:35:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937033d2ccdsm94691585a.30.2026.08.17.10.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:35:15 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:35:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Natalie Vock <nat@pixelcluster.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org
Subject: Re: userfaultfd wp-async support for (GPU) special mappings?
Message-ID: <aoNGR04WaFkqde8a@x1.local>
References: <d5ea3344-24e7-4834-b743-4dec812ada70@pixelcluster.dev>
MIME-Version: 1.0
In-Reply-To: <d5ea3344-24e7-4834-b743-4dec812ada70@pixelcluster.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R6NWCoxOGeRO6C6aau3j8al8sVIfE20OAixIhVt3MIE_1786988117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

On Wed, Aug 12, 2026 at 11:01:55PM +0200, Natalie Vock wrote:
> Hi all,

Hi, Natalie,

> 
> lately I've been investigating some ways to efficiently query for whether
> particular memory has been written to or not. The functionality I'm looking
> for is pretty much exactly what userfaultfd's wp-async mode exposes, but
> with a twist: The memory I'm interested in is GPU memory mapped into users'
> address spaces.
> 
> The broader context here is writing a "capture/replay" tool for the Vulkan
> graphics API: The tool lives in a .so that is injected into some app at
> runtime (LD_PRELOAD style). All graphics API calls (rendering commands etc.)
> are then intercepted, making a copy of any call parameters and writing
> ("capturing") them to disk. Later, these calls can be read back from the
> file and "replayed", reproducing the exact same sequence of rendering
> commands again (hopefully leading to the same rendering output, too).
> However, one of the commands is a simple wrapper over mmap(), where the
> input is a GPU resource and the output is a mapped pointer for free use by
> applications. To correctly reproduce the behavior of apps using this
> command, the capture/replay tool needs some side-channel to know which parts
> of this mapped memory have been overwritten by the CPU, so that it can
> perform the same modifications when replaying API calls.
> 
> The only part I'm interested here are writes done by the CPU. The GPU may
> also write to the mapped memory itself, but there's no need to track where
> it wrote.
> 
> userfaultfd wp-async tracking would be a pretty great match for this, if
> only it could be made to work with GPU mappings, too. I've been hacking
> around in the kernel and I did get my use case working fairly well with only
> a few modifications:
> 
> First, I mostly-reverted commit 3c58f641e81 ("userfaultfd: prevent
> registration of special VMAs") for rather obvious reasons :)
> Then, all I had to change to get things to work was add handling for
> encountering uffd-wp marker PTEs on a read fault inside insert_pfn(), and
> allow the PM_SCAN ioctl for /proc/<pid>/pagemap to process vmas marked with
> VM_PFNMAP if ioctl only does uffd wp-async bookkeeping.
> 
> I included a complete diff of these changes at the end of this email, but
> their quality is very much proof-of-concept only; it's not remotely in an
> upstreamable state.
> 
> Is this something upstream would consider supporting at all? I'm not
> familiar enough with memory management to judge whether there are
> fundamental pitfalls making this whole idea impossible (but for what it's
> worth, it worked really well on every program I tried capturing/replaying
> :P)

I believe the VM_FAULT_NOPAGE path was used to be overlooked.. bypassing
finish_fault() completely.  It's good to see that we have forbidden SPECIAL
mappings for now.

On the use case alone, it looks like a valid one. Said that, I think it'll
be slightly more involved than what you have proposed below.

> 
> Best,
> Natalie
> 
> ---
> 
> Here's the diff for my dirty hacks making uffd work with GPU mappings, based
> on commit f5098b6bae ("Linux 7.2-rc5"):
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d32408f7cd5ed..7ac75ac0a7794 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2426,6 +2426,19 @@ struct pagemap_scan_private {
>  	struct page_region __user *vec_out;
>  };
> 
> +static bool pagemap_exclusively_mark_wp(struct pagemap_scan_private *p)
> +{
> +	return (p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out;
> +}
> +
> +static bool
> +pagemap_exclusively_mark_and_query_wp(struct pagemap_scan_private *p)
> +{
> +	return !p->arg.category_anyof_mask && !p->arg.category_inverted &&
> +	       p->arg.category_mask == PAGE_IS_WRITTEN &&
> +	       p->arg.return_mask == PAGE_IS_WRITTEN;
> +}
> +
>  static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  					   struct vm_area_struct *vma,
>  					   unsigned long addr, pte_t pte)
> @@ -2689,7 +2702,9 @@ static int pagemap_scan_test_walk(unsigned long start,
> unsigned long end,
>  		 */
>  	}
> 
> -	if (vma->vm_flags & VM_PFNMAP)
> +	if ((vma->vm_flags & VM_PFNMAP) &&
> +	    !(pagemap_exclusively_mark_wp(p) ||
> +	      pagemap_exclusively_mark_and_query_wp(p)))
>  		return 1;
> 
>  	if (wp_allowed)
> @@ -2844,7 +2859,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned
> long start,
> 
>  	lazy_mmu_mode_enable();
> 
> -	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
> +	if (pagemap_exclusively_mark_wp(p)) {
>  		/* Fast path for performing exclusive WP */
>  		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
>  			pte_t ptent = ptep_get(pte);
> @@ -2860,9 +2875,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned
> long start,
>  		goto flush_and_return;
>  	}
> 
> -	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
> -	    p->arg.category_mask == PAGE_IS_WRITTEN &&
> -	    p->arg.return_mask == PAGE_IS_WRITTEN) {
> +	if (pagemap_exclusively_mark_and_query_wp(p)) {
>  		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>  			unsigned long next = addr + PAGE_SIZE;
>  			pte_t ptent = ptep_get(pte);
> diff --git a/mm/memory.c b/mm/memory.c
> index ff338c2abe923..a06a31f7f45cc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2698,6 +2698,10 @@ static vm_fault_t insert_pfn(struct vm_area_struct
> *vma, unsigned long addr,
>  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
>  				update_mmu_cache(vma, addr, pte);
> +		} else if (pte_uffd_wp(entry)) {
> +			entry = pte_mkspecial(pfn_pte(pfn, prot));
> +			entry = pte_mkuffd_wp(entry);
> +			goto out_set_pte;
>  		}

I don't think I understand how this current patch works so far at least
here..  Logically this path should need to at very minimum take care of pte
markers, which async uffd-wp tracking requires.  I think it means we may
need to pass *vmf over to check orig_pte, atomically install the pte with
the knowledge of what is orig_pte, especially if it was a marker.

Maybe in your case the pfnmap VMA doesn't dynamically do .fault()s, but
install the pgtables either with remap_pfn_range(), or something always
populated in mmap() time?  If all the entries were populated at pte level
properly, uffd-wp could have worked all fine indeed even for pfnmap.
However it may not work fine with pfnmaps that either allow ptes to be
dynamcally faulted in, or being zapped and repopulated somehow.

Currently, for any holes that are tracked (e.g. pfnmaps that can lazily be
faulted into the pgtable with fault()s), the async uffd-wp tracking relies
on the pte markers installed in the pgtables when wr-protection happened
without a mapping.

To support pfnmap with uffd-wp async in a generic way, IIUC we need to make
sure all VM_FAULT_NOPAGE users be able to properly process pte markers with
uffd-wp bit set, then install a RO+UFFD_WP pte instead, leaving the rest
processing to do_wp_page().

That's why the current change of insert_pfn() doesn't look like to have
achieved what is needed to me.  The other thing is, insert_pfn() may also
not be the only path that can be used by pfnmaps.  E.g. I saw at least
insert_page_in_batch_locked() that may need similar care.

So supporting pfnmaps with uffd-wp async tracking might be more challenging
to be done in one shot, and that may need careful look.  We need to make
sure all paths like that to be properly covered, and AFAIU it's not easy,
because VM_FAULT_NOPAGE can be randomly used in special drivers.. unlike
the other normal case where __do_fault() will bring back a page within
vmf->page, then finish_fault() will do the pgtable job in one place.

Nowadays, with vm_uffd_ops, maybe one viable approach is to allow drivers
opt-in with uffd-wp on pfnmaps, that might be slightly easier to achieve
with a custom .can_userfault() after justifying the driver works, either
the driver should make sure all pfnmaps will be populated upfront and never
zapped, or the driver should be able to identify things like pte markers
when injecting pfnmaps.

Thanks,

>  		goto out_unlock;
>  	}
> @@ -2710,6 +2714,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct
> *vma, unsigned long addr,
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  	}
> 
> +out_set_pte:
>  	set_pte_at(mm, addr, pte, entry);
>  	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index c3adedaaf7d54..aa1553ec5a3bb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2114,8 +2114,8 @@ static bool vma_can_userfault(struct vm_area_struct
> *vma, vm_flags_t vm_flags,
>  	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
>  		return false;
> 
> -	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
> -		return false;
> +	//if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
> +	//	return false;
> 
>  	vm_flags &= __VM_UFFD_FLAGS;
> 
> -- 
> 2.55.0
> 
> 

-- 
Peter Xu

