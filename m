Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D611FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CBE10EB44;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWObE4+7";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03CA10E627
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:01:26 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso1114645ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783962086; x=1784566886; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R9LV+16tD32KS6yXCzCBkB0u2lL8SNr6pDg+a+HPC20=;
 b=cWObE4+7shrvUl4uaczCEu7Kv3aOoU9zBS94KfdE10ghs3QaLn+9Lne+ko6GBxY/H0
 3vpJFD4vDqfbyZGLPL62DdaYkymGzsWzsucuEcIBhEPA9BrRI+EQGIac50Bcp8ujo1mu
 Bxyy1WCFd5Avn51ddba5WLaLz+kIT9BUafo5MVVAu6gMbSJoBvI6ujzyIYJivGmJ4m9f
 XfiW54YDMyZ2h3vSmeonSp8tX8MquI9BR1AbHNPg4MOlwxhECQYd2zXah+ZOYMjjsl1d
 EzwpWYCLXXVKgC7JYUfuzp2dhVB8MCIlQY9WurkeUy94sQ1BIxDbtscJAQtp9iam0d76
 0eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783962086; x=1784566886;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9LV+16tD32KS6yXCzCBkB0u2lL8SNr6pDg+a+HPC20=;
 b=DwrhtKFAtorwH89LO1/6gLGLJKFaW49zGLcRdf8vDIHg3sXBWiYfQvpFKmAaHXYZus
 U3rGLTkJC7mb4uLa759qzBQSKcV0BjKWUnXU7I7BEGLrL7eueOnsdOGnNkx0QVGX86pA
 E6r0bIKqycg/mQfxfbnYuOgvMwCjx/DigrdP85rctu5MGvxh/O6U9sPQMXaI1jZvsYwo
 oslxBl2JAKiXLFMULrik18IqjeleqGYVOKIyWmN93m2VdN4NeVZ268S/DA3xk42uE2wr
 6hnKMK6vnAf9RIhJwvU8gO00UQ/IgRZ308vinnS+gmJoww6aRUlalp50ngW4tS2VgQ7I
 0hxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk+G2dScUW1Qf+za79wcCPWBZGvlUFuE24t45mhRwohR2LCP+W5prV/jB34ewk8/uYoZSAENYZscM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwD+tYhSBLamsNbpRHO8kzmwrYBQ48akG9zKuqNcnXKvkgkHNAy
 Ghz5JEiro/bvLt/lCPPuLDuiSS9/WvwQ1lys4TM328AKJ13dhKjK/+z0
X-Gm-Gg: AfdE7cnGmKh3gHfjU+iTlu8hT8BGKPqYuVCRQRb4C09+zVYOGGEMlP5TPupaw+W26er
 Xsjo60ZQQF/emfMLTpku6u3iUnbKbWl2F3ck/cxHhABDXrT4FjTC7wzQkBdVUEU3Zf5IlqvvhMb
 hPfWCl0B8sqMCZ78xvWF/JswUSOseMMVSL/ZRqZ4VVcbYB0ZfWWooHCq195ZuFsvs9pxTjiAiTo
 g/OUKbfSVoz9szQulWBgi8CwmwwMFZS6YxQkdUeXJrVOA3pkMy09jNUxpXqZuSXcuZ4s+PPzJSZ
 zg3Oo1V5sUZlVYPquu/ZHgEo/b/kjXlhPel6umKjbT8rVCcHvyuZIUkWkDsiFEmN1TVQmgOADab
 gHn3nQIIAbvKA/BL5U6m6J89EshV5OWno16KbtaG6rrenFBrUbBkRuwQrarSBJJUKrbOhUZK2D2
 5mSJxoQBjDajrIuo1b/TAZLyzPSFDhBJIzAX1ZJm6qxFxXBiYIUIDZA0k=
X-Received: by 2002:a17:902:e88a:b0:2ca:de3:15d7 with SMTP id
 d9443c01a7336-2ce8292bad0mr123460335ad.16.1783962085860; 
 Mon, 13 Jul 2026 10:01:25 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d451sm102224465ad.65.2026.07.13.10.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 10:01:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:01:20 -0700
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
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <alUZ4NQptiD9fRfz@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883977.900500.2198446134676328631.stgit@skinsburskii>
 <alUSq0o7CC2Pnr+H@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUSq0o7CC2Pnr+H@gsse-cloud1.jf.intel.com>
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

On Mon, Jul 13, 2026 at 09:30:35AM -0700, Matthew Brost wrote:
> On Fri, Jul 10, 2026 at 02:27:19PM -0700, Stanislav Kinsburskii wrote:
> 
> Please send series like this to intel-xe@lists.freedesktop.org list too
> as this will trigger our CI which expercises the change paths changed in
> this series.
> 
> > Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
> > then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
> > MMU interval notifiers whose mm matches the mm that was locked for the HMM
> > fault.
> > 
> > Use hmm_range_fault_unlocked_timeout() for those faults and pass the
> > remaining retry budget to HMM. The helper owns mmap_lock acquisition and
> > refreshes range->notifier_seq internally for each retry, while GPU SVM
> > keeps its existing driver-lock validation with mmu_interval_read_retry()
> > after a successful fault.
> > 
> > Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> > called with the mmap lock already held by its caller.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
> >  1 file changed, 7 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 958cb605aedd..6b7a6eaebcd9 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -788,22 +788,8 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
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
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +					       max(timeout - jiffies, 1L));
> >  	if (err)
> >  		goto err_free;
> >  
> > @@ -1439,21 +1425,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +				max_t(long, timeout - jiffies, 1));
> 
> Unaligned indentation.
> 
> So I'd write this like this to avoid weird wraps:
> 
> ctimeout = max_t(long, timeout - jiffies, 1));
> err = hmm_range_fault_unlocked_timeout(&hmm_range, ctimeout);
> 
> >  	mmput(mm);
> >  	if (err)
> >  		goto err_free;
> > @@ -1736,24 +1709,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
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
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +				max_t(long, timeout - jiffies, 1));
> >  
> 
> Same here.
> 
> Nits, aside LGTM.
> 

Will change as requested and send to intel-xe@lists.freedesktop.org next time.

Thanks,
Stanislav

> Matt
> 
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
