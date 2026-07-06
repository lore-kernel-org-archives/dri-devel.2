Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF050C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F3F10E857;
	Mon,  6 Jul 2026 09:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJgDOpS9";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368B810E857
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:46:03 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39b2acd2414so14770631fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783331161; cv=none;
 d=google.com; s=arc-20260327;
 b=cQIwmO7uqqXrKmeC6MGVxmwPZrHBwFbXSe6Ggrxu32RqLNaeUL+S6aeLqNVG4xOdxw
 lVKFPKCsahYmg8euF0p/fTsZGf13epxpM2HDLSTDYBZN3sj7qsC7oH/AQyjvi1ua4knc
 Ef2i3yV74RWTPLbtV/lIdKtEnfmrVWvqEwXY2RmC92YrzxzWHB/P2JSUVajtxxE/c5UL
 jQOXCjcNO0BihpFOTbWDJndkpiW0FJ+sXH7e4vda266JtelNN++1PdAedOmW7UFDkFds
 d4/+RfDdKoOT6MJ7nQijyNmswmkNMtUd6X52zHoq8hUMAZ0pO4AwJG1Xqht9e5+ANgU6
 sZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PMEMLMncWw8sfZOVOI7T5ls/qkEdxo6gss1G42lMxvU=;
 fh=NVdf2cEPp+vcRT5MxnApYu2RXnwD6WKcZL4sJXCpc6s=;
 b=sXIMFBGO4de2PBWvcjeZWZ1uAwhlsttd5aPwOGxyMorGXfqnwxSAanuhHWvUks9NZz
 rE903O2LntxmF9BkGk4SZxywbrB/lRODV4BHa+i+sAkTt21HqEXz5Ciayg/rv6FrgGFZ
 ArpOePT02Zj7WomO8Xz4CpNmmcyYOQamnUlvNxDJauSrukrfanagm1ws5V957VQP/+XJ
 WA7Osc6nR5+RmFBcDbcUspiZgn1tattmkv+P7YbW3sLo4FNWgIUEmwDJzhwWmlOLun0z
 Uh0vOgES/TqhtYUT2wBhvuv/JDL1mnRLPm3D2T0r+qCklcSkPiucg68htCLOnXyXQxxK
 Jemg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783331161; x=1783935961; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PMEMLMncWw8sfZOVOI7T5ls/qkEdxo6gss1G42lMxvU=;
 b=kJgDOpS9uHgJmsiT9XqdPv6IuqbGIG3FdgmWbPJRLafz0iEELFrezRndqQOvGUeKDj
 7ivVZPJG43WuZzoIk5GgZn0QMJMUvT5dAlXCbkq0hdNX3gPx50jqgywaODitskxMeDzA
 cPhG43A2lXsRBjARGw2uMPi2eXm8RGaTjP7acIZIwkT/6mCrVxpuAaQyC5QA1IEvfrRw
 VOtwdHKlBbxY7hGhp3ZmVww/8d3fMY6HhR18pEvcb9nKn4HYLkmv71lQq7Lsmb4wMnwC
 cKCMzVgqBNeRALugJfL1HLNRdPwRwJ1k49irM449NGNu3d7D/xf7MzrQjYDWKlazlmHR
 OvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783331161; x=1783935961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMEMLMncWw8sfZOVOI7T5ls/qkEdxo6gss1G42lMxvU=;
 b=ZbpCQFZTNQz3fxPaSmrmKsJM0RkIenKEXUJu5YjOSWSmE9gJ+n/VMkcW1UX5Vi69pU
 UBVsv1M2AwM1IT66EMuraK6xsN+BQMT5eSJ+cghzRYxugWji6BLpwxKp199QaZwbG7fl
 kK3CPzqSkl4Oemx2ELMugIyqhChLoN/jRuLwbSFuNnjiQCdJlSuK31TsoL8zrDIK701u
 aO/SNZcAoCxdcatd0+riuta19toUph7VQHt7jWbl0OC0C13g5e01OR2QYwJx2sXcECU6
 it997soYRJWQGFZU5gIXbSZQAqER8bx2U7qZsVsviY5zL9FRauftrXoum77YiIwA1uWN
 YSJQ==
