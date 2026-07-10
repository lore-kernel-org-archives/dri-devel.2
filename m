Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0FC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9863610E20C;
	Fri, 10 Jul 2026 16:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="drtE5KJZ";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14F810E20C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:38:37 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8efef6533aaso7439406d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701517; x=1784306317; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fjPC+dGtl7NWTD2gQsmUUpevrDX1aRJ0R6Q1EEoKDOI=;
 b=drtE5KJZAKoPAgnLEPFLCTh/1OyiBq6wmdtLmEQNp3Phc34VlQrLTV+M4bqhG4y1M7
 Q2hgcnBxTX7pd75hc3AAd+VwLUgTLHm7lcZSliA9bs9H0KfxqSgH0m6TP29mOeHSXhrb
 bkOxWHzOujDJlIm/ea/hmVVpgX5jO3YOA7Pt33UD/C0tFEjzZIvnf64olwvcgMaC28DM
 E0A0FMGek//+Ogr0s5Tel5nV3nDcFfnMasqWIj4Owq6VnzUGrzevR7GDCUDUlzMxaaiT
 5V7B1yMB2eymeg7aPqKGYNkNd8/gQ+bQo9GRMniIPQjk8NBiC6CaElgLMrOx/tv3D8fs
 vumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701517; x=1784306317;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fjPC+dGtl7NWTD2gQsmUUpevrDX1aRJ0R6Q1EEoKDOI=;
 b=aDKCBUQGxoJ+Fu4gBCqzfzxh2GG75vf6laloEd05v0TQOT/H2SWUEV8yLqD+r27KyF
 BL5U3e6h26vv3rKHm1Rau/3cLGLuCtREmTclSxRjzpTMWibD4i6RX+III2Rm5dUJ/zyM
 BmHayupXH1fcbpGPSrkiOb3cObhH2JlSDYJvA6OCiLzTmSUR4/RyZqMafc6PHwvHXSQg
 o8CzMF/oW1gQ4EDpMWvkYFC5SmgyJGjZvO0iMDvqRSbVcrwLjPC7tjxFA2oNXbk21rYs
 wnN0IPqRUbHTXGoh7eHlePXDRQqLWvmlILxG5qpXKpu5D1mqzMuwmoaXHPMUy3bJVeC1
 0xwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr17zy4+y0sT44E230+87Acp0ZymGZvqEOJJCOVXfSBIPMPA6/C//llfxx7qW+Z39VA+4O7iF4XHXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRzXxeBvaC6L9r+VwY2r7QkxxLvGmgXGjO6wgtGqenPzQQNVGS
 xtP7fzHyBHs1GtGl7sATq3CE1m8Kqg1gaGfP4vy2f+XydoLllybeLlAaMy1n8NiYblY=
X-Gm-Gg: AfdE7ckRfE6CZtuLIsxUcMP0Pt1IM8cdte86mTCVXNakO2hFViuDH2bxNOjKd6gxHRu
 neYENkIVNoSpBw94L9rTP+cWSyAOMgc6/RF5i8JBYJk8GIBoBUMXIzYPgicohNHjQrB8MlqplP+
 n9LJ6OtkLc239WPKUaRa0aWRs0iL3VMwa3lMbplSncdWUGnoJHt/dTTxqjuP1qZnd/ZGt2tsCEf
 QWhEuDNxzASX6vFp0JIvG1H2WA1FQEMHovfCyrFEeNW83uthrfv6EQMz/xMN9TZLw17Nlkqeleh
 ItYHP7269RQRSVIqwT+FcPdmjTcW3qxQun2/tLx61QyKSd/KZy0x5tvxa8+iBaO8pmpW5Me1/e/
 9dg8Vs9ArEm7CPaoYwux1/Bi1bnvRYB1Hgmmp8f242RAKlJuqRAZt0xucQ1qn
X-Received: by 2002:a05:6214:19e7:b0:8f1:36c7:497c with SMTP id
 6a1803df08f44-8fec217aa9emr148367176d6.33.1783701516760; 
 Fri, 10 Jul 2026 09:38:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1d8fcsm45350946d6.25.2026.07.10.09.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:38:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEFH-00000007YQp-17rB;
 Fri, 10 Jul 2026 13:38:35 -0300
Date: Fri, 10 Jul 2026 13:38:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710163835.GR118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345362182.660027.12809852179204464964.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> hmm_range_fault() requires the caller to hold the mmap read lock for the
> duration of the call. This is incompatible with mappings whose fault
> handler may release the mmap lock, notably userfaultfd-managed regions,
> where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
> after dropping the lock. Drivers that need to populate device page tables
> for such mappings have no way to do so today.

sashiko could not apply v7 for some reason but the remarks on v6
seemed meaningful, did you see them were they delt with?

https://sashiko.dev/#/patchset/178336023903.504354.7500950448226027718.stgit%40skinsburskii

> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index 7d61b7a8b65b..70885f153d03 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -208,6 +208,69 @@ invalidate() callback. That lock must be held before calling
>  mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
>  update.
>  
> +Dropping the mmap lock during page faults
> +=========================================
> +
> +Some VMAs have fault handlers that need to release the mmap lock while
> +servicing a fault (for example, regions managed by ``userfaultfd``).
> +``hmm_range_fault()`` cannot be used on such mappings because it must hold the
> +mmap lock for the duration of the call. Drivers that need to support them
> +should call::

Given the majority of callers use this API it should probably be the
focus of the documentation and example, regulate the existing API to a
'BTW if you really need the mmap lock, and you really shouldn't, this
exists too'

> @@ -32,6 +32,7 @@
>  
>  struct hmm_vma_walk {
>  	struct hmm_range	*range;
> +	int			*locked;

Let's use bool if you have to respin this

> @@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
>  		fault_flags |= FAULT_FLAG_WRITE;
>  	}
>  
> -	for (; addr < end; addr += PAGE_SIZE)
> -		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
> -		    VM_FAULT_ERROR)
> -			return -EFAULT;
> +	for (; addr < end; addr += PAGE_SIZE) {
> +		vm_fault_t ret;
> +
> +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> +
> +		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
> +			*hmm_vma_walk->locked = 0;
> +			return HMM_FAULT_UNLOCKED;
> +		}
> +
> +		if (ret & VM_FAULT_ERROR) {
> +			int err = vm_fault_to_errno(ret, 0);
> +
> +			if (err)
> +				return err;
> +			BUG();

Linux will be upset if he sees this.  

if (WARN_ON(!err))
   err = -EINVAL

> +/**
> + * hmm_range_fault - try to fault some address in a virtual address range
> + * @range:	argument structure
> + *
> + * Returns 0 on success or one of the following error codes:
> + *
> + * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
> + *		(e.g., device file vma).
> + * -ENOMEM:	Out of memory.
> + * -EPERM:	Invalid permission (e.g., asking for write and range is read
> + *		only).
> + * -EBUSY:	The range has been invalidated and the caller needs to wait for
> + *		the invalidation to finish.
> + * -EFAULT:     A page was requested to be valid and could not be made valid
> + *              ie it has no backing VMA or it is illegal to access
> + *
> + * This is similar to get_user_pages(), except that it can read the page tables
> + * without mutating them (ie causing faults).
> + *
> + * The mmap lock must be held by the caller and will remain held on return.
> + * For a variant that allows the mmap lock to be dropped during faults (e.g.,
> + * for userfaultfd support), see hmm_range_fault_unlocked_timeout().
> + */

Add a comment discourging anyone from using this function and prefer
hmm_range_fault_unlocked_timeout()

Other than the concern about the timeout and minor nits this looks
fine

Jason
