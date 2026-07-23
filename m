Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A7C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064B210E609;
	Thu, 23 Jul 2026 22:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xv1S2EtA";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C256810E609
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:22:29 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso12167705ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845349; x=1785450149; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vzwHTZR2iosFUiZOe0Oy97LjUFogfrOTmiFLxNsdVTA=;
 b=Xv1S2EtAItxm/U3QX7taC38vWgi8Yk0p9CzBNUhc/RoEhLZaVvRVHjAfP91DadYK3y
 ibV0pdj9MLRkSk5YE7YU/dT265UbWZC/y1z5WSrqwbyXKd3lrE0gV1Q6c+I25uLWgZ9C
 QjrHhk4xyuP6Yrmph6PhhRfhLMkbnoaQ3YW0DvtzkAIb57300erbGkBuMn8s9sjpllpk
 /COtYtnc6pdc7rVxmZGQzrVlM3Dk5nsKwERY1GHQgnEoGDUqM6CvTyP06QZMhadsqREC
 Oed7EgtIcRpMTomSANKRNWzT73xaQl4SF+vvZ/T7Gsl4jckB+fKXIM0X+soh75fME/Uz
 I69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845349; x=1785450149;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vzwHTZR2iosFUiZOe0Oy97LjUFogfrOTmiFLxNsdVTA=;
 b=sVehoZ+3D7puSKshM6YwW8z6LoHCPxkEgvjFQX59vF6Vvj6pxOURfShI90KlG3XsHH
 DZhTgE8X4O/ylWHNQkgzGWxmkJtEheExKjzPN3YjZmJdN2pVnt8rttAuWi4RVOOl/flc
 AhD1x6HXxY6IzGquX94uZJHdsO3hva187uiIXrtWuRu0XWNIAAghdq+XK1XPWXSG2g6d
 coXj2M6jnvK/kAPvHzrgtmstCp8pkoY3BJvdFI8WZ67z9AHVnKKiqw2LGXsjkC4Bck1x
 EnoWFJhR7Ycu+MLAUECweUapjFKRxuv1Jd7gm/EAO4TAUivvtXzoJnSsf97tPRd8F4hs
 gZ2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZnGN72b0BBZBTaFETBbc6JLNaxlxXt2AdWyeNSudKRn/fEkBR1bmzQ/PZcDApWshcNUnin5IZ2eo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVZoXMJ4dqly54qxy786THyiA6BbZztqQCE86cc40sj9RrvBC6
 TGJNq8hutw0aVBHdw1k6H7swy6hhIiUIwcCDCnA1SoyI8PuYcR0Wg1fB
X-Gm-Gg: AR+sD10DfeKeH6dDXTCk3gxGlDkgrulUaJEoRpoUfaA943J2g6vY7SxmZzUqPYu7eSr
 d2wBvlxA+CTBfrR1NrbqtRCvX0mdddT8SvdftzB6zPE3YE5AosWpvm/7CyyLbY1QZHlJqhZWImD
 lwfYJXvQxYO9e6bdT2jpzMoViAgsLKjXc8avRQvHF87BTKyPwX5zwsZ73w36feZk8Uxu+p8y3D8
 GClBW/TNL6iA9oGKzLrOtw0ssQBoU67xJOSqxpzBtlVLn2Ko1lfQFAcdGwt2ZUZCOan/7Lji6lr
 ZE8OgLhWMXJw+ebpKO9deOi0cbK1JvN5884WX2eQjAjLWdPvSWafTo8sDoScW3GeSJ1ntfx8rSm
 r3rlbiwKG3XbWhgoBpzZ6m3WcsxTwd3JPCmOyVGJBea7bQrNNngrXb6oLdNdP0XVnlZyFHvxdwR
 L3QcvlbOfApcX7Q1F9g76VARI/s5BOhVOqCJIQk3pduLUk
