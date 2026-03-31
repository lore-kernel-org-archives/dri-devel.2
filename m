Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099AC10F9302
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C31C10EBE6;
	Tue, 31 Mar 2026 21:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GM7fl7IF";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A1010EBE6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 21:25:27 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12a71ade78cso7392876c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992327; cv=none;
 d=google.com; s=arc-20240605;
 b=WiBiZYubFRco0UeoYZQJrM3dDtfeWx2CDni+5XW70CaS4Tu1D2zppVk3omv50Yms4S
 3x/K4d8CEGVm9GpR/5j9R1jF2J+be+UZ20Tof4r+MWHT2fA9OEKDoRCkOArGWYSE8m3p
 sJ7eXMKANpSw+8UdAoKK3qjKQwIjepxXrMaQF85mHSVhGu9ZHDROrFe+OlvSY8Z6SSMW
 q95GU67QpyfYcy0yc9VTLaPIb/Dbd1mtjZmmfwWg3Ip36pAVoqHA9D/NiYSlW1jtQFyj
 yIDyNjTA6uHZErWLjkypCTQf977dU/J++k6iHohYJui9mtAqqj3NYu8k7GgEbQjoV4Gk
 o6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PJtc7MyBAFI3tK7+cZOuROzeutpIe2Qst2X4qNqsY80=;
 fh=aIWUNrzR+A8fAjxmJsoW0c75z+7VTK9zHOS87YL0oY4=;
 b=l0jmIAi5FeSJ5eIJm7ID/LflP9Q2K+rkUszoODUBOf2czx+PZJSZM6uklmwf4tM23i
 ow69EQyj5vxE+Ogz88yS2VKuiUNJUr6MEOxtEzQQhdrUfvPR0eQXia6Bo4pjdYg/SIdB
 FZQh4rRDz19tMXUGyQIpPHX5JZchROcMDm0pugb6+ISVjjktmp+1Eds64llvQzgXM/6e
 kfqFh/4vZjSBob9FGs8BN/Gu27/5MEpVxsp8skG82Ahi4u/itu1Qi8UyJwvGCitrUMs/
 zAsgPbJNtxvAIPlTOzrO0wmDsZ2UMClj5Q4nTEBsyLLfBJLO9Rh/qwBRWuHtCeB9bKiT
 jT5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774992327; x=1775597127; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJtc7MyBAFI3tK7+cZOuROzeutpIe2Qst2X4qNqsY80=;
 b=GM7fl7IFQmKbF8Q36R0LBFhMJCOW22OY5w1BICkQnTmCPj+y3WFIQLOH5FPEmLVVru
 B6Pyb1lsNDhxzEcCUISlN1mK/OLYjcXp9wvhf7wCRiNPGAwlS2x3kuSzyApRLpJUL7ug
 lq2+vgP0D53Xbc5lrz3TAHCbQLJ5Q+Jq2TpipRwEPhNCAgNYsY0b2GnY7fofXSIUapQ0
 DFx9qji38bp9f8yzi6X9MuhOLJbdrYOORSCLQQS7F3x1t4zzT/513qHmMqBaah2KE3/N
 Wv+nXgTlMhghQRSr0hUrgDRnxBohwuftmPkRJWqtLFsWBwC8ajRvowR/TuJC3WilNaT+
 Lkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774992327; x=1775597127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJtc7MyBAFI3tK7+cZOuROzeutpIe2Qst2X4qNqsY80=;
 b=Hf729QY6YjzfaptvDC0XRnPKJzC9yzJZBInwS6hBHgb3CZkK87xP5HyTS/qTMmNTmg
 lN/YjGOL2cQD2pBvjkVplrjXVrxInVnnF2Xleik29yPslQ5+X3LfEK/jvthhoT4OFUz3
 nrluM+HbuILWcMACk5XSjiac/Ftcx+OLzxDUolnL2A4G83ydpXli7/sEW4b33xebt5H1
 EMapzZ1NAzo/UZZzUB7OBj9hBzGk3gX7TeEbDAiLLX3vxpNOt24p74CgwTKfeqF2z4mR
 S6lMo/bNh3xYTLdAJNelxtolX79ppJkpViu6KwVSbhu4yvSL4u46sIYW8Fw5ABUMKvja
 snfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkrpnhGC7Q45+bh5sPDduLaLHHcwTw4FspuyiYxyEycrVzM/sZn+pdtr6s/A0hhSGdm7RVgHzB+Es=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1jCqid3OgOj26wyrC4mF8+KSRT4Oik3A9cY34ZgOLaOxZLMFP
 /t+Tx3yazSocA6lnQdGV2XgdPyYcifYwyuGIkcZd7NB2q96JMq8hGYfkP2ZxgrpSOe4eUPZAQg5
 yYB7biXVdpK8isATnB5UmpyqIZWciRgw=
