Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22385C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580B010E9E1;
	Fri, 10 Jul 2026 16:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="gr3hXuLv";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C072010E605
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:41:01 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c01089e8aso6039531cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701660; x=1784306460; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z7U3THTZDjx6I8tSiQ91l//DDsukKiO5Egsu4KIAjvc=;
 b=gr3hXuLvo5TxktPTMlhBYWJ12iZauTvNQ0oDNahGbx20f9DNPGiKzlM4KA2YiEIGOR
 q7dsY7GfXKYSewtIkYcTv8zSCaLVIrFc0vqQnFxMzQlWwuzzpaiUhPYCZW5A/xNOtQYb
 0exmxT926FFYOqR3ESZOYVqBdMtu59WMYelF3X5lzC58AV4unAM2kzB638YbQ8rA0lO1
 fsDmolAthjURcdZuE4r1hZyR9AC4dhvtffr0YO6/etX1Byv5fd1eMIzID0XFPWo/shKs
 DjFwHKlblQ4A2uo0b804uKFR2GRXcDiC4GPu8r3Fw52yNOSoajyVrTK9yk5UlCv2WaGj
 3/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701660; x=1784306460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z7U3THTZDjx6I8tSiQ91l//DDsukKiO5Egsu4KIAjvc=;
 b=MrAmANdE4FC1L3A589ASNoOPfCGCxILhcApLKT6Z19DchHUGMn6D5vqX17SZtqEoI5
 dyUAphKE+Qq6NFriQ4C9qUnAXJK04C+HPq+hfdHqFThrKepvR+vG0AIVEk9583rP3h3N
 9geezymuso9jKY/aaEQu++Xkqp0q6hRRU36fpb3p8cBF1911kHCq3zLapkszEa7WUj51
 P0S1On8+kuDj1DXnaNE7eHdXK31qidWwJs7zhYBs90R3a6VQui8N1oJd5iuX3BvPtJ0C
 JYwwFZim+5s6vv9u/xIUAAJZU+OBt3viV3Kc9wFbLpxNK+b0zdHwbKankBgtZ7eZAC3X
 YGfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtBy6CarYDZStgXRUeyfrEgWC3fuG4erfNjn00Ha7eaStvM29m6L9NMPWmRJhqEjqtNfumCH1UIM8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjleAR1dWLTZPU6HXNTPZVBiv2fIMyf3IIkbJOzaz9+kD774TD
 RIFYx6m7i2X8kM25S2f9AtoF1qUoE8sdttnVNj0yZw0KmzIyThrCrKkGHy3myUN3o2M=
X-Gm-Gg: AfdE7cl+qfL+1yBXKCEDOrjo1l7vjEl/s9np1HGBlv9Zb2r8a0c9nckIlLW6Qkvq9pF
 36wPrRO6sDRgA4ZLtn1ZRbI9OXlC2w7ZZu1LRFmjXGHaGkqZr6oXfjmF51LLuIfi+gR4fprf9kW
 6JPBJm0WJdRgfx1mJwZBsGQa+C1aiJ90nMN8VQ22KG1q8/D4IxkekMIVI4sho474FlfR3JBD6VO
 lwNj2tJmXbasbyZsVEyV8UXn+HZnXjpKyvPMt5uE3GT6WgyWJmpFR8oyU9kfqCUqia3+UhhpwIb
 lm8pm7rBNLnJfEzi4bAMgEG+q7Nk7whnR78kjv37Ww/4i0/F4L3Dio02srWCiERcJFuNyXh260i
 JvugL1JchGbfOVMUxv4ebFiyt0hX1J2UwbH8FZ/M/smSmV4JrCuRd3TXEHSxCW88S87Sme7A=
X-Received: by 2002:a05:622a:558d:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-51c8b2d5582mr133755821cf.13.1783701660503; 
 Fri, 10 Jul 2026 09:41:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e0347sm45334476d6.2.2026.07.10.09.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:40:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEHb-00000007Yc5-1TXt;
 Fri, 10 Jul 2026 13:40:59 -0300
Date: Fri, 10 Jul 2026 13:40:59 -0300
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
Subject: Re: [PATCH v7 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <20260710164059.GT118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345364273.660027.15274510603185163961.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345364273.660027.15274510603185163961.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:22PM -0700, Stanislav Kinsburskii wrote:
> nouveau_range_fault() takes mmap_read_lock() only to call
> hmm_range_fault(). It also keeps a single HMM_RANGE_DEFAULT_TIMEOUT
> deadline across both HMM -EBUSY retries and post-fault
> mmu_interval_read_retry() retries.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes range->notifier_seq for its internal retries.
> Nouveau keeps its existing absolute deadline in the outer loop and passes
> the remaining jiffies to the helper for each fault attempt, so retries
> caused by mmu_interval_read_retry() do not reset the overall retry budget.
> 
> Nouveau still validates the interval notifier sequence while holding
> svmm->mutex before programming the GPU mapping.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> -		mmap_read_lock(mm);
> -		ret = hmm_range_fault(&range);
> -		mmap_read_unlock(mm);
> -		if (ret) {
> -			if (ret == -EBUSY)
> -				continue;
> +		ret = hmm_range_fault_unlocked_timeout(&range,
> +				       max_t(long, timeout - jiffies, 1UL));

Avoid max_t, 1L should be a signed long.

Though I'm even more concerned about the timeout if drivers are now
wrapping the whole thing in a timeout... That's not sensible at all

Jason
