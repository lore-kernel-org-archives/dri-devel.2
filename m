Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F2CC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A4610E493;
	Wed, 22 Jul 2026 18:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCYoa8gH";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4780610E493
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:52:42 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so119636725ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784746362; x=1785351162; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uym772qkEh9LOk/iL6aKk1xWDH0j1Tlr0rPbsmQanS4=;
 b=gCYoa8gHD1X8/BL1iIeCacjQVpJSpz4ZmWnoIvX6Y4m/OODxwJwDcPD1Q8ZO8KbRYq
 dn0mKMq8oPGYE5dAK3pbJ4N59Rrw0l6zhJQue8kvbwcniLGSy25XKCEdMa33AGcSDi6H
 JZMyDWejwMqlzgwnnl00tzof+1TM4kI1kQ+TD0HPLZPD/Up3FzF5ToEPzZr7Is9aiCEV
 VmXTA4N6uR+XyH2ThiyIAKxy/US3GXSTRLJGtc6IGy6LFKZ2//4bxnDlxMDlUtCLpp5l
 nw4lfZDwxjGEuv2JDhqvN5+sfiQm09eKP8fWj6UrpCCNoaQpAswErT+7GrVBt5pHGr6i
 z0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784746362; x=1785351162;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uym772qkEh9LOk/iL6aKk1xWDH0j1Tlr0rPbsmQanS4=;
 b=Rh+Ogdp9OLSLhEt5NlGGCFdt6kLk0sjusgoVlJSyAPFFWgTXs2g0gtNou2tJUQrOMd
 ddORwCNhR0ELpR2Ji/rPLRXmgmYx5ujt+qmHzaMg8cIZVRDjRg14EbgKam2plwvFpAc+
 iKNz13Wy3ym0Z1sigC4CWhHDcSomIExkslorVdCo0VyeGEVkInKv83uc6ba8nSgSwRV1
 Rytt69W8hqQmRd0SauF8yLm85KsN5CXoGhrZbTdEu4MlYrdxcn2EMF1Dl+FgX3Rwoy44
 ojf0nCUaMmc42muNO0VZVW782bF67aMzqpoLHGV9sCZsSI2313CRthmz6xDm/j0s9tlg
 m2xQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDxxG2lPeBQmlP3eTtHSCPbqlu0BYC+XOPFDjkGQm6Ok3XiYQ3etm2lqbr3If3+4ibswRsEyujIFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8hUpWcHUcX15DsdKGCyJF7bHT+FOBNA5BB5yR47MfQwnTMWJM
 V/3H1Zbyn81rvfqE/S6ZQEmpiPevxwIxh6f5z91CmcWQjxqBovKoCWYu
X-Gm-Gg: AR+sD103FW2QRMTqAGt70je6Vds8tuul/StBfNuvAh+yRjM8Dq2QLTLdRReiRe50HvR
 if8ujBmHQ4GrnmN85r9uNdYE67dRo1ZT2PzJXLZiK7L8Soc6O1eccifDsQeFv7A0UuyNBI5hqzb
 LIeZwK/YcBvVbLRgdVn64LXo9R7IYHYUmTXPLrO63diBb0pEw9OPp4zV0Pw95UXZq1t48zdsYMy
 AvDWqdgBG/j4oIGyAgJagdIb1SYNKe+U32HdxpHgNdzld/2I/0EhBhxVtPUT/hWhd86Y8ib/N1u
 nc5cb+winOyVVNW+yH4YLhB2avzm3kRFav3YT/Z78KNlGuRq8ws/zxMM3BwJbNm+dvJCjPkt+Bp
 42ib30ffsNqCEqmkyFSxLRuyLEs8NKcFOrQYLwbhqsUgq3QGL5F3baz4l0vj7106yHw6poTXGsI
 6MstoykbXmSoWkIrn1nEV448j6VVR0NoX7NR5RAQVK2EHV676PTSTvNqg=
X-Received: by 2002:a17:902:da8b:b0:2cc:7e4a:bcc5 with SMTP id
 d9443c01a7336-2cfa71aa7demr1018275ad.32.1784746361700; 
 Wed, 22 Jul 2026 11:52:41 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8efde5cfsm19378335ad.31.2026.07.22.11.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:52:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:52:38 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, jgg@ziepe.ca,
 kees@kernel.org, kys@microsoft.com, leon@kernel.org,
 liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
 mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
 ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
 surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
 wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v9 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <amERdq2X5l5vHfJo@skinsburskii>
References: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
 <178413941236.1155966.14485211391150425997.stgit@skinsburskii>
 <al7CGPdJGM+asOFK@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al7CGPdJGM+asOFK@gsse-cloud1.jf.intel.com>
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

