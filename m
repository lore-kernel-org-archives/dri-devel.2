Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1382ECA5FAB
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 00:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0490710E230;
	Tue, 29 Sep 2026 00:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k5RBNl8P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E7C10E230
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:00:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C50A2419A1;
 Tue, 29 Sep 2026 00:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D62A1F000FF;
 Tue, 29 Sep 2026 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790640044;
 bh=5ciXBmNzMw1rOwmbGcny8jZrQPt6zu0pPu4bcqSgV90=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=k5RBNl8PB8OGoynwm1uKQAMklBTFpJZYsdSZuoIPNw7W/JCVttZhhV+sZph6XOmnP
 hZ0JrZ/ChgCXA7+NuYWrjJjM4ywvwmJPQThJrCbm92do703ChvTscT8Hci7wR59UdE
 uPTajEomKbC0THWRaM2YY7ysdCRlcit38zgOpM56vEDON1WeUMtXSAVEo69lYZz+FI
 AvXu6iGmJ7cSZWJswqEn0glQLxNUasLzoagFkVwFpVr6M5AVzQ+96wa5uoHt39/fsP
 0UNrb+yz+rmwrcish6+GmnJ/AjVnIrl6KN3Xpkxy7s0+B/B3m4ueEEOqXtUa70xQoD
 P6oRFG0uP6NXg==
Date: Mon, 28 Sep 2026 14:00:43 -1000
Message-ID: <3ff40909da4f1510419ac0e2f9f4e6a1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v5 2/3] workqueue: Add support for real-time workers
In-Reply-To: <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
 <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello,

On Wed, Sep 23, 2026 at 05:12:50PM +0100, Tvrtko Ursulin wrote:
> For use cases such as the DRM scheduler submitting work to the GPU on
> behalf of low latency userspace applications, where latter have sufficient
> privileges to have had successfully obtained realtime Vulkan global
> priority, competing with random background CPU load can create large
> latency spikes which gets in the way of a smooth user experience.

panthor's group_priority_permit() also allows realtime groups for DRM
master without CAP_SYS_NICE. What's the usage model there? Should DRM
master be enough to get RT workers?

> @@ -374,8 +374,9 @@ enum wq_flags {
>  	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
>  	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
>  	WQ_HIGHPRI		= 1 << 4, /* high priority */
> -	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
> -	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
> +	WQ_RTPRI		= 1 << 5, /* real-time priority, valid only with WQ_UNBOUND */
> +	WQ_CPU_INTENSIVE	= 1 << 6, /* cpu intensive workqueue */
> +	WQ_SYSFS		= 1 << 7, /* visible in sysfs, see workqueue_sysfs_register() */

Can we name it just WQ_RT? Also, I think WQ_RT is closer to WQ_BH. We can
reorder the flags later if that helps but for now can you just put it in an
empty slot?

> @@ -127,6 +127,7 @@ enum wq_internal_consts {
>  	 */
>  	RESCUER_NICE_LEVEL	= MIN_NICE,
>  	HIGHPRI_NICE_LEVEL	= MIN_NICE,
> +	RTPRI_NICE_LEVEL	= MIN_NICE - 1,

Can we match the scheduler's representation instead by replacing
attrs->nice with attrs->prio which uses the same encoding as p->prio?
Normal pools would be NICE_TO_PRIO(nice) and WQ_RT pools would be in the RT
range. create_worker() would then do:

	if (rt_prio(pool->attrs->prio))
		sched_set_fifo_low(worker->task);
	else
		set_user_nice(worker->task, PRIO_TO_NICE(pool->attrs->prio));

> @@ -7606,7 +7626,10 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
>  	int written;
>
>  	mutex_lock(&wq->mutex);
> -	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
> +	if (wq->attrs->nice == RTPRI_NICE_LEVEL)
> +		written = scnprintf(buf, PAGE_SIZE, "rt\n");
> +	else
> +		written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);

Can you also show rt in pr_cont_pool_info() and tools/workqueue/wq_dump.py?

Thanks.

-- 
tejun
