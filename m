Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951D4F531C0
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8A810E4F9;
	Mon, 13 Apr 2026 18:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pQD+tzXw";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6968310E4F9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:13:20 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c22b9bdabso283524c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776104000; cv=none;
 d=google.com; s=arc-20240605;
 b=QJ+5ljJjceoiU28KoR0Q+oleBkYlqvgPExc3yXcYwpC93EonGZU0OR/DTzDaKjI62u
 f0uDG0PqH3ClJQmO954rfAy0NIuGfQhQoEvLwTqMc+PTKxSz2Su902c+stgXKdFW08Lb
 iihNJdginc5ZY083+DWQijyo7jTCO4wKqbHzE34CjqGB21rVO4pNeUS4L3xTBddKnHol
 7l+r69t7ZBwxSwnfZCN48ru6a69pXDHH1KtginAqUQSLNj3gCjeMAtlOofaQL1BpwsiH
 bYTpG1Wt6/SG9MHpA1EF28ZRJAWPM1mlXU1g8q0nEUlWgz7An8kdh18W12IQieQBAw60
 CSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
 fh=RGSPmTiu9yDggugg58zz1EdcBPfnylAyQqtdi7Qljag=;
 b=PekIo0J3iFyDBKC5CwwQ0l/TuLDn8hfSany9SqVhntiPM018RKFeJcMFqBl1ff0n3X
 jQuCF9WFoTttYT9MOsk31DCdLYCkyjTjwzJikLxlkqb9hI/G7OaEXysPfdnUOjhICdRT
 wIJWq2iqyWMouxEqToOP16QaCrW8FuhAJDrGec4VYFhSgHAsS6aBwOqxibE1eWX6YUlR
 ODtzbS30uw8VdC11sFTFyN0Gfv90ThXRCYd3U7aAHibGYsbbR3qOzFElu6tjBnSIxdL9
 /ots/3RtdnxDAaOoBBZxU4ubenNfgvI2OiPTWy1pRUjEpje+L+nhn8bjE4os7kCwmzwz
 hzVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776104000; x=1776708800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
 b=pQD+tzXw8SuQyS05iN0r4bSGggsgngv5gj49tjaQIBj1MYprSd3724z9RC3+VNqDHL
 J/MbpsyUJx5ti4pCjxE0uZb3Q0BaxoCm5GMevB+i8qpwIzUu9x2RmnBSIR0TZKNtlFLl
 IEhrMSQOQAKYZ+NiX0RR+l9tj0VS0KQylpXyfavy4+fF1lvNhluo1aMj6gP6KEfRrXU2
 BC6e43KtlE7f1LqgdZU0s5dnUgUKHalC5iYKo+jXf60Vq348DIafqTZuc8BQnIrJknx9
 XbGBJoqUfxR1KYTPNO/nw/sdJxmorl4fksO9bTnhw4RMZZCucLBu0gmcL9IkGU+bvsz/
 tDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104000; x=1776708800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
 b=l4fo/Q7kS9vwRb/2yT1ZTljWqw+lBZx+5xsbC/YOOgkOqvFWLdb0Uv+ZZsDaBuXvO0
 MloUwJ8zSp9grzdoElmdTK5xnnGpgzKlVqgHU3cKCpEpcC1l28HB0YkuW1TkspqLDZ6+
 b6mqNf9LhMfHaSEjH4JetfUdb++6lQnQk9+a9lVdq9pf5Clq8Y8ucyImItgOJufztTLH
 6ZXO0S8fRz+buIefMIx7dVcaYoATv5I7lmDFHcjiUzE+5KwiktIgBkfTKnsSVOqzxqQA
 ZU5vC7kUXHU+7RLEnKjtzDny8pVWTvQ/408Gps7jXho7swWFA/xwscPI9lvTrbEdkpq7
 upmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KehvUt5Fdvily1OIcYFZ9RpId5NGk+2jWx1KRm66NPjO+ZOBP7EvDJNitEPLNSBZlAIzVwDKgvZE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9ulZL/SW2FICQGm2bkWmUwrYI1qQNq4F41AakebB3IbPvlTzv
 9UEYCRg0GI8NAEOMWkHxkfcrwHX3mHUzx9fU0HKgoPYmFHsFvTYKfnJ1myYepEv8UArTTAmn3Dd
 FSZ5sh3x2pbw6H/YoTMVSIweqgVLXD34=
