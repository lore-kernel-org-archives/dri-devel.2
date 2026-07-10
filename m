Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06426C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343C910F172;
	Fri, 10 Jul 2026 16:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="CSj7DX0h";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D2310E212
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:31:40 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8ff88549786so10886796d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701099; x=1784305899; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
 b=CSj7DX0hWeyE/eTX5n7PkKRobWSRqtVerqD6Y5bwmFmB/QbegtCboewFL/+nvRwShE
 2gxTBp8FRuvzK++bDdZhiD6+kJqtkGcdex9/kP0mKJvG7Z0TTjbGJYUZH8eyRzFIQOMK
 ydtV/pG5tuKA3kZSa1mljp+A4NjWT8XRCzOkrkKsZZ6ANDnIiB87ZtUskFohVY9BCF+i
 BXA7Gq6JQTMFjbgsLQTBAn1eiNPqEPPgxFY/xDN2Pen3VT6zH6+uHUA2wqR/KvXz2CA4
 kQKGRC4m3hBZce6+TpesSx3seJvvzALCLeS0UjHj24L44ZYRUpr8TUH+YqNa8CwysqFh
 33kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701099; x=1784305899;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
 b=mRy+2HrXdoBLc0UeqGe/Ac5iEftHOBaI8uibdPFcDk0zQWSDDymk1eQIOXl7M2u/QZ
 tDKSuFxuxsNRxm6+UQgBL/mORm/IiPv3UzvCrCPRF7RxKMJ+yce7DKv8GMV1zE8QJLVT
 Bt2o79zTokSS5Z6u9dlo3tVmYDAzy5dzRgsBUGOie8aHVRQV3xHViOaJ6cCkTv5nKqzt
 ELTIJe92MtQvRD9OlOEWwQlKTILuiGNPeecB9TdaEQ35XQ6s2uAphQ9Ieq1WwykGw/+V
 V4folixYpBxWYE1vwskWb6Iidhdmu5KecK7GQIh9mnwofmfOBmveKjlYXEnFLQa++mIZ
 wM7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4/DqvAK4Q2vK0hzG82Y92NgalZVdF41ccgXYWy7j4Yc2fZtkYj8Kz0IV5Z9yCN7qq/LVBHqAOYpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwqV134yJEKqNM6ditPU/q09myOt/wfyqM35thNjZmaNoOJfRr
 s7Jvxdmd7Ca2J13P8KhgLz/JMIP3fcWhhJnKjOokFTzHIoU+xvyS3zRsldHZ7ITzIlQ=
X-Gm-Gg: AfdE7cn6OFxrlboACpKSFaoybgidCYESomcPkzYq17O3qkn+/4rM4ohZypLFW+o70MC
 T44nFeVa/qL8xrsC0Wunize5i0AmDxYUffB6cNAYMGon9xFSIsnjO0Fg/XOWvkzAX24mtlWFjBS
 9ZWDCh70FdNHF5EvhPjfT8GtbwljEMEiUsX5pUMnhpNSfVHmeHXQxGYelK8JuNqVzEH7NkQOkgq
 a7L1pqCxQcz0KwDbq35DEkTwEur+oFihxvyD6fEA1N8ytiLvTrJISX+EH/kVvn9NqyJ0PKRzCdl
 rMB7LCMNcZEzSFodGwcDasZp9ZHNlyLFQAVUCgTPrTi5lFczHZcISLLN2SG1cBK9FNNrKid1aaP
 J9XYYsZXKYv96D17ZG33YyCBqM3H0MOz5YDqVFLoUs7eBZ6jr27iZodMsGWkdRazs6Zt+VqI=
X-Received: by 2002:a05:6214:4710:b0:903:12c9:cba6 with SMTP id
 6a1803df08f44-90312c9dcb8mr32500716d6.47.1783701099176; 
 Fri, 10 Jul 2026 09:31:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4cd1sm44753226d6.16.2026.07.10.09.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:31:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiE8X-00000007Xks-3Vyo;
 Fri, 10 Jul 2026 13:31:37 -0300
Date: Fri, 10 Jul 2026 13:31:37 -0300
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
Subject: Re: [PATCH v7 1/8] mm/hmm: move page fault handling out of walk
 callbacks
Message-ID: <20260710163137.GQ118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345361483.660027.16455119612963295072.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345361483.660027.16455119612963295072.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:46:54PM -0700, Stanislav Kinsburskii wrote:
> hmm_range_fault() currently triggers page faults from inside the page-table
> walk callbacks: hmm_vma_walk_pmd(), hmm_vma_walk_pud(),
> hmm_vma_walk_hugetlb_entry() and the pte-level helper all call
> hmm_vma_fault(), which in turn calls handle_mm_fault() while the walker
> still holds nested locks.  The pte spinlock is dropped explicitly by each
> caller, and the hugetlb path manually drops and retakes
> hugetlb_vma_lock_read around the fault to dodge a deadlock against the walk
> framework's unconditional unlock.
> 
> This layering does not extend cleanly to fault handlers that may release
> mmap_lock (VM_FAULT_RETRY, VM_FAULT_COMPLETED). If the lock is dropped
> while walk_page_range() is mid-traversal, the VMA can be freed before the
> walk framework's matching hugetlb_vma_unlock_read(), turning that unlock
> into a use-after-free.
> 
> Split the responsibilities the way get_user_pages() does. Walk callbacks
> become inspect-only: when they detect a range that needs to be faulted in,
> they record it in struct hmm_vma_walk and return a private sentinel
> (HMM_FAULT_PENDING). The outer loop in hmm_range_fault() then drops out of
> walk_page_range(), invokes a new helper hmm_do_fault() that calls
> handle_mm_fault() with only mmap_lock held, and restarts the walk so the
> now-present entries are collected into hmm_pfns.
> 
> No functional change for existing callers. As a side effect the hugetlb
> callback no longer needs the hugetlb_vma_{un}lock_read dance, and every
> fault-path exit from the callbacks now releases the pte spinlock on a
> single, common path. This refactor is also a precursor for adding an
> unlockable variant of hmm_range_fault() in a follow-up patch.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  mm/hmm.c |  118 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 43 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