X-Gm-Message-State: AOJu0YxMkNXIpBzZiNewO+CjNEz0dKKGn1euqmUFLBx+EuXKdJgCyoqp
 1Fbv9fK39dgItTLL7ohFFNMJXIcohcdDCqTgwS/KhXeViLGoXKY8VXFFYS5VznNVmdsvPUnfsKx
 rZcXt626BPg9Ms9jKMABySdWmK9D7YoM=
X-Gm-Gg: AfdE7cm2TLgDqbNckYHeLl8ZreG6176PTbGv3A1Zgq1umMOc+rKvLwk7lq07ugG2hOT
 dujkSNNWDklYoHvG58vd7YPxzJcqPPzdKTwC9TiLwmCmnNEbi0fjFl0tt7Zi9W9vnjbO8eYoE6E
 z7GwtW2AqnAHamg3jpYkoHEHqr+OkCl07Xhxg5XlcFptaX+uVpj3/iCUbQf7Zz2U38KzLqnYUXu
 FBtlzHXFqAiZ4G6EWU0VfXZW2g/LwaNZztRd0N76AgqVVtf5B+qyVG0ljvE0lYtl3cUZA09lstX
 XN5gZGpAnSAYWYA9gZXguG0sDcZWF7pTt7KCmBAgMvH0jdpfWOt2FfQ9E+iAbo0=
X-Received: by 2002:a2e:bd87:0:b0:39b:35bd:e705 with SMTP id
 38308e7fff4ca-39b53d2dc89mr18415481fa.37.1783331160861; Mon, 06 Jul 2026
 02:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
 <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
 <aksVMhFr8YzedE1w@raspi>
In-Reply-To: <aksVMhFr8YzedE1w@raspi>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Mon, 6 Jul 2026 15:15:24 +0530
X-Gm-Features: AVVi8CfCMxaVPQe-lVS3pW2079rulbhZEt9BrcQm8_1wgvCLCAR2HVA8Bu0NmLI
Message-ID: <CAMB+xkY2rut-sEUMyFnXqYCNmyseP4nAGj4BfreORTTM=SN8_g@mail.gmail.com>
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com, 
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/alternative; boundary="0000000000005c33dc0655ee245b"
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

--0000000000005c33dc0655ee245b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:07=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote:
>
> On Sun, Jul 05, 2026 at 03:33:51AM +0530, Piyush Patle wrote:
> > On Fri, Jun 26, 2026 at 3:22=E2=80=AFPM Liu Ying <victor.liu@nxp.com> w=
rote:
> > >
> > > On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
> > >
> > > [...]
> > >
> > > > The current dc/ implementation is a multi-device component driver
with one
> > > > platform_driver per block bound via the component framework. The
downstream
> > > > i.MX95 driver is a single monolithic platform_driver mapping all
blocks from
> > > > one register base. Unifying appears to require reconciling two bind
models,
> > > > rather than only adding match_data.
> > >
> > > I think that upstream i.MX95 display controller driver would also be
based
> > > on the component helper.  That's something for sure.
> > >
> > > [...]
> > >
> > > > There is also anticipated divergence which is not yet upstream
(i.MX8QXP
> > > > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95
blit
> > > > engine), although mainline dc/ is KMS-only today.
> > >
> > > Just want to point out that I sent out v5 patch set[2] to add i.MX8QX=
P
> > > prefetch engine(DPRC + PRG) support for KMS.  That changes the
driver's
> > > mode setting code a lot.
> > >
> > > [2]
https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp=
.com/
> > >
> > > [...]
> > >
> > > > One question for Liu Ying is whether the separate-driver plus share=
d
> > > > helper-library approach is still the preferred direction, and where
the
> > > > helper boundary would be drawn (which blocks/ops are shared versus
> > > > implemented per driver).
> > >
> > > Yes, separate DRM drivers + a helper library approach is still the
direction
> > > I want.  I think that the drivers and library would sit in the same
> > > directory drivers/gpu/drm/imx/dc/.
> > >
> > > The purpose to add a library is to share code to reduce overall code
lines.
> > > I'd assume that shared blocks or common part of slightly different
blocks
> > > should be covered by the library.
> > >
> > > [...]
> > >
> > > > how the component and monolithic driver models
> > > > would be reconciled given the differences described above.
> > >
> > > Like I said above, I don't think upstream driver would be monolithic.
> > >
> > > --
> > > Regards,
> > > Liu Ying
> >
> > Hi Liu,
>
> Hi Piyush,
>
> >
> > A quick follow-up with some progress.
> > I went ahead with the refactoring we discussed and now have it working
on the
> > i.MX95 15x15 FRDM, following the component-based model.
> > The common implementations for ConstFrame, ExtDst, LayerBlend, FrameGen
and
> > the FetchUnit base have been moved into shared dc-lib-* helpers, with
>
> Can you please share the code in a public place, like github?
>