X-Gm-Gg: ATEYQzzxst5yLHg7T3IAn6spC8KXvn9soZL5NrbUuA81yaeDKZsnpDHjfQ7fHNQgI0b
 IwXz2je94995U6Mh+eh4HEzB4EUbsXP1FeHVDnkqlAXtSdxP/vUp6lQa1DK2NxS8MWlxHFrGhhV
 kr0guHmcdR3GSuUMEIwc1wnv83MJpQE4tWesUEZ2HV+zovebpa8o1D9VPQBVeZO4fVV557HojYX
 eliXavOEc7XciCq0ylHFy+LDFDwQ5lLYSAzEd7eu74q+9p5R6Gbe+B9oVcNHIwUlZmLjlcl5jm4
 yufYjqq4RTfcnQgObY9WP/izBUTRcHfJyyAqv+rH
X-Received: by 2002:a05:7022:6987:b0:128:ca83:5aa1 with SMTP id
 a92af1059eb24-12be649ca84mr651704c88.16.1774992326852; Tue, 31 Mar 2026
 14:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
 <CAEsyxyie_2Tr9_3vqz3N=_9u=Z1b4SqBGMcptKW454XH5ZEsQw@mail.gmail.com>
 <220ec077-3187-457e-b42a-7b2bd87528f6@amd.com>
In-Reply-To: <220ec077-3187-457e-b42a-7b2bd87528f6@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Tue, 31 Mar 2026 23:24:49 +0200
X-Gm-Features: AQROBzBHWVFUsPLoXaBf7RRWqL7r70mbphe3rcN6urpAHwoTn5UJxbjgRylS-48
Message-ID: <CAEsyxyiuzpd3Ykd7YFGiBDNJ8oFmSTHLXOSs1EqQOsVTn5a7bA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: "Kovac, Krunoslav" <kkovac@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Harry Wentland <harry.wentland@amd.com>, "Kovac,
 Krunoslav" <Krunoslav.Kovac@amd.com>, 
 "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000001f0373064e589be7"
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

--0000000000001f0373064e589be7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:06=E2=80=AFPM Kovac, Krunoslav <kkovac@amd.com> =
wrote:

> On 3/31/2026 16:13, Mario Kleiner wrote:
> > To clarify: I do agree with Michel and Kruno that in most typical use
> cases
> > you'd probably want to get all or as much of the internal HW pipelines
> > precision as possible to the Eyes of the person in front of the display=
,
> or
> > at least an approximation of it. My understanding of current AMD hardwa=
re
> > is that you can have an up to 16 bpc framebuffer, which gets
> > truncated/rounded down to 12 bpc somewhere in the pipeline (gamma table=
s,
> > color transformation matrices, etc.) and then retained at 12 bpc until
> > shortly before the actual output, which can be 6, 8, 10 or 12 bpc
> depending
> > on connection type, bandwidth, "max bpc" etc.
>
> At the start of the pipeline we immediately go into a 19bpc space. Except
> around 3DLUT, all color processing happens at this precision.
> It's near the end of the color pipeline that we go from 19 to 12 in a
> block called DENORM. Other than some specialized ABM block, we then go in=
to
> FMT that does 12 -> monitor bpc.
>

