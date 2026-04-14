Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC4AF9D0CE
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5855E10E5FA;
	Tue, 14 Apr 2026 13:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZiajlVq";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7F610E5FA
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:11:37 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-127337e3870so850430c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 06:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172297; cv=none;
 d=google.com; s=arc-20240605;
 b=RTvP1qcRal0rO5/D94tH0QpxLdYsl8KMBycA3qzazuDLKXaIPo6TRiTFGXcPz6C6ms
 PxGWg3lEikBnwSVxearUX+RH8lZl4F0BV8rx/txAfSI5aPg/rWzVGjrMGKIXiRHG6IJX
 U1BTtcc31JGG97AeM9A6ftzWEhJ0fsdU9iQkjEcWG0GP6l+uB7R5o/TKmbN6gD/ho7PJ
 5+6s0auitKgiUdaxLHp4HjxtoSh6HcqujyuR0CU0+lmyafBOVKQHgxybJIG7eph2RLio
 yMYVcgtk6XdPuG9ze6xFlFUq+OitfmqZDaiQq1PDF7/EdY1VpVWVvbaEYQRJpEMRJwfR
 hBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 fh=yqcnHkC/EkiTMBLq7rEH2tOVwK2Si8/ez8lrkxdiLw4=;
 b=WQnOAuTVnXAhohR/UNE0jF6Y8rXPhKbGBzDHxtHAJBPJLxeUOrl+/oT2PheG5yTd9u
 raZlQeo4e8Ec02P8U19CJZm02ehf4o1JljE6xMHC7ltO4I+cDK8LRY6KS1DULT7YbceS
 eBkm316tXjBDD1PhMlI4E31m6FLTietp7kDZVXTDucLorJ7eDPQQV5a/cIpfm/9tj1Uk
 SMK7m0bfpWq2QA6+J97kZAhOyLOqgkU0VXRoOmcMZ8Hv1t8UkksIK714AGOvPUGaXwau
 JIPbLn9uNOtEow6gO9C9SBzaOrn+DpqMaKI8qN36c3ZoykRRa4Wh1nJxTHDrRb2j5yNM
 scNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776172297; x=1776777097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 b=BZiajlVqwDbLpL+ZXq0yR1Om0zeAfFybcyhXZBB4UqYrWdQsrT14NHU2CYajptNduC
 8pOlmsb3gF5uX6m5ak7ngzhtjsGrhUaFbz2XlxcqtWRiNUS8ND9pBHT1BDPb+dCHh5Lt
 ww9T1fU3V9BD7dkFbxFE8i0Tz1wbPJQp+M4KBhhcQHhLD5ZzmNHRNCLr7L66telxvXke
 nOHzggFdqAwnd1aAtxVi6LFIEukPCOYuAUkp2e7vvWYs9Z1CPMtdCOtklzz+yVB/3Iyt
 zipP94FNLP8p6/lq9uxUFQHjqcRjbiCCHoeXTWLXheGyaRS4Cvk6RaU2xUYY653wVWsk
 Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172297; x=1776777097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xAUGbKK/fQ8I+ulZb26pbb2JDvVKutYnIPXuPQk8XPY=;
 b=LfQbbZul2GBFXZGUPHtrs/1KktsJqMGfJ3LLSW+5alpldi5vxQob17jhuHevh0n0YR
 hFrw/UAaNJFCV34aLCSjZQE4Z6qt90TsnCFSuGazcPMDpazeOH6ISz4X9wv78lpDej7/
 v2Ve5Vcw01xhV2O4K9JTQQSIqWqPiYTALx81Uh63qBk0M2m6/n92VKZfSIKi+O6E6lVW
 yxZZUEa2qCoU9GduIlzK/Lhz8fVnJOj0PJghAbP4yEdvN9Tj0gdCZt9HHX7M4qQT3Dew
 NgKhbTtmvVb28JEN5bELo2EguOzFB/c/vhr728cvPaOHxNAhq9Xh/jdclFrKXfa+Nqak
 lT6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vRiZBUSOzgNVXdzfg2oi7AKF5z8F0MvWtXfK86Lpmwce0y4Gvl/EEtgePDXAwBNurOdcTcOQmrnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdLLNTHufZVZBgNfHTqgsVD2A1YfHfyv90Nz2JMC0kgSTEqyRV
 T00/A1mR+nMCMtsek3ghL4bm4obm/8s6BD8MIHJROp4o3bIwBVJDBtNjBG4z9HOZwsUS53A6XVJ
 nzUljT1O75VdIC0f7qsHsbK+7n+8aNGU=
X-Gm-Gg: AeBDievBW1iowmlLQEJLAYlq0O9P/9PoO3nZruXbcifQaATOzEeAGqY8ip60V++TRu4
 dDhNa+uXbilxI34hAQwC/kWuZ+FoZE+bGozK6O8DrwjrkkdYL7003dD3jrGvKxpAS+GDqAoGACZ
 XqJ9ENHhjCz7Rv4reIh5nV7G2hGbxQbo3WTkqxpWAs3tUQjIPaVEQGTkX2JkKUjjWp17hDyZDW2
 5B45qQvRXA1P1yX0P/mIHMxBdmmj1ot9CTB9PF99QDHTfGgwMhnpfzekorW97jlc5LqyHbmWwaZ
 RS9kWcOHB2O+5p7sUQPtavXEsZBOoPDEI3fz7Wl61uFM/OonQGQzrY5NsCXDZZdkMyiV7w==
X-Received: by 2002:a05:7022:31b:b0:12c:3ef2:ef0b with SMTP id
 a92af1059eb24-12c3ef2ef95mr3052157c88.6.1776172296806; Tue, 14 Apr 2026
 06:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260406225008.2787532-1-werner@verivus.com>
 <20260406225008.2787532-3-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-3-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:11:25 -0400
X-Gm-Features: AQROBzAsbCXMjAgIiqqWYbip5sdNaqMuufvvZpt7WJlaFFjmFoOYluDAPOh2VSY
Message-ID: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
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
> radeon_align_pitch() has the same integer overflow as amdgpu's variant:
> 'aligned * cpp' can overflow signed int to 0 when alignment rounding
> pushes the width past INT_MAX/cpp. This produces a 0-byte GEM buffer
> via radeon_mode_dumb_create(), reachable from unprivileged userspace
> via DRM_IOCTL_MODE_CREATE_DUMB on the render node.
>
> Add an overflow check in radeon_align_pitch() and reject zero pitch/size
> in radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>

Can you fix this up similar to the amdgpu patch?

Thanks,

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..2cd179fef347 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -828,6 +828,11 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>
>         aligned +=3D pitch_mask;
>         aligned &=3D ~pitch_mask;
> +
> +       /* Guard against integer overflow in aligned * cpp. */
> +       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +               return 0;
> +
>         return aligned * cpp;
>  }
>
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0
>
