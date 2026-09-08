Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651F9C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC88B10E0E2;
	Tue,  8 Sep 2026 11:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QhNNAWMy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A935110E0BB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:21:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3805643D9A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B311F00A3D;
 Tue,  8 Sep 2026 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788866468;
 bh=j/U5fkLSK9elTXfNHHdRbWrYETO2jxa4HIXPfQxvanw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QhNNAWMyanhZKcd+z7B1H4RiMsW9Z6qpCKJEw2oi0im5vvXS2N8/rKZreFytbxaHh
 eEo14pw6yg0eq8Kzcz6mEgZ+BzT6RHmaOjxv+dzQ+ewFZ/m7kKZR3pf/W4cVrI+y8s
 Dv6FGzryq7UIX+fkTE2TMVHgiyJq1xyO81S8Syiq/pMP+vbJP1EKWiHF9dU1xK8lsg
 USe2xaAMR3PrxUSPr7njHy5VGuWJE9FU2jVtApw1xC/ZQr9d0/k/6xvItNV6wUCXF2
 1kn5ksWuG0UtCjjMigjREd3L/MabVDtPzIvWBMlKx/FCU9rinOt8OSSynfEWfndrQr
 g5D43+lvp1tLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] drm/i915: Adjust to RCU-less fence
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908105926.1120378-3-phasta@kernel.org>
References: <20260908105926.1120378-2-phasta@kernel.org>
 <20260908105926.1120378-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:21:07 +0000
Message-Id: <20260908112107.E4B311F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leftover `rcu_dereference()` calls on local stack arrays after remo=
ving `rcu_read_lock()`, causing compile errors and lockdep warnings.
--

commit 19905da799945ee74ece58c7907776bf754a26d6
Author: Philipp Stanner <phasta@kernel.org>

drm/i915: Adjust to RCU-less fence

This commit adjusts the i915 driver to accommodate changes in dma_fence=20
that allow for handling fences without relying on RCU functionality.

> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/dr=
m/i915/gt/intel_gt_requests.c
> index 93298820bee2c..724c4359f6884 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
> @@ -238,6 +238,8 @@ void intel_gt_fini_requests(struct intel_gt *gt)
> =20
>  void intel_gt_watchdog_work(struct work_struct *work)
>  {
> +	char driver[64] =3D "";
> +	char timeline[64] =3D "";
>  	struct intel_gt *gt =3D
>  		container_of(work, typeof(*gt), watchdog.work);
>  	struct i915_request *rq, *rn;
> @@ -250,17 +252,13 @@ void intel_gt_watchdog_work(struct work_struct *wor=
k)
>  	llist_for_each_entry_safe(rq, rn, first, watchdog.link) {
>  		if (!i915_request_completed(rq)) {
>  			struct dma_fence *f =3D &rq->fence;
> -			const char __rcu *timeline;
> -			const char __rcu *driver;
> =20
> -			rcu_read_lock();
> -			driver =3D dma_fence_driver_name(f);
> -			timeline =3D dma_fence_timeline_name(f);
> +			dma_fence_driver_name(f, driver, 64);
> +			dma_fence_timeline_name(f, timeline, 64);
>  			pr_notice("Fence expiration time out i915-%s:%s:%llx!\n",
>  				  rcu_dereference(driver),
>  				  rcu_dereference(timeline),

[Severity: Low]
Does this cause a compilation error? The patch changes the driver and timel=
ine
variables to be local stack arrays, but rcu_dereference() expects a scalar
pointer, not a character array.

Additionally, if it does compile, could this trigger a lockdep warning sinc=
e=20
rcu_read_lock() was removed from this function?

>  				  f->seqno);
> -			rcu_read_unlock();
>  			i915_request_cancel(rq, -EINTR);
>  		}
>  		i915_request_put(rq);

[ ... ]

> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i=
915_request.c
> index d2c7b1090df08..2a3df13217b94 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -2185,7 +2185,7 @@ void i915_request_show(struct drm_printer *m,
>  		       const char *prefix,
>  		       int indent)
>  {
> -	const char __rcu *timeline;
> +	char timeline[64] =3D "";
>  	char buf[80] =3D "";
>  	int x =3D 0;
> =20
> @@ -2221,8 +2221,7 @@ void i915_request_show(struct drm_printer *m,
> =20
>  	x =3D print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
> =20
> -	rcu_read_lock();
> -	timeline =3D dma_fence_timeline_name((struct dma_fence *)&rq->fence);
> +	dma_fence_timeline_name((struct dma_fence *)&rq->fence, timeline, 64);
>  	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
>  		   prefix, indent, "                ",
>  		   queue_status(rq),
> @@ -2232,7 +2231,6 @@ void i915_request_show(struct drm_printer *m,
>  		   buf,
>  		   jiffies_to_msecs(jiffies - rq->emitted_jiffies),
>  		   rcu_dereference(timeline));

[Severity: Low]
Similar to intel_gt_watchdog_work() above, is it safe to keep the
rcu_dereference() call wrapped around the timeline character array here now
that it is stack allocated and rcu_read_lock() is no longer held?

> -	rcu_read_unlock();
>  }
> =20
>  static bool engine_match_ring(struct intel_engine_cs *engine, struct i91=
5_request *rq)

[ ... ]

> diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/=
i915_sw_fence.c
> index f24f616e23ee6..d0e733beff863 100644
> --- a/drivers/gpu/drm/i915/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/i915_sw_fence.c
> @@ -427,25 +427,23 @@ static void dma_i915_sw_fence_wake(struct dma_fence=
 *dma,
> =20
>  static void timer_i915_sw_fence_wake(struct timer_list *t)
>  {
> +	char driver[64] =3D "";
> +	char timeline[64] =3D "";
>  	struct i915_sw_dma_fence_cb_timer *cb =3D timer_container_of(cb, t,
>  								   timer);
>  	struct i915_sw_fence *fence;
> -	const char __rcu *timeline;
> -	const char __rcu *driver;
> =20
>  	fence =3D xchg(&cb->base.fence, NULL);
>  	if (!fence)
>  		return;
> =20
> -	rcu_read_lock();
> -	driver =3D dma_fence_driver_name(cb->dma);
> -	timeline =3D dma_fence_timeline_name(cb->dma);
> +	dma_fence_driver_name(cb->dma, driver, 64);
> +	dma_fence_timeline_name(cb->dma, timeline, 64);
>  	pr_notice("Asynchronous wait on fence %s:%s:%llx timed out (hint:%ps)\n=
",
>  		  rcu_dereference(driver),
>  		  rcu_dereference(timeline),

[Severity: Low]
Does this code also suffer from the same issue? The rcu_dereference() macro=
 is=20
still being applied to the driver and timeline stack arrays after=20
rcu_read_lock() was removed.

>  		  cb->dma->seqno,
>  		  i915_sw_fence_debug_hint(fence));
> -	rcu_read_unlock();
> =20
>  	i915_sw_fence_set_error_once(fence, -ETIMEDOUT);
>  	i915_sw_fence_complete(fence);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908105926.1120=
378-2-phasta@kernel.org?part=3D2