Interesting new info, good to know.


> I didn't see any difference with my capture HW for 8bpc->8bpc either, so =
I
> left spatial dithering as default. There's enough extra precision that
> apparently it doesn't matter here.
>

Yes, that satisfies both the high precision and identity passthrough use
cases.


>
> Maybe your case always has an FP16 plane, say compositing space?
>

It all depends on the application. My software is not a single purpose
self-contained app, but a toolkit - a set of extensions for
Matlab/Octave/Python with many wildly different use cases and requirements.
Think of it as SDL, but tailored to neuroscience research and related
bio-medical research, and for scientists with usually only basic
programming skills (Matlab scripting language or Python). Can be 8 bpc SDR,
10 bpc SDR or HDR, effective ~11 bpc unorm SDR (hw that can do fp16
surfaces but not rgba16 unorm) 12 bpc (AMD hw with rgba16unorm framebuffer
-> native 12 bpc or dithered 12 bpc) SDR/HDR, 14 bpc or 16 bpc SDR on
special (and very expensive) neuroscience display equipment. For high
precision modes, the software often uses fp32 "framebuffers" and its own
composition pipeline with various GLSL shader plugins for post-processing,
then outputting to the actual 8/10/fp16/16bpc framebuffer via OpenGL or
Vulkan or OpenXR for VR applications. So it's difficult to explain the
specific use case, because there isn't a specific use case.


> > If the final output depth is lower than 12 bpc one would usually still
> want
> > an approximation of 12 bpc reaching the "eyes" of the person
> > (/animal/retina in some of the use cases of my research users) in front
> of
> > the display, and spatial dithering down from 12 bpc -> 10/8/6 bpc is th=
e
> > way to go. That's also true for most of my users use cases, and
> especially
> > for the use cases involving 16 bpc framebuffers/surfaces.
> >
> > Some more special use cases will require an absolutely perfect identity
> > passthrough of pixel color values, where any kind of transformation in
> the
> > pipeline, including spatial dithering, would be bad. Some of your
> customers
> > seem to require this for 10 bpc output. Some of my users require this
> for 8
> > bpc output of a 8 bpc framebuffer. Specifically, some neuroscience
> research
> > requires up to 16 bpc color or luminance precision, but all graphics
> cards
> > and normal displays max out at 12 bpc. There exist special display
> devices
> > and converters that can do up to 16 bpc precision (native or via some
> form
> > of spatial or temporal dithering), e.g., the Bits# or Display++ from
> > Cambridge Research Systems (UK) and Datapixx, ViewPixx and ProPixx
> devices
> > from VPixx in Canada. These are essentially active DVI-D or DisplayPort=
 8
