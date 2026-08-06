Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF06C5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD2C10E3C5;
	Thu,  6 Aug 2026 23:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eNAP8KNa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF9E10E3C5
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786059159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
 b=eNAP8KNa58goi9beZIbcJMsWCr/PZ8T8SpDpBkuJwFIDv5V5xCTo1whiXCy+j82jc13d+n
 OIlcZU2DC5GtbCc8LJqqRgR/KMT/W1w96YTCCyK3QO0jK03EGaY/rHzPXnTQjHRQrTIv8b
 AWtfVDHf/YXHqugn73of2OABShKYyH0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-yMKBqrB3OSOO21djW1gsqQ-1; Thu, 06 Aug 2026 19:32:37 -0400
X-MC-Unique: yMKBqrB3OSOO21djW1gsqQ-1
X-Mimecast-MFC-AGG-ID: yMKBqrB3OSOO21djW1gsqQ_1786059157
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0408254aso17356911cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 16:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786059157; x=1786663957;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
 b=dvTVoR7J0FYUxzgOpft06i6hIL3xpQY5Mg8kMWH08yeq5I1l+v3sn0SwPwpoRsfnHG
 paL4z7HrzxpQz32KyFOIBEjdkn9s+Ct/CKXOaPgQW0zSvTaryLZ8GvyXz2Uq9j8btlPB
 gSG/bhCTFhyaJxBpgsXvGSq3MC4XW0EYsGBUxbHRkZ6kwrHPry77kqyIygxq4ojIA28s
 O+qkVgYH7hW0Sc5mzRZRIQU0FTH+2yM72/End4ru5Gw0W2Pnd8DiJutEbxkBF+X+R3Vs
 J4j9EaY5I2fcin1+RTxBRiyIvmczicMYJMGjZMeV+2YdPDEn4eA4GumklFVow75fv3qN
 Qlug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpT8KhCgzrslFuGfa8E9t71hSrMBJqaPpXXJpwU/WpNlzjhpWu28SxG2az8xBGgFdUPAi0yvu4b7nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqzOOVftj5joR1Ro3WxHeo990PGnDHQJAC4QkYLMnLnMScFqX/
 1EIZ8nwFD1pMbdavM1rQXJNKFCdnVBCfZY2zu82P3gh9lGAlxuwe/SJ2kN5ZJwgkNMAKV/LFHWf
 7EciW6KsVCayMCNIxyYqPXxVulEi1KwNgMKOoVv4dPcyKnhSbi1PheCSLf77b7/Ko8wE51g==
X-Gm-Gg: AR+sD11NmP9jNx+csJ4Hc93SheIA5JBv+QOgp5nOxcpjUwcQltY3eJlNCJzgw+vsfCa
 heVmfOb4ztlPpj20Z+f7BHC3XbOQ7AUtbmb1oIUGqOI+ECLYVLWRjZyYgLQyUTI/G0JqVU4LxqY
 0ryZwJ8t4187ndivDw/3b73PawQRRFcIEB6doF2AOpJehnxrtVHL+9uAYVQXoRVD0CPPaat/b5C
 UuaPC5XzaEi2osK1J86KoOaUufCKOb2kW0xf/+Vf5I1f1ZnABK9Hp1u8MV4DI1EAmpl2Tpk5lrR
 gAk73ORS5n1SfHI6F70mSpCqH58OWfZ8MNSSiLSJKXf0oy8tBKzoQN72DMdqLvzuuYtV
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id
 d75a77b69052e-52d00498b36mr95353201cf.22.1786059156644; 
 Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id
 d75a77b69052e-52d00498b36mr95352631cf.22.1786059156155; 
 Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d16335bb4sm273151cf.2.2026.08.06.16.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:32:35 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:32:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>,
 Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
Message-ID: <anUZhiwas8pN_No8@x1.local>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260804120529.1730187-4-pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CcTC4n38ftOmDd585zRJFjq8ImXs-dpa_GhFdeagucg_1786059157
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

On Tue, Aug 04, 2026 at 02:05:25PM +0200, Paolo Bonzini wrote:
> This ensures that fixup_user_fault() users see a writable PTE when
> they request one.  The flip side is that vmw_bo_vm_fault() now has
> to record by hand the write fault, because .pfn_mkwrite() is
> not invoked.
> 
> Prefaulting works as before because only the first entry comes
> out writable, while the following ones still end up executing
> the .pfn_mkwrite() callback.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Only some quick thoughts while reading through this, as below.. even if
some of it may make sense, I think that may be more suitable as follow up.

This looks like a good fix for a regression already to me.

> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c            |  7 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..3ebde936ce60 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -191,6 +191,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	unsigned long pfn;
>  	struct ttm_tt *ttm = NULL;
>  	struct page *page;
> +	bool mkwrite;
>  	int err;
>  	pgoff_t i;
>  	vm_fault_t ret = VM_FAULT_NOPAGE;
> @@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	 * Speculatively prefault a number of pages. Only error on
>  	 * first page.
>  	 */
> +	mkwrite = !!(vmf->flags & FAULT_FLAG_WRITE);
>  	for (i = 0; i < num_prefault; ++i) {
>  		if (bo->resource->bus.is_iomem) {
>  			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
> @@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
>  
> -		/* Never error on prefaulted PTEs */
> +		/* Never error on prefaulted PTEs and never map them writable */

I got confused when reading 1st time, but I got it then noticing the mark
dirty was done by the caller.

Two small things I thought about here:

- Comparing to the time before introducing pfn_mkwrite(), this will cause
  previously one fault (with prefaults marking all follow up ptes writable)
  to be 1 writable plus N-1 read-only. May not be the most ideal if we
  consider the 2nd WP faults on the rest N-1 later as slight overheads,

- Split the "mark WRITABLE" and "mark DIRTY" in code might be slightly
  error prone, especially if this is a common function used by multiple
  drivers, while there's only one driver that does the "mark DIRTY".

IIUC the other idea can be, do not reset @mkwrite here but instead move the
set dirty here, invoking whatever the vma's .pfn_mkwrite() is. So that we
stick two things together; maybe slightly less error prone and less dup
code when other drivers opt-in for pfn_mkwrite().

Not sure if it's a good idea, but just to raise it in case useful.  Again,
I still think this is a solid fix to the problem already.

Other than that, FWIW the whole approach looks reasonable at least to me.
I agree in the fault processing we should best resolve the fault in one
shot if possible.  In this context, FAULT_FLAG_WRITE is the flag showing
that a 2nd fault is required, then IMHO it's indeed better to resolve the
fault in one go, as proposed in this series.

Another thing I came to mind that may not really be relevant to this
regression alone, but maybe matters for the future to at least keep in
mnind: I wonder if there can be races happen while fixup_user_fault() is
resolving faults, causing the 2nd pfnmap follow code to fail once more,
say, some other thread modified the pgtable again (e.g. wr-protect with
write bit removed right after set).

So maybe pfnmap lookup and fixup_user_fault() should be done in a loop
until any of them hit real errors.. if any of such race may become a real
problem some day.

Looks like low possibility that threads will mess up with PFN maps.. but
just to raise this idea.

I believe currently our mm fault handler should be working like that with
handle_mm_fault(), hence neutral with such races (it'll loop a few more
rounds until race disappear).  I recall there used to have thoughts adding
some n_retry_max counts to the fault handler, but we didn't really do that,
and it runs all fine over the years.

Thanks,

-- 
Peter Xu

