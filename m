Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D838C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B4410E7E2;
	Mon, 13 Jul 2026 07:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OstrPz6A";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D8710E708
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:14:57 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2159748a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783739697; x=1784344497; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xrd/oJTRX2Uc0zxJ+R9Qjxy6xmTV66E4ZoYglWTlGgs=;
 b=OstrPz6AeKvRyr2DhgvuNlfKE2EUzV7MwKQH0Q7iVKOd8dqmwEL8hjVrixOM+CVWyd
 ND9ZqesyhtAWyuONW0zThqM0Iu6O5q1cTy+MP7j/8gNy8WtAXk7juzUxflw+fdAqpCkb
 Y0ZAexnCAi7LVxEwiX8xGA8WDuoh8n95r+v0D8DnAWlaw9Sl5wZN7gWEil1qJs/SXluN
 hZgWlAQLssTiVj51V8FmxETiz4HzGszcelcDYG4kIMeOJXoA7pc5K/oTlqlHl5P1z/iV
 DwW2jtVrLYBVyv6tZQ3FXfnmUR/XxnaiDy5qS+qmRMtoCaXuzDggHwopMSe1UG0KZxDU
 rzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783739697; x=1784344497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xrd/oJTRX2Uc0zxJ+R9Qjxy6xmTV66E4ZoYglWTlGgs=;
 b=bthgSPr3DjW7IEqF7McwKn4rDPamMsUd1cKowYvbbyiahP173w8BubqHpccSCeeLcL
 i7bKdcw6nfRd6IgXJtnxhGkg2OKG1GQiZNtbhduCcJlnAQ2tdpUMt5jxESQ1eMT9/Qim
 Jj8LU22ekpLUIwTmE3u3iKPezvQukIAE1LRPHR7X7yd3EXLf/UYmhBkFbK499pWrejst
 UguYCJ7QxdKbvzB+bqNavN8s4aSDkB77v4wVLpjgwxj1okbDfmAQ43+jZw82dnmHqn0O
 u2PAAV6VPyEO88MTe4wvmDkMzijOr+3GFGjwowJQo0jmP4lv9C7wQ3IJ6XcLDxuB540p
 6sUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTG9kbjDMbygiwEy9017mHqQ9IDljDXg7FkKNMqTep2W1EvoWEy0DJxuXexMCxHmpOv8ZvvMWGXP8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+rmTSihkMsV/rpZtec2FGazj/tEKVIY5KGZ4ZtZIcjXUDEaHE
 dZ6vowsZlbUCXeVlOv35GRK7KqKOJeF5lrKAuLiCzR/tplG/02J5vthr
X-Gm-Gg: AfdE7claj06r5Ei5ampN8OmFYAw2xw+odDN0WTmxaQnbFEzzvUPpzLkrKZB5tu4lBAB
 WHM+RM/EJ40B/VFw5Pluz25Z8wLeQ58M/PS0I2p8eYvOGSC5vDO0ivesey72ysWs1SNN2b3fIDk
 Dpud3rTkyoqNpRjowEyCVhTrhxDOwI3h+FDFTtCJtMiAfZni1JU3HmfcD43zeKIAgGEL4jICUos
 LGafukU/1dlNHdHc5hFt4wzQ62rS9tG7FpF2I2J7D08h7shW3uPWvu1SRoFFzyrObD3hpbihrsj
 ZsRGMPWnh7t7Z0N/RpUsqff9PXRxXY+7GZW4AU72QH6ZP+b2YQGKcofAEfGk+VkFxJn4nm/ZYaR
 2we6zDcZwNLJGg8Q3jl+nnR35/HalWDJEXb4tZ1FJft//K6KapV8fUsEXgC3avhaNm710NeN9tL
 jWXuALfTpK7wR7V2xOmXixdFN1Dugb5xiFac/slPhta6QIYzqfSP4XwFw=
X-Received: by 2002:a17:90b:5688:b0:381:29f2:481b with SMTP id
 98e67ed59e1d1-38dc74cbe73mr1405854a91.11.1783739697430; 
 Fri, 10 Jul 2026 20:14:57 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55a47286sm3463061a91.10.2026.07.10.20.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 20:14:56 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:14:47 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
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
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <alG1JwgUK44dCiN4@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 03:12:16PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:50 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > MSHV currently faults movable memory regions by taking mmap_read_lock()
> > around hmm_range_fault(). That prevents the fault path from handling VMAs
> > whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
> > mappings.
> > 
> > Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
> > preserves MSHV's existing unbounded retry behavior while letting the HMM
> > helper own mmap_lock acquisition and refresh range->notifier_seq internally
> > before walking the range. After the fault succeeds, MSHV still takes
> > mreg_mutex and checks mmu_interval_read_retry() before installing the pages
> > into the region, so the existing invalidation synchronization is preserved.
> > 
> > Fold the small fault-and-lock helper into mshv_region_range_fault(), since
> > the remaining retry path is just the standard "fault, take the driver lock,
> > check the interval notifier sequence" pattern.
> > 
> > ...
> >
> > @@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> >  	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> >  	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
> >  
> > -	do {
> > -		ret = mshv_region_hmm_fault_and_lock(region, &range);
> > -	} while (ret == -EBUSY);
> > -
> > +again:
> > +	ret = hmm_range_fault_unlocked_timeout(&range, 0);
> >  	if (ret)
> >  		goto out;
> >  
> > +	mutex_lock(&region->mreg_mutex);
> > +
> > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > +		mutex_unlock(&region->mreg_mutex);
> > +		cond_resched();
> > +		goto again;
> > +	}
> > +
> 
> If the calling process has realtime scheduling policy and either a)
> we're uniprocessor or b) this process and the holder of
> interval_sub->invalidate_seq are both pinned to the same CPU then
> cond_resched() won't do anything, and this might be an infinite loop?

Yes, looks like it might.
What can be done to prevent this?

Thanks,
Stanislav

