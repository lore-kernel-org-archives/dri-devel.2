Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18D8CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDDD10E0C6;
	Tue,  9 Jun 2026 11:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmhKYb/S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B1810E0C6
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 11:17:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EADAD601D6;
 Tue,  9 Jun 2026 11:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079E1F0089F;
 Tue,  9 Jun 2026 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781003826;
 bh=aaTlbREA4bAL49OCp+Hd2FI4mdXiyVpdkgXXXbyFRnk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bmhKYb/S2DaupodVdeHG2BRivflXhsnfh+lMtLzD47Cc8VTwuTHBVYJm8qVnBVOxJ
 g8DJkWeBIuxWPryHXeJQT6/ILSF1XLnSqyCCi/y4jGrdewn7Aybl+j2FoHHwlI75tA
 SqAkmIrX8Maz0mc/EHMQu/m/bD/6dz9u8mocToEJfJeKODcETilXbfyyvV6mNoX60g
 jBlZ9AWb3iGttJ1jPyRy3V5p7uLWCWefnhYkWh2Lo/4RaGiX2hn3FcuMt79BVxZIsb
 E86EeTSsCjtcrKDPLOh5wg6plgR7obX8wlsVdd0GXAGLajXjwWUFjV6rhr1JP59ctS
 JmRoNnAITLzdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] drm/colorop: make lut(1/3)d_interpolation props
 correctly behave as mutable
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609110420.1298352-3-mwen@igalia.com>
References: <20260609110420.1298352-3-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:17:05 +0000
Message-Id: <20260609111706.7079E1F0089F@smtp.kernel.org>
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

Pre-existing issues:
- [High] The function `drm_colorop_atomic_destroy_state` frees the `drm_col=
orop_state` struct without releasing the reference to the `state->data` blo=
b, leading to a memory leak of `drm_property_blob` objects.
- [High] `__drm_atomic_helper_colorop_duplicate_state` unconditionally rese=
ts `bypass =3D true`, destroying user state.
--

commit af8aea1831e57bd16ec95c73773d4e52e3faa54a
Author: Melissa Wen <mwen@igalia.com>
Subject: drm/colorop: make lut(1/3)d_interpolation props correctly behave a=
s mutable

This commit moves the interpolation properties into drm_colorop_state so
they can correctly behave as mutable properties. It updates the getters,
setters, and state printing to use the state objects instead of the base
colorop.

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 44eb823585d2e..5ab77cf47f0a9 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
[ ... ]
> @@ -488,6 +486,20 @@ static void __drm_colorop_state_reset(struct drm_col=
orop_state *colorop_state,
>  						      &val);
>  		colorop_state->curve_1d_type =3D val;
>  	}
> +
> +	if (colorop->lut1d_interpolation_property) {
> +		if (!drm_object_property_get_default_value(&colorop->base,
> +							   colorop->lut1d_interpolation_property,
> +							   &val))
> +			colorop_state->lut1d_interpolation =3D val;
> +	}
> +
> +	if (colorop->lut3d_interpolation_property) {
> +		if (!drm_object_property_get_default_value(&colorop->base,
> +							   colorop->lut3d_interpolation_property,
> +							   &val))
> +			colorop_state->lut3d_interpolation =3D val;
> +	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does=20
drm_colorop_atomic_destroy_state() leak the state->data blob reference?

During atomic state duplication, a reference is taken on the data blob:

static void __drm_atomic_helper_colorop_duplicate_state(...)
{
        ...
        if (state->data)
                drm_property_blob_get(state->data);
        ...
}

However, the destruction function frees the state without dropping this
reference:

void drm_colorop_atomic_destroy_state(...)
{
        kfree(state);
}

Could this leak system memory on every atomic commit that includes the
colorop? Is it possible this also happens in drm_colorop_reset() when it
calls kfree() on colorop->state?

[Severity: High]
This is also a pre-existing issue, but does=20
__drm_atomic_helper_colorop_duplicate_state() corrupt the user state by=20
forcing bypass to true?

static void __drm_atomic_helper_colorop_duplicate_state(...)
{
        memcpy(state, colorop->state, sizeof(*state));
        ...
        state->bypass =3D true;
}

If userspace configures a color pipeline with bypass =3D false, will a
subsequent unrelated atomic commit (like moving a cursor or doing a pagefli=
p)
that duplicates the colorop state inadvertently reset bypass back to true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609110420.1298=
352-1-mwen@igalia.com?part=3D2