X-Received: by 2002:a17:903:90f:b0:2cb:2b53:559f with SMTP id
 d9443c01a7336-2cfa6c793d3mr60755125ad.35.1784845349134; 
 Thu, 23 Jul 2026 15:22:29 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f38757esm40198575ad.75.2026.07.23.15.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:22:28 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:22:25 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <amKUIWpMfVS6OFkQ@skinsburskii>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723142242.5d3f87208d47819d873ae458@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723142242.5d3f87208d47819d873ae458@linux-foundation.org>
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

On Thu, Jul 23, 2026 at 02:22:42PM -0700, Andrew Morton wrote:
> On Thu, 23 Jul 2026 10:36:32 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > This series extends the HMM framework to support userfaultfd-backed memory
> > by allowing the mmap read lock to be dropped during hmm_range_fault().
> > 
> 
> Thanks, I've updated mm.git to this version.
> 
> AI review suggests there may be some problems.  Sorry, I don't recall if
> these were considered in previous versions of the patchset:
> 
> 	https://sashiko.dev/#/patchset/20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com
> 

These look like new findings, perhaps from a newer model or review prompt.

I do not think they apply here.

The unlockable path sets FAULT_FLAG_ALLOW_RETRY only when HMM provides a
non-NULL lock state pointer. The legacy hmm_range_fault() path passes NULL
and therefore does not opt in to lock-dropping faults. Fault handlers are not
supposed to return VM_FAULT_RETRY/VM_FAULT_COMPLETED with the mmap lock
dropped unless FAULT_FLAG_ALLOW_RETRY allows that, so the NULL locked state is
not expected to be dereferenced on the legacy path.

For the FAULT_FLAG_TRIED concern, HMM is not trying to emulate GUP's exact
single-address retry loop. If a fault drops mmap_lock, HMM has to restart the
range walk because the VMA/page table state may have changed. Resetting the
timeout on that path is intentional: a lock-dropping fault made progress, and
the timeout is meant to bound mmu-notifier retry churn rather than the time
spent servicing faults.

Also, the newly converted HMM users are not using this path for ordinary
file-backed page-cache population, and process-context callers can still be
interrupted by fatal signals. All the existent kernel thread callers are
capped by a timeout.

So I do not think this requires a code change.

Thanks,
Stanislav


> > 
> > Changes in v11:
> >   - Reject unstable address spaces in hmm_range_fault_unlocked_timeout()
> >     after taking mmap_lock and before walking page tables.
> >   - Compute the remaining HMM timeout budget before the time_after_eq()
> >     check in drm_gpusvm_get_pages() to make sure it can't result in zero
> >     and lead to infinite HMM range faulting loop.
> 
> Here's how v11 altered mm.git:
> 
> 
>  drivers/gpu/drm/drm_gpusvm.c |    4 ++--
>  mm/hmm.c                     |    6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/drivers/gpu/drm/drm_gpusvm.c~b
> +++ a/drivers/gpu/drm/drm_gpusvm.c
> @@ -1422,11 +1422,11 @@ int drm_gpusvm_get_pages(struct drm_gpus
>  	struct dma_iova_state *state = &svm_pages->state;
>  
>  retry:
> +	remaining = timeout - jiffies;
> +
>  	if (time_after_eq(jiffies, timeout))
>  		return -EBUSY;
>  
> -	remaining = timeout - jiffies;
> -
>  	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
>  	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
>  		goto set_seqno;
> --- a/mm/hmm.c~b
> +++ a/mm/hmm.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/mmzone.h>
> +#include <linux/oom.h>
>  #include <linux/pagemap.h>
>  #include <linux/leafops.h>
>  #include <linux/hugetlb.h>
> @@ -806,6 +807,11 @@ int hmm_range_fault_unlocked_timeout(str
>  		if (ret)
>  			return ret;
>  
> +		if (check_stable_address_space(mm)) {
> +			mmap_read_unlock(mm);
> +			return -EFAULT;
> +		}
> +
>  		if (timeout && time_after(jiffies, deadline)) {
>  			mmap_read_unlock(mm);
>  			return -EBUSY;
> _
> 