> > bpc to 14 bpc or 16 bpc VGA analog converters with 14 or 16 DAC's, or
> > special purpose LCD panels or DLP video projectors which can do 14/16 b=
pc
> > precision. Because commercially available gpu's and PHY's do not suppor=
t
> > true 16 bpc output (the DP and HDMI standards specify such signal
> formats,
> > but no actual transmitter hardware afaik), these devices encode 16 bpc
> > color content on top of a 8 bpc framebuffer and link: The software
> renders
> > 16 bpc unorm/fp or 32 bpc float content and then uses GLSL shaders to
> split
> > up 16 bpc into 8 MSB and 8 LSB and puts the 8 MSB into the 8 bpc red
> > channel and 8 LSB into the 8 bpc blue channel (and 8 bpc color index
> > overlay into the 8 bpc blue channel) to false-color encode a pure
> grayscale
> > image + some 256 color index palette overlay. Or for true color images,
> it
> > sacrifices half the horizontal resolution by putting 8 MSB of each colo=
r
> > channel into the even pixel columns, and the 8 LSB into the odd pixel
> > columns. So a false color 8 rgb8 framebuffer -> pixel identity
> passthrough
> > -> 8 bpc link output via DVI-D or DP, and the video sink then decodes a=
nd
> > reassembles again into 16 bpc color/luminance content and uses special
> > display hardware to these 16 bpc into the eyes of the being in front of
> the
> > display. Some medical imaging displays, e.g., for Radiology use (e.g.,
> > cancer screening) in hospitals or at eye doctors, also use such special
> > framebuffer encodings to get > 12 bpc content out of the gpu Siemens
> > Medical and similar companies sell these for research and medical use.
> >
> > Another use case of my users requiring perfect pixel identity passthrou=
gh
> > is to encode side-band signals into the scanlines of the vactive area o=
f
> an
> > image, encoding binary control data and packets as false color pixel
> > values, similar to the various info packets transmitted inside vblank.
> This
> > for control data that is very custom and not standardized in any Vesa o=
r
> > HDMI standard, e.g., in my case to control special neuroscience hardwar=
e,
> > e.g., sound microsecond synchronized to pictures, sending various analo=
g
> > waveforms to electrophysiology equipment or haptic stimulation, or
> digital
> > trigger signals to transmagnetic stimulators (magnetic pulses to brain
> > regions), or start/stop/synchronize various recording equipment (fMRI a=
nd
> > MEG scanners, electrophysiological recordings, video capture etc.)
> >
> > For the pixel identity passthrough, the difference is that I only need =
it
> > for 8 bpc framebuffers to 8 bpc (DVI-D or DP) outputs atm., and that
> works
> > fine under OpenGL with an identity gamma table loaded, despite spatial
> > dithering down to 8 bpc active. Right now, I neither have the need nor
> the
> > equipment to verify 10 bpc identity passthrough, as my capture hw can
> only
> > process 8 bpc signals.
> >
> > I don't think there is an automated way for the driver to guess the
> proper
> > configuration in all cases. The proper solution would be a drm connecto=
r
> > property that can be queried/set to control dithering
> on/off/method/target
> > depth, and plumb that through. Or maybe something that could be derived
> > from existing connector properties? E.g., if a content property has
> > something standardized that essentially requires identity passthrough? =
In
> > my case, it is important that such settings still fully work under nati=
ve
> > X11 via RandR properties. Something that is only realistically accessib=
le
> > via an atomic client or Wayland server is insufficient for me.
> >
> > So yes, as Michel points out, there is a disconnect between the
> framebuffer
> > color depth and hw pipeline depth and what dither settings should be
> used.
> > But Harry's patch, if it worked, would be at least a good enough
> > guess-o-matic or heuristic to make the situation better in the short
> > term, even if it is not optimal. Or at least for my users use cases it
> > would make it better, as for my use cases the framebuffer color depth
> > usually corresponds to what my users need as effective output precision=
.
> > For me there is also the urgency of wanting to have a not broken
> situation
> > for Linux 7.0 and upcoming Ubuntu 26.04-LTS / Fedora Core 44. If I have
> the
> > choice of having the current state, or this patch, I'd gladly have this
> > patch as a step up.
> >
> > I hoped this patch would be still simple and contained and early enough=
,
> to
> > make it into drm-fixes for Linux 7.0, and maybe be backportable to olde=
r
> > kernels, as all kernels since late 2023 are impaired from my use cases
> > point of view. But as I said, my testing didn't confirm the patch is
> > actually working - it always ends up enabling dithering. Which, to be
> > sneaky, would also be a step up for me, as that "only" breaks use cases
> > that don't affect my users specifically :/
> >
> > On Tue, Mar 31, 2026 at 9:16=E2=80=AFAM Michel D=C3=A4nzer <
> michel.daenzer@mailbox.org>
> > wrote:
> >
> >> On 3/30/26 19:36, Harry Wentland wrote:
> >>> On 2026-03-30 12:20, Michel D=C3=A4nzer wrote:
> >>>> On 3/24/26 20:20, Mario Kleiner wrote:
> >>>>> On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav <
> >> Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
> >>>
> >>>>>>      I believe we don't have surface info in that code, but one wa=
y
> to
> >> work around it would be to use spatial dithering for FP16/ARGB16 and
> >> rounding for 10 bits. But if we just switch to spatial, some of the
> earlier
> >> complaints about 10-bit output having one-off bit errors will be comin=
g
> >> back.
> >>>>>
> >>>>> Looking at all callers of
> resource_build_bit_depth_reduction_params(),
> >> they all have access to the associated "struct pipe_ctx", which should
> give
> >> access to pipe_ctx ->plane_state->format of an associated display
> plane. I
> >> could prepare a patch that passes the pipe_ctx from each caller
> >> into resource_build_bit_depth_reduction_params() and that function cou=
ld
> >> check if a 16 bpc framebuffer is in use and switch to spatial ditherin=
g
> >> down-to-10-bpc in this case, and leave the rounding/truncation to 10 b=
pc
> >> otherwise.
> >>>>
> >>>> That doesn't really make sense, the output of the display HW colour
> >> pipeline has more than 10 bpc regardless of framebuffer format.
> >>>>
> >>>
> >>> The output will be determined by the link bandwidth, display-advertis=
ed
> >> supported bpc, and userspace-selected "max bpc" on a drm_connector. Th=
is
> >> could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to
> the
> >> internal DCN HW representation of the values?
> >>
> >> I am indeed.
> >>
> >>> They're higher, but that's somewhat irrelevant.
> >>
> >> How so? Surely dithering is applied to those values, not to the origin=
al
> >> values sampled from the framebuffer.
> >>
> >>
> >> --
> >> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa de=
veloper
> >> https://redhat.com             \               Libre software
> enthusiast
> >>
> >
>
>