On Mon, Jul 20, 2026 at 05:49:28PM -0700, Matthew Brost wrote:
> On Wed, Jul 15, 2026 at 11:16:52AM -0700, Stanislav Kinsburskii wrote:
> > Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault()
> > and open-code mmu interval sequence setup before each HMM walk. They also
> > retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires.
> > 
> > Use hmm_range_fault_unlocked_timeout() for those faults. The HMM helper now
> > owns mmap_lock acquisition and refreshes range->notifier_seq for its
> > internal retries, while GPU SVM keeps its existing driver-lock validation
> > with mmu_interval_read_retry() after a successful fault.
> > 
> > Pass HMM_RANGE_DEFAULT_TIMEOUT as the helper retry budget for each HMM
> > fault attempt. This scopes the timeout to repeated HMM notifier retries
> > while preserving the outer retry loops that restart when the interval is
> > invalidated before GPU SVM updates or consumes the mapping state.
> > 
> 
> This part doesn't seem right for get_pages(), see below.
> 
> > Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> > called with the mmap lock already held by its caller.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c |   61 +++++-------------------------------------
> >  1 file changed, 7 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 958cb605aedd..de5bbfe58ee9 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -773,8 +773,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
> >  		.end = end,
> >  		.dev_private_owner = dev_private_owner,
> >  	};
> > -	unsigned long timeout =
> > -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> > +	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> >  	enum drm_gpusvm_scan_result state = DRM_GPUSVM_SCAN_UNPOPULATED, new_state;
> >  	unsigned long *pfns;
> >  	unsigned long npages = npages_in_range(start, end);
> > @@ -788,22 +787,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
> >  	hmm_range.hmm_pfns = pfns;
> >  
> >  retry:
> > -	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> > -	mmap_read_lock(range->gpusvm->mm);
> > -
> > -	while (true) {
> > -		err = hmm_range_fault(&hmm_range);
> > -		if (err == -EBUSY) {
> > -			if (time_after(jiffies, timeout))
> > -				break;
> > -
> > -			hmm_range.notifier_seq =
> > -				mmu_interval_read_begin(notifier);
> > -			continue;
> > -		}
> > -		break;
> > -	}
> > -	mmap_read_unlock(range->gpusvm->mm);
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
> >  	if (err)
> >  		goto err_free;
> >  
> > @@ -1406,8 +1390,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  		.dev_private_owner = ctx->device_private_page_owner,
> >  	};
> >  	void *zdd;
> > -	unsigned long timeout =
> > -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> > +	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> >  	unsigned long i, j;
> >  	unsigned long npages = npages_in_range(pages_start, pages_end);
> >  	unsigned long num_dma_mapped;
> > @@ -1422,9 +1405,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  	struct dma_iova_state *state = &svm_pages->state;
> >  
> >  retry:
> > -	if (time_after(jiffies, timeout))
> > -		return -EBUSY;
> > -
> 
> I think that by deleting the code above, you have changed this function's
> semantics by removing the hard cap of HMM_RANGE_DEFAULT_TIMEOUT. This
> code was added because, on some non-production platforms, the timing in
> this function could cause it to livelock.
> 
> Is there any reason this was remove aside from timeout variable not
> being a deadline now? You likely should add the deadline back in.
> 

Indeed, this one can be called from a kernel thread context as well.
I'll revert the change in the next revision.

Thanks,
Stanislav


> Matt
> 
> >  	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> >  	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
> >  		goto set_seqno;
> > @@ -1439,21 +1419,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  	}
> >  
> >  	hmm_range.hmm_pfns = pfns;
> > -	while (true) {
> > -		mmap_read_lock(mm);
> > -		err = hmm_range_fault(&hmm_range);
> > -		mmap_read_unlock(mm);
> > -
> > -		if (err == -EBUSY) {
> > -			if (time_after(jiffies, timeout))
> > -				break;
> > -
> > -			hmm_range.notifier_seq =
> > -				mmu_interval_read_begin(notifier);
> > -			continue;
> > -		}
> > -		break;
> > -	}
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
> >  	mmput(mm);
> >  	if (err)
> >  		goto err_free;
> > @@ -1720,8 +1686,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
> >  		.end = drm_gpusvm_range_end(range),
> >  		.dev_private_owner = NULL,
> >  	};
> > -	unsigned long timeout =
> > -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> > +	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> >  	unsigned long *pfns;
> >  	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
> >  					       drm_gpusvm_range_end(range));
> > @@ -1736,24 +1701,12 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
> >  		return -ENOMEM;
> >  
> >  	hmm_range.hmm_pfns = pfns;
> > -	while (!time_after(jiffies, timeout)) {
> > -		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> > -		if (time_after(jiffies, timeout)) {
> > -			err = -ETIME;
> > -			break;
> > -		}
> > -
> > -		mmap_read_lock(mm);
> > -		err = hmm_range_fault(&hmm_range);
> > -		mmap_read_unlock(mm);
> > -		if (err != -EBUSY)
> > -			break;
> > -	}
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
> >  
> >  	kvfree(pfns);
> >  	mmput(mm);
> >  
> > -	return err;
> > +	return err == -EBUSY ? -ETIME : err;
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gpusvm_range_evict);
> >  
> > 
> > 
