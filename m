Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3018A10E2AD;
	Tue, 30 Jun 2026 22:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IWQb58ix";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AC810E2AD
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 22:53:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 175B86001D;
 Tue, 30 Jun 2026 22:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984AB1F000E9;
 Tue, 30 Jun 2026 22:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782860029;
 bh=8B3q/thG54EUfuEZ/08rJh6xLnB9H4fTaqPZ+inN2gI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IWQb58ixPyCL5W5FtmVBTEfP7J9cvedLN/UbqpKORYc42y6+eK4pTfDOOVVn7shsj
 aos2736jb4ncatGi+qvZgvdz08+lZ26EwLcHrUptIQBBrGYmB3R6mugp5U0FVNiiOx
 PTHcZ/MkSFwV8Ket+ME2rqPCUEISxHO0LkaUYLHDIrBL2ZX8lzt4YDKaBwhNB3QrDZ
 RFftQMCBTr803XPjt4NAF0+D1HGKVI+eClO6ovQJGbgpeKtruBuhX2y01Rrt3wDM1J
 cwnD9JmrHHfg45KUzJwy7NMcK2CklLfVPKb9LH/KyXpkMCyA8T/Izy9iUFXtISYpR1
 3ROAC+tAN3MqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
To: "Jia Yao" <jia.yao@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630223946.2107382-1-jia.yao@intel.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 22:53:49 +0000
Message-Id: <20260630225349.984AB1F000E9@smtp.kernel.org>
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
- [High] Dynamically modifying the globally shared MCR register LSC_CHICKEN=
_BIT_0 per-context causes a race condition when contexts execute concurrent=
ly on different engines, leading to L3 cache state corruption and GPU hangs.
--

commit aa5554c571fd6ea50b4b1d107d0ba27eeae18a7c
Author: Jia Yao <jia.yao@intel.com>

drm/i915/dg2: Add per-context control for Wa_22013059131

This commit introduces a per-context opt-out for Wa_22013059131 on DG2-G11
platforms, allowing userspace to manage LSC_CHICKEN_BIT_0 bit 15 itself.
It applies this workaround conditionally during indirect context batchbuffer
execution rather than globally at engine init.

Link: https://github.com/intel/compute-runtime/pull/919

> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/g=
t/intel_lrc.c
> index 147d22907960b..a35601e6f1e90 100644
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
> +	/*
> +	 * Wa_22013059131: only set FORCE_1_SUB_MESSAGE_PER_FRAGMENT for
> +	 * userspace contexts that have not opted out.  Kernel-internal
> +	 * contexts (gem_context =3D=3D NULL) never run shader workloads that
> +	 * require this workaround, so skip them unconditionally.
> +	 */
> +	if (rcu_access_pointer(ce->gem_context) &&
> +	    !test_bit(CONTEXT_WA_22013059131, &ce->flags)) {
> +		val |=3D FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
> +	}
> +

[Severity: High]
Does dynamically modifying LSC_CHICKEN_BIT_0 per-context cause a race condi=
tion
when contexts execute concurrently on different engines?

LSC_CHICKEN_BIT_0 is a globally shared MCR register affecting the L3 cache,
which is shared across all render and compute engines on DG2. Modifying it =
via
MI_LOAD_REGISTER_IMM broadcasts the change to all L3 banks.

If Context A (which requires the workaround) runs on RCS0, and Context B (w=
hich
opts out) switches in on CCS0, CCS0's context switch executes this indirect
batchbuffer and clears bit 15 globally. This could dynamically alter the st=
ate
for Context A on RCS0, potentially disabling the workaround and causing a G=
PU
hang.

> +	*cs++ =3D MI_LOAD_REGISTER_IMM(1);
> +	*cs++ =3D i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> +	*cs++ =3D val;
> +
> +	return cs;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630223946.2107=
382-1-jia.yao@intel.com?part=3D1
