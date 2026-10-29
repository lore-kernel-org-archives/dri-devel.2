Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63540606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6RjrfAK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AE610FECA;
	Thu, 29 Oct 2026 01:51:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF0610FECA;
 Thu, 29 Oct 2026 01:51:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2F7640829;
 Thu, 29 Oct 2026 01:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC411F01825;
 Thu, 29 Oct 2026 01:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793238668;
 bh=9FLRnWcPnz+Kd+94uiOQHxP9fhZKSyuISoi2tYrFQ6c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=V6RjrfAKPN44RhB0L5aDf8bbT8+YlvcY3GHgX7n8QfaOH68k4CU0NwBgXunKdfwfd
 gV8eI0bv1JHBrUja5CAL3vjBDLcmOFPxpwb5ybBcSTicaMIkWlCIt2CgBdazn0weNW
 gehcO5tg8ZStRgc2aT3/iX0+O7a9EndZMbBdXKO2mnh89F1yG63Vo9DReEAKzegXOE
 aZFXF47QvBRuquEx+bXTJFX4tco8Tne3nPLqwZHdErN/guU0j5Q8JyFGsxsEsbWCoy
 rTl2XhlJ4jypiYwMiic3ztT7CK1FVB2/8v5c8EkKB/ORVexMsuIp4vcugPEac+A6Rg
 kzyY+ZkLfFqsA==
Message-ID: <sashiko-outbox-188621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 5/5] drm/i915/selftests: Port selftests that access ggtt
 to work with multi-gt
To: "Krzysztof Niemiec" <krzysztof.niemiec@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261029014155.55865-6-krzysztof.niemiec@intel.com>
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
 <20261029014155.55865-6-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 01:51:08 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/i915/selftests: partial per-GT resume in igt_pm_resume()
- [Medium] drm/i915/selftests: wrong GGTT pinned in igt_vma_remapped_gtt()
--

commit 8db2f33415f217cdf07f8583781cb2c2c4d93d25
Author: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

drm/i915/selftests: Port selftests that access ggtt to work with multi-gt

This patch updates several i915 live selftests in i915_gem_client_blt.c,
i915_gem.c, and i915_vma.c to iterate over each GT via for_each_gt() and
intel_gt_live_subtests() instead of referencing to_gt(i915)->ggtt directly.

> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/=
i915/selftests/i915_gem.c
> index ad650f67114a6..8f72fd1af8d61 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem.c

[ ... ]

> @@ -99,29 +100,29 @@ static int igt_pm_prepare(struct drm_i915_private *i=
915)
>  	return 0;
>  }
> =20
> -static void igt_pm_suspend(struct drm_i915_private *i915)
> +static void igt_pm_suspend(struct intel_gt *gt)
>  {
>  	intel_wakeref_t wakeref;
> =20
> -	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
> -		i915_ggtt_suspend(to_gt(i915)->ggtt);
> -		i915_gem_suspend_late(i915);
> +	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
> +		i915_ggtt_suspend(gt->ggtt);
> +		i915_gem_suspend_late(gt->i915);
>  	}
>  }
> =20
> -static void igt_pm_hibernate(struct drm_i915_private *i915)
> +static void igt_pm_hibernate(struct intel_gt *gt)
>  {
>  	intel_wakeref_t wakeref;
> =20
> -	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
> -		i915_ggtt_suspend(to_gt(i915)->ggtt);
> +	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
> +		i915_ggtt_suspend(gt->ggtt);
> =20
> -		i915_gem_freeze(i915);
> -		i915_gem_freeze_late(i915);
> +		i915_gem_freeze(gt->i915);
> +		i915_gem_freeze_late(gt->i915);
>  	}
>  }
> =20
> -static void igt_pm_resume(struct drm_i915_private *i915)
> +static void igt_pm_resume(struct intel_gt *gt)
>  {
>  	intel_wakeref_t wakeref;
> =20
> @@ -129,17 +130,18 @@ static void igt_pm_resume(struct drm_i915_private *=
i915)
>  	 * Both suspend and hibernate follow the same wakeup path and assume
>  	 * that runtime-pm just works.
>  	 */
> -	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
> -		i915_ggtt_resume(to_gt(i915)->ggtt);
> -		if (GRAPHICS_VER(i915) >=3D 8)
> -			setup_private_pat(to_gt(i915));
> -		i915_gem_resume(i915);
> +	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
> +		i915_ggtt_resume(gt->ggtt);
> +		if (GRAPHICS_VER(gt->i915) >=3D 8)
> +			setup_private_pat(gt);
> +		i915_gem_resume(gt->i915);
>  	}
>  }

[Severity: Medium]
Does converting igt_gem_suspend() and igt_gem_hibernate() into per-GT
subtests via intel_gt_live_subtests() leave non-target GTs with
unconfigured private PAT registers and unresumed GGTT mappings while
device-wide GEM suspend and resume still reset and submit work to all GTs?