--0000000000001f0373064e589be7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31,=
 2026 at 11:06=E2=80=AFPM Kovac, Krunoslav &lt;<a href=3D"mailto:kkovac@amd=
.com">kkovac@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 3/31/2026 16:13, Mario Kleiner wrote:<br>
&gt; To clarify: I do agree with Michel and Kruno that in most typical use =
cases<br>
&gt; you&#39;d probably want to get all or as much of the internal HW pipel=
ines<br>
&gt; precision as possible to the Eyes of the person in front of the displa=
y, or<br>
&gt; at least an approximation of it. My understanding of current AMD hardw=
are<br>
&gt; is that you can have an up to 16 bpc framebuffer, which gets<br>
&gt; truncated/rounded down to 12 bpc somewhere in the pipeline (gamma tabl=
es,<br>
&gt; color transformation matrices, etc.) and then retained at 12 bpc until=
<br>
&gt; shortly before the actual output, which can be 6, 8, 10 or 12 bpc depe=
nding<br>
&gt; on connection type, bandwidth, &quot;max bpc&quot; etc.<br>
<br>
At the start of the pipeline we immediately go into a 19bpc space. Except a=
round 3DLUT, all color processing happens at this precision.<br>
It&#39;s near the end of the color pipeline that we go from 19 to 12 in a b=
lock called DENORM. Other than some specialized ABM block, we then go into =
FMT that does 12 -&gt; monitor bpc.<br></blockquote><div><br></div><div>Int=
eresting new info, good to know.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
I didn&#39;t see any difference with my capture HW for 8bpc-&gt;8bpc either=
, so I left spatial dithering as default. There&#39;s enough extra precisio=
n that apparently it doesn&#39;t matter here.<br></blockquote><div><br></di=
v><div>Yes, that satisfies both the high precision and identity passthrough=
 use cases.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Maybe your case always has an FP16 plane, say compositing space?<br></block=
quote><div><br></div><div>It all depends on the application. My software is=
 not a single purpose self-contained app, but a toolkit - a set of extensio=
