Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E935CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B55410E726;
	Tue, 13 Oct 2026 06:11:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD8F10E754
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:11:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEEE6429FF;
 Tue, 13 Oct 2026 06:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB561F000FF;
 Tue, 13 Oct 2026 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791871890;
 bh=XNxt7wwex7pUWDMg9V+3M/jTcecLEnREYVs82yyM9aI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=YALk6qqKtPdpcsxHCEb6uvpb2E11q490MxJK0iGJMqeSZ3yQudydI0b2f/myBLVIM
 C6BF8rcCphjTDwvNOShHrnWejq1NYMLJri+gXA9wNepU0ucFeHZLUf7Bna2ZGGNY8R
 h2x+hPM80NwNThLC6pSawUKDuhzNukpeE6VlTzW8siz/raPskdFnhHFTz+ldkR9Qz+
 IuEh/gK1V3bV9FlML/ekBHhNT3VyWXZCp1Jxb1+yyVO1Gza/+2hJbY8so2bCazACHz
 dLLzWrNKLPyG5KWe20GdJcSSQuRMm64KgoruGc7/kEA1SIDtL+vy2ruCUIzISQlWNu
 dURRJrJm5hlpA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 linux-coco@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>
Subject: Re: [RFC PATCH v8 06/14] dma-pool: Allocate CoCo atomic pools using
 CoCo shared memory allocator
In-Reply-To: <20260924101945.95D7F1F000FF@smtp.kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-7-aneesh.kumar@kernel.org>
 <20260924101945.95D7F1F000FF@smtp.kernel.org>
Date: Tue, 13 Oct 2026 11:41:25 +0530
Message-ID: <yq5aqzhuqgdu.fsf@kernel.org>
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
> - [High] dma-pool: atomic_pool_expand() falsely returns success on failure
> --
>
> commit 7de8bc3a8ea9e2bbef83e09d72fa88999ce898b9
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma-pool: Allocate CoCo atomic pools using CoCo shared memory allocator
>
> This commit modifies atomic DMA pools to use the CoCo shared memory allocator.
> It prevents allocation fallback below the required shared granule size, and
> uses the cc_make_shared() helper to transition the backing allocations in a
> sleepable context.
>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 70b7f64b17ab5..f059312c15aa5 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
> [ ... ]
>> @@ -85,6 +85,9 @@ static bool cma_in_zone(gfp_t gfp)
>>  static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>>  			      gfp_t gfp)
>>  {
>> +	struct cc_shared_layout layout;
>> +	unsigned long attrs = 0;
>> +	unsigned int min_order = 0;
>>  	unsigned int order;
>>  	struct page *page = NULL;
>>  	bool leak_pages = false;
>> @@ -92,6 +95,17 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>>  	int ret = -ENOMEM;
>>  	pgprot_t prot __maybe_unused;
>>  
>> +	if (dma_pool->cc_shared) {
>> +		ret = cc_shared_calc_layout(pool_size, &layout);
>> +		if (ret)
>> +			goto out;
>
> [Severity: High]
> If cc_shared_calc_layout() succeeds, it returns 0 and overwrites the initial
> ret = -ENOMEM. Could this cause the function to falsely return 0 (success) on
> subsequent failures?
>
> For instance, if page allocation fails below, the function jumps to out and
> returns the current value of ret:
>
>     if (!page)
>         goto out;
>
> Similarly, if remapping fails later in the function:
>
>     addr = dma_common_contiguous_remap(...)
>     if (!addr)
>         goto free_page;
>
> In both cases, ret will be 0 instead of -ENOMEM. Would it be better to reset
> ret back to -ENOMEM when these failures occur, or use a separate variable
> for the cc_shared_calc_layout() return value?
>

Fixed as

modified    kernel/dma/pool.c
@@ -96,9 +96,11 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	pgprot_t prot __maybe_unused;
 
 	if (dma_pool->cc_shared) {
-		ret = cc_shared_calc_layout(pool_size, &layout);
-		if (ret)
-			goto out;
+		int err;
+
+		err = cc_shared_calc_layout(pool_size, &layout);
+		if (err)
+			return err;
 		pool_size = layout.shared_size;
 		min_order = get_order(layout.alignment);
 		if (min_order > MAX_PAGE_ORDER)


-aneesh