In igt_gem_suspend() and igt_gem_hibernate(), live_context(i915, file)
creates a context with engines across all GTs, and switch_to_context(ctx)
submits requests across every engine on all GTs.

Similarly, the GEM suspend/resume helpers operate across all GTs on the
device:

  igt_pm_prepare()
    -> i915_gem_suspend()
      -> for_each_gt() intel_gt_suspend_prepare(gt)
  igt_pm_suspend()
    -> i915_gem_suspend_late()
      -> for_each_gt() intel_gt_suspend_late(gt)
  igt_pm_resume()
    -> i915_gem_resume()
      -> for_each_gt() intel_gt_resume(gt)

However, igt_pm_suspend(), igt_pm_hibernate(), and igt_pm_resume() only
call i915_ggtt_suspend(gt->ggtt), i915_ggtt_resume(gt->ggtt), and
setup_private_pat(gt) on the single gt passed to the subtest. By contrast,
i915_drm_resume() in drivers/gpu/drm/i915/i915_driver.c programs the
private PAT for every GT before calling i915_gem_resume():

  for_each_gt(gt, dev_priv, i)
      if (GRAPHICS_VER(gt->i915) >=3D 8)
          setup_private_pat(gt);

On multi-GT platforms, sanitizing and resetting all GTs while only calling
setup_private_pat(gt) and i915_ggtt_resume(gt->ggtt) on one GT leaves the
other GTs without private PAT setup (and without GGTT/GuC mapping resume if
the GTs have separate GGTTs) when i915_gem_resume() and
switch_to_context(ctx) execute across all GTs.

In addition, running i915_gem_live_selftests() in a for_each_gt() loop via
intel_gt_live_subtests() only waits for idle on a single GT in
__intel_gt_live_setup() and redundantly runs the GT-independent
igt_gem_ww_ctx() test once per GT. Should i915_gem_live_selftests() remain
a device-level i915_live_subtests() run and iterate for_each_gt() inside
igt_pm_suspend(), igt_pm_hibernate(), igt_pm_resume(), and trash_stolen()
instead?

> diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/=
i915/selftests/i915_vma.c
> index fc068dab27f44..3231025a7b7fa 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_vma.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
> @@ -957,7 +957,8 @@ int i915_vma_mock_selftests(void)
> =20
>  static int igt_vma_remapped_gtt(void *arg)
>  {
> -	struct drm_i915_private *i915 =3D arg;
> +	struct intel_gt *gt =3D arg;
> +	struct drm_i915_private *i915 =3D gt->i915;
>  	const struct intel_remapped_plane_info planes[] =3D {
>  		{ .width =3D 1, .height =3D 1, .src_stride =3D 1 },
>  		{ .width =3D 2, .height =3D 2, .src_stride =3D 2 },
> @@ -990,7 +991,7 @@ static int igt_vma_remapped_gtt(void *arg)
>  	intel_wakeref_t wakeref;
>  	int err =3D 0;
> =20
> -	if (!i915_ggtt_has_aperture(to_gt(i915)->ggtt))
> +	if (!i915_ggtt_has_aperture(gt->ggtt))
>  		return 0;
> =20
>  	obj =3D i915_gem_object_create_internal(i915, 10 * 10 * PAGE_SIZE);

[Severity: Medium]
In igt_vma_remapped_gtt(), the aperture check is updated to inspect
gt->ggtt, but doesn't the body of the loop still pin into
to_gt(i915)->ggtt?

Later in igt_vma_remapped_gtt(), the object is pinned twice using
i915_gem_object_ggtt_pin():

  vma =3D i915_gem_object_ggtt_pin(obj, &view, 0, 0, PIN_MAPPABLE);
  ...
  vma =3D i915_gem_object_ggtt_pin(obj, NULL, 0, 0, PIN_MAPPABLE);

i915_gem_object_ggtt_pin() calls i915_gem_object_ggtt_pin_ww() with
ggtt =3D NULL, which defaults to to_gt(i915)->ggtt:

  drivers/gpu/drm/i915/i915_gem.c:i915_gem_object_ggtt_pin_ww() {
      struct drm_i915_private *i915 =3D to_i915(obj->base.dev);
      struct i915_ggtt *ggtt =3D to_gt(i915)->ggtt;

      if (_ggtt)
          ggtt =3D _ggtt;
      ...
  }

If a non-primary GT has its own GGTT, igt_vma_remapped_gtt() will still
bind and map through to_gt(i915)->ggtt (or fail with -E2BIG if
to_gt(i915)->ggtt has a smaller aperture than gt->ggtt). Should those two
calls use i915_gem_object_ggtt_pin_ww(obj, NULL, gt->ggtt, ...) so that
gt->ggtt is actually used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029014155.5586=
5-1-krzysztof.niemiec@intel.com?part=3D5