Sure. I've pushed the current work-in-progress branch here:
https://github.com/PiyushPatle26/linux-mecha-im95-wip/tree/imx95-dc-preview

The files you asked about are:
drivers/gpu/drm/imx/dc/dc-drv-common.c
drivers/gpu/drm/imx/dc/dc-lib-*.c
One thing I'd like to point out is that the pixel interleaver, display pixe=
l
link, LDB and LVDS PHY drivers are ports of the existing NXP downstream
drivers. The new work in this branch is mainly the DC refactoring into the
component model and the shared helper library.
> > SoC-specific register layouts and tables supplied as data. The per-SoC
glue is
> > split into dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while
>
> Same here, just want to see how dc-drv-common.c and dc-lib-* would look
like.
>
The files you mentioned are available under:
drivers/gpu/drm/imx/dc/dc-drv-common.c
drivers/gpu/drm/imx/dc/dc-lib-*.c
The helper library currently contains the common implementations for
ConstFrame, ExtDst, LayerBlend, FrameGen and the FetchUnit base.

> > i.MX95-specific blocks such as DomainBlend, Dither, FetchEco, FetchYUV,
> > HScaler and VScaler remain separate component drivers.
>
> i.MX8QXP display controller also has Dither, FetchEco, HScaler and
Vscaler,
> so they are not i.MX95-specific blocks.  To add minimal feautures at
first,
> we don't need to support them as of now.  i.MX95-specific FetchYUV is
similar
> to i.MX8QXP-specific FetchDecode, so maybe FetchYUV won't be a separate
> component driver at the end of the day.  To start up small, I think the
> must-have DomainBlend and Dither(for Data-Enable, HSync and VSync polarit=
y
> controls) and two FetchLayers can be enabled to support two display
pipelines.
>

Okay, I've reduced the implementation accordingly. The current branch
only keeps DomainBlend, Dither and two FetchLayers. FetchEco, FetchYUV,
HScaler and VScaler have been dropped for now.
> BTW, do you have the i.MX95 TRM?  If no, then it would be difficult for
you
> to add DT bindings for *all* blocks.  Note that the DT bindings are
supposed
> to be complete at the first place.
>

Yes, I do.

> >
> > The implementation is functional on the FRDM over the pipeline
> > DPU -> pixel-interleaver -> pixel-link -> LDB -> LVDS PHY -> IT6263 ->
HDMI
>
> As I said before in separate mail thread, pixel link is not used in the
LVDS
> display pipeline, but instead it's only used in the MIPI DSI display
pipeline.
>

Thanks for pointing that out. After checking the TRM, I updated the DT grap=
h
so the LVDS pipeline is now:

DC -> Pixel-interleaver -> LDB -> LVDS PHY -> IT6263 -> HDMI

Removing display_pixel_link from the LVDS path also required moving the
bridge
format translation into the pixel interleaver driver.
> >
> > EDID is read successfully, the initial modeset works for all tested
modes
> > (1920x1080@60, 1280x720@60, 720x480 and 640x480), and Weston and sway
both run.
> >
> > There are still two known limitations. The initial modeset works, but
> > subsequent mode changes currently wedge the ExtDst content shadow load,
which
> > appears related to the lack of a reset path for the i.MX95 FrameGen.
>
> Not sure what's the cause of the issue, but FrameGen needs to be disabled
and
> then re-enabled if you want to do a full modeset.  I'd say that's not a
reset
> path.  This critical issue needs to be fixed before posting formal
patches.
>

