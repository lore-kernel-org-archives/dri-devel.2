Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA33ACDE010
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7AFA10E304;
	Fri, 26 Jun 2026 05:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXioAr4b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9382E10E301
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:37:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5881A4430F;
 Fri, 26 Jun 2026 05:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186481F00A3A;
 Fri, 26 Jun 2026 05:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782452243;
 bh=3L9kUMFvkcsEwXd1FMeno5feXTAes1pulqJgLgUwPnw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VXioAr4bBSEys1YvqtmFTQbC7bfVJQwXTQTsktQ2lrPHUiDmjuUH/KfgCykKaix4A
 fuJOBY0SLIIVa2YFArsaYsiM6Cug5urjAGpu5stqCNgZY6ruXVbjAM+nig9/vAOLrU
 Lc8VFe+TYD71jc1uwOxIREcdpAmunNdpVwnT5114EnOoVbTggbnlJXpfzXqAV7PhYz
 3lifZ49vka1YfS0PDa6ts7YkpYw2VDvey0PkVNcBE9RvhqXp6uhgnbzO4uE6ZbfsVc
 iDIumFFrnX+neKEWTF4kNffgOvdkdRcn/qv5opwPqf4SAmfV2YJv1qpINgu6ANxLCf
 GyoF0GOWEAYVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] drm/i915/dg2: Add per-context control for
 Wa_22013059131
To: "Jia Yao" <jia.yao@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626052551.1327022-1-jia.yao@intel.com>
References: <20260626052551.1327022-1-jia.yao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:37:22 +0000
Message-Id: <20260626053723.186481F00A3A@smtp.kernel.org>
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
- [High] Race condition between concurrent engines due to per-context toggl=
ing of shared global MCR register `LSC_CHICKEN_BIT_0`.
- [High] Invalid cross-domain hardware programming by unconditionally emitt=
ing Render/Compute workaround on Video (VCS) and Copy (BCS) engines.
--

commit 77b4f585118e5a808b879e93ddf1a2f08c7c13c1
Author: Jia Yao <jia.yao@intel.com>
Subject: drm/i915/dg2: Add per-context control for Wa_22013059131

This commit introduces a per-context control for Wa_22013059131, which
toggles FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0 at engine
init. It adds I915_CONTEXT_PARAM_WA_22013059131 to allow userspace to
manage the workaround itself, skipping the bit 15 programming.
LSC_CHICKEN_BIT_0 is dynamically rewritten on every context switch to
avoid leaking state between contexts.

Link: https://github.com/intel/compute-runtime/pull/919

> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/g=
t/intel_lrc.c
> index 147d22907960b..13344ebb847ec 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
[ ... ]
> @@ -1348,6 +1348,37 @@ gen12_invalidate_state_cache(u32 *cs)
>  	return cs;
>  }
> =20
> +static u32 *
> +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
> +{
[ ... ]
> +	if (rcu_access_pointer(ce->gem_context) &&
> +	    !test_bit(CONTEXT_WA_22013059131, &ce->flags)) {
> +		val |=3D FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
> +	}
> +
> +	*cs++ =3D MI_LOAD_REGISTER_IMM(1);
> +	*cs++ =3D i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> +	*cs++ =3D val;

[Severity: High]
Does dynamically overwriting LSC_CHICKEN_BIT_0 using MI_LOAD_REGISTER_IMM
during an engine-local context switch create a race condition?

Because LSC_CHICKEN_BIT_0 is a shared Multicast (MCR) register across the D=
SS,
concurrent engines (like RCS and CCS) execute independently. Would a context
switch on one engine clobber the workaround state of another context active=
ly
executing on a concurrent engine, leading to GPU hangs or workload corrupti=
on?

> +
> +	return cs;
> +}
> +
[ ... ]
> @@ -1387,7 +1422,13 @@ gen12_emit_indirect_ctx_xcs(const struct intel_con=
text *ce, u32 *cs)
>  						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
>  						    0);
> =20
> -	return gen12_emit_aux_table_inv(ce->engine, cs);
> +	cs =3D gen12_emit_aux_table_inv(ce->engine, cs);
> +
> +	/* Wa_22013059131:dg2 */
> +	if (IS_DG2_G11(ce->engine->i915))
> +		cs =3D dg2_g11_emit_wa_22013059131(ce, cs);

[Severity: High]
Does gen12_emit_indirect_ctx_xcs() incorrectly emit a Render/Compute regist=
er
write on Video (VCS) and Copy (BCS) engines?

Since gen12_emit_indirect_ctx_xcs() is called to build the indirect context
batch buffer for all non-Render engines, this unconditionally emits the
MI_LOAD_REGISTER_IMM to LSC_CHICKEN_BIT_0.

As LSC (Load/Store Cache) is part of the Xe-Core (Render/Compute domain),
Video and Blitter engines don't have access to this register domain. Will t=
his
invalid cross-domain hardware programming cause command exceptions, dropped
writes, or command streamer hangs?

Would it be better to add an engine class check here, such as
(ce->engine->class =3D=3D COMPUTE_CLASS)?

> +
> +	return cs;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626052551.1327=
022-1-jia.yao@intel.com?part=3D1