ns for Matlab/Octave/Python with many wildly different use cases and requir=
ements. Think of it as SDL, but tailored to neuroscience research and relat=
ed bio-medical research, and for scientists with usually only basic program=
ming skills (Matlab scripting language or Python). Can be 8 bpc SDR, 10 bpc=
 SDR or HDR, effective ~11 bpc unorm SDR (hw that can do fp16 surfaces but =
not rgba16 unorm) 12 bpc (AMD hw with rgba16unorm framebuffer -&gt; native =
12 bpc or dithered 12 bpc) SDR/HDR, 14 bpc or 16 bpc SDR on special (and ve=
ry expensive) neuroscience display equipment. For high precision modes, the=
 software often uses fp32 &quot;framebuffers&quot; and its own composition =
pipeline with various GLSL shader plugins for post-processing, then outputt=
ing to the actual 8/10/fp16/16bpc framebuffer via OpenGL or Vulkan or OpenX=
R for VR applications. So it&#39;s difficult to explain the specific use ca=
se, because there isn&#39;t a specific use case.</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; If the final output depth is lower than 12 bpc one would usually still=
 want<br>
&gt; an approximation of 12 bpc reaching the &quot;eyes&quot; of the person=
<br>
&gt; (/animal/retina in some of the use cases of my research users) in fron=
t of<br>
&gt; the display, and spatial dithering down from 12 bpc -&gt; 10/8/6 bpc i=
s the<br>
&gt; way to go. That&#39;s also true for most of my users use cases, and es=
pecially<br>
&gt; for the use cases involving 16 bpc framebuffers/surfaces.<br>
&gt; <br>
&gt; Some more special use cases will require an absolutely perfect identit=
y<br>
&gt; passthrough of pixel color values, where any kind of transformation in=
 the<br>
&gt; pipeline, including spatial dithering, would be bad. Some of your cust=
omers<br>
&gt; seem to require this for 10 bpc output. Some of my users require this =
for 8<br>
&gt; bpc output of a 8 bpc framebuffer. Specifically, some neuroscience res=
earch<br>
&gt; requires up to 16 bpc color or luminance precision, but all graphics c=
ards<br>
&gt; and normal displays max out at 12 bpc. There exist special display dev=
ices<br>
&gt; and converters that can do up to 16 bpc precision (native or via some =
form<br>
&gt; of spatial or temporal dithering), e.g., the Bits# or Display++ from<b=
r>
&gt; Cambridge Research Systems (UK) and Datapixx, ViewPixx and ProPixx dev=
ices<br>
&gt; from VPixx in Canada. These are essentially active DVI-D or DisplayPor=
t 8<br>
&gt; bpc to 14 bpc or 16 bpc VGA analog converters with 14 or 16 DAC&#39;s,=
 or<br>
