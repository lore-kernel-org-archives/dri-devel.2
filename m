Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB11610F9310
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C3310E2DC;
	Wed,  1 Apr 2026 00:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1tY15Y6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43C210E27D;
 Wed,  1 Apr 2026 00:05:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DAB6A600C4;
 Wed,  1 Apr 2026 00:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72700C19423;
 Wed,  1 Apr 2026 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775001942;
 bh=Z5BZ/JumfybSInyb3/dNCVeo40Y5CQhBHcoIcom2nVs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W1tY15Y67eOqzSQF1clsFT+4WXALa93aYxetdZUXEO07Pyd41uHHNllqhiqwpZcgH
 ObQjjvgXDVnazSuyFWw4s0Y8i51/Cma9fZ6V5aToGc3x8ixyH2Dj4cD4p62MZMsEJK
 zqywnUxcUnjiJmbnksDDyqn4qpUnYIUJZV10E3Kg1yFmTKPkdLp0yn/VMaQer2YeI/
 Xvm2z1UTTd3VFBiKyV+thFTLN16OV8was8dzUW37K2AgvxpKOhoh/ZOjIF0xFGXKCc
 +7XZauKJxOQVg434eD5fCjjJGx1ay6HMQzRGD0Fx6AA1Vuf959pblL9ziIbnPMQitS
 4zMp/0JlgMb4Q==
Date: Tue, 31 Mar 2026 14:05:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
 Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Message-ID: <acxhVZK_zlv1orIX@slm.duckdns.org>
References: <20260331221839.1033423-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331221839.1033423-1-matthew.brost@intel.com>
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

Hello,

On Tue, Mar 31, 2026 at 03:18:39PM -0700, Matthew Brost wrote:
> @@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
>  	raw_spin_lock_irq(&pwq->pool->lock);
>  	if (pwq->plugged) {
>  		pwq->plugged = false;
> -		if (pwq_activate_first_inactive(pwq, true))
> +		if (pwq_activate_first_inactive(pwq, true)) {
> +			if (!list_empty(&pwq->inactive_works)) {
> +				struct worker_pool *pool = pwq->pool;
> +				struct wq_node_nr_active *nna =
> +					wq_node_nr_active(wq, pool->node);
> +
> +				raw_spin_lock(&nna->lock);
> +				if (list_empty(&pwq->pending_node))
> +					list_add_tail(&pwq->pending_node,
> +						      &nna->pending_pwqs);
> +				raw_spin_unlock(&nna->lock);
> +			}

It's a bit gnarly to open code locking and list operation. Would just
calling pwq_activate_first_inactive(pwq, false) one more time work here?
That'd trigger tryinc_node_nr_active() failure in pwq_tryinc_nr_active() and
the addition to the pending list. As this is quite subtle, it'd be nice to
have some comment - it's compensating for the missed pwq_tryinc_nr_active()
call due to plugging, right?

Thanks.

-- 
tejun
