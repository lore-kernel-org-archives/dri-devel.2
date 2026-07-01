Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448B9C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8463210EE38;
	Wed,  1 Jul 2026 08:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E4IsbmzJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D148A10EE38
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:11:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02FD8601D7;
 Wed,  1 Jul 2026 08:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC911F00A3A;
 Wed,  1 Jul 2026 08:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782893504;
 bh=Vj+koLo+XVoR5/GWndGB2vgIKO6NuwjAsmqDqsrMnPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E4IsbmzJ73ZZs4AfAWFru1T1MqWJM9up6+6V/uOMfBSrJE04RQ8dL3gB/B2ROIILW
 gPQXb/c/dwYMiz2Ca06SSrbKOpv5h7YFbS4vOJPjKHMtJ7hPeHzALIHd9u7z6YL5Hg
 BiyQwLJLtrCdrWdxNhFYnMpEhHA9NEx7cqwBdO7jHM7c0yD9HdFe50dMpO1YIESS5C
 tHx1Ca6LXjCw9QF4yQJElIwIo5qIWndmpQ7fT+ojhUup08QsYdxeocEk4OpLIPOFXm
 +7RoJ/KDdixMi+I9n+KxyL62Z1ruhMjZ+3lG89UDEZK9bDjSBabub8D6lIRzxNGhdS
 eXpC5x6eTQDzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
To: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
References: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:11:43 +0000
Message-Id: <20260701081144.8EC911F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `user_engines()` function incorrectly applies the SSEU configu=
ration of the first engine (`pe[0]`) to all engines being created, allowing=
 unprivileged userspace to trigger a kernel warning.
- [High] Unhandled error path in `set_proto_ctx_engines()` leaks dynamicall=
y allocated `siblings` arrays when an extension chain fails.
- [High] Unconditional intel_runtime_pm_get() in proto_context_set_protecte=
d() leaks runtime PM wakerefs if I915_CONTEXT_PARAM_PROTECTED_CONTENT is se=
t multiple times.
--

commit 2f8b7b6ff36e141ab796af7361b851e23a041b50
Author: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU

This commit fixes a NULL pointer dereference when setting context engine
slot N to I915_ENGINE_CLASS_INVALID or I915_ENGINE_CLASS_INVALID_NONE
and then attempting to apply I915_CONTEXT_PARAM_SSEU to that same slot.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.c
> index aeafe1742d308..347d1f2c05f50 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -850,7 +850,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_pr=
ivate *fpriv,
>  		pe =3D &pc->user_engines[idx];
> =20
>  		/* Only render engine supports RPCS configuration. */
> -		if (pe->engine->class !=3D RENDER_CLASS)
> +		if (!pe->engine || pe->engine->class !=3D RENDER_CLASS)
>  			return -EINVAL;
> =20
>  		sseu =3D &pe->sseu;

[Severity: High]
This isn't a bug introduced by this patch, but looking at user_engines()
in the same file, does it incorrectly apply the first engine's SSEU
configuration to all context engines?

If userspace creates a context with a RENDER engine at index 0 and a
non-RENDER engine at index 1, and sets the SSEU configuration for the
RENDER engine:

drivers/gpu/drm/i915/gem/i915_gem_context.c:user_engines()
    ...
    ret =3D intel_context_set_gem(ce, ctx, pe->sseu);
    ...

It appears user_engines() passes pe->sseu (which evaluates to pe[0].sseu)
instead of pe[n].sseu to intel_context_set_gem().

Since pe[0].sseu.slice_mask is non-zero, will intel_context_set_gem()
evaluate WARN_ON(ce->engine->class !=3D RENDER_CLASS) to true for the
non-RENDER engine and trigger a kernel warning?

[Severity: High]
This is a pre-existing issue, but does the error path in
set_proto_ctx_engines() leak memory?

If userspace submits a I915_CONTEXT_PARAM_ENGINES parameter with an
extension chain containing a valid load balance or parallel submit
extension, memory is dynamically allocated and assigned to
set->engines[idx].siblings.

If a subsequent extension in the chain fails:

drivers/gpu/drm/i915/gem/i915_gem_context.c:set_proto_ctx_engines()
    ...
    if (err) {
            kfree(set.engines);
            return err;
    }
    ...

The error handler frees set.engines, but is it missing a cleanup for the
dynamically allocated siblings arrays inside set.engines[idx]?

[Severity: High]
This is a pre-existing issue, but can proto_context_set_protected() leak
runtime PM wakerefs?

If userspace chains multiple extensions setting
I915_CONTEXT_PARAM_PROTECTED_CONTENT to 1 in a single context creation
call:

drivers/gpu/drm/i915/gem/i915_gem_context.c:proto_context_set_protected()
    ...
    pc->pxp_wakeref =3D intel_runtime_pm_get(&i915->runtime_pm);
    ...

The function unconditionally calls intel_runtime_pm_get() and overwrites
the pc->pxp_wakeref tracker cookie. When the context is closed,
intel_runtime_pm_put() is only called once.

Could this permanently leak all previous references and prevent the GPU
from entering runtime suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701075555.5214=
2-1-joonas.lahtinen@linux.intel.com?part=3D1