&gt; special purpose LCD panels or DLP video projectors which can do 14/16 =
bpc<br>
&gt; precision. Because commercially available gpu&#39;s and PHY&#39;s do n=
ot support<br>
&gt; true 16 bpc output (the DP and HDMI standards specify such signal form=
ats,<br>
&gt; but no actual transmitter hardware afaik), these devices encode 16 bpc=
<br>
&gt; color content on top of a 8 bpc framebuffer and link: The software ren=
ders<br>
&gt; 16 bpc unorm/fp or 32 bpc float content and then uses GLSL shaders to =
split<br>
&gt; up 16 bpc into 8 MSB and 8 LSB and puts the 8 MSB into the 8 bpc red<b=
r>
&gt; channel and 8 LSB into the 8 bpc blue channel (and 8 bpc color index<b=
r>
&gt; overlay into the 8 bpc blue channel) to false-color encode a pure gray=
scale<br>
&gt; image + some 256 color index palette overlay. Or for true color images=
, it<br>
&gt; sacrifices half the horizontal resolution by putting 8 MSB of each col=
or<br>
&gt; channel into the even pixel columns, and the 8 LSB into the odd pixel<=
br>
&gt; columns. So a false color 8 rgb8 framebuffer -&gt; pixel identity pass=
through<br>
&gt; -&gt; 8 bpc link output via DVI-D or DP, and the video sink then decod=
es and<br>
&gt; reassembles again into 16 bpc color/luminance content and uses special=
<br>
&gt; display hardware to these 16 bpc into the eyes of the being in front o=
f the<br>
&gt; display. Some medical imaging displays, e.g., for Radiology use (e.g.,=
<br>
&gt; cancer screening) in hospitals or at eye doctors, also use such specia=
l<br>
&gt; framebuffer encodings to get &gt; 12 bpc content out of the gpu Siemen=
s<br>
&gt; Medical and similar companies sell these for research and medical use.=
<br>
&gt; <br>
&gt; Another use case of my users requiring perfect pixel identity passthro=
ugh<br>
&gt; is to encode side-band signals into the scanlines of the vactive area =
of an<br>
&gt; image, encoding binary control data and packets as false color pixel<b=
r>
&gt; values, similar to the various info packets transmitted inside vblank.=
 This<br>
&gt; for control data that is very custom and not standardized in any Vesa =
or<br>
&gt; HDMI standard, e.g., in my case to control special neuroscience hardwa=
re,<br>
&gt; e.g., sound microsecond synchronized to pictures, sending various anal=
og<br>
&gt; waveforms to electrophysiology equipment or haptic stimulation, or dig=
ital<br>
&gt; trigger signals to transmagnetic stimulators (magnetic pulses to brain=
<br>
&gt; regions), or start/stop/synchronize various recording equipment (fMRI =
and<br>
&gt; MEG scanners, electrophysiological recordings, video capture etc.)<br>
&gt; <br>
&gt; For the pixel identity passthrough, the difference is that I only need=
 it<br>
&gt; for 8 bpc framebuffers to 8 bpc (DVI-D or DP) outputs atm., and that w=
orks<br>
&gt; fine under OpenGL with an identity gamma table loaded, despite spatial=
<br>
&gt; dithering down to 8 bpc active. Right now, I neither have the need nor=
 the<br>
&gt; equipment to verify 10 bpc identity passthrough, as my capture hw can =
only<br>
&gt; process 8 bpc signals.<br>
&gt; <br>
&gt; I don&#39;t think there is an automated way for the driver to guess th=
e proper<br>
&gt; configuration in all cases. The proper solution would be a drm connect=
or<br>
&gt; property that can be queried/set to control dithering on/off/method/ta=
rget<br>
&gt; depth, and plumb that through. Or maybe something that could be derive=
d<br>
&gt; from existing connector properties? E.g., if a content property has<br=
>
&gt; something standardized that essentially requires identity passthrough?=
 In<br>
&gt; my case, it is important that such settings still fully work under nat=
ive<br>
&gt; X11 via RandR properties. Something that is only realistically accessi=
ble<br>
&gt; via an atomic client or Wayland server is insufficient for me.<br>
&gt; <br>
&gt; So yes, as Michel points out, there is a disconnect between the frameb=
uffer<br>
&gt; color depth and hw pipeline depth and what dither settings should be u=
sed.<br>
&gt; But Harry&#39;s patch, if it worked, would be at least a good enough<b=
r>
&gt; guess-o-matic or heuristic to make the situation better in the short<b=
r>
&gt; term, even if it is not optimal. Or at least for my users use cases it=
<br>
&gt; would make it better, as for my use cases the framebuffer color depth<=
br>
&gt; usually corresponds to what my users need as effective output precisio=
n.<br>
&gt; For me there is also the urgency of wanting to have a not broken situa=
tion<br>
&gt; for Linux 7.0 and upcoming Ubuntu 26.04-LTS / Fedora Core 44. If I hav=
e the<br>
&gt; choice of having the current state, or this patch, I&#39;d gladly have=
 this<br>
