Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457E606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+LBB7Lk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED5F10F483;
	Tue, 20 Oct 2026 10:27:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700CB10F483;
 Tue, 20 Oct 2026 10:27:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 308524400F;
 Tue, 20 Oct 2026 10:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B21F000C7;
 Tue, 20 Oct 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792492039;
 bh=3chU6oP5fGM8h96OrIheQ+HBD3rk0HtVL/oaoy0nLhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c+LBB7LkJ2SOe1mcIUOf1o+KVWTJr3GIMjgUZYPKFkE5PAfjzSowsarcv45/U+M1K
 hdCPqP2NmmBlWQDqQOz/bStRVN37dKKHVvFro2JrfxTenPUeEPCaalIrxh3ngvVv7p
 Euss8VAv2ClGtc1K/F+MHSmVXpcUfkL7ZeNI1izIkY8tg0/sozc/W4cafK6uNcAX4m
 aMsxe49VpmNR0KqqXgsJBrrFH+WmyC135K57ip/z7oF6G+pPNU8y5PxHAIlTPcHIQ0
 SLC0S4UA/68fNR7DVxAvDUpwqv99XZgOwEI7aByHVak4eq5m7tKVElMYHgIhb9Dfw8
 EIn5gfIGeR/Tg==
Message-ID: <sashiko-outbox-178830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] dma-fence: Support unload for
 ops->get_XXX_name()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261020100034.759183-5-phasta@kernel.org>
References: <20261020100034.759183-2-phasta@kernel.org>
 <20261020100034.759183-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:27:18 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] dma-fence: use-after-free on extern_lock in dma_fence_driver_n=
ame()
- [High] dma-fence: uninitialized locals in dma_fence_describe() when signa=
led
- [High] dma-fence: recursive spinlock deadlock via trace_dma_fence_destroy=
()
- [High] drm/i915: rq->lock ABBA deadlock in i915_request_show()
- [Low] dma-fence: stack VLAs in dma_fence and i915 fence name callers
- [Low] dma-fence: leftover rcu_read_lock() and outdated kernel-doc in name=
 helpers
--

commit 9ca3a4e9e4ca7aa50b6bddada4c64fc3ed8e2861
Author: Philipp Stanner <phasta@kernel.org>

dma-fence: Support unload for ops->get_XXX_name()

This commit replaces the RCU-protected return values of
dma_fence_driver_name() and dma_fence_timeline_name() with callers
passing destination buffers that are populated under the fence lock.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index e4350bce9cf9b..d473d4ea601a7 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -555,23 +555,22 @@ void dma_fence_release(struct kref *kref)
>  	struct dma_fence *fence =3D
>  		container_of(kref, struct dma_fence, refcount);
>  	const struct dma_fence_ops *ops =3D fence->ops;
> +	const unsigned short len =3D 64;
> +	char timeline[len];
> +	char driver[len];

[Severity: Low]
In C11/gnu11, a const-qualified variable is not an integer constant
expression, so does declaring timeline[len] and driver[len] create stack
VLAs that trigger compiler warnings (and build failures with CONFIG_WERROR
or CONFIG_DRM_I915_WERROR) under -Wvla-larger-than=3D1 in
scripts/Makefile.warn?

The same pattern appears in dma_fence_describe(), intel_gt_watchdog_work(),
i915_request_show(), and timer_i915_sw_fence_wake(). Also, in
dma_fence_release(), these buffers were moved out of the unlikely error
block to the top of the function.

> =20
> -	rcu_read_lock();
>  	trace_dma_fence_destroy(fence);

[ ... ]

