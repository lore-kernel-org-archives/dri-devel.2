Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2744CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D8E10E153;
	Thu,  1 Oct 2026 11:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VObuAAiQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D559110E153;
 Thu,  1 Oct 2026 11:46:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 107F760A5F;
 Thu,  1 Oct 2026 11:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F21F00898;
 Thu,  1 Oct 2026 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790855217;
 bh=O9HPu+v9+wBog9bi9ISNUhwjTjMx5TMEZ/vPQ5YFebM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=VObuAAiQigL402sEg1PHo0WktvUqNB7A8ZhmfM1gh2ccG+gjPxn4b/crq/9AkMzeR
 d4h846WdBgOc7zopfg3x7q2gnXZALduWllV30fH++UI/rqCv+vf9LEYwSR0wIb55tJ
 UYDikfs4gSMgN4fdDHbFh9rARwlRQ23AcHnz0CLixwQ0sbBkzHSYHtgXlyYEgYF9QW
 YwLVixQgUl5lrZ0n+/tsUv6UxlwqmAZvMbdriTvfxrpyWdd7mFy1h4AIV+UNfX+C0K
 vF2N6imvTICUX+TYc/4aRfRLuayJxfXDkNX8F0T3q1YSliItfJI82JA3r8AfWk3FPF
 XxwpemWkOK1GQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 13:46:52 +0200
Message-Id: <DLTH6V7D5VNW.TD696VJNM98E@kernel.org>
Subject: Re: [PATCH 1/3] drm/gpuvm: allow locking external objects in two
 passes
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "David Airlie" <airlied@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <20260814073258.893007-2-matthew.brost@intel.com>
In-Reply-To: <20260814073258.893007-2-matthew.brost@intel.com>
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

On Fri Aug 14, 2026 at 9:32 AM CEST, Matthew Brost wrote:
> So let a driver set drm_gpuvm_exec::two_pass and have
> drm_gpuvm_exec_lock() acquire its locks in two steps:
>
>   DRM_GPUVM_EXEC_PASS_EARLY validates what the transaction already
>   holds. The GPUVM's own dma-resv is locked from the start, so that is
>   every private object, and the driver validates the evicted ones. The
>   pass also opportunistically locks the external objects which are
>   evicted, since those need validating anyway, and the driver validates
>   those too. The resident external objects are left unlocked, then
>
>   DRM_GPUVM_EXEC_PASS_LATE locks everything else, i.e. exactly what the
>   early pass left out. The driver validates anything which raced with
>   the early pass and does whatever needs every lock held, such as
>   attaching its job's fence.
>
> Both passes share one drm_exec transaction. The early pass keeps
> everything it locked and the late pass only ever adds to it, so there is
> no window in which another thread can undo the early pass' work, and no
> recheck or retry logic is needed. The extra.fn callback is invoked once
> per pass, with drm_gpuvm_exec::pass telling it which one it is in.
>
> Only the external objects are divided up like this. The passes have to
> agree on which objects belong to which, and the GPUVM's common dma-resv
> is what gives that, so it is held throughout.

That's a nice optimization!

> The early pass reads drm_gpuvm_bo::evicted without holding the object's
> dma-resv, that being the lock it is trying not to take. The race is
> benign: an object evicted just after being skipped is validated by the
> late pass instead, exactly as if it had been evicted a moment later
> still.

I only read this after I stumbled across this in the code below.  Leaving t=
his
as-is is still a data race per LKMM and I'd expect KCSAN to flag it.

In any case, please also add the corresponding WRITE_ONCE() as well as a co=
mment
that explains why in this specific case it is OK to read the value without =
the
dma-resv lock held and why ordering is not an issue.

> Two pass locking requires a DRM_GPUVM_RESV_PROTECTED drm_gpuvm.

This is unfortunate, I don't want to have any second class citizens.

That said, I think I can make nouveau switch to DRM_GPUVM_RESV_PROTECTED. W=
ith
this, only MSM is left, and it says

	* We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
	* makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
	* tracking that an extobj is evicted) :facepalm:

which is probably similar to why nouveau didn't do it in the first place. I
could have a look after LPC so we can get rid of !DRM_GPUVM_RESV_PROTECTED
entirely, which I think would be great.

