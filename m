Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E245CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C149910E771;
	Tue, 13 Oct 2026 06:46:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F2410E771
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:46:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E7674087E;
 Tue, 13 Oct 2026 06:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52B91F000FF;
 Tue, 13 Oct 2026 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791874006;
 bh=2JJcHZm2wlX4VUk8I+EW0Bm36MPCTKsLvSSStPnKLN0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kJwA7B9UiFHkL/DnvAVg/frvpkp4oL/S9lgGhHVKRZzRt5WsKpMe/3OMvBVw+Fluf
 A5YhHmVw1ksQsazXm8wt2EoWcot4gQsM/J+/Ah9xOtXFeGKWFsz0/H8bbJz0UiDZ5a
 A6TgRhf/rHEVy54YT+pySEx7GNZbrgBDYwnOSjRbgj/FCtAZV+1zRqRYabFA7/QBSz
 A1fKwzqL/jhxJsO3UgLFvvC/q7z1YTi8J05eee5nu2E8hvv2/3llFwjtzP7Yedrm30
 KD7tN4ClcHEWon5AWGuTfrEb/SuYs1hEJyxcJnRACCOyDQ6xvE54dI4E4HwHbUZ4M+
 4kQGg/V6uNXFA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-coco@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: media-ci@linuxtv.org, kvmarm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Oliver Upton <oupton@kernel.org>,
 Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v8 08/14] swiotlb: Align shared IO TLB pools to the
 shared granule size
In-Reply-To: <20260924102254.60C431F00893@smtp.kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-9-aneesh.kumar@kernel.org>
 <20260924102254.60C431F00893@smtp.kernel.org>
Date: Tue, 13 Oct 2026 12:16:39 +0530
Message-ID: <yq5ao6cyqer4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm: infinite loop in swiotlb_init_late() when remap fails
> --
>
> commit 9e7f1b72520615870ee21508117e4c5c7e0eb684
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> swiotlb: Align shared IO TLB pools to the shared granule size
>     
> This commit aligns and sizes the early memblock pool to the common CoCo
> shared granule, leaving the slot count unchanged. It replaces the default
> and dynamic pool set_memory calls with helpers to keep alignment validation
> and architecture dispatch centralized. Pages are intentionally leaked if
> their private state cannot be restored safely.
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index ded7016a46a71..394db93b7eb96 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>
> [ ... ]
>
>> @@ -578,7 +578,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>>  		swiotlb_adjust_nareas(num_possible_cpus());
>>  
>>  retry:
>> -	order = get_order(nslabs << IO_TLB_SHIFT);
>> +	order = get_order(ALIGN(nslabs << IO_TLB_SHIFT, cc_shared_granule_size()));
>>  	nslabs = SLABS_PER_PAGE << order;
>
> [Severity: Medium]
> If remap() fails later in this function, nslabs is halved and the code jumps
> back to the retry label to try a smaller allocation:
>
> kernel/dma/swiotlb.c:swiotlb_init_late() {
>     ...
> 	if (remap)
> 		rc = remap(vstart, nslabs);
> 	if (rc) {
> 		free_pages((unsigned long)vstart, order);
>
> 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> 		if (nslabs < IO_TLB_MIN_SLABS)
> 			return rc;
> 		retried = true;
> 		goto retry;
> 	}
>     ...
> }
>
> Does the new ALIGN macro at the retry label risk inflating the halved size
> back to its original value if cc_shared_granule_size() is >= 2MB?
>
> If so, this would restore nslabs to its original failing value, overriding
> the shrinking mechanism and creating an infinite loop.
>

We don't expect cc_shared_granule_size() > 2MB. But i can also add a
check. 

modified    kernel/dma/swiotlb.c
@@ -719,8 +719,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		free_pages((unsigned long)vstart, order);
 
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
-		if (nslabs < IO_TLB_MIN_SLABS)
-			return rc;
+		if (nslabs <= IO_TLB_MIN_SLABS)
+			return rc;
+
+		/* Avoid infinite loop */
+		if (WARN_ON(nslabs < (cc_shared_granule_size() >> IO_TLB_SHIFT)))
+			return rc;
+
 		retried = true;
 		goto retry;
 	}
