Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB7BC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDD910F04D;
	Wed,  1 Jul 2026 16:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c2NKdvCb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC8110F04D;
 Wed,  1 Jul 2026 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782924451; x=1814460451;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=Eg0d6mEjYoCwZN6wDgOQtSayaI45/eybca/GwSK9Bt8=;
 b=c2NKdvCbJWHKdZBNfbnpjWAaXmlomXRXuy8oCVjxYLGZnXlkdmnHJGE3
 /lqnVZKG7x4V9afDHQ6eqZ7NNXCrGwQ5yUwuNjLm4F9lEsl1l74nOE3Gw
 fGj2JXR0V6cqTi83++ssLMF/B+RWNpAF5PxVsx663FGa9oEtDNopkzLIE
 GeiRhoAp8bPurGML82jzKsQUYpcHvCgCQK5hUqQxs6rKcJth1bYijZBma
 5sv3GcXJ7XAZV3+knwOqTRFOcWK/wKppQyEVzPyVNgtzZXkzpoWU+maIj
 8EQlQDcBbTLNW4bBhLzbkWKppafgA+RZYyUs3V3+TykcdJmYgUfxOkCc9 w==;
X-CSE-ConnectionGUID: NgtgYa1YQh69aiD69fIibQ==
X-CSE-MsgGUID: AiZdrse1RRexLvOb+cWnsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83697597"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="83697597"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 09:47:31 -0700
X-CSE-ConnectionGUID: dLk0VwoqRQqbIjwu9ugsNA==
X-CSE-MsgGUID: IYy8J8tES9iqzBx+/CmOAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="250899661"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.25])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 09:47:29 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <178290749714.224587.15234445443946207851@jlahtine-mobl>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Matt Roper <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: Jia Yao <jia.yao@intel.com>, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Date: Wed, 01 Jul 2026 19:47:21 +0300
Message-ID: <178292444166.273574.16738251742448073960@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

(+ intel-gfx for real this time)

Quoting Joonas Lahtinen (2026-07-01 15:04:57)
> (+ intel-gfx, Matt and Tvrtko)
>=20
> Quoting sashiko-bot@kernel.org (2026-07-01 01:53:49)
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Dynamically modifying the globally shared MCR register LSC_CHI=
CKEN_BIT_0 per-context causes a race condition when contexts execute concur=
rently on different engines, leading to L3 cache state corruption and GPU h=
angs.
> > --
> >=20
> > commit aa5554c571fd6ea50b4b1d107d0ba27eeae18a7c
> > Author: Jia Yao <jia.yao@intel.com>
> >=20
> > drm/i915/dg2: Add per-context control for Wa_22013059131
> >=20
> > This commit introduces a per-context opt-out for Wa_22013059131 on DG2-=
G11
> > platforms, allowing userspace to manage LSC_CHICKEN_BIT_0 bit 15 itself.
> > It applies this workaround conditionally during indirect context batchb=
uffer
> > execution rather than globally at engine init.
> >=20
> > Link: https://github.com/intel/compute-runtime/pull/919
> >=20
> > > diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i9=
15/gt/intel_lrc.c
> > > index 147d22907960b..a35601e6f1e90 100644
> > > --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> > > +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
> >=20
> > [ ... ]
> >=20
> > > @@ -1348,6 +1348,37 @@ gen12_invalidate_state_cache(u32 *cs)
> > >       return cs;
> > >  }
> > > =20
> > > +static u32 *
> > > +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
> > > +{
> > > +     /*
> > > +      * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
> > > +      * other bits of the register will also get overwritten.  The
> > > +      * hardware default for all other bits is 0, but any workarounds
> > > +      * that adjust the other bits in the lower dword of the register
> > > +      * also need to be re-applied here.  At the moment that's just
> > > +      * Wa_22014226127, which is always set for DG2-G11 platforms.
> > > +      */
> > > +     u32 val =3D DISABLE_D8_D16_COASLESCE;
> > > +
> > > +     /*
> > > +      * Wa_22013059131: only set FORCE_1_SUB_MESSAGE_PER_FRAGMENT for
> > > +      * userspace contexts that have not opted out.  Kernel-internal
> > > +      * contexts (gem_context =3D=3D NULL) never run shader workload=
s that
> > > +      * require this workaround, so skip them unconditionally.
> > > +      */
> > > +     if (rcu_access_pointer(ce->gem_context) &&
> > > +         !test_bit(CONTEXT_WA_22013059131, &ce->flags)) {
> > > +             val |=3D FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
> > > +     }
> > > +
> >=20
> > [Severity: High]
> > Does dynamically modifying LSC_CHICKEN_BIT_0 per-context cause a race c=
ondition
> > when contexts execute concurrently on different engines?
> >=20
> > LSC_CHICKEN_BIT_0 is a globally shared MCR register affecting the L3 ca=
che,
> > which is shared across all render and compute engines on DG2. Modifying=
 it via
> > MI_LOAD_REGISTER_IMM broadcasts the change to all L3 banks.
> >=20
> > If Context A (which requires the workaround) runs on RCS0, and Context =
B (which
> > opts out) switches in on CCS0, CCS0's context switch executes this indi=
rect
> > batchbuffer and clears bit 15 globally. This could dynamically alter th=
e state
> > for Context A on RCS0, potentially disabling the workaround and causing=
 a GPU
> > hang.
>=20
> The fact that we expect compute and Mesa to align across their own
> contexts sharing single address space today is one thing, but I think
> we should be enforcing that. Currently nothing preventing RCS and CCS
> sharing one address space from fighting over the variable.
>=20
> This makes me doubt if modelling this as a per-context variable was
> the right choice.
>=20
> Maybe we should instead be making it DRM client wide property and
> inheriting it to all contexts?
>=20
> Regards, Joonas
>=20
> >=20
> > > +     *cs++ =3D MI_LOAD_REGISTER_IMM(1);
> > > +     *cs++ =3D i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> > > +     *cs++ =3D val;
> > > +
> > > +     return cs;
> > > +}
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630223946.=
2107382-1-jia.yao@intel.com?part=3D1