&gt; patch as a step up.<br>
&gt; <br>
&gt; I hoped this patch would be still simple and contained and early enoug=
h, to<br>
&gt; make it into drm-fixes for Linux 7.0, and maybe be backportable to old=
er<br>
&gt; kernels, as all kernels since late 2023 are impaired from my use cases=
<br>
&gt; point of view. But as I said, my testing didn&#39;t confirm the patch =
is<br>
&gt; actually working - it always ends up enabling dithering. Which, to be<=
br>
&gt; sneaky, would also be a step up for me, as that &quot;only&quot; break=
s use cases<br>
&gt; that don&#39;t affect my users specifically :/<br>
&gt; <br>
&gt; On Tue, Mar 31, 2026 at 9:16=E2=80=AFAM Michel D=C3=A4nzer &lt;<a href=
=3D"mailto:michel.daenzer@mailbox.org" target=3D"_blank">michel.daenzer@mai=
lbox.org</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt;&gt; On 3/30/26 19:36, Harry Wentland wrote:<br>
&gt;&gt;&gt; On 2026-03-30 12:20, Michel D=C3=A4nzer wrote:<br>
&gt;&gt;&gt;&gt; On 3/24/26 20:20, Mario Kleiner wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunosl=
av &lt;<br>
&gt;&gt; <a href=3D"mailto:Krunoslav.Kovac@amd.com" target=3D"_blank">Kruno=
slav.Kovac@amd.com</a> &lt;mailto:<a href=3D"mailto:Krunoslav.Kovac@amd.com=
" target=3D"_blank">Krunoslav.Kovac@amd.com</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 I believe we don&#39;t have su=
rface info in that code, but one way to<br>
&gt;&gt; work around it would be to use spatial dithering for FP16/ARGB16 a=
nd<br>
&gt;&gt; rounding for 10 bits. But if we just switch to spatial, some of th=
e earlier<br>
&gt;&gt; complaints about 10-bit output having one-off bit errors will be c=
oming<br>
&gt;&gt; back.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Looking at all callers of resource_build_bit_depth_red=
uction_params(),<br>
&gt;&gt; they all have access to the associated &quot;struct pipe_ctx&quot;=
, which should give<br>
&gt;&gt; access to pipe_ctx -&gt;plane_state-&gt;format of an associated di=
splay plane. I<br>
&gt;&gt; could prepare a patch that passes the pipe_ctx from each caller<br=
>
&gt;&gt; into resource_build_bit_depth_reduction_params() and that function=
 could<br>
&gt;&gt; check if a 16 bpc framebuffer is in use and switch to spatial dith=
ering<br>
&gt;&gt; down-to-10-bpc in this case, and leave the rounding/truncation to =
10 bpc<br>
&gt;&gt; otherwise.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; That doesn&#39;t really make sense, the output of the disp=
lay HW colour<br>
&gt;&gt; pipeline has more than 10 bpc regardless of framebuffer format.<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The output will be determined by the link bandwidth, display-a=
dvertised<br>
&gt;&gt; supported bpc, and userspace-selected &quot;max bpc&quot; on a drm=
_connector. This<br>
&gt;&gt; could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring=
 to the<br>
&gt;&gt; internal DCN HW representation of the values?<br>
&gt;&gt;<br>
&gt;&gt; I am indeed.<br>
&gt;&gt;<br>
&gt;&gt;&gt; They&#39;re higher, but that&#39;s somewhat irrelevant.<br>
&gt;&gt;<br>
&gt;&gt; How so? Surely dithering is applied to those values, not to the or=
iginal<br>
&gt;&gt; values sampled from the framebuffer.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GNOME / Xwayland / Mesa developer<br>
&gt;&gt; <a href=3D"https://redhat.com" rel=3D"noreferrer" target=3D"_blank=
">https://redhat.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Libre software enthu=
siast<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000001f0373064e589be7--