Understood. I'll continue investigating the modeset issue before posting th=
e
formal patch series.

> > In
> > addition, the DSI path is implemented on the DC side but remains
unvalidated.
>
> It's fine to support the LVDS display pipeline first as long as it doesn'=
t
> do harm to the MIPI DSI display pipeline support.  So, maybe drop the
latter
> first.

I've done that in the current branch. It now focuses only on the validated
LVDS pipeline.

>
> >
> > The implementation is currently based on v7.2-rc1 together with your
prefetch
> > v5 series.
> >
> > The work is now ready to be posted as patch series: Adding LVDS/DSI
> > i.MX95 support.
> >
> >
> > Regards,
> > Piyush Patle
>
> --
> Regards,
> Liu Ying

Thanks again for taking the time to review this.

Regards,
Piyush Patle

--0000000000005c33dc0655ee245b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br>On Mon, Jul 6, 2=
026 at 8:07=E2=80=AFAM Liu Ying &lt;<a href=3D"mailto:victor.liu@nxp.com" t=
arget=3D"_blank">victor.liu@nxp.com</a>&gt; wrote:<br>&gt;<br>&gt; On Sun, =
Jul 05, 2026 at 03:33:51AM +0530, Piyush Patle wrote:<br>&gt; &gt; On Fri, =
Jun 26, 2026 at 3:22=E2=80=AFPM Liu Ying &lt;<a href=3D"mailto:victor.liu@n=
xp.com" target=3D"_blank">victor.liu@nxp.com</a>&gt; wrote:<br>&gt; &gt; &g=
t;<br>&gt; &gt; &gt; On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle=
 wrote:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; [...]<br>&gt; &gt; &gt;<br>&gt;=
 &gt; &gt; &gt; The current dc/ implementation is a multi-device component =
driver with one<br>&gt; &gt; &gt; &gt; platform_driver per block bound via =
the component framework. The downstream<br>&gt; &gt; &gt; &gt; i.MX95 drive=
r is a single monolithic platform_driver mapping all blocks from<br>&gt; &g=
t; &gt; &gt; one register base. Unifying appears to require reconciling two=
 bind models,<br>&gt; &gt; &gt; &gt; rather than only adding match_data.<br=
>&gt; &gt; &gt;<br>&gt; &gt; &gt; I think that upstream i.MX95 display cont=
roller driver would also be based<br>&gt; &gt; &gt; on the component helper=
.=C2=A0 That&#39;s something for sure.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =
[...]<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; There is also anticipated di=
vergence which is not yet upstream (i.MX8QXP<br>&gt; &gt; &gt; &gt; prefetc=
h/PRG, LTS and tiling modifiers, and the downstream i.MX95 blit<br>&gt; &gt=
; &gt; &gt; engine), although mainline dc/ is KMS-only today.<br>&gt; &gt; =
&gt;<br>&gt; &gt; &gt; Just want to point out that I sent out v5 patch set[=
2] to add i.MX8QXP<br>&gt; &gt; &gt; prefetch engine(DPRC + PRG) support fo=
r KMS.=C2=A0 That changes the driver&#39;s<br>&gt; &gt; &gt; mode setting c=
ode a lot.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; [2] <a href=3D"https://lore.=
kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/" target=
=3D"_blank">https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb=
6c6d4941@nxp.com/</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt; [...]<br>&gt; &gt=
; &gt;<br>&gt; &gt; &gt; &gt; One question for Liu Ying is whether the sepa=
rate-driver plus shared<br>&gt; &gt; &gt; &gt; helper-library approach is s=
till the preferred direction, and where the<br>&gt; &gt; &gt; &gt; helper b=
oundary would be drawn (which blocks/ops are shared versus<br>&gt; &gt; &gt=
; &gt; implemented per driver).<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Yes, se=
parate DRM drivers + a helper library approach is still the direction<br>&g=
t; &gt; &gt; I want.=C2=A0 I think that the drivers and library would sit i=
n the same<br>&gt; &gt; &gt; directory drivers/gpu/drm/imx/dc/.<br>&gt; &gt=
; &gt;<br>&gt; &gt; &gt; The purpose to add a library is to share code to r=
educe overall code lines.<br>&gt; &gt; &gt; I&#39;d assume that shared bloc=
ks or common part of slightly different blocks<br>&gt; &gt; &gt; should be =
covered by the library.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; [...]<br>&gt; &=
gt; &gt;<br>&gt; &gt; &gt; &gt; how the component and monolithic driver mod=
els<br>&gt; &gt; &gt; &gt; would be reconciled given the differences descri=
bed above.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Like I said above, I don&#39=
;t think upstream driver would be monolithic.<br>&gt; &gt; &gt;<br>&gt; &gt=
; &gt; --<br>&gt; &gt; &gt; Regards,<br>&gt; &gt; &gt; Liu Ying<br>&gt; &gt=
;<br>&gt; &gt; Hi Liu,<br>&gt;<br>&gt; Hi Piyush,<br>&gt;<br>&gt; &gt;<br>&=
gt; &gt; A quick follow-up with some progress.<br>&gt; &gt; I went ahead wi=
th the refactoring we discussed and now have it working on the<br>&gt; &gt;=
 i.MX95 15x15 FRDM, following the component-based model.<br>&gt; &gt; The c=
