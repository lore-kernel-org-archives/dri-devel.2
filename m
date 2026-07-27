Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8DCC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB0710E462;
	Mon, 27 Jul 2026 16:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NzlbiIbs";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A31710E462
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 16:04:53 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so299953a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 09:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785168293; cv=none;
 d=google.com; s=arc-20260327;
 b=aaFaVyIhmZoCzlonPz0y+x8e3LD5CBEyCQABt8x3u5NHBRn/RoC1S9rxKoCXBhBDNC
 nN6cBCj3z0vPs8IgIWwr2UNpyPmotVAD2dFAYnQhJqrFPPQXx6CV/i3DoG0oNP2sse5n
 06raVeEUMCU31UagYdfXMstuIbzf+uT2lntKcVN3JuyqVoNGMp1eOq2pg6sKcvbsv/05
 vJ98+WU1qMDuflSW9BhkFP1+L/7VBxgHw0Khp/HQdKtHIpXglpbP6j/R5u/8Bsb03MF8
 43N4leI9gYs3oW1dXOt6NdOf83OKN98Nvbk8bOkMM0ZbeDF9iFUprDyQqX9s3ElauUoD
 spwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mV132EboBiIC6aD49jRxyvOFo9SoecgWipLHtdHMdLE=;
 fh=BpErldt3C/vOJJ9M0Z1IxElA1nHZGCAHTX4vC+/KAN4=;
 b=UCWqT7nUg9wZw2ChI+bjC+FOxvXA3hSEyoeRkq1BHun6WJjCEWdD/X2eUwD6qyQYby
 5RQVBiNu1CZVH2tm6f+Y3bf6j4TByOr5T45AnJNUzNKRvBblZkiFMr1u1hLW+hx1P8Y1
 lR3sZi5UXWofsLccXdr0ddCuUyFt7oETv0JT7vBCWOHfxuCJ3Z+We7FUy3jd5ZTHUEac
 OUAK7kY1cgoh6CR5xUzf7rnYkr/+0hlgvjd+CZms/cwT7pS69eZlhDGdQOHgKaxtJZTP
 9i+FpvrHIYLL9Q/1jjHQ28RgQtcEIaNEQAknOA5SNSW3bALi1ceg35G/H0Ehy/WN/CFQ
 URGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785168293; x=1785773093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mV132EboBiIC6aD49jRxyvOFo9SoecgWipLHtdHMdLE=;
 b=NzlbiIbsopJIFqTQRXg3vkEs+hRFxTiIL/jEHXjrIPY7Yn1y4xvjBzxpWXvVHs0pTw
 1hl2UuY8c7QWa1AsHQMrJ3J7k9YiUwHm3w2pJONSU2S/zZiU2CAA3Ll+VXHAE9Ls3WP+
 mGiEeIi1QAqCwqA3AWhVq+yDZ4lZ52SneAIX+lyWiiU5GcY/ypnA35m/OjMbr/sTlY5e
 EpzJqq3nTivUCq9N4ClbLPd6ue391wVk89b7z7EXbSfdMwY5ilniDXgRxSEuH457onq9
 fR7sSqiVmMCIHrsbgNT0fuODXpDb9L6QCBtY6E92hNeR6wLgUOfCDJR2mSfoi2M4+DZF
 Q4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785168293; x=1785773093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mV132EboBiIC6aD49jRxyvOFo9SoecgWipLHtdHMdLE=;
 b=UQgQxvzuEkuZnEjiOno4dYC+2onWOqFKrVlAKGOK2QN+r/0pfj/dRqMBzC1ED/NpKT
 S/lf17jPbyl6iVo9Ck+WGCLm/7Ou8ZM3XYxZSIFenVucYa0BFr9F20MHdow9ZsS86rao
 T+RhnHKsWh8Wh+jppHWFp2AN2dKOG7XbRyUe6nPPvSgupuh7RCU74XyP7wGZamoOz0Ph
 kkYX82WBqLcuUI3TcfeGeuWkEUB9Jgc+5ruRayo/FJFSGkF2KpGFoMrnV6E+zGAK8Rti
 IWIjNphpMKvnG7sAvEttiCwMa16SdL8ZTn2I0KBL77lEJsVM5h7d5J+A+CXcuPxwp4fn
 5XBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJbgw6nE6d9+MhpKXg2H/wzoJT1HIihNeQ3E7sLz9rpWvJ7bRX3izPAKVmLyBDMqZOIUwoF0UM2jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDI/gYApV9blYtXRQqZywaWHhnkHx/iXlssOMZ6XJdJygq/Cl/
 dnW9LiapHyKPbgufIOUzd84fjGPTOrV8GU9Zq64UbQUn9ne/kMbnd9MB4VVakaU/jhY0RniuoKl
 Dvg27oC8RfSzNB+/HMLFzUnazkYBFUU0TjQ==
