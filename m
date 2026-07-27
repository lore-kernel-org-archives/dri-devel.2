Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122FC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3563A10E467;
	Mon, 27 Jul 2026 15:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HkrTraOv";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3F510E467
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:44:59 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so170153a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785167099; cv=none;
 d=google.com; s=arc-20260327;
 b=CyDSM3G91ewQiPS2Q/jxHthgWnXBc0ZUUnM052d8ABHnRYPXi2M36zSA/c+OlfkiIu
 +aqnq8wSthJZ/5QaZ6FJhjSGTlTLLazy14dSHwUPAVy+lY3Zmj93YImCMX0gSAbQuOqP
 TDoHUCVnbCApxi0mEwkjbCTND4i9T7f8mpsXuAYE8YbpnnvqmeCfuPt9djgS8MgPcKOx
 NCaqhp8g+cTrhGuFl2XwsJnpyvOP5zTBeHm/9gYmqApZC6XI3f3Km0BFXlGNYHa3ac08
 ZKWaX1eE+y7j3PScA4OvXzEBrqpP8v9kmtovAvpT9yb7R5zxja7s8cGzlsNe6LvoZZLg
 /tUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2E2+wNwOz3ocOPNdYPXNkPVFbk7ggoeG58MpWzTPseA=;
 fh=OxJxRNSUr4ANnKxnLBUtmEii6hKO3m4jwupnAHmhjTU=;
 b=LmiuhpF1aUJJ3T3FstpsGY4l7PKTFA+yPaFFO5e4+wY5rBLFSQRxOhBD4BdprjAgne
 TOt/kAgQo+OKOKglrQIi+tApdyaD4m2bsme/WAxTdKkHQLRHauoJoekyauTw/lujav0x
 YF17lTznE214M2gxtvzATBFOccGDi/urPDjRn1j3QwfXbyJm2OIJrYhQksArGFDj1jlg
 2PZ623ThlKXMVzNPpJc9QcRaSif+1odn3DMXFLd7y56Gjhb2Myg6h5sQTdHCDV42njfu
 k04L+WPtfo09H5G6gVGrma+E4ienyr7/ub7V1I5bMWBRZwYvwuJYWX34PGNHkFHWvzIW
 BF2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785167099; x=1785771899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2E2+wNwOz3ocOPNdYPXNkPVFbk7ggoeG58MpWzTPseA=;
 b=HkrTraOv9YmTblG2ln0kjsqVcWN9aBPZFclpipeaUtRXSvrBRnhVHOvQV4KYUzwzCW
 P4zu3/G9u4L4bTWLarlSCgToNunj8ctv3MNZG22dTvPrqBBgz5dSyqdoxNq2O4qj0mHc
 Web5akNrv5O7zyxzzuXGHX98wmkfAXBOqZp1yClPwn2AEIfoxyIQt++euBhXGc1qDcdy
 FgIXPFxuHH20b6HS33DagKW0TR6kkbrh3U8/ikrRrOH9EyULrJFh1FJnLL9vktWoN4Dc
 NNR8AaQVF+nWfbGQkbAzv/AO56tiMyNW7nnzBQqPK11MXObYo4gUnbj3uNz0bhCl5fWv
 Mnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167099; x=1785771899;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2E2+wNwOz3ocOPNdYPXNkPVFbk7ggoeG58MpWzTPseA=;
 b=kBlo7ef9HKXp3N1nNBxiJpVAVHqIrZpCd6wruwOkBeUjNosNdKxuZEmcXJ9Pv+UCNk
 rcemxA0wOg3eL+Gq4TZKJPIdZQxaSmOT1ZytvRgTibnEYmF4DFhcj2llFBv15x85FyEu
 Vk8lGhHYzAvZGa1+qoTTYl/qvtl5AgbXp39wB4qU08YK229wH/3w+mqCgdPRG3kErKKH
 Cei2v1DChz+Fv5aFjlD0VtCzgHFVpkd86e9qn72kgTUZoCZYOBHoqLcAXLa9VSxbOBKp
 bnQpQNhpsL73Z7HHHjmjmeiIWgaRIeE6FQojVbItJN5ni2gltJJtpgtddqM1TXliW4bt
 4cYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxv6EGhuzlQmhBRkC51DFGIl9h55pGN1QflMN5zM3aOF+EGIjY/QOE/3Kb8cURrrzNpcuzC42hSgI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHUQ34TP1lUJb4fKa+nJYokyVQMJW1nlakxVzyRHIb6Ywd5RDv
 0noqX/ByWqm04v92gIZ1bHjF6BXse/ygLHtjPu5pAkAqE+KNH48GsHeyK745DiC4uZ8fJuEVlJv
 sUb1yEZvIBlDK9eobcDO6DTybO9+lSRc=
