Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D7C44508
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1FA10F968;
	Fri, 10 Jul 2026 22:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vrKNqD/R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5EA10F968;
 Fri, 10 Jul 2026 22:12:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15A9C41A63;
 Fri, 10 Jul 2026 22:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C384A1F00A3E;
 Fri, 10 Jul 2026 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1783721538;
 bh=vZPCZ7vPd1NuY/NOvoRK1wg4DzJ9OfLHTV03rmwvPpc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=vrKNqD/RSYZafjQOwVndW01m5aLwswfnuVAfqI5wWJJiUGxMunb7KBRBbR+vIavWm
 Jwjm7GTEqUP54kAGt2vK1og8+S0X4K5USi4sGzpjMkFtbq+y8rgsLvuLfwWeKzYqds
 EILDdi2jW5IYL94/XhZxUobGPOo9gvao6LZmzPYg=
Date: Fri, 10 Jul 2026 15:12:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-Id: <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
In-Reply-To: <178371881034.900500.5214601525971121683.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 10 Jul 2026 14:26:50 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:

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
> ...
>
> @@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
>  	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
>  	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
>  
> -	do {
> -		ret = mshv_region_hmm_fault_and_lock(region, &range);
> -	} while (ret == -EBUSY);
> -
> +again:
> +	ret = hmm_range_fault_unlocked_timeout(&range, 0);
>  	if (ret)
>  		goto out;
>  
> +	mutex_lock(&region->mreg_mutex);
> +
> +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> +		mutex_unlock(&region->mreg_mutex);
> +		cond_resched();
> +		goto again;
> +	}
> +

If the calling process has realtime scheduling policy and either a)
we're uniprocessor or b) this process and the holder of
interval_sub->invalidate_seq are both pinned to the same CPU then
cond_resched() won't do anything, and this might be an infinite loop?