X-Gm-Gg: AeBDievngh6T0NyMlwjqbIyLaFSzyCLcf+ofdLcZ3p21gMyh0aQunXeEK5nsNCQxpX8
 B2jyB9fEp7oNyakDQyHpdn23000Wa6xt2NZbQ4HnINMMrKFQMdl+XPR9ivGatzL1Exc6SdfJwxZ
 BkO2iM9m9TZIeQAKed7WBBTKWjo/IgDYheJiUMGsUncXdMrYHBw7n3TZdw9woENHrRIgUGpL/8b
 icS5TYIdaw42Qmz5twSfu3Ok8Sjtzcs4ZpC6QKrNzCaysaRP74Frl/Uvihl/U2HN26jVneJwJUS
 0fQdyy43XNdjtk+eXWMK4yqN6xLY8o1Eikp3dHn+Eaiw52fD4Oyz9hkcI1zIsPalCQsbCw==
X-Received: by 2002:a05:7022:672b:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12c34dbed15mr3119305c88.0.1776103999545; Mon, 13 Apr 2026
 11:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260406225008.2787532-1-werner@verivus.com>
 <20260406225008.2787532-2-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-2-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 14:13:06 -0400
X-Gm-Features: AQROBzAVudQT9b1KEMIQwaqVTOGdwq-wFQfJObhPf6ovAb3esDyy6cLWlE6yctQ
Message-ID: <CADnq5_PUEMT4n3ZpBuZH0A5QRZdwLjXAGCAnc6nM6CW5td8LmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 7, 2026 at 3:41=E2=80=AFAM Werner Kasselman <werner@verivus.ai>=
 wrote:
>
> amdgpu_gem_align_pitch() uses signed int for the pitch calculation.

Can you convert amdgpu_gem_align_pitch() to use unsigned ints?  The
width passed to it is always unsigned.  That would simplify things.

Alex

> When alignment rounding pushes the width to a boundary value (e.g.,
> 2^30 for cpp=3D4), the multiplication 'aligned * cpp' overflows signed
> 32-bit int, producing 0 or a negative value.
>
> The overflow guard in drm_mode_create_dumb() validates width * cpp
> BEFORE the driver callback, but amdgpu_mode_dumb_create() bypasses the
> generic drm_mode_size_dumb() helper and performs its own alignment
> rounding, which can push the pitch past the pre-validated range.
>
> A zero pitch propagates to a zero-size GEM object allocation via
> amdgpu_gem_object_create(). The 0-byte BO passes
> amdgpu_bo_validate_size() (since 0 < man->size) and is returned to
> userspace with a valid handle. This object can then be mmap'd or
> referenced in GPU command submissions, potentially causing out-of-bounds
> access to adjacent slab memory.
>
> DRM_IOCTL_MODE_CREATE_DUMB requires no DRM authentication, so any local
> user with access to /dev/dri/renderD* can trigger this with e.g.
> width=3D1073741760, bpp=3D32, height=3D1.
>
> Add an overflow check in amdgpu_gem_align_pitch() to detect when
> 'aligned * cpp' would exceed INT_MAX, returning 0 in that case. Add
> corresponding checks in amdgpu_mode_dumb_create() to reject pitch=3D0
> and size=3D0 with -EINVAL.
>
> The proper long-term fix is to convert amdgpu to use
> drm_mode_size_dumb() which centralizes pitch/size calculation with
> proper overflow guards, as is being done for other drivers in Thomas
> Zimmermann's dumb-buffer series.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setti=
ng up AMD own's.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index a6107109a2b8..b4341abba20c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1246,6 +1246,15 @@ static int amdgpu_gem_align_pitch(struct amdgpu_de=
vice *adev,
>
>         aligned +=3D pitch_mask;
>         aligned &=3D ~pitch_mask;
> +
> +       /* Sanity check to avoid integer overflow in aligned * cpp.
> +        * The caller (drm_mode_create_dumb) validates width * cpp fits
> +        * in u32 before alignment, but rounding up can push aligned
> +        * past INT_MAX / cpp, causing signed overflow to 0 or negative.
> +        */
> +       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +               return 0;
> +
>         return aligned * cpp;
>  }
>
> @@ -1273,8 +1282,12 @@ int amdgpu_mode_dumb_create(struct drm_file *file_=
priv,
>
>         args->pitch =3D amdgpu_gem_align_pitch(adev, args->width,
>                                              DIV_ROUND_UP(args->bpp, 8), =
0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>         domain =3D amdgpu_bo_get_preferred_domain(adev,
>                                 amdgpu_display_supported_domains(adev, fl=
ags));
>         r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, flags=
,
> --
> 2.43.0
>
