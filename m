Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A0AF459F3
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060E010E04F;
	Fri, 10 Apr 2026 15:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZeetXj/I";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295D210E04F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:40:13 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-89fc349b5ceso33412516d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1775835612; x=1776440412; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+N+RyRq+4Lu2ncfMlDfFIZSLyoiGyTWZ5uga3Pmg4s=;
 b=ZeetXj/IafO5xfRpEob3r+Y0wdaFGWkHqLnhC4YKM/2eMeLOJBrzxYIcAerw4pt8y0
 /lvpufiWkyOUvInTa27wP4WPfz4niQXAssbIx3ZjK7tcVtoDz4/aEYJNIFR5njB0DpXp
 uvEpmAh6vtatugtiq2TD4LG51ruvQItzNcLGkyblLbIkz2gYw34Pum2D6VUhLjqD0fDr
 EWo/f3alfBjj+jD3XGwS9vH2Y9X1eV/Fp4/QRPGgtsugrswvDpLyOZN19BKk7nqOJWMX
 8nSUn7TsL85ioznGQu7cL4PB8Y5D+R6swu80jxxbERBo1+mLwDUJxb/yGNJHy1BigXU2
 BJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775835612; x=1776440412;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+N+RyRq+4Lu2ncfMlDfFIZSLyoiGyTWZ5uga3Pmg4s=;
 b=bOYFPPiH+ywACnEzf9qITBQoyNd+ecQg9Tn/n/9QBGR55ZWGjCXLohxL75xUzcZJLz
 /AsPVeVrPCMszJWoUm8v5cqv0jTBNwaUSQTo42VUs8R3FuZ1j2Bx84CIs+RxXl1AyGgl
 Ty47dac31EnYs9rnyiRWsX4nHViK6LUXT6HAzkF7QQi3ViJNcvw6gJYYyBp8pyFrTVH1
 LVX8epdPZN5KpFaN8RUBe3W34K9rSUmaR+F5ijoq1COkQUinGZ8ZQ/ZyUsmMDeNYPOf8
 8NZLmy0Dz4z6HeaIpneVzLQ7G29+qX0lYDIGp+DJkJBdtaDKLBedWE0SuSJeOMIywdfs
 tanw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+hlfhVAAe60k2BefBzcg8esRl5zecISPLdeefMgolrlxCa1MSZIuNYZPxPMmIm3ZDtmNjFWzgYXc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSxqqoxTXUysuQeywA5EQk00lO3/+NEqvvbFLzjjY+2uQ5+HGO
 P36V11Xcg0xxGMN+Ggc+44vd1lCXabxyMuJ+tl0rXZA6u9CxO5LCo5VbpoVtMBjQyTM=
X-Gm-Gg: AeBDieutJPKWA2EoUSST4UszFV9SsRx0KjeGnK2PCb9KxiUUFrQKYg7o0p3Ik+LoqGZ
 qT2Rlw51hOrY+ipc7y9C5AKLVGafNTRTPlv/iO1VlNORy0mo0BEUXhVkvl1rSGCX/d10TWzOcaR
 moekbJC4yQRtrYnt5BCUzz1YoT+qU+cUze1YWZtllyjz3PzjSIOpoDVGmU5ty8rCQoMxB8UZT43
 yCe1XZmBV83I3PNHMvwWSpMuzqVnJEa1MD4HPOa+4sX7Wv/AyQ9IkzCRZTSNaIsm351V23svC3n
 B/1UcK6FSahXiKuqwO/zjwzSOLnIWhpkDs9T8MDaBsNjQFK2v1D9FMkgAAPYezmDrWTh3AU2PuT
 sqyHUwFiew1JsXQb0rgtzMTjfAoRNHQRNlrWBuSyXrf0j8I7I9P+G/y4Ql7LdjmNK3NuC01NI+0
 Ybv3pQUvGDLDmAUV1iGRK5YTdeL+2nN1FH9VVspZUcxijwipe4meOBRkbxiw5IZTPgA6xwpA==
X-Received: by 2002:a0c:f118:0:b0:89c:5c57:98c with SMTP id
 6a1803df08f44-8ac861b003cmr41115156d6.18.1775835611674; 
 Fri, 10 Apr 2026 08:40:11 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84a104ddsm24587146d6.14.2026.04.10.08.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 08:40:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wBDxq-0000000EhY3-2N2g;
 Fri, 10 Apr 2026 12:40:10 -0300
Date: Fri, 10 Apr 2026 12:40:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 Alistair Popple <apopple@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm/mmu_notifier: Allow two-pass struct
 mmu_interval_notifiers
Message-ID: <20260410154010.GZ2551565@ziepe.ca>
References: <20260305093909.43623-1-thomas.hellstrom@linux.intel.com>
 <20260305093909.43623-2-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305093909.43623-2-thomas.hellstrom@linux.intel.com>
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

On Thu, Mar 05, 2026 at 10:39:06AM +0100, Thomas Hellström wrote:
> GPU use-cases for mmu_interval_notifiers with hmm often involve
> starting a gpu operation and then waiting for it to complete.
> These operations are typically context preemption or TLB flushing.
> 
> With single-pass notifiers per GPU this doesn't scale in
> multi-gpu scenarios. In those scenarios we'd want to first start
> preemption- or TLB flushing on all GPUs and as a second pass wait
> for them to complete.
> 
> One can do this on per-driver basis multiplexing per-driver
> notifiers but that would mean sharing the notifier "user" lock
> across all GPUs and that doesn't scale well either, so adding support
> for multi-pass in the core appears to be the right choice.
> 
> Implement two-pass capability in the mmu_interval_notifier. Use a
> linked list for the final passes to minimize the impact for
> use-cases that don't need the multi-pass functionality by avoiding
> a second interval tree walk, and to be able to easily pass data
> between the two passes.
> 
> v1:
> - Restrict to two passes (Jason Gunthorpe)
> - Improve on documentation (Jason Gunthorpe)
> - Improve on function naming (Alistair Popple)
> v2:
> - Include the invalidate_finish() callback in the
>   struct mmu_interval_notifier_ops.
> - Update documentation (GitHub Copilot:claude-sonnet-4.6)
> - Use lockless list for list management.
> v3:
> - Update kerneldoc for the struct mmu_interval_notifier_finish::list member
>   (Matthew Brost)
> - Add a WARN_ON_ONCE() checking for NULL invalidate_finish() op if
>   if invalidate_start() is non-NULL. (Matthew Brost)
> v4:
> - Addressed documentation review comments by David Hildenbrand.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: <linux-mm@kvack.org>
> Cc: <linux-kernel@vger.kernel.org>
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6 # Documentation only.
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/linux/mmu_notifier.h | 42 +++++++++++++++++++++++
>  mm/mmu_notifier.c            | 65 +++++++++++++++++++++++++++++++-----
>  2 files changed, 98 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
