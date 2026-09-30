Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497FDCA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724F710F1E4;
	Wed, 30 Sep 2026 17:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cizgxzbg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770E610F1D6;
 Wed, 30 Sep 2026 17:25:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9830601DE;
 Wed, 30 Sep 2026 17:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E71F000FF;
 Wed, 30 Sep 2026 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790789144;
 bh=sp41OETltS+I0mLnuMRUftFcjWT8kPhvhFsmitMZgj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CizgxzbgE7hDMtqDs3tYbjRDrMxngPQe+3gea9vKg+hdsko4SFOm7kgQGNb4ftFXE
 ZAf/RI2yW8r3kBElgaF/b0t68bq6RlkP/bAO9RubGm6plVIc+RlGPjoxscvcDZ4Azo
 G7oc+uKnvU/Ig57HiuBIC2r7uTIqoefDIy7QIbJwpUxal/6IFNGDOQzdpUDi3x00qs
 UMrqlwF+wKecJrx9d4EA9enPFTGCh4N3/Q4bRl52O2R5jQpVLCK5dgjts0GfYrwnLn
 qnu7h5Q+OtLAhHrGG5SaSqwBICgQidCSFUGaLLrcLYI213d6Wg6F96C7lvFMhptarb
 EPSuHCc2uBROA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] drm/i915/dg2: Add per-client control for
 Wa_22013059131
To: "Jia Yao" <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260930171334.3636-1-jia.yao@intel.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260930171334.3636-1-jia.yao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:25:43 +0000
Message-Id: <20260930172544.3A1E71F000FF@smtp.kernel.org>
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
- [Medium] drm/i915/dg2: kernel contexts clear Wa_22013059131 in LSC_CHICKE=
N_BIT_0
--

commit 4fe69a30e73450cf67244b9e1360470b774fd0a5
Author: Jia Yao <jia.yao@intel.com>

drm/i915/dg2: Add per-client control for Wa_22013059131

Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
at engine init, but this is known to cause GPU hangs in certain workloads.
Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
kernel know bit 15 programming is not needed.

Link: https://github.com/intel/compute-runtime/pull/919

> diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i9=
15/gt/intel_context.c
> --- a/drivers/gpu/drm/i915/gt/intel_context.c
> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
> @@ -80,6 +81,7 @@ int intel_context_alloc_state(struct intel_context *ce)
>  			if (ctx->client)
>  				i915_drm_client_add_context_objects(ctx->client,
>  								    ce);
> +			lrc_latch_wa_22013059131(ce, ctx);

[Severity: Medium]
Since lrc_latch_wa_22013059131() in intel_context_alloc_state() is only cal=
led=20
when ctx is not NULL, what happens for kernel-internal contexts where=20
ce->gem_context is NULL?

If the latch function is skipped, CONTEXT_WA_22013059131_APPLY remains unse=
t=20
(0). Does this mean the kernel context will execute with the=20
FORCE_1_SUB_MESSAGE_PER_FRAGMENT workaround disabled?

>  			i915_gem_context_put(ctx);
>  		}
>  	}
> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/g=
t/intel_lrc.c
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c

[ ... ]

> +static u32 *
> +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
> +{
> +	/*
> +	 * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
> +	 * other bits of the register will also get overwritten.  The
> +	 * hardware default for all other bits is 0, but any workarounds
> +	 * that adjust the other bits in the lower dword of the register
> +	 * also need to be re-applied here.  At the moment that's just
> +	 * Wa_22014226127, which is always set for DG2-G11 platforms.
> +	 */
> +	u32 val =3D DISABLE_D8_D16_COASLESCE;
> +
> +	if (test_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags))
> +		val |=3D FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
> +
> +	*cs++ =3D MI_LOAD_REGISTER_IMM(1);
> +	*cs++ =3D i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> +	*cs++ =3D val;

[Severity: Medium]
If CONTEXT_WA_22013059131_APPLY is unset for kernel contexts, this will
unconditionally emit a write that clears FORCE_1_SUB_MESSAGE_PER_FRAGMENT
in the hardware register.

The commit message indicates that "Kernel-internal context will not change
workaround settings", but it appears this code clears the workaround during
kernel context execution. Could this expose the kernel context to the GPU
hangs the workaround is meant to prevent?

> +
> +	return cs;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930171334.3636=
-1-jia.yao@intel.com?part=3D1
