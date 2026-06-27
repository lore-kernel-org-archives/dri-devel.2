Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5E4C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B703D10F757;
	Sat, 27 Jun 2026 03:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E0A+w143";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A7310F757
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:41:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2CAD600AA;
 Sat, 27 Jun 2026 03:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362D61F000E9;
 Sat, 27 Jun 2026 03:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531669;
 bh=4lXmK0GKdxCU7rzUQQXgzBf2tBRs+O52HsskkLHIPFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E0A+w143vEc+mOff31Ji1jEmSXYfd3y4MFcmUavComZyVWylQggqokL6HDJQv513Q
 4wc5swARZUn8NQtatc8WCoLQKoBKLF0qr6w4pF0/0vZ+EWoBTCUgXkfpnsHi2hVhT9
 Kk7tXgWl710LwTzxoSAuL/2a4Oo8ljGNjC4J0uAGhLh8VcuflGQA0Uys9W/cGnUhTy
 cQJR1OpDgTJUoltxak+8vTNQnap4nj3McIoSSNZzS0dUWqmQglvBBzWldASrYsubUh
 D4Yc193QF3K9L4RH31v6QUE4tiCMtY6kuKpuZOtSrgnfBVS/u2/zVfnmuGeNM336u2
 Piph81z4wOhXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/38] drm/blend: Get a rotation name from it's bitfield
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-2-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-2-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:41:08 +0000
Message-Id: <20260627034109.362D61F000E9@smtp.kernel.org>
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
- [Medium] drm_get_rotation_name() incorrectly treats a rotation bitmask ar=
gument as a direct array index, returning wrong strings for valid rotation =
masks.
--

commit b39dab0752eb4becf3196f5e38118e4db280556f
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/blend: Get a rotation name from it's bitfield

This commit extracts the rotation property table and implements
drm_get_rotation_name() to return the name from a rotation value. It
also introduces a macro for formatting multiple rotation masks.

> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 2f0d1ba285be8..eecdaf623c1e2 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
[ ... ]
> +/**
> + * drm_get_rotation_name - Return the name of a rotation
> + * @rotation: The rotation mask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
> + *
> + * Returns: the name of the rotation type (unknown) if rotation is not
> + * a known rotation/reflection
> + */
> +const char *drm_get_rotation_name(unsigned int rotation)
> +{
> +	if (rotation < ARRAY_SIZE(rotation_props))
> +		return rotation_props[rotation].name;

[Severity: Medium]
Since the kernel-doc states the rotation parameter is a mask, won't this=20
return incorrect strings?

DRM_MODE_ROTATE_90 is 2, so this would index rotation_props[2].name and=20
return "rotate-180" instead of "rotate-90". For higher masks like=20
DRM_MODE_REFLECT_X which evaluates to 16, this fails the bounds check=20
and returns "(unknown)".

Should this extract the bit index using __builtin_ffs before indexing the=20
array?

> +
> +	return "(unknown)";
> +}
> +EXPORT_SYMBOL(drm_get_rotation_name);
[ ... ]
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index bebbb77a8f214..33329170aafe8 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
[ ... ]
> +#define DRM_ROTATION_FMT "%s%s%s%s%s%s%s%s%s%s%s%s"
> +#define DRM_ROTATION_FMT_ARGS(rot) \
> +	(rot) & DRM_MODE_ROTATE_0  ? drm_get_rotation_name(0) : "", \
> +	(rot) & DRM_MODE_ROTATE_0  ? " " : "", \
> +	(rot) & DRM_MODE_ROTATE_90 ? drm_get_rotation_name(1) : "", \

[Severity: Medium]
Does passing array indices like 0, 1, 2 directly to drm_get_rotation_name()=
=20
contradict the documented API contract?

The function's documentation states it expects rotation masks. Passing=20
literal indices works around the indexing bug in the function implementatio=
n=20
but leaves the exported API broken for other callers passing standard masks.

> +	(rot) & DRM_MODE_ROTATE_90 ? " " : "", \
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D2
