Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE66D109C033
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1434410E814;
	Wed, 25 Mar 2026 15:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzWM0u6Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B630910E7CD;
 Wed, 25 Mar 2026 15:59:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EE8C7600AC;
 Wed, 25 Mar 2026 15:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAFEC19423;
 Wed, 25 Mar 2026 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774454395;
 bh=+0nYu3vCNrNhMzd9/cm+tOj/aB8NO24ErTKeKQYbAV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nzWM0u6Qn1Ms4fqYrCExyYxHIfM6vh+F+i3D305lycMHoCKQn6flf2mB9tX4f0yf0
 HDXCp6Qn0MlfR5lcr22WMhU8g009OnayD5giTXAChnzu0FmZa/FzGWmLdGWBL/oP+b
 9bNXvXKVEzrJso+IcawYcSGjBzXjnncUNjHZUd6g8kvvwUalawwmFXR0/FSfVqhN4Z
 5TcHvhGvaBtA+2pM8pdgJP8NvTvuG62bv34LWoketzyeLzuX0b+B8ZNPGl13T4UeuI
 QakjLYnapmg3qxQ35mZx2hDrLuKeP818tlYa1JC7mOE16Nmtd+Cd/hrAz+w4rd2Wo0
 cBew4lBG36lxw==
Date: Wed, 25 Mar 2026 05:59:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to
 warn on reclaim violations
Message-ID: <acQGehvhyfU5j6uL@slm.duckdns.org>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-2-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316043255.226352-2-matthew.brost@intel.com>
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

Sorry about the tardiness. Traveling during spring break. Getting more than
I can catch up with each day.

On Sun, Mar 15, 2026 at 09:32:44PM -0700, Matthew Brost wrote:
> @@ -403,6 +403,7 @@ enum wq_flags {
>  	 */
>  	WQ_POWER_EFFICIENT	= 1 << 7,
>  	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
> +	WQ_MEM_WARN_ON_RECLAIM	= 1 << 9, /* teach lockdep to warn on reclaim */

Shouldn't this require WQ_MEM_RECLAIM?

> +/**
> + * workqueue_is_reclaim_annotated() - Test whether a workqueue is annotated for
> + * reclaim safety
> + * @wq: workqueue to test
> + *
> + * Returns true if @wq is flags have both %WQ_MEM_WARN_ON_RECLAIM and
> + * %WQ_MEM_RECLAIM set. A workqueue marked with these flags indicates that it
> + * participates in reclaim paths, and therefore must not perform memory
> + * allocations that can recurse into reclaim (e.g., GFP_KERNEL is not allowed).
> + *
> + * Drivers can use this helper to enforce reclaim-safe behavior on workqueues
> + * that are created or provided elsewhere in the code.
> + *
> + * Return:
> + * true if the workqueue is reclaim-annotated, false otherwise.
> + */
> +bool workqueue_is_reclaim_annotated(struct workqueue_struct *wq)
> +{
> +	return (wq->flags & WQ_MEM_WARN_ON_RECLAIM) &&
> +		(wq->flags & WQ_MEM_RECLAIM);
> +}
> +EXPORT_SYMBOL_GPL(workqueue_is_reclaim_annotated);

Why is this function necessary? It feels rather odd to use wq as the source
of this information. Shouldn't that be an innate knowledge of the code
that's using this?

Thanks.

-- 
tejun
