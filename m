Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB964C561E6
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587AD10E2F3;
	Tue,  4 Aug 2026 21:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Sfz9oeaV";
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B95C10E4F4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 21:15:43 +0000 (UTC)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so331503a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785878143; x=1786482943;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rHQOfCFF6yaKH9HqGSLDO98Dtf8szKrkpDeyDbaXUEA=;
 b=Sfz9oeaVfuZvamsASosEu1jgtrFLYHOouPmDQiznzlPCDRQvXo+IwXlhbn8SfZnCWK
 8t8aIMCnaJPPY2xeFAls9V1bgCarjpZ0IGG5XuPUINpOUb1Fz5JkQYS2Bvzw++TVBOhL
 2AmHH+gPv7iZ1TW4m43RRpiGpe7BJ3B/6/csKwBP8iUAWIvU/ntAO2Qhab9bfpfaU+J3
 fvlyTNHAzp0zqE0NXZpDm+kodxWMQuOjNiXDzHYnhQdwcSnhkP3s9c5fynUlU0I6B86y
 3TU2PGHfJP+dAy0NNjXFGSuePXa0F5bm8NKE3qA9qD0vf8DGagAbv4V6yz6rQM+ASSbw
 6XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785878143; x=1786482943;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rHQOfCFF6yaKH9HqGSLDO98Dtf8szKrkpDeyDbaXUEA=;
 b=MQrRNBZxqGyINThCLnNQWeSf6gZ2ZvnkovBFJhknyxdthrMMlIbbWeF4gYgf6XbD/K
 eCRozmaraoIeVAoLpFbGhZkBPo+B5LsqR/e8TeV420mo+mqLPlIsqMchiFl/LYA9xQOU
 MtzDJDJ64INJlspUBm/tlVIEclsIr/HDgh0GFEjVofkawjOxnNLKEq6nD0o1GCQgOfOA
 t/o9pqj/VXYRI2XtCRKTG3JPrdLos6drVSmTVcNQDpnRcYlvuKtdAGkLl6Ngrb3tPkt/
 pIcAhr2zSeXF3aNniIsUayObZImcrSVvljbAws05k0K8GxmW7xEeDrBM/K9esDBo+2dK
 vc8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5e+VqotHQRAqfoN7s8nKdOm2PhBQqEzLy+blT4UugGz5VjCfK+91YcF/OQXWNSI8MvRdGHg3r96g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAN8t30DSrvTHBbmgGKPU8MquOpyQOv22xufavnDAjTH9hsEE1
 sOUkwVVFw3prhIfaFOLmzuAZN/CY6q/8imiW3/FIDZV0OnWyb+E9wn5amyiPH/D5CQ9UJdYH57x
 QIawrGw==
X-Received: from pjot9.prod.google.com ([2002:a17:90a:9509:b0:38e:1db:751c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:540e:b0:38e:6a30:4bbc
 with SMTP id 98e67ed59e1d1-3903c681346mr1785320a91.21.1785878142058; Tue, 04
 Aug 2026 14:15:42 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:15:41 -0700
In-Reply-To: <20260804120529.1730187-5-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-5-pbonzini@redhat.com>
Message-ID: <anJWfesPj1C8fzFr@google.com>
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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

KVM:

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> The VM_READ and VM_WRITE flags are checked only at the very end of
> hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
> mappings, this adds unnecessary cases and inconsistent error behavior.
> 
> For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
> detect this situation.  This is fragile because hva_to_pfn_remapped()
> returns different error codes for a !VM_WRITE VMA depending on whether
> the PTE happens to be mapped:
> 
> * if the PTE is present, follow_pfnmap_start() sets args.writable to
>   false and KVM_PFN_ERR_RO_FAULT is returned;
> 
> * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
>   -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
>   up returning KVM_PFN_ERR_FAULT.
> 
> With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
> a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
> pte_present()[1] when the guest attempted to read it; with the patch
> instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
> avoids these special cases and also sidesteps the issue pointed out at
> https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.
> 
> For regular mappings a PROT_READ VMA, if placed in a writable memslot,
> would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
> the guest writes to it.  This would cause a -EFAULT exit to userspace,
> instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
> however it should be considered part of the KVM API because mmu_stress_test
> relies on it.
> 
> Still, even with this snag about the returned pfn error code, pull the
> vm_flags checks in front so that they are done for all VMAs and the
> above inconsistency goes away for the VM_IO|VM_PFNMAP case.
> 
> [1] on x86, for example, such a page would have _PAGE_PRESENT clear
>   but _PAGE_PROTNONE set
> 
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 45e784462ec6..576bcb21be3a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
>  	return npages;
>  }
>  
> -static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
> -{
> -	if (unlikely(!(vma->vm_flags & VM_READ)))
> -		return false;
> -
> -	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
> -		return false;
> -
> -	return true;
> -}
> -
>  static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>  			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
>  {
> @@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
>  retry:
>  	vma = vma_lookup(current->mm, kfp->hva);
>  
> -	if (vma == NULL)
> +	/*
> +	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
> +	 * or the page might be absent.
> +	 */
> +

Unnecessary newline, IMO.

> +	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
>  		pfn = KVM_PFN_ERR_FAULT;
> -	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> +	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
> +		/*
> +		 * Exit to userspace for PROT_READ mappings in a writable
> +		 * memslot, as this is part of the API.

Can we say something along the lines of "for backwards compatibility" instead
of saying this is part of the API?  Because that's definitely not KVM's documented
API, and we're hoping it's not part of KVM's undocumented API either.

> +		 */
> +		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
> +			KVM_PFN_ERR_FAULT;

Please align the two branches of the ternary operators:

		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
							    KVM_PFN_ERR_FAULT;
	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
		r = hva_to_pfn_remapped(vma, kfp, &pfn);
		if (r == -EAGAIN)
			goto retry;
		if (r < 0)
			pfn = KVM_PFN_ERR_FAULT;
	} else {
		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
						 KVM_PFN_ERR_FAULT;
