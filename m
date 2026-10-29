Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97405606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYuayyOq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B629610FEF4;
	Thu, 29 Oct 2026 02:09:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CC610E17F;
 Thu, 29 Oct 2026 02:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27089600D1;
 Thu, 29 Oct 2026 02:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1EB1F01825;
 Thu, 29 Oct 2026 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793239762;
 bh=pnIY/vaY0r0NtR9vXgq6JvHe2lnMIHx6XQ1SP11K9mY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UYuayyOqI6VZ0cF9iq5CrccC0h/0YbocO6HHpnIW+hotTUVYHWadAMrtvKb2sWer6
 Y0xd0XxeeN8dDxRdKEzHlBnaK66YtsPvkRgvyU/adXOYRozul7/pDgfugbAUDgjPab
 yx4W6SL7kEfcmAlG/5Loo+kzM/xNZJGG4w85aDpIYIhdR/zIpAS9YZo3Nds6lDPQbH
 CAPXNd7rmnu9SnZTIilSfdoBU0bGEsTLLT6X7yDDtg16Cu/hjF7OqPPmY1P8ALE9Uc
 1ekgkRZfwTcNnMJiafI1OHCxWjor05sxtWQN2QJPFWDclpd1N9Lr4xlv70UKA0TUQo
 Bt1Zqkag/9rCQ==
Message-ID: <sashiko-outbox-188631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/5] drm/i915/selftests: Port GT-dependent selftests to
 work with multi-GT (low-hanging fruits part 1)
To: "Krzysztof Niemiec" <krzysztof.niemiec@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261029014155.55865-2-krzysztof.niemiec@intel.com>
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
 <20261029014155.55865-2-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 02:09:22 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/i915/selftests: hang_init() uses UABI-only GT0 context in mu=
lti-GT loop
- [Medium] drm/i915/selftests: GT mismatch in selftest_execlists spinner co=
ntexts
- [Medium] drm/i915/selftests: missing gsi_offset in __live_rc6_ctx() on me=
dia GT
--

commit 39fe8a3841172dae27e66c85ef1663181f7d0e43
Author: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

drm/i915/selftests: Port GT-dependent selftests to work with multi-GT (low-=
hanging fruits part 1)

This patch wraps several GT-dependent live and performance selftest suites =
in
for_each_gt() loops so that they run against all GTs present on the system
rather than only the primary GT.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/d=
rm/i915/gt/selftest_execlists.c
> index 21e5ed9f72a30..ddf71b3784bf7 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -4495,12 +4495,21 @@ int intel_execlists_live_selftests(struct drm_i91=
5_private *i915)
>  		SUBTEST(live_virtual_slice),
>  		SUBTEST(live_virtual_reset),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
> =20
> -	if (to_gt(i915)->submission_method !=3D INTEL_SUBMISSION_ELSP)
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (gt->submission_method !=3D INTEL_SUBMISSION_ELSP)
> +			continue;
> =20
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +		if (intel_gt_is_wedged(gt))
> +			continue;
> =20
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err =3D intel_gt_live_subtests(tests, gt);

[Severity: Medium]
When intel_execlists_live_selftests() runs on a secondary GT where
gt !=3D to_gt(i915), won't several preemption subtests trigger a GEM_BUG_ON=
()
in igt_spinner_create_request()?

Specifically, live_preempt(), live_late_preempt(), live_preempt_timeout(),
and preempt_client_init() (used by live_nopreempt(), live_preempt_cancel(),
live_suppress_self_preempt(), and live_chain_preempt()) create GEM contexts
with a NULL vm while initializing their spinners on gt:

drivers/gpu/drm/i915/gt/selftest_execlists.c:live_preempt() {
	...
	ctx_hi =3D kernel_context(gt->i915, NULL);
	if (!ctx_hi)
		return -ENOMEM;
	ctx_hi->sched.priority =3D I915_CONTEXT_MAX_USER_PRIORITY;

	ctx_lo =3D kernel_context(gt->i915, NULL);
	if (!ctx_lo)
		goto err_ctx_hi;
	ctx_lo->sched.priority =3D I915_CONTEXT_MIN_USER_PRIORITY;

	if (igt_spinner_init(&spin_hi, gt))
		goto err_ctx_lo;
	...
}

When kernel_context(gt->i915, NULL) calls i915_gem_create_context() with
pc->vm =3D=3D NULL, the context VM is created on to_gt(i915) rather than gt:

drivers/gpu/drm/i915/gem/i915_gem_context.c:i915_gem_create_context() {
	...
	if (pc->vm) {
		vm =3D i915_vm_get(pc->vm);
	} else if (HAS_FULL_PPGTT(i915)) {
		struct i915_ppgtt *ppgtt;

		ppgtt =3D i915_ppgtt_create(to_gt(i915), 0);
	...
}

When those subtests then call
spinner_create_request() -> igt_spinner_create_request(spin, ce, arb),
spin->gt is gt while ce->vm->gt is to_gt(i915), hitting:

drivers/gpu/drm/i915/selftests/igt_spinner.c:igt_spinner_create_request() {
	...
	GEM_BUG_ON(spin->gt !=3D ce->vm->gt);
	...
}

> diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i=
915/gt/selftest_gt_pm.c
> index 07eaf71955c44..09c0c4096665a 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
> @@ -205,9 +205,18 @@ int intel_gt_pm_late_selftests(struct drm_i915_priva=
te *i915)
>  		 */
>  		SUBTEST(live_rc6_ctx_wa),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
> =20
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
> =20
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err =3D intel_gt_live_subtests(tests, gt);

[Severity: Medium]
Now that intel_gt_pm_late_selftests() runs live_rc6_ctx_wa() on every GT,
does __live_rc6_ctx() read the wrong MMIO offset when executing on a
standalone media GT?

In drivers/gpu/drm/i915/gt/selftest_rc6.c, __live_rc6_ctx() emits an
MI_STORE_REGISTER_MEM command for GEN8_RC6_CTX_INFO without adding
ce->engine->gt->uncore->gsi_offset:

drivers/gpu/drm/i915/gt/selftest_rc6.c:__live_rc6_ctx() {
	...
	*cs++ =3D cmd;
	*cs++ =3D i915_mmio_reg_offset(GEN8_RC6_CTX_INFO);
	*cs++ =3D ce->timeline->hwsp_offset + 8;
	*cs++ =3D 0;
	...
}

On platforms with a standalone media GT (where uncore->gsi_offset is
0x380000), won't the media engine command streamer read the primary GT's
GEN8_RC6_CTX_INFO register at 0x8504 instead of the media GT's register at
0x388504?

> diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/d=
rm/i915/gt/selftest_hangcheck.c
> index 53f3ce5c33a47..d67a6d75c56a4 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> @@ -2016,21 +2016,27 @@ int intel_hangcheck_live_selftests(struct drm_i91=
5_private *i915)
>  		SUBTEST(igt_reset_evict_fence),
>  		SUBTEST(igt_handle_error),
>  	};
> -	struct intel_gt *gt =3D to_gt(i915);
>  	intel_wakeref_t wakeref;
> +	struct intel_gt *gt;
> +	unsigned int id;
>  	int err;
> =20
> -	if (!intel_has_gpu_reset(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (!intel_has_gpu_reset(gt))
> +			continue;
> =20
> -	if (intel_gt_is_wedged(gt))
> -		return -EIO; /* we're long past hope of a successful reset */
> +		if (intel_gt_is_wedged(gt))
> +			return -EIO; /* we're long past hope of a successful reset */
> =20
> -	wakeref =3D intel_runtime_pm_get(gt->uncore->rpm);
> +		wakeref =3D intel_runtime_pm_get(gt->uncore->rpm);
> =20
> -	err =3D intel_gt_live_subtests(tests, gt);
> +		err =3D intel_gt_live_subtests(tests, gt);

[Severity: Medium]
Can running intel_hangcheck_live_selftests() across all GTs cause subtests
such as igt_hang_sanitycheck(), igt_reset_active_engine(),
igt_reset_engines(), and igt_reset_queue() to fail with -EINVAL on secondary
GTs that have non-UABI engines like GSC0?

In drivers/gpu/drm/i915/gt/selftest_hangcheck.c, hang_init() sets up h->ctx
via kernel_context(gt->i915, NULL):

drivers/gpu/drm/i915/gt/selftest_hangcheck.c:hang_init() {
	...
	h->ctx =3D kernel_context(gt->i915, NULL);
	if (IS_ERR(h->ctx))
		return PTR_ERR(h->ctx);
	...
}

Because vm is NULL, i915_gem_create_context() allocates h->ctx->vm on
to_gt(i915) instead of gt, and populates h->ctx->engines via
default_engines() using only for_each_uabi_engine(). Non-UABI engines such =
as
GSC0 on the standalone media GT (which has uabi_class =3D=3D I915_NO_UABI_C=
LASS)
are skipped in intel_engines_driver_register(), leaving engine->legacy_idx =
as
INVALID_ENGINE (-1).

When the hangcheck subtests iterate over all engines on the GT with
for_each_engine(engine, gt, id) and call hang_create_request(&h, engine) on
GSC0:

drivers/gpu/drm/i915/gt/selftest_hangcheck.c:hang_create_request() {
	...
	rq =3D igt_request_alloc(h->ctx, engine);
	if (IS_ERR(rq)) {
		err =3D PTR_ERR(rq);
		goto unpin_hws;
	}
	...
}

igt_request_alloc() looks up engine->legacy_idx in h->ctx:

drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c:igt_request_alloc() {
	...
	ce =3D i915_gem_context_get_engine(ctx, engine->legacy_idx);
	if (IS_ERR(ce))
		return ERR_CAST(ce);
	...
}

Should hang_init() pass gt->vm to kernel_context(), and should the hangcheck
subtests either create per-engine contexts on gt or skip engines that are n=
ot
populated in h->ctx?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029014155.5586=
5-1-krzysztof.niemiec@intel.com?part=3D1
