Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B2CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801F910E280;
	Tue,  9 Jun 2026 12:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YgkrFxBM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB65110E280
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:32:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47E8F437ED;
 Tue,  9 Jun 2026 12:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5DB1F00893;
 Tue,  9 Jun 2026 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781008377;
 bh=HP5vXcYOfNqWtdGl6U9doH4cnd/kX9JsaRWIpjliG04=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YgkrFxBMiXcfaxDMihiKlDiNWIUp66vEJ6BmJTcUCMfLABWCn8PaZazP6tr5ANPsl
 ozgrN+y/IdgjZrZAu6TSbebQPIb69/0j9yMDb/ty6Ix7227DeWlM8g19dJqOJtvybn
 6AHybBjMSawwJ7AS+FiPmSCWMpKxhjQy8If3xUtyjtGyCYGbsPDaaXhnb7X+Qi76J3
 SqmVcYctoSI4n1/+f53BACtPj2Bb5ynBFeIn+nTAz1CoIAYGyCFtZ7Mlw5InZwMXMe
 i3ROVYNpJHTQVRqoNp84wyGdnWLdx1m6hXZWujj7yoy3kOeGCAgcEFsZT3ARjkjXj/
 tYoXD5w33Js9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] drm/amd/display: make shaper bypass mode cleaner
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-6-mwen@igalia.com>
References: <20260609121230.1358786-6-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:32:56 +0000
Message-Id: <20260609123256.ED5DB1F00893@smtp.kernel.org>
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

New issues:
- [High] Removing the `enabled` fallback leaves the shaper transfer functio=
n in a corrupted state if an invalid 1D LUT size is provided.

Pre-existing issues:
- [High] Atomic check silently ignores invalid colorop LUT sizes and alloca=
tion failures in the blend transfer function.
--

commit 7d44b36a8843f15370d407ecab07d171e3f7d506
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: make shaper bypass mode cleaner

Start shaper tranfer function setup in bypass mode, i.e. tf->type =3D=3D
TF_TYPE_BYPASS and let the helper checks set it to a different mode
according to userspace request.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 13ad7ac1e35e4..4651241433296 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1648,10 +1648,11 @@ __set_dm_plane_colorop_shaper(struct drm_plane_st=
ate *plane_state,
>  	struct dc_transfer_func *tf =3D &dc_plane_state->in_shaper_func;
>  	const struct drm_color_lut32 *shaper_lut;
>  	struct drm_device *dev =3D colorop->dev;
> -	bool enabled =3D false;
>  	u32 shaper_size;
>  	int i =3D 0, ret =3D 0;
> =20
> +	tf->type =3D TF_TYPE_BYPASS;
> +
>  	/* 1D Curve - SHAPER TF */
>  	old_colorop =3D colorop;
>  	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {

[ ... ]

> @@ -1702,13 +1702,9 @@ __set_dm_plane_colorop_shaper(struct drm_plane_sta=
te *plane_state,
>  			ret =3D __set_output_tf_32(tf, shaper_lut, shaper_size, false);
>  			if (ret)
>  				return ret;
> -			enabled =3D true;
>  		}
>  	}
> =20
> -	if (!enabled)
> -		tf->type =3D TF_TYPE_BYPASS;
> -
>  	return 0;
>  }

[Severity: High]
Does removing the enabled fallback leave the shaper transfer function in a
corrupted state if an invalid 1D LUT size is provided?

If userspace sets bypass =3D false but provides an invalid LUT size or unse=
ts
the data blob (size =3D 0), the check for shaper_size =3D=3D colorop->size =
fails
and __set_output_tf_32() is skipped in __set_dm_plane_colorop_shaper().

Since tf->type was already set to TF_TYPE_DISTRIBUTED_POINTS earlier in the
function, and we no longer fall back to TF_TYPE_BYPASS when enabled is fals=
e,
the function returns 0. Could this cause the atomic commit to succeed while
programming the hardware with an uninitialized transfer function?

[Severity: High]
This is a pre-existing issue, but a similar problem exists in
__set_dm_plane_colorop_blend().

Does the atomic check silently ignore invalid colorop LUT sizes and allocat=
ion
failures in the blend transfer function?

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:__set_dm_plane_colo=
rop_blend() {
	...
		/* Custom LUT size must be the same as supported size */
		if (blend_size =3D=3D colorop->size)
			__set_input_tf_32(NULL, tf, blend_lut, blend_size);
	}

	return 0;
}

If the size check fails, __set_input_tf_32() is skipped entirely, but the
function returns 0. Also, the return value of __set_input_tf_32() is ignore=
d,
meaning allocation failures are not propagated. Could this allow the hardwa=
re
to be programmed with an uninitialized or partially initialized transfer
function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D5
