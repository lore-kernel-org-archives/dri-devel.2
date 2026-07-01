Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4599BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA1610E214;
	Wed,  1 Jul 2026 07:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zo6kKGrY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0A610E214
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:41:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 085B46001D;
 Wed,  1 Jul 2026 07:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9B1F000E9;
 Wed,  1 Jul 2026 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782891697;
 bh=JoWttcAAohstAtCRZJQ2wMbKXoRz1YeIdNJA0KexknI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zo6kKGrYFy+hmmg0gr8hfSY68XtORoUDQzocftassHFE5d8HBBvqSX2ummGbKq6o0
 avcuO3Pgrr1U7aTm2wRNcgPA6F04YE5gVzCAPZl8+Dop9ozHnFSFZWT0LiosyHPiau
 U1FKRPMksMpY3LM2VAUnMmeh3J7nGPn5uiTkwFErQOemTHvjo4Rv9gpV8ph6V9Yb8G
 dwALzrrA8TMkSrzZdpR2gWhVpK7lRS63VfbHNmGnptKKc4bcn2+giSxhclOY20VeIH
 5z9OmuBCEaPg0rdd1oCqdouZeLui4Nq4s8A1M09wNFFnbRFY+aOGTWzWKeuP6ElbOp
 6lsRYeZEdkqag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gem: Do not leak siblings[] on proto context
 error
To: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
References: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:41:36 +0000
Message-Id: <20260701074137.84A9B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Unchecked NULL pointer dereference of `pe->engine` in `set_pro=
to_ctx_sseu()`.
--

commit 65a99ba2c873d452c04e00448f3e025e69552b68
Author: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

drm/i915/gem: Do not leak siblings[] on proto context error

This commit fixes a memory leak in the context creation error path.
It ensures the siblings[] array is properly freed if an error happens
while processing user extensions.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.c
> index aeafe1742d308..87fce2adfeefb 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
[ ... ]
> @@ -800,15 +800,21 @@ static int set_proto_ctx_engines(struct drm_i915_fi=
le_private *fpriv,
>  					   set_proto_ctx_engines_extensions,
>  					   ARRAY_SIZE(set_proto_ctx_engines_extensions),
>  					   &set);
[ ... ]
> +err_extensions:
> +	for (n =3D 0; n < set.num_engines; n++)
> +		kfree(set.engines[n].siblings);
> +err:
> +	kfree(set.engines);
> +
> +	return err;
>  }
> =20
>  static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,

[Severity: Critical]
This is a pre-existing issue, but could this cause a NULL pointer
dereference later in set_proto_ctx_sseu()?

If a user creates a proto-context and uses I915_CONTEXT_PARAM_ENGINES to
set an engine array with an I915_ENGINE_CLASS_INVALID entry,
set_proto_ctx_engines() initializes the slot to 0 and skips setting
pe->engine.

If the user then calls I915_CONTEXT_PARAM_SSEU and specifies the index of
that invalid engine, set_proto_ctx_sseu() executes this:

    idx =3D array_index_nospec(idx, pc->num_user_engines);
    pe =3D &pc->user_engines[idx];

    /* Only render engine supports RPCS configuration. */
    if (pe->engine->class !=3D RENDER_CLASS)
        return -EINVAL;

Does pe->engine need to be checked for NULL before dereferencing it here, to
prevent a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701073030.4485=
0-1-joonas.lahtinen@linux.intel.com?part=3D1
