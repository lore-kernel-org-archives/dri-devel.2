Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VmqzD1cc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FB810E2ED;
	Mon, 26 Oct 2026 13:50:04 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B6210E2ED
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:49:59 +0000 (UTC)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so2863145a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793022598; x=1793627398;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c7my5rSEsn+U+kYhoFnNu7P7PE6jHz+gWSHK/wcS/Mk=;
 b=VmqzD1ccXkloZDK4Rjo1kUYeSgKe087hapboqSY/q2fGTQeWGv8vx6rZFXPiZaNorh
 AgfxU5XQicUnNqSbQgQxpqI9cCxGFvp6oaoYi8pn3b4Icc1efzFlXlZ4h+rYfxBLTZkN
 6yynHlzNWB6YpDy3wZDHS2VIxhZ5VVeNKh/dM6kNqBo5XE2RN7z0f5ezXsPPfLC+o+E9
 w20tV3mDP134rosz0J78eTvsknNV28DgApOC1NnB4p+bMi9JBgis1p0u75+ecZ0ye3nh
 Cwjkk8v7cy7KQ2wRN9aPBf6lVICrbLiw29gZEL8P80e3sB6Pw+n8Gu5VYaMCrERO5Mxo
 Z2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022598; x=1793627398;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7my5rSEsn+U+kYhoFnNu7P7PE6jHz+gWSHK/wcS/Mk=;
 b=pPJZIJ2ZHgMtSE1OgZ4pETKtoRKxWC7K/nwgIggMZkOzCHqZGtVpNirkmD/rH/BkA0
 X/hl+XBqtZQ90PXasje93tV7285QkxsrYqCilcG5pyNrJSGAf4Ok6kQSPynAEU3kWx2/
 lxXcJ+fwyoAsrStxqY6QWAogjkn55NcesxEeUi4xL9oWbasKUiKAnaLluP+xBPRjvBbC
 XEJdVf6Re6BsQdvVOExDFNBGur69Swoa0CcrD1a9R9pB7Cl8Lxtizp99BzhoIBXAN80S
 0KnZBDyJXhjcl1UdU7yT0jXU/AeBBSDD4hhyiHD7YksPUj6sNHD0vpmM5tQmnjzDMzSt
 pKVA==
X-Forwarded-Encrypted: i=1;
 AKwUvByf/RbMbC5xLqWT++9EQTcoUSFvx3WxcrVE0z6rzXcHGFWyO+PGZ5MOiqm8UtDYZN2cvKBlr2Eirds=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIT2CBQlHhhB/2Jlq9PINfDOjXHDTuqCl0/IA904xq5TQccuKcr
 NrI0XPC/vgw5XEcFLzk4y4W+iY0yY7cQVCIn2FG9KJwZp6tuIG3vfHy2WByzF2TNEeWyWh/BvHb
 GbWTnaw==
X-Received: from pjbbu22.prod.google.com ([2002:a17:90a:ee56:b0:3ac:c43b:e322])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:564d:b0:3ac:7f4c:a690
 with SMTP id 98e67ed59e1d1-3adeafb0449mr5178332a91.35.1793022598376; Mon, 26
 Oct 2026 06:49:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 06:49:56 -0700
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Message-ID: <at9ahKiYsVtH8kpU@google.com>
Subject: Re: [PATCH v2 0/6] mm,
 drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
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
 Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="us-ascii"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> This "v2" combines three series that I have previously posted separately to gather
> reviews and tests:
> 
> - kvm: apply VM_READ/VM_WRITE checks to all VMA types
>   https://lore.kernel.org/kvm/20260731175834.1121005-1-pbonzini@redhat.com/
> 
> - mm: pull writability check to follow_pfnmap_start()
>   https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/#u
> 
> - mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
>   https://lore.kernel.org/kvm/20260731164341.1109827-1-pbonzini@redhat.com/
> 
> All three, together, make it possible to write drivers that use .fault()
> and .pfn_mkwrite() callbacks for VM_IO|VM_PFNMAP regions, and that also
> interact correctly with users of fixup_user_fault().
> 
> The problem is that if you define .pfn_mkwrite(), vma_set_page_prot()
> clears the writable PTE bit in vma->vm_page_prot, at which point
> the .fault() callback has no way to create a writable PTE.  Users of
> fixup_user_fault() will then see a read-only PTE and have no clue that
> the page needs a *second* fault to reach its final status.
> 
> fixup_user_fault() itself does not have a good way to notice this, because
> vma->vm_page_prot is an opaque pgprot_t, so the fix needs to be somewhere
> else.  Other preexisting functions, namely vmf_insert_page_mkwrite()
> as well as vmf_insert_pfn_pmd(), suggest that this has to be the driver.
> In fact, of the five vm_ops that use .pfn_mkwrite() together with .fault(),
> three are in file systems and are not buggy: all of them ultimately end
> up in dax_fault_iter(), which uses vmf_insert_page_mkwrite() to correctly
> insert the PTE.
> 
> The two problematic implementations instead are both in drm code.  One, in
> drm_gem_shmem_helper, was reported as a KVM regression; the other, in
> vmwgfx, was found by inspection of .pfn_mkwrite() implementors.
> Both of these use pfn-mapped regions, but there is nothing like a
> vmf_insert_pfn_mkwrite() function that they could use; the first part of
> this series thus adjusts mm.h to provide two new functions for this
> usecase---vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite()---and
> then teaches drm's two users of .pfn_mkwrite() to call them.
> 
> This however leaves another case buggy where fixup_user_fault() is preceded
> by follow_pfnmap_start().  Most callers of follow_pfnmap_start(), seeing
> it return 0 for a PFN that is mapped read-only, would not attempt to
> call fixup_user_fault() on it, and thus the PTE would not be upgraded
> to writable.
> 
> This is arguably a bug in... almost all the callers of follow_pfnmap_start(),
> but fixing it is much better achieved with a small improvement to the API;
> if follow_pfnmap_start() is told by the caller that it needs the memory
> for a write, most callers are simplified because they were doing such a check
> anyway and now just see -EFAULT.  They then proceed to call fixup_user_fault()
> and everyone is happy.  This is done in patch 5.
> 
> To sum up:
> 
> - patches 1-3 introduce the new MM API, and use it in the DRM .fault()
>   callbacks to install writable PTEs in response to write faults
> 
> - patch 4 is a preparatory fix in KVM, eliminating inconsistencies in the
>   handling of !VM_READ and !VM_WRITE VMAs; these would return different
>   error codes for a !VM_WRITE VMA depending on whether the PTE happens
>   to be mapped (but with wrong permissions).  This needs to be here
>   because the next patch would introduce even more inconsistencies.
>   
> - patch 5 moves the check for writable PTEs from follow_pfnmap_start()'s
>   callers to the function itself
> 
> - finally, patch 6 is a KVM addendum that will have to wait until
>   the next merge window; it removes yet another inconsistency in
>   KVM's handling of !VM_WRITE but is technically userspace-visible,
>   and therefore it shouldn't be included in stable kernel releases
>   unlike the rest.

What happened to this series?  It seemed liked something semi-urgent, but AFAICT
it got silently dropped?
