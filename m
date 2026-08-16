Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36FDC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC56010E33B;
	Sun, 16 Aug 2026 19:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EbRqHbsD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7165010E33B
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:10:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA04B41720;
 Sun, 16 Aug 2026 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD11F000E9;
 Sun, 16 Aug 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786907414;
 bh=iR6IAKOZKy95BLSUHFK6MXY/YV8hSVxpWjFmKYp0jfo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EbRqHbsD0/rBMibGFOOl7INVE0luZOFQtxgi2IDt9g9KbchSYVW+GrdYqOFvHCmG6
 bRWSklYRoB1kptd6GwcMdmxDYDEiF+tjdoXmGXG1S4Wwn+q93ofkNMuWMt8Z+cDu0F
 UMqcICrNZQR8hTKpVL8TNZESjRTjGHz0YAQTj6OIxJ1c6WOhf46oPfionArHcYrUoq
 FnKohcxQ10A9KbOcykR4MEkoZxZq26Qvvfihth920V0fIbPuVGSyZCsa4BNS4wLM9L
 7OJmMxaXDnAXE38y507iPTEDcUUGda6Tu6oFGtLVY1SRJ4Yg1kyYbYc+M2YbGqWNLI
 ESUmOdM74wceQ==
Date: Sun, 16 Aug 2026 09:10:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, Bradley Morgan <include@grrlz.net>,
 Chia-I Wu <olv@google.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v4 1/2] workqueue: Add support for real-time workers
Message-ID: <aoILFR3SNYBbMOOz@slm.duckdns.org>
References: <20260804101925.55414-1-tvrtko.ursulin@igalia.com>
 <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
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

(cc'ing Breno as he has been working in the area)

Hello,

Sorry about the delay.

On Tue, Aug 04, 2026 at 11:19:24AM +0100, Tvrtko Ursulin wrote:
>  struct workqueue_attrs {
>  	/**
> -	 * @nice: nice level
> +	 * @prio: priority level
> +	 */
> +	enum wq_priority prio;
> +
> +	/**
> +	 * @nice: nice level for WQ_PRIO_HIGH
>  	 */
>  	int nice;

I find this rather confusing. We're scattering the same internal state
across multiple fields. If you look at scheduler code, rt and normal nice
values are encoded into a single prio value, maybe we can do the same?

>  static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  {
> -	bool highpri = wq->flags & WQ_HIGHPRI;
> -	int cpu, ret;
> +	int prio, cpu, ret;
>  
>  	lockdep_assert_held(&wq_pool_mutex);
>  
> +	if (wq->flags & WQ_RTPRI)
> +		prio = WQ_PRIO_RT;
> +	else if (wq->flags & WQ_HIGHPRI)
> +		prio = WQ_PRIO_HIGH;
> +	else
> +		prio = WQ_PRIO_NORMAL;
> +
>  	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
>  	if (!wq->cpu_pwq)
>  		goto enomem;
> @@ -5622,7 +5637,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  			struct pool_workqueue **pwq_p;
>  			struct worker_pool *pool;
>  
> -			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
> +			pool = &(per_cpu_ptr(pools, cpu)[prio]);

And this looks a bit confusing too because there's no per-cpu counterpart
but it looks like there should be.

I wonder whether this would look better after the percpu and unbound pool
unification that Breno is working on.

Thanks.

-- 
tejun
