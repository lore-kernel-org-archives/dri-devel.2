Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84C7C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3870A10F03C;
	Thu, 27 Aug 2026 13:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UBg9Ao6T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A3C10F033;
 Thu, 27 Aug 2026 13:11:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50ED0600D2;
 Thu, 27 Aug 2026 13:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43BB1F000E9;
 Thu, 27 Aug 2026 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836303;
 bh=LUSQUFJjoOqPn5JLbFG1AamK9d3GO4RWhRuFx1cXQ5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBg9Ao6Ta/9sHh5j2vVAZnX+FuSHuZDl7wEOSm12sUt7vOJal0jrn8Nqz/wnS28W/
 4eFll8xj4OXpfa4rpJf/7VjkoOlse5HJIn3uDbTWVq9kl3rc3zVP6xOkSx4reACA5w
 rJqpncj19XfNlco1m9kpuWfdt8HjjVhVqCSxHfmSS+hSkdmDvz06GEHrrpTz8ASUuI
 1EiE99Qjm123Kjt5CwuWBdoAP5IySinxx/uBYnwnH4afx7FKBHgu6lzAkdByuXCg3h
 FkMO894cVZFkpkmo8X8+OUo3WRYzqVNcN3xeMMvpjBniAuFclLWNZrp3I7WEgCwcf1
 pB/Nmd1LQMeMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] drm/i915/gt: Use dma_resv_alloc for VM
 reservation objects
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-9-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:11:42 +0000
Message-Id: <20260827131142.C43BB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double allocation of `dma_resv` causes a permanent memory leak bec=
ause `vm->_resv` is allocated twice and the first pointer is unconditionall=
y overwritten.
- [High] Calls to `i915_address_space_init()` ignore the new `-ENOMEM` erro=
r return value, leading to incomplete initialization and potential NULL poi=
nter dereferences.
--

commit 5239b0e3c5a536da51a7fa10affcf28e378bea31
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
drm/i915/gt: Use dma_resv_alloc for VM reservation objects

Replaces the embedded dma_resv object in struct i915_address_space with a
dynamically allocated pointer, returning int from initialization functions
to properly handle allocation failures.

> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/g=
t/intel_gtt.c
> index 7b1bdb121c88d..670cbe0b8cc05 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
> @@ -258,7 +258,7 @@ void i915_vm_release(struct kref *kref)
>  	queue_work(vm->i915->wq, &vm->release_work);
>  }
> =20
> -void i915_address_space_init(struct i915_address_space *vm, int subclass)
> +int i915_address_space_init(struct i915_address_space *vm, int subclass)
>  {

[Severity: High]
Does this change leave some callers unhandled? i915_address_space_init() now
returns an error code, but it appears some existing callers were not updated
to check the return value.=20

For instance, i915_dpt_create() in drivers/gpu/drm/i915/i915_dpt.c, as well
as the mock tests in drivers/gpu/drm/i915/selftests/mock_gtt.c, seem to ign=
ore
this return value. If dma_resv_alloc() fails under memory pressure, it could
leave vm->mm uninitialized and vm->_resv as NULL, which might lead to a pan=
ic
later when the Display Page Table is used.

[ ... ]

> @@ -295,7 +295,10 @@ void i915_address_space_init(struct i915_address_spa=
ce *vm, int subclass)
>  		might_alloc(GFP_KERNEL);
>  		mutex_release(&vm->mutex.dep_map, _THIS_IP_);
>  	}
> -	dma_resv_init(&vm->_resv);
> +
> +	vm->_resv =3D dma_resv_alloc();
> +	if (!vm->_resv)
> +		return -ENOMEM;

[Severity: High]
Could this unconditionally overwrite an already allocated vm->_resv pointer?

The callers ppgtt_init() and ggtt_probe_hw() explicitly allocate vm->_resv
before calling i915_address_space_init(), which then allocates it again her=
e.
This appears to cause a permanent memory leak of the first allocation on ev=
ery
successful VM initialization.

> =20
>  	GEM_BUG_ON(!vm->total);

[ ... ]

> diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915=
/gt/intel_ppgtt.c
> index 72d8473a448b9..9abd4faa2e550 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> @@ -315,9 +315,17 @@ void ppgtt_init(struct i915_ppgtt *ppgtt, struct int=
el_gt *gt,
>  	ppgtt->vm.total =3D BIT_ULL(RUNTIME_INFO(i915)->ppgtt_size);
>  	ppgtt->vm.lmem_pt_obj_flags =3D lmem_pt_obj_flags;
> =20
> -	dma_resv_init(&ppgtt->vm._resv);
> -	i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT);
> +	ppgtt->vm._resv =3D dma_resv_alloc();
> +	if (!ppgtt->vm._resv)
> +		return -ENOMEM;
> +
> +	if (i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT)) {
> +		dma_resv_put(ppgtt->vm._resv);
> +		return -ENOMEM;
> +	}

[Severity: High]
If i915_address_space_init() fails, does this leak the first allocation?

Inside i915_address_space_init(), if its own dma_resv_alloc() fails,
ppgtt->vm._resv is clobbered to NULL. When control returns here and
dma_resv_put() is called, it will be passing NULL, leaving the original
allocation leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D8