> Assisted-by: GitHub_Copilot:claude-opus-5

Please use Assisted-by: LLM instead.

> +/**
> + * DOC: Two pass locking

I think this should say that this is about "preparing" objects and object
validation.

Maybe "GPUVM EXEC two-pass locking"?

> +static bool
> +drm_gpuvm_prepare_skip(struct drm_gpuvm_bo *vm_bo,
> +		       enum drm_gpuvm_exec_pass pass)
> +{
> +	drm_gpuvm_pass_assert_held(vm_bo->vm, pass);
> +
> +	switch (pass) {
> +	case DRM_GPUVM_EXEC_PASS_EARLY:
> +		vm_bo->lock_skipped =3D !READ_ONCE(vm_bo->evicted);

Ick! Not a huge fan of this, but I guess it makes sense. AFAICS this can ra=
ce
with drm_gpuvm_bo_evict() though.

> +int
> +drm_gpuvm_prepare_objects_pass(struct drm_gpuvm *gpuvm,
> +			       struct drm_exec *exec,
> +			       unsigned int num_fences,
> +			       enum drm_gpuvm_exec_pass pass)
> +{
> +	if (pass !=3D DRM_GPUVM_EXEC_PASS_ALL &&
> +	    drm_WARN_ON(gpuvm->drm, !drm_gpuvm_resv_protected(gpuvm)))

drm_WARN_ON_ONCE() seems to make more sense here.

> @@ -1360,6 +1603,10 @@ drm_gpuvm_exec_lock(struct drm_gpuvm_exec *vm_exec=
)
>  	unsigned int num_fences =3D vm_exec->num_fences;
>  	int ret;
> =20
> +	if (vm_exec->two_pass &&
> +	    drm_WARN_ON(gpuvm->drm, !drm_gpuvm_resv_protected(gpuvm)))

Same here...

> @@ -1422,6 +1680,9 @@ drm_gpuvm_exec_lock_array(struct drm_gpuvm_exec *vm=
_exec,
>  		unsigned int num_objs;
>  	} args;
> =20
> +	if (drm_WARN_ON(vm_exec->vm->drm, vm_exec->two_pass))

...and here.

> +int
> +drm_gpuvm_validate_pass(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
> +			enum drm_gpuvm_exec_pass pass)
>  {
>  	const struct drm_gpuvm_ops *ops =3D gpuvm->ops;
> =20
>  	if (unlikely(!ops || !ops->vm_bo_validate))
>  		return -EOPNOTSUPP;
> =20
> +	if (pass !=3D DRM_GPUVM_EXEC_PASS_ALL &&
> +	    drm_WARN_ON(gpuvm->drm, !drm_gpuvm_resv_protected(gpuvm)))

That's really a lot of !drm_gpuvm_resv_protected() checks needed. :(

> +bool
> +drm_gpuvm_has_evicted(struct drm_gpuvm *gpuvm, enum drm_gpuvm_exec_pass =
pass)

The name is a bit confusing, as the scope of the function is limited to an
exec_pass, but not the VM in general.

Even though a bit verbose, I think drm_gpuvm_exec_pass_has_evicted() is bet=
ter.
I'd probably also use the drm_gpuvm_exec_pass prefiy consistently for the
functions newly introduced for the feature.

> @@ -680,6 +799,18 @@ struct drm_gpuvm_bo {
>  	 */
>  	bool evicted;
> =20
> +	/**
> +	 * @lock_skipped: Indicates that the current &drm_exec transaction does
> +	 * not hold this &drm_gpuvm_bo's dma-resv, because
> +	 * %DRM_GPUVM_EXEC_PASS_EARLY skipped it as not needing validation.
> +	 * Unlike @evicted this is stable for the duration of a locking
> +	 * sequence, which is what makes it safe for drm_gpuvm_validate_pass()
> +	 * to key off, and what tells %DRM_GPUVM_EXEC_PASS_LATE which objects
> +	 * are still missing. Field protected the same way as the &drm_gpuvm's
> +	 * extobj list.
> +	 */
> +	bool lock_skipped;

That's a bit nasty, but it works and I can't think of a cleaner solution.