> @@ -1017,23 +1015,20 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
>   */
>  void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
>  {
> -	const char __rcu *timeline =3D (const char __rcu *)"";
> -	const char __rcu *driver =3D (const char __rcu *)"";
> -	const char *signaled =3D "";
> -
> -	rcu_read_lock();
> +	const unsigned short len =3D 64;
> +	char timeline[len];
> +	char driver[len];
> +	char *signaled;
> =20
>  	if (!dma_fence_is_signaled(fence)) {
> -		timeline =3D dma_fence_timeline_name(fence);
> -		driver =3D dma_fence_driver_name(fence);
> +		dma_fence_timeline_name(fence, timeline, len);
> +		dma_fence_driver_name(fence, driver, len);
>  		signaled =3D "un";
>  	}
> =20
>  	seq_printf(seq, "%llu:%llu %s %s %ssignalled\n",
>  		   fence->context, fence->seqno, timeline, driver,
>  		   signaled);
> -
> -	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(dma_fence_describe);

[Severity: High]
What happens in dma_fence_describe() when dma_fence_is_signaled(fence)
returns true?

Previously, timeline, driver, and signaled were initialized to "" at
declaration. Now they are only assigned inside the
if (!dma_fence_is_signaled(fence)) block. When the fence is already
signaled, won't seq_printf() dereference the uninitialized stack pointer
signaled and read the uninitialized stack arrays timeline and driver?

Also, if the fence signals concurrently right after
!dma_fence_is_signaled(fence) evaluates to true,
dma_fence_timeline_name() and dma_fence_driver_name() will populate
"signaled-timeline" and "detached-driver" while signaled is set to "un".

> @@ -1129,20 +1124,22 @@ EXPORT_SYMBOL(dma_fence_init64);
>   * memory potentially accessed by the &dma_fence.ops functions, is forbi=
dden
>   * after the fence has been signalled. Drivers are allowed to free that =
data,
>   * and some do.
> - *
> - * To allow safe access drivers are mandated to guarantee a RCU grace pe=
riod
> - * between signalling the fence and freeing said data.
> - *
> - * As such access to the driver name is only valid inside a RCU locked s=
ection.
> - * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block =
guarded
> - * by the &rcu_read_lock and &rcu_read_unlock pair.
>   */
> -const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
> +void dma_fence_driver_name(struct dma_fence *fence, char *s, unsigned sh=
ort len)
>  {
> +	unsigned long flags;
> +	const char *tmp;
> +
> +	dma_fence_lock_irqsave(fence, flags);
> +
>  	if (!dma_fence_test_signaled_flag(fence))
> -		return (const char __rcu *)fence->ops->get_driver_name(fence);
> +		tmp =3D fence->ops->get_driver_name(fence);
>  	else
> -		return (const char __rcu *)"detached-driver";
> +		tmp =3D "detached-driver";
> +
> +	strscpy(s, tmp, len);
> +
> +	dma_fence_unlock_irqrestore(fence, flags);
>  }
>  EXPORT_SYMBOL(dma_fence_driver_name);
> =20
> @@ -1158,19 +1155,21 @@ EXPORT_SYMBOL(dma_fence_driver_name);
>   * memory potentially accessed by the &dma_fence.ops functions, is forbi=
dden
>   * after the fence has been signalled. Drivers are allowed to free that =
data,
>   * and some do.
> - *
> - * To allow safe access drivers are mandated to guarantee a RCU grace pe=
riod
> - * between signalling the fence and freeing said data.
> - *
> - * As such access to the driver name is only valid inside a RCU locked s=
ection.
> - * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block =
guarded
> - * by the &rcu_read_lock and &rcu_read_unlock pair.
>   */
> -const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
> +void dma_fence_timeline_name(struct dma_fence *fence, char *s, unsigned =
short len)
>  {
> +	unsigned long flags;
> +	const char *tmp;
> +
> +	dma_fence_lock_irqsave(fence, flags);
> +
>  	if (!dma_fence_test_signaled_flag(fence))
> -		return (const char __rcu *)fence->ops->get_timeline_name(fence);
> +		tmp =3D fence->ops->get_timeline_name(fence);
>  	else
> -		return (const char __rcu *)"signaled-timeline";
> +		tmp =3D "signaled-timeline";
> +
> +	strscpy(s, tmp, len);
> +
> +	dma_fence_unlock_irqrestore(fence, flags);
>  }
>  EXPORT_SYMBOL(dma_fence_timeline_name);

[Severity: Critical]
Is it safe for dma_fence_driver_name() and dma_fence_timeline_name() to
unconditionally acquire dma_fence_lock_irqsave(fence, flags) before
checking if the fence is already signaled?

As noted in the kernel-doc comment above these functions, external memory
not embedded in struct dma_fence (including fence->extern_lock) must not
be accessed after the fence has signaled because drivers are allowed to
free the structure containing the lock once the fence is signaled:

  drivers/gpu/drm/panthor/panthor_sched.c:group_free_queue()
    dma_fence_put(queue->fence_ctx.last_fence);
    kfree(queue); /* frees queue->fence_ctx.lock */

  drivers/gpu/drm/msm/msm_fence.c:msm_fence_context_free()
    kfree(fctx); /* frees fctx->spinlock */

  drivers/gpu/drm/xe/xe_hw_fence.c:xe_hw_fence_irq_finish()
    synchronize_rcu(); /* before freeing irq containing irq->lock */

If a signaled fence is still held (for example in a sync_file) after the
driver frees the structure containing fence->extern_lock, and userspace
calls SYNC_IOC_FILE_INFO -> sync_fill_fence_info() ->
dma_fence_timeline_name(), won't dma_fence_lock_irqsave() dereference and
modify the freed spinlock?

[Severity: High]
Can acquiring dma_fence_lock_irqsave() inside dma_fence_driver_name() and
dma_fence_timeline_name() also cause a recursive spinlock deadlock when
trace_dma_fence_destroy is enabled?

In dma_fence_release(), trace_dma_fence_destroy(fence) is invoked when the
refcount drops to zero, which calls dma_fence_driver_name() and
dma_fence_timeline_name() in TP_fast_assign():

  dma_fence_put(fence)
    -> dma_fence_release()
      -> trace_dma_fence_destroy(fence)
        -> dma_fence_driver_name()
          -> dma_fence_lock_irqsave(fence, flags)

However, several paths in the kernel call dma_fence_put() while already
holding the fence's spinlock:

1. dma_fence_signal_timestamp_locked() holds dma_fence_spinlock(fence)
   while invoking callbacks such as dma_fence_chain_cb(), which calls
   dma_fence_put(f).

2. Drivers with shared external fence locks call dma_fence_put() while
   holding that lock, such as virtio_gpu_fence_event_process() (holding
   drv->lock), nouveau_fence_signal() (holding fctx->lock), and
   hw_fence_irq_run_cb() (holding irq->lock).

If the last reference is dropped on any of these paths while the
dma_fence_destroy tracepoint is active, won't dma_fence_lock_irqsave()
deadlock trying to acquire the already-held lock on the same CPU?

[Severity: Low]
Also, should the kernel-doc comments for dma_fence_driver_name() and
dma_fence_timeline_name() in drivers/dma-buf/dma-fence.c be updated to
document the new @s and @len parameters and void return, as well as the
get_driver_name and get_timeline_name comments in struct dma_fence_ops in
include/linux/dma-fence.h (which still state that the returned string is
RCU protected) and the leftover rcu_read_lock() wrappers around
trace_dma_fence_wait_start() and trace_dma_fence_wait_end() in
dma_fence_wait_timeout()?

> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> index 2166bbdf7e4a4..0f08713b3b5e2 100644
> --- a/drivers/dma-buf/sync_file.c
> +++ b/drivers/dma-buf/sync_file.c

[ ... ]

> @@ -268,19 +269,11 @@ static long sync_file_ioctl_merge(struct sync_file =
*sync_file,
>  static int sync_fill_fence_info(struct dma_fence *fence,
>  				 struct sync_fence_info *info)
>  {
> -	const char __rcu *timeline;
> -	const char __rcu *driver;
> +	dma_fence_timeline_name(fence, info->obj_name, sizeof(info->obj_name));
> +	dma_fence_driver_name(fence, info->driver_name, sizeof(info->driver_nam=
e));
> =20
>  	rcu_read_lock();
> =20
> -	driver =3D dma_fence_driver_name(fence);
> -	timeline =3D dma_fence_timeline_name(fence);
> -
> -	strscpy(info->obj_name, rcu_dereference(timeline),
> -		sizeof(info->obj_name));
> -	strscpy(info->driver_name, rcu_dereference(driver),
> -		sizeof(info->driver_name));
> -
>  	info->status =3D dma_fence_get_status(fence);
>  	info->timestamp_ns =3D
>  		dma_fence_is_signaled(fence) ?

[Severity: Low]
In sync_fill_fence_info(), now that dma_fence_timeline_name() and
dma_fence_driver_name() have been moved outside the RCU critical section,
is the remaining rcu_read_lock() / rcu_read_unlock() pair around
dma_fence_get_status() and dma_fence_is_signaled() still needed?

> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i=
915_request.c
> index f66f8efc70629..ce9aff50c0885 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -2183,7 +2183,8 @@ void i915_request_show(struct drm_printer *m,
>  		       const char *prefix,
>  		       int indent)
>  {
> -	const char __rcu *timeline;
> +	const unsigned short len =3D 64;
> +	char timeline[len];
>  	char buf[80] =3D "";
>  	int x =3D 0;
> =20
> @@ -2219,8 +2220,7 @@ void i915_request_show(struct drm_printer *m,
> =20
>  	x =3D print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
> =20
> -	rcu_read_lock();
> -	timeline =3D dma_fence_timeline_name((struct dma_fence *)&rq->fence);
> +	dma_fence_timeline_name((struct dma_fence *)&rq->fence, timeline, len);
>  	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
>  		   prefix, indent, "                ",
>  		   queue_status(rq),
> @@ -2229,8 +2229,7 @@ void i915_request_show(struct drm_printer *m,
>  		   fence_status(rq),
>  		   buf,
>  		   jiffies_to_msecs(jiffies - rq->emitted_jiffies),
> -		   rcu_dereference(timeline));
> -	rcu_read_unlock();
> +		   timeline);
>  }
> =20
>  static bool engine_match_ring(struct intel_engine_cs *engine, struct i91=
5_request *rq)

[Severity: High]
Does calling dma_fence_timeline_name() in i915_request_show() introduce a
lock ordering inversion between rq->lock and sched_engine->lock (or
ce->guc_state.lock)?

Each i915_request initializes rq->fence with &rq->lock. During request
signaling in i915_request_retire() and signal_irq_work(), rq->lock is held
while invoking fence callbacks:

  i915_request_retire() / signal_irq_work() [holds rq->lock]
    -> dma_fence_signal_locked(&rq->fence)
      -> dma_i915_sw_fence_wake()
        -> submit_notify()
          -> execlists_submit_request() [acquires sched_engine->lock]
          -> guc_submit_request() [acquires ce->guc_state.lock]

However, i915_request_show() is called while holding sched_engine->lock or
ce->guc_state.lock in paths such as:

  intel_execlists_show_requests() / intel_execlists_dump_active_requests() =
[holds sched_engine->lock]
    -> i915_request_show()
      -> dma_fence_timeline_name() [acquires rq->lock]

  intel_guc_dump_active_requests() [holds ce->guc_state.lock]
    -> intel_engine_dump_active_requests()
      -> engine_dump_request()
        -> i915_request_show()
          -> dma_fence_timeline_name() [acquires rq->lock]

Can this cause an AB-BA deadlock when engine state is dumped concurrently
with request retirement or breadcrumb signaling?

[ ... ]

> diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_=
fence.h
> index 5b10a9e06fb4e..f3b929b98cf42 100644
> --- a/include/trace/events/dma_fence.h
> +++ b/include/trace/events/dma_fence.h
> @@ -9,6 +9,8 @@
> =20
>  struct dma_fence;
> =20
> +#define FENCE_NAME_LEN 64
> +
>  DECLARE_EVENT_CLASS(dma_fence,
> =20
>  	TP_PROTO(struct dma_fence *fence),
> @@ -16,21 +18,21 @@ DECLARE_EVENT_CLASS(dma_fence,
>  	TP_ARGS(fence),
> =20
>  	TP_STRUCT__entry(
> -		__string(driver, dma_fence_driver_name(fence))
> -		__string(timeline, dma_fence_timeline_name(fence))
> +		__array(char, driver, FENCE_NAME_LEN)
> +		__array(char, timeline, FENCE_NAME_LEN)
>  		__field(unsigned int, context)
>  		__field(unsigned int, seqno)
>  	),
> =20
>  	TP_fast_assign(
> -		__assign_str(driver);
> -		__assign_str(timeline);
> +		dma_fence_driver_name(fence, __entry->driver, FENCE_NAME_LEN);
> +		dma_fence_timeline_name(fence, __entry->timeline, FENCE_NAME_LEN);
>  		__entry->context =3D fence->context;
>  		__entry->seqno =3D fence->seqno;
>  	),

[Severity: High]
As noted above in dma_fence_driver_name(), calling dma_fence_driver_name()
and dma_fence_timeline_name() inside TP_fast_assign() acquires the fence
spinlock during trace_dma_fence_destroy(fence), which can deadlock when
dma_fence_put() is called under the fence lock.

> =20
>  	TP_printk("driver=3D%s timeline=3D%s context=3D%u seqno=3D%u",
> -		  __get_str(driver), __get_str(timeline), __entry->context,
> +		  __entry->driver, __entry->timeline, __entry->context,
>  		  __entry->seqno)
>  );
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020100034.7591=
83-2-phasta@kernel.org?part=3D3
