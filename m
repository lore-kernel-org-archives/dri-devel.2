Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSEZuOCv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F8710E5E5;
	Fri, 23 Oct 2026 21:28:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C9710E5E5
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 21:28:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E90160142;
 Fri, 23 Oct 2026 21:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1B51F01828;
 Fri, 23 Oct 2026 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792790897;
 bh=6UN1W0eT+Inio+UzVeQE/6qRYM+8bQWI7zoN0SuRn50=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SSEZuOCvrR3mGxUTIawZWx+T5B77FggTpptCoXYcFd1IToEQUBHEJ7SnKnl3fSTmq
 H9yLnUMKBXw4CSAzikYFdrIKvdXOQQXO8Y4qAPkS6bX0O1bKfoPpgAwGeXBFtHxZi8
 sXTL4sZR8PzIsou3mT/fWod3E2EYELKE1VfluutoZl0XIaZGPTpQ1SEVwaXAUapQSH
 HC4zqh7quPUmuqEMdRqzr7X7HZU0EGgd0c6HWjC/q6Vl7Lfxg98ReQuwziNPzmhjf9
 sxS9mZ2MJGbZuDksB4pZdE8phunEtjSoCyEacXgKUNc9RYouAeHQgj12Y8tHjJpp/Q
 fYthYuZIZpK1A==
Date: Fri, 23 Oct 2026 11:28:17 -1000
Message-ID: <a3ae9a0f13e3972d0645f555bcc26f4f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v7 3/4] workqueue: Add support for real-time workers
In-Reply-To: <20261022093848.5727-4-tvrtko.ursulin@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-4-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Tvrtko.

On Thu, Oct 22, 2026 at 10:38:47AM +0100, Tvrtko Ursulin wrote:
>  struct workqueue_attrs {
>  	/**
> -	 * @nice: nice level
> +	 * @prio: priority encoded analogous to task_struct->prio.
>  	 */
> -	int nice;
> +	int prio;

Can the nice to prio conversion be split into a preparation patch with
no functional change, so that this patch only adds WQ_RT on top?

>  sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
>  				   struct workqueue_attrs *attrs)
>  {
> +	if (wq->flags & WQ_RT) {
> +		attrs->prio = RT_PRIORITY;
> +		/* Strict CPU affinity for low latency execution. */
> +		attrs->affn_scope = WQ_AFFN_CPU;
> +		attrs->affn_strict = true;
> +	}

Can WQ_RT set only the priority and leave the affinity at the defaults?
If the pinning is needed for the latency, can you share numbers with
and without it?

>  	mutex_lock(&wq->mutex);
> -	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
> +	if (wq->attrs->prio == RT_PRIORITY)
> +		written = scnprintf(buf, PAGE_SIZE, "rt\n");
> +	else
> +		written = scnprintf(buf, PAGE_SIZE, "%d\n",
> +				    PRIO_TO_NICE(wq->attrs->prio));

Can the sysfs interface comment above struct wq_device be updated too?
It still lists nice as RW int, while nice reads "rt" and is read-only
for WQ_RT.

> +rt_prio = prog.constant('RT_PRIORITY', filename='kernel/workqueue.c')
> ...
> +    nice = pool.attrs.prio.value_()
> +    if nice == rt_prio:
> +        nice = 'rt'
> +    else:
> +        nice = nice - 120 # PRIO_TO_NICE

These fail on a kernel without this patch, where neither RT_PRIORITY
nor attrs.prio exists. Can they fall back to nice, the way wq_attrs()
falls back to unbound_attrs for the earlier rename?

Thanks.

--
tejun