X-Gm-Gg: AR+sD11iGk9cNGld3zkoVh9mp6eO11dHUcObcrGNZWJrZnj9QnHRZPV7BElC0yBrXrV
 Xf4N6p4/n35QaHYRMPa0Q0gXDNGfRzgYTtylaXyN2FFNZ/pR6I4yeSQDFeukc5dsHnmNuUT0Wsq
 JQ/BJog4EO8wUrGQxvtI8GwhB3yubKLMSH3OJtqIwYsMgK4HFOV6rMOCuRlRnvCmlcaVeph4/qp
 Ftb3p2aS3S2vpp3uieL/zjcbQBKxVCR/R89vL6QcdImDFCzAPnoZyNpHPCjqC9K4crxeqIEhzMG
 aylDsITvlQr04WUFNxEW674I5axJicVqLiVJ7oYwAQcqM/hd
X-Received: by 2002:a17:90a:c796:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38f57f023e2mr2502724a91.0.1785168292617; Mon, 27 Jul 2026
 09:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260722165925.15805-1-timur.kristof@gmail.com>
 <20260722165925.15805-5-timur.kristof@gmail.com>
 <20260722173453.CF3FA1F000E9@smtp.kernel.org>
 <CADnq5_P7-_RfV=MbbNw8w8CVEmE12t8ZgVSa5Pbz+ujjkB7Xcw@mail.gmail.com>
In-Reply-To: <CADnq5_P7-_RfV=MbbNw8w8CVEmE12t8ZgVSa5Pbz+ujjkB7Xcw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:04:40 -0400
X-Gm-Features: AUfX_mwpq0JK-tagzmnnC3l8RlwAoLulYEgYgRhrWefqgs1LtECeYxmJjsirTog
Message-ID: <CADnq5_Og8M+0Xn3U1+SY48PEstC13RgxqoKsoixco6bJw8h2Bg@mail.gmail.com>
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

Applied the series.  Thanks!

Alex

On Mon, Jul 27, 2026 at 11:44=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Jul 22, 2026 at 2:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Missing 2D tiling format modifier for 8 bpp formats on GFX6-8 =
breaks NV12/NV21 video playback.
> > --
> >
> > --- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anym=
ore ---
> > commit 9ecc330329837cba2c5f2f431e911a3b7ec6c4df
> > Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Subject: drm/amd/display: Don't use tiling flags anymore
> >
> > The commit removes the usage of legacy tiling flags from the amdgpu_dm
> > display code, transitioning all supported GPU generations to rely
> > completely on DRM format modifiers. It updates plane attribute filling,
> > surface updates, and cursor checks to reflect this change.
> >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > index a593a44ef97bc..87187c965d55c 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > [ ... ]
> > > @@ -1235,8 +1201,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attribute=
s(struct amdgpu_device *adev,
> > >                                                                      =
         address);
> > >               if (ret)
> > >                       return ret;
> > > -     } else if (afb->base.modifier =3D=3D DRM_FORMAT_MOD_INVALID) {
> > > -             amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling=
_info, tiling_flags);
> > >       } else {
> > >               ret =3D amdgpu_dm_plane_fill_gfx6_tiling_info_from_modi=
fier(tiling_info,
> > >                                                                      =
   afb->base.modifier);
> >
> > [Severity: High]
> > By removing the legacy tiling flags fallback here, does this break NV12=
/NV21
> > video playback on GFX6-8?
> >
> > Looking at amdgpu_dm_plane_add_gfx6_modifiers(), it appears to add 2D t=
iled
> > modifiers only for 16, 32, and 64 bpp:
> >
> >         amdgpu_dm_plane_add_modifier(mods, size, capacity,
> >                 amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TIL=
ED_THIN1));
> >         amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> >                 amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TIL=
ED_THIN1));
> >         amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> >                 amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TIL=
ED_THIN1));
> >
> > Since the modifier calculation for 8 bpp (which is required for NV12/NV=
21
> > formats) is missing, when userspace allocates a 2D-tiled NV12 framebuff=
er,
> > won't drm_plane_check_pixel_format() reject the atomic commit since it
> > cannot find the 8bpp modifier in the plane's advertised list?
>
> Shouldn't be an issue as we don't expose any YUV planes on DCE hardware.
>
> Alex
>
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722165925.=
15805-1-timur.kristof@gmail.com?part=3D4