ommon implementations for ConstFrame, ExtDst, LayerBlend, FrameGen and<br>&=
gt; &gt; the FetchUnit base have been moved into shared dc-lib-* helpers, w=
ith<br>&gt;<br>&gt; Can you please share the code in a public place, like g=
ithub?<br>&gt;<br><br>Sure. I&#39;ve pushed the current work-in-progress br=
anch here:<br><a href=3D"https://github.com/PiyushPatle26/linux-mecha-im95-=
wip/tree/imx95-dc-preview" target=3D"_blank">https://github.com/PiyushPatle=
26/linux-mecha-im95-wip/tree/imx95-dc-preview</a><br><p class=3D"gmail-isSe=
lectedEnd"><span>The files you asked about are:<br></span><span>drivers/gpu=
/drm/imx/dc/dc-drv-common.c<br></span><span>drivers/gpu/drm/imx/dc/dc-lib-*=
.c<br>One thing I&#39;d like to point out is that the pixel interleaver, di=
splay pixel</span><br><span>link, LDB and LVDS PHY drivers are ports of the=
 existing NXP downstream</span><br><span>drivers. The new work in this bran=
ch is mainly the DC refactoring into the</span><br><span>component model an=
d the shared helper library.</span></p>&gt; &gt; SoC-specific register layo=
uts and tables supplied as data. The per-SoC glue is<br>&gt; &gt; split int=
o dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while<br>&gt;<br>&g=
t; Same here, just want to see how dc-drv-common.c and dc-lib-* would look =
like.<br>&gt;<br><span>The files you mentioned are available under:<br></sp=
an><span>drivers/gpu/drm/imx/dc/dc-drv-common.c<br></span><span>drivers/gpu=
/drm/imx/dc/dc-lib-*.c<br></span><span>The helper library currently contain=
s the common implementations for<br></span><span>ConstFrame, ExtDst, LayerB=
lend, FrameGen and the FetchUnit base.</span><br><br>&gt; &gt; i.MX95-speci=
fic blocks such as DomainBlend, Dither, FetchEco, FetchYUV,<br>&gt; &gt; HS=
caler and VScaler remain separate component drivers.<br>&gt;<br>&gt; i.MX8Q=
XP display controller also has Dither, FetchEco, HScaler and Vscaler,<br>&g=
t; so they are not i.MX95-specific blocks.=C2=A0 To add minimal feautures a=
t first,<br>&gt; we don&#39;t need to support them as of now. =C2=A0i.MX95-=
specific FetchYUV is similar<br>&gt; to i.MX8QXP-specific FetchDecode, so m=
aybe FetchYUV won&#39;t be a separate<br>&gt; component driver at the end o=
f the day.=C2=A0 To start up small, I think the<br>&gt; must-have DomainBle=
nd and Dither(for Data-Enable, HSync and VSync polarity<br>&gt; controls) a=
nd two FetchLayers can be enabled to support two display pipelines.<br>&gt;=
<br><p><span>Okay, I&#39;ve reduced the implementation accordingly. The cur=
rent branch</span><br><span>only keeps DomainBlend, Dither and two FetchLay=
ers. FetchEco, FetchYUV,</span><br><span>HScaler and VScaler have been drop=
ped for now.</span></p>&gt; BTW, do you have the i.MX95 TRM?=C2=A0 If no, t=
hen it would be difficult for you<br>&gt; to add DT bindings for *all* bloc=
ks.=C2=A0 Note that the DT bindings are supposed<br>&gt; to be complete at =
the first place.<br>&gt;<br><br>Yes, I do.<br><br>&gt; &gt;<br>&gt; &gt; Th=
e implementation is functional on the FRDM over the pipeline<br>&gt; &gt; D=
PU -&gt; pixel-interleaver -&gt; pixel-link -&gt; LDB -&gt; LVDS PHY -&gt; =
IT6263 -&gt; HDMI<br>&gt;<br>&gt; As I said before in separate mail thread,=
 pixel link is not used in the LVDS<br>&gt; display pipeline, but instead i=