X-Gm-Gg: AR+sD125hRCmnU/N2ENU6sCd9oOsjUT1K01h43vTe8j3tsW0nt/JucrFnpOyhyBRANQ
 iDJ7z3IUy6FpGWPLC+jTRE/B8rhmMnP8+/Zd1vDPEHX94S2IDtk/ZA3xYXz1Xa9YWrGyRxvXPE7
 L+/Pv5+ze6HoZye/byvyfQrnLO+LEtRHd+UCMURIVS1PVcdY4X3q+cquFux/EgsidYs8dqrDadL
 HEr9MINkYru6MLe0eoAjiNUR/jousuQ2hJcqBPNpCt67aP5fkhkCXN0czaPZ6sRt0chS4iX6flm
 NtBajqb8UCie6cybwBUjBgV07I7aBAymE796phubT5pMvwA7
X-Received: by 2002:a17:90b:5410:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38f624d077emr524367a91.1.1785167099129; Mon, 27 Jul 2026
 08:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260722165925.15805-1-timur.kristof@gmail.com>
 <20260722165925.15805-5-timur.kristof@gmail.com>
 <20260722173453.CF3FA1F000E9@smtp.kernel.org>
In-Reply-To: <20260722173453.CF3FA1F000E9@smtp.kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 11:44:46 -0400
X-Gm-Features: AUfX_mwETSo9kiss-1GnIwKajUUdXFUtUnyAL3OvYEYQzv50TeWz9ODlfFe6OLc
Message-ID: <CADnq5_P7-_RfV=MbbNw8w8CVEmE12t8ZgVSa5Pbz+ujjkB7Xcw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
To: sashiko-reviews@lists.linux.dev
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 dri-devel@lists.freedesktop.org
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

On Wed, Jul 22, 2026 at 2:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Missing 2D tiling format modifier for 8 bpp formats on GFX6-8 br=
eaks NV12/NV21 video playback.
> --
>
> --- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymor=
e ---
> commit 9ecc330329837cba2c5f2f431e911a3b7ec6c4df
> Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Subject: drm/amd/display: Don't use tiling flags anymore
>
> The commit removes the usage of legacy tiling flags from the amdgpu_dm
> display code, transitioning all supported GPU generations to rely
> completely on DRM format modifiers. It updates plane attribute filling,
> surface updates, and cursor checks to reflect this change.
>
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > index a593a44ef97bc..87187c965d55c 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> [ ... ]
> > @@ -1235,8 +1201,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(=
struct amdgpu_device *adev,
> >                                                                        =
       address);
> >               if (ret)
> >                       return ret;
> > -     } else if (afb->base.modifier =3D=3D DRM_FORMAT_MOD_INVALID) {
> > -             amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_i=
nfo, tiling_flags);
> >       } else {
> >               ret =3D amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifi=
er(tiling_info,
> >                                                                        =
 afb->base.modifier);
>
> [Severity: High]
> By removing the legacy tiling flags fallback here, does this break NV12/N=
V21
> video playback on GFX6-8?
>
> Looking at amdgpu_dm_plane_add_gfx6_modifiers(), it appears to add 2D til=
ed
> modifiers only for 16, 32, and 64 bpp:
>
>         amdgpu_dm_plane_add_modifier(mods, size, capacity,
>                 amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TILED=
_THIN1));
>         amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
>                 amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED=
_THIN1));
>         amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
>                 amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED=
_THIN1));
>
> Since the modifier calculation for 8 bpp (which is required for NV12/NV21
> formats) is missing, when userspace allocates a 2D-tiled NV12 framebuffer=
,
> won't drm_plane_check_pixel_format() reject the atomic commit since it
> cannot find the 8bpp modifier in the plane's advertised list?

Shouldn't be an issue as we don't expose any YUV planes on DCE hardware.

Alex

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722165925.15=
805-1-timur.kristof@gmail.com?part=3D4
