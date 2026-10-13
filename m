Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BD9CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E7610E073;
	Tue, 13 Oct 2026 05:46:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C44C10E073
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:46:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F360243BEB;
 Tue, 13 Oct 2026 05:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F1B1F000FF;
 Tue, 13 Oct 2026 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791870396;
 bh=Kn3sevWHfnmO/p6abMJZzG209Y+bg0EY/JmHb1ot1GE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ORBFjCtiLmLFAFdLrfSgNeOhZmd84KKHFG3/Ud7vCkeR4P8xYLLZV9vJFZ9ITLqEe
 FMcv3ppgXKgS5hFtzSNr4sAImv5Sdpk0ehtcOYGsTGWDo86WRES/kHNuLfrpJ6fZQ5
 UkIXfDT+sNYdhwqiizR0uHiVfZvAl5dSuTWJgDGUIonxzF4PoWnSjEnD/7AV84IV6T
 KlOFHLybwTcUxVQVhLAxJmYWXoF9CG+nbk05dPYB79O4JJCPM61Sx65t0yX3jSSURg
 t89eP8ob5nP7tBZa9s8UbYDKxfcRjW0OYyoY394hTRMnB4nKntpZASnVO7i6WnpKxZ
 ubmnZ6/1aT1RA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
 Marc Zyngier <maz@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v8 03/14] irqchip/gic-v3-its: Resolve the default
 NUMA node explicitly
In-Reply-To: <20260924101929.815D81F00893@smtp.kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-4-aneesh.kumar@kernel.org>
 <20260924101929.815D81F00893@smtp.kernel.org>
Date: Tue, 13 Oct 2026 11:16:32 +0530
Message-ID: <yq5awlrmqhjb.fsf@kernel.org>
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
> - [Medium] irqchip/gic-v3-its: incomplete NUMA_NO_NODE resolution exposes allocations to task mempolicy
> --
>
> commit 6d762ab83972132164ae57c1422f1916decb2fe3
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
>     irqchip/gic-v3-its: Resolve the default NUMA node explicitly
>     
>     alloc_pages_node() resolves NUMA_NO_NODE to numa_mem_id() internally. In
>     preparation for switching ITS allocations to the CoCo shared memory
>     allocator, resolve the default node explicitly in its_alloc_pages().
>     
>     The CoCo shared memory allocator interprets NUMA_NO_NODE as a request to
>     apply the current task's memory policy. Passing numa_mem_id() instead
>     preserves the existing nearest-memory-node placement across the
>     allocator switch. This patch does not change the current allocation
>     behavior.
>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -236,7 +237,7 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>>  
>>  static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
>>  {
>> -	return its_alloc_pages_node(NUMA_NO_NODE, gfp, order);
>> +	return its_alloc_pages_node(numa_mem_id(), gfp, order);
>>  }
>
> [Severity: Medium]
> Will this leave other callers of its_alloc_pages_node() exposed to the
> task memory policy change?
>
> When a device probe or ITT allocation occurs with its->numa_node ==
> NUMA_NO_NODE (which is common when firmware lacks NUMA info), callers pass
> NUMA_NO_NODE directly to its_alloc_pages_node():
>
> drivers/irqchip/irq-gic-v3-its.c:its_alloc_pages_node() {
> 	...
> 	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> 	...
> }
>
> If node is NUMA_NO_NODE, it passes it directly to the underlying allocator.
> When the underlying allocator interprets NUMA_NO_NODE as a request to apply
> task mempolicy, these direct callers will be subjected to the current task's
> memory policy instead of bypassing it and using the local node. 
>
> If a user binds the driver via sysfs under a restrictive task mempolicy,
> the allocations could land on suboptimal distant nodes or fail entirely.
>
> Should the NUMA_NO_NODE resolution logic be moved inside its_alloc_pages_node()
> to ensure all callers are protected?

Yes, updated the patch to perform the mapping in its_alloc_pages_node(),
so all callers are handled.

@@ -216,6 +217,9 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 	struct page *page;
 	int ret = 0;
 
+	if (node == NUMA_NO_NODE)
+		node = numa_mem_id();
+
 	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
 
 	if (!page)