t&#39;s only used in the MIPI DSI display pipeline.<br>&gt;<br><p class=3D"=
gmail-isSelectedEnd"><span>Thanks for pointing that out. After checking the=
 TRM, I updated the DT graph</span><br><span>so the LVDS pipeline is now:<b=
r></span></p><p class=3D"gmail-isSelectedEnd"><span>DC -&gt; Pixel-interlea=
ver -&gt; LDB -&gt; LVDS PHY -&gt; IT6263 -&gt; HDMI</span></p><p><span>Rem=
oving display_pixel_link from the LVDS path also required moving the bridge=
</span><br><span>format translation into the pixel interleaver driver.</spa=
n></p>&gt; &gt;<br>&gt; &gt; EDID is read successfully, the initial modeset=
 works for all tested modes<br>&gt; &gt; (1920x1080@60, 1280x720@60, 720x48=
0 and 640x480), and Weston and sway both run.<br>&gt; &gt;<br>&gt; &gt; The=
re are still two known limitations. The initial modeset works, but<br>&gt; =
&gt; subsequent mode changes currently wedge the ExtDst content shadow load=
, which<br>&gt; &gt; appears related to the lack of a reset path for the i.=
MX95 FrameGen.<br>&gt;<br>&gt; Not sure what&#39;s the cause of the issue, =
but FrameGen needs to be disabled and<br>&gt; then re-enabled if you want t=
o do a full modeset.=C2=A0 I&#39;d say that&#39;s not a reset<br>&gt; path.=
=C2=A0 This critical issue needs to be fixed before posting formal patches.=
<br>&gt;<br><span><br>Understood. I&#39;ll continue investigating the modes=
et issue before posting the</span><br><span>formal patch series.<br></span>=
<br>&gt; &gt; In<br>&gt; &gt; addition, the DSI path is implemented on the =
DC side but remains unvalidated.<br>&gt;<br>&gt; It&#39;s fine to support t=
he LVDS display pipeline first as long as it doesn&#39;t<br>&gt; do harm to=
 the MIPI DSI display pipeline support.=C2=A0 So, maybe drop the latter<br>=
&gt; first.<br><br><span>I&#39;ve done that in the current branch. It now f=
ocuses only on the validated</span><br><span>LVDS pipeline.<br></span><br>&=
gt;<br>&gt; &gt;<br>&gt; &gt; The implementation is currently based on v7.2=
-rc1 together with your prefetch<br>&gt; &gt; v5 series.<br>&gt; &gt;<br>&g=
t; &gt; The work is now ready to be posted as patch series: Adding LVDS/DSI=
<br>&gt; &gt; i.MX95 support.<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Regard=
s,<br>&gt; &gt; Piyush Patle<br>&gt;<br>&gt; --<br>&gt; Regards,<br>&gt; Li=
u Ying<br><br><p><span>Thanks again for taking the time to review this.</sp=
an></p><p><span>Regards,</span><br><span>Piyush Patle</span></p><br></div>
</div>
</div>

--0000000000005c33dc0655ee245b--
