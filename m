Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64613CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB88C10F339;
	Wed, 30 Sep 2026 11:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LRnAU4fw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704D110F339
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:57:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59B8341E99;
 Wed, 30 Sep 2026 11:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABA41F000FF;
 Wed, 30 Sep 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769469;
 bh=vGBAJuP5zfhwRUsF2MWgpAG7yyMLggjg5vtTzCRNLQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LRnAU4fw9Fee7KwslHH2vIBPMeu4wlDITnqkzEPya8UcFOCYiQQLbw6hvmZVR/OWq
 Gj4rCRdlAWaNrB718r0b8BUXf5gFDprV3ajwLyfeSO6NFg0Ceg9yqNKvDa/+COo4Ju
 G12NDgGK1X56Y6oPiG4QrHGz3A5/IoJ8GJ4uGMcXkY4ZQNDPmMDWYJBJjfUDeomvtQ
 yzQEziYsk3rWXTu4KFLn6HbRap/VYKRLhogpgl+CL5RglvoofpDZ5CwzgMErQx3jiO
 SU1mwSvMWwOxPOo2JqezLIQ4Bk6LxBbXZJmb3w8Vz7KEDwVCzvmlP+cphzaMxYevFk
 IHDXvx8nhEL8w==
Date: Wed, 30 Sep 2026 12:58:20 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Message-ID: <20260930115820.GH480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
 <20260717111016.4B15D1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717111016.4B15D1F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 11:10:15AM +0000, sashiko-bot@kernel.org wrote:
> > +static void cla_vma_open(struct vm_area_struct *vma)
> > +{
> > +	/*
> > +	 * A vma previously created with cla_file_mmap() has been duplicated
> > +	 * within the same mm (most likely due to mremap). While this could also
> > +	 * be called for duplication into a new mm (via fork), we set
> > +	 * VM_DONTCOPY on the original mmap, so this will never happen. So the
> > +	 * contexts covered by this new vma already exist.
> > +	 */
> > +	struct cla_domain *domain;
> > +
> > +	cla_for_each_mapped_domain(vma, domain)
> > +		cla_ctx_map(domain, vma->vm_mm, vma->vm_file);
> 
> [Severity: High]
> Does this code need to check the return value of cla_ctx_map()?
> 
> If a VMA is duplicated (e.g., via mremap with MREMAP_MAYMOVE) and the
> domain is in a broken state, cla_ctx_map() will return ERR_PTR(-EIO)
> without incrementing the context refcount.
> 
> Because cla_vma_open() silently ignores this error, the refcount remains
> unbalanced. When the old VMA is subsequently closed, cla_ctx_unmap() drops
> the refcount to zero and frees the context.

I think it wouldn't hurt to move the domain->broken check after
cla_domain_lookup_ctx()


> > +static vm_fault_t cla_vma_fault(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct cla_domain *domain;
> > +	struct cla_dev *dev;
> > +	struct cla_ctx *ctx;
> > +	unsigned long pg;
> > +
> > +	/*
> > +	 * Reassignment needs mmap_lock, so we cannot wait while holding it.
> > +	 * Luckily, this flag is only missing in some exotic cases which do not
> > +	 * apply for this VM_IO | VM_PFNMAP vma. i.e. GUP without
> > +	 * FOLL_UNLOCKABLE or FOLL_NOWAIT or fixup_user_fault(unlocked=NULL),
> > +	 * used by futex fault-in path.
> > +	 */
> > +	if (WARN_ON(!(vmf->flags & FAULT_FLAG_ALLOW_RETRY)))
> > +		return VM_FAULT_SIGBUS;
> 
> [Severity: High]
> Is it safe to unconditionally assume FAULT_FLAG_ALLOW_RETRY is set here?

I'll have a look myself at some point, but the experts say it is fine.


> Under the per-VMA lock fault path (which is the default for modern kernels),
> FAULT_FLAG_VMA_LOCK is set but FAULT_FLAG_ALLOW_RETRY is explicitly absent.
> 
> Consequently, any normal page fault handled under the VMA lock will hit this
> branch, returning VM_FAULT_SIGBUS and breaking normal memory access.
> 
> Additionally, because this is user-controllable, could the WARN_ON allow an
> unprivileged local attacker to spam the kernel log or crash the system if
> panic_on_warn is enabled?
