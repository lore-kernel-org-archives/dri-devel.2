Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F120410E3B0;
	Fri, 10 Jul 2026 16:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="eGGjoSW7";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E0410E3B0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:39:10 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-92e7632b193so69667385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701549; x=1784306349; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pz9Az2A5A+eQsiowkEP3oUH5xkba/HyvmJjmLQ4f6yE=;
 b=eGGjoSW7zvSY0xs/Rl9x+y+OpiKSlzZVxhgn38OmVl9vaaiEDy+oKW3pkOi1Id+2S6
 oLVbtEV/sDqqygb4p3M7RmT2Aqcpot6VbZRcbKfyj2hL8pkb1vcWJJRm2S7AnrQCwjLG
 8faGxXpBueYGWMbj6+cJeZmnwrN/6mEDmhvBVTROmJlmFgyQ5TDAeFPjO5aP/X5xEELB
 dDHcdMlTP7/YzhYiJhguJlkMPUQDJZxdM7AfQP8Tpcc+rXRcV/nZ9J/I5CeCUuF4cx28
 DCfzT9gAGjAOXvVNL5Al6mxRYio+ViGKswdXwCAGj0yudMXfi6YdRXmxuEVUnI7YGtv8
 2myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701549; x=1784306349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pz9Az2A5A+eQsiowkEP3oUH5xkba/HyvmJjmLQ4f6yE=;
 b=dRPp6T30HX/7EDTAlA4I1Ho/Ih4Wxz4Gy9Uqk6MMsfHTR3DrklgJnd6lh6sUx/CEka
 ttTifb3ufh2VGlJ2Gi0Pb+Tbq/iJfJhnKPksn1NEpDbLv280zPZDIJbFdC7/KiHUzbFl
 Si0GfuFemUZWkJ58cHgGcY0HNWkwQLSn9AO862sGInfpQIe+ZpKQ5sdoUVjHC9eKcKx6
 2e+726+y1C/GoC6OMnjfJAAz4YGqbFjLQBistwalO0lvC/Itm1vJoZGYePq3ywvz4C9u
 ZSzZY/8w4F68DqkGvAEtKFqw/p3GxCUvnP2z7sKxbzkJMFwyMOQaBkAmdW/pDLgbLkq8
 tphg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1SQ6fWGSCLm0ucQYOV0EHfYyQDItNDZuQP/CCcs64uE8ft8LeZa2mNGleSNDcRLYQnI9I8IW+ovY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyodW2uEj+YLVejHn557Z7nzoTQvH9l6eZYeew1bSwJf031YsLs
 GTz3XZbVXeU90OzoPOW68nF2lRp/wsUi7dfATE1whm+jboe0cwGRhZxjtneF8eZ1AJg=
X-Gm-Gg: AfdE7cntlHE03J2xTbwp50+K8aezXBX/9ya0H4LW58M3YfHDjFiTmzb+36ai0aUS3Ok
 8+OB86EKWieU8SeQbPII+9aNPr4AwFCvre1Eo1pByxZiThQqaOpzuVeqxF/pAKmBXGkF89LwUyi
 SfMahfAXaPW+pu6w5vk2ietJfa4pVOjluBK88BQt+duGw4mErJNJjJhT16Ktuoxr/9CKFr7OiI9
 ULnOdHlXL5WoTI80PyGPKYbdqPMlxxalnjR0BRNTrxg2y8uHzHK/S8I4qnTcb6oxK+CYCE2LkXe
 nfH4vwpC2DamSYYnPcoza4ZLXVDPz72J0ovaTwCyZVJeifNqR4YUXoVSANQmwCaA69FF/Y45eCI
 G15j/WjMZyAkQzM7Tg36UqjuSohmyauCzjOVRuZtQcrrCzVcSXcCrbTHazj/J
X-Received: by 2002:a05:620a:2842:b0:92e:44eb:1e7a with SMTP id
 af79cd13be357-92ecf5f0e37mr1356630085a.29.1783701549520; 
 Fri, 10 Jul 2026 09:39:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5bcb074sm235123285a.21.2026.07.10.09.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:39:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEFo-00000007YRj-1Qzt;
 Fri, 10 Jul 2026 13:39:08 -0300
Date: Fri, 10 Jul 2026 13:39:08 -0300
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
Subject: Re: [PATCH v7 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <20260710163908.GS118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345363584.660027.14063544694872741718.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345363584.660027.14063544694872741718.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:15PM -0700, Stanislav Kinsburskii wrote:
> MSHV currently faults movable memory regions by taking mmap_read_lock()
> around hmm_range_fault(). That prevents the fault path from handling VMAs
> whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
> mappings.
> 
> Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
> preserves MSHV's existing unbounded retry behavior while letting the HMM
> helper own mmap_lock acquisition and refresh range->notifier_seq internally
> before walking the range. After the fault succeeds, MSHV still takes
> mreg_mutex and checks mmu_interval_read_retry() before installing the pages
> into the region, so the existing invalidation synchronization is preserved.
> 
> Fold the small fault-and-lock helper into mshv_region_range_fault(), since
> the remaining retry path is just the standard "fault, take the driver lock,
> check the interval notifier sequence" pattern.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/hv/mshv_regions.c |   54 ++++++++-------------------------------------
>  1 file changed, 10 insertions(+), 44 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
