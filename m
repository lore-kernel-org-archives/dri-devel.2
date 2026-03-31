Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4526910F92FA
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 20:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49D910E0D4;
	Tue, 31 Mar 2026 20:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TY4Dz/Ig";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9F110E0D4
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:14:06 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1279eced0b9so8342405c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774988046; cv=none;
 d=google.com; s=arc-20240605;
 b=U4dvMMkAGNuqMmmi7tjaQq2iyHLWBXeQr3nlMJAGTZ1rIvXv77+BXMWZHXQSjDApYt
 sWJ0/ivirJrf8iM+I2vy/V/pRFJBgRVL2XxHtCBmpkUoowQERgZ7yLUriB1iaZ61++yf
 BgSCwk6QUl5DsSh656vXWcjoEtAISVO0gk/6yuS2w7zIx25V9lMYY8An5ysDiGZrgex4
 yI08eMzItQ8II7XTCvCl2myf2fGTcZ5lOWNDZmAoNoUIuJhNkdeuazsVbQ5nXor6c8VG
 6bOHGym43q2U+lrEAOYVSG/q2ZKurW2kTqu0QBEiQ3rK2WVhlIVxG7zX/EMzVge49jeN
 uSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=adlVBk9dfXeCp5nC+AZB/db4iwNHAQ6dLGmrn04g9ho=;
 fh=yKJ3ULC6ibWcJKzGukqHas2j+dSUVKc4UMe7FOkrg9M=;
 b=do+kiTzEPPPWbWYkft4VyPML5W6jcHdnAWKEyxw0cwVjy4C65yxchGpb5GcExYint6
 8x5sa18A4oVnHOU5OPzCbXL12RqHu5raSfa/Z6kbMDIkU7F509lqle8cqJrlh1yOPd0t
 CAuT/bU2RsDPAr1ieOTVF7udZFOb0oKMsQDdhJhh72mU91cBZQchqoRvlYegdURzm+0X
 eTzd6Utyc/193CdNDkVybBnYmeT4ItZVzofdaLi5X9XYuW2xRMha9IDZyWeVOU8ZoIJQ
 a4Wq1LnAa41eVkB/Kj4iXEPEEbQC1s9YyTNc5R0eGXXq7FyrBK+N4lVBE/4o07GRfnzK
 H/jg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774988046; x=1775592846; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=adlVBk9dfXeCp5nC+AZB/db4iwNHAQ6dLGmrn04g9ho=;
 b=TY4Dz/IgxNCuPDfBXs3+ZN9iKwNwb0oTsY6a1vBIZX+kEJmbG1F1YrvNwWfcPkbUCP
 CndavSQU4i0nKRzYA3PeZcD4JcE/zGqVqQDipjM7Nzv7Q1di8FostqTu60yZTuYhAbUj
 OkgM28mmD1l44R93lCqtwAJuzdM1mJjSRI5oLGYlMxjgaapjKuq3MeEWacwHoSptZEk2
 xshzmflEFcenfc92RD0QgElnKwkcD26o8w4xheUS6QQyKfcey7j/qzWtcALObywQgcP0
 kIpGzSbc1zVOxg3JTGBzSAnXn4CFMnHefmO1EL8zL0UDAGKea7ukog2PHlyBigv4/3BS
 3S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774988046; x=1775592846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adlVBk9dfXeCp5nC+AZB/db4iwNHAQ6dLGmrn04g9ho=;
 b=EU6FDPat83odY1Zux9JY7qAfRoHw1Cn00Q/HlY1S9HbrkvSAqs3MgkTyqXi+Tsxx0+
 YGRHeuoTTLKnyl+FcWkqXJgrOHKfCzLrKRQDLyCtQLyW7HPPIMSgINwKbrMsNTpKkQ7c
 tfsQ+/3FPqciNWKKfVxjXckL8HrlLymDr+xts01hDTc11Tyqo23IMDpxZ9fksNEesvBz
 eVRIkCoCJUW3KHlCN9uHDqmg9HUGjiaFj1zykBga/jyd01IolPzC1kzHaWWNGi56Ay/5
 5E1iknmupIomHjYCbcrn3ucRp2ukHOKhSh64NMUvaVMvdub6T8SdGTFr90XhWXX7tJzl
 x9gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBVTxXthbbwmxXiWmxEafTVTw1nZ8BNoPromi4NfAifbO4bdGy5mNQVJwLkJFWVW1xBEjKSqfhOaA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yye5SGcGdlNSvu8T8+zUMmUgT/kEZfVcbHpmuHP+o2D3z440Cdq
 k8BpptxUbMjf9mcEpkHh7Wyax+PaleZB0mLu3j2m7L1c/OaMXbZzrR9Y5uK/gjC/945YbimTK2D
 i1zMc7+K6cliWW/olvywELUEopnqp1cg=
X-Gm-Gg: ATEYQzwzE5yEh+oKONn+wi+jpIAxtdyQeN1Iw9Ty3r+sJV9FBRNQoxNi14P8j6+Oo+F
 /CJfXKBGAJTsI03qEh2kvwHkemCXYB6oV2se/RyfryJ2jx7y4wGwPpkkjcF19gPAdAZ/CyZBogD
 QqMjHc8oztn/bzw4u5mT7GVQO+8TjCtdFY5Dj/49cnS8BW6Q+gIVpGZCxDRa+GRfyoznA/pylhy
 mc7JCFeE0ND5pbLGLDf50n9KOqAPp8r1ilSlSmvqDZhYLUk/noDuR22+sJCEiWhlvguWmwzlgaR
 2KEKiUk=
X-Received: by 2002:a05:7022:ec2:b0:12a:91fe:f5c0 with SMTP id
 a92af1059eb24-12be64e9473mr526553c88.32.1774988045467; Tue, 31 Mar 2026
 13:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
In-Reply-To: <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Tue, 31 Mar 2026 22:13:29 +0200
X-Gm-Features: AQROBzBmAgvgKnAWQAopD4QXZRTRDfF6FFL1YbUaCBrKBwQkirDJAWsvUTo1US8
Message-ID: <CAEsyxyie_2Tr9_3vqz3N=_9u=Z1b4SqBGMcptKW454XH5ZEsQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Harry Wentland <harry.wentland@amd.com>, "Kovac,
 Krunoslav" <Krunoslav.Kovac@amd.com>, 
 "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000ee4641064e579b2a"
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

--000000000000ee4641064e579b2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To clarify: I do agree with Michel and Kruno that in most typical use cases
you'd probably want to get all or as much of the internal HW pipelines
precision as possible to the Eyes of the person in front of the display, or
at least an approximation of it. My understanding of current AMD hardware
is that you can have an up to 16 bpc framebuffer, which gets
truncated/rounded down to 12 bpc somewhere in the pipeline (gamma tables,
color transformation matrices, etc.) and then retained at 12 bpc until
shortly before the actual output, which can be 6, 8, 10 or 12 bpc depending
on connection type, bandwidth, "max bpc" etc.

If the final output depth is lower than 12 bpc one would usually still want
an approximation of 12 bpc reaching the "eyes" of the person
(/animal/retina in some of the use cases of my research users) in front of
the display, and spatial dithering down from 12 bpc -> 10/8/6 bpc is the
way to go. That's also true for most of my users use cases, and especially
for the use cases involving 16 bpc framebuffers/surfaces.

Some more special use cases will require an absolutely perfect identity
passthrough of pixel color values, where any kind of transformation in the
pipeline, including spatial dithering, would be bad. Some of your customers
seem to require this for 10 bpc output. Some of my users require this for 8
bpc output of a 8 bpc framebuffer. Specifically, some neuroscience research
requires up to 16 bpc color or luminance precision, but all graphics cards
and normal displays max out at 12 bpc. There exist special display devices
and converters that can do up to 16 bpc precision (native or via some form
of spatial or temporal dithering), e.g., the Bits# or Display++ from
Cambridge Research Systems (UK) and Datapixx, ViewPixx and ProPixx devices
from VPixx in Canada. These are essentially active DVI-D or DisplayPort 8
bpc to 14 bpc or 16 bpc VGA analog converters with 14 or 16 DAC's, or
special purpose LCD panels or DLP video projectors which can do 14/16 bpc
precision. Because commercially available gpu's and PHY's do not support
true 16 bpc output (the DP and HDMI standards specify such signal formats,
but no actual transmitter hardware afaik), these devices encode 16 bpc
color content on top of a 8 bpc framebuffer and link: The software renders
16 bpc unorm/fp or 32 bpc float content and then uses GLSL shaders to split
up 16 bpc into 8 MSB and 8 LSB and puts the 8 MSB into the 8 bpc red
channel and 8 LSB into the 8 bpc blue channel (and 8 bpc color index
overlay into the 8 bpc blue channel) to false-color encode a pure grayscale
image + some 256 color index palette overlay. Or for true color images, it
sacrifices half the horizontal resolution by putting 8 MSB of each color
channel into the even pixel columns, and the 8 LSB into the odd pixel
columns. So a false color 8 rgb8 framebuffer -> pixel identity passthrough
-> 8 bpc link output via DVI-D or DP, and the video sink then decodes and
reassembles again into 16 bpc color/luminance content and uses special
display hardware to these 16 bpc into the eyes of the being in front of the
display. Some medical imaging displays, e.g., for Radiology use (e.g.,
cancer screening) in hospitals or at eye doctors, also use such special
framebuffer encodings to get > 12 bpc content out of the gpu Siemens
Medical and similar companies sell these for research and medical use.

Another use case of my users requiring perfect pixel identity passthrough
is to encode side-band signals into the scanlines of the vactive area of an
image, encoding binary control data and packets as false color pixel
values, similar to the various info packets transmitted inside vblank. This
for control data that is very custom and not standardized in any Vesa or
HDMI standard, e.g., in my case to control special neuroscience hardware,
e.g., sound microsecond synchronized to pictures, sending various analog
waveforms to electrophysiology equipment or haptic stimulation, or digital
trigger signals to transmagnetic stimulators (magnetic pulses to brain
regions), or start/stop/synchronize various recording equipment (fMRI and
MEG scanners, electrophysiological recordings, video capture etc.)

For the pixel identity passthrough, the difference is that I only need it
for 8 bpc framebuffers to 8 bpc (DVI-D or DP) outputs atm., and that works
fine under OpenGL with an identity gamma table loaded, despite spatial
dithering down to 8 bpc active. Right now, I neither have the need nor the
equipment to verify 10 bpc identity passthrough, as my capture hw can only
process 8 bpc signals.

I don't think there is an automated way for the driver to guess the proper
configuration in all cases. The proper solution would be a drm connector
property that can be queried/set to control dithering on/off/method/target
depth, and plumb that through. Or maybe something that could be derived
from existing connector properties? E.g., if a content property has
something standardized that essentially requires identity passthrough? In
my case, it is important that such settings still fully work under native
X11 via RandR properties. Something that is only realistically accessible
via an atomic client or Wayland server is insufficient for me.

So yes, as Michel points out, there is a disconnect between the framebuffer
color depth and hw pipeline depth and what dither settings should be used.
But Harry's patch, if it worked, would be at least a good enough
guess-o-matic or heuristic to make the situation better in the short
term, even if it is not optimal. Or at least for my users use cases it
would make it better, as for my use cases the framebuffer color depth
usually corresponds to what my users need as effective output precision.
For me there is also the urgency of wanting to have a not broken situation
for Linux 7.0 and upcoming Ubuntu 26.04-LTS / Fedora Core 44. If I have the
choice of having the current state, or this patch, I'd gladly have this
patch as a step up.

I hoped this patch would be still simple and contained and early enough, to
make it into drm-fixes for Linux 7.0, and maybe be backportable to older
kernels, as all kernels since late 2023 are impaired from my use cases
point of view. But as I said, my testing didn't confirm the patch is
actually working - it always ends up enabling dithering. Which, to be
sneaky, would also be a step up for me, as that "only" breaks use cases
that don't affect my users specifically :/

On Tue, Mar 31, 2026 at 9:16=E2=80=AFAM Michel D=C3=A4nzer <michel.daenzer@=
mailbox.org>
wrote:

> On 3/30/26 19:36, Harry Wentland wrote:
> > On 2026-03-30 12:20, Michel D=C3=A4nzer wrote:
> >> On 3/24/26 20:20, Mario Kleiner wrote:
> >>> On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav <
> Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
> >
> >>>>     I believe we don't have surface info in that code, but one way t=
o
> work around it would be to use spatial dithering for FP16/ARGB16 and
> rounding for 10 bits. But if we just switch to spatial, some of the earli=
er
> complaints about 10-bit output having one-off bit errors will be coming
> back.
> >>>
> >>> Looking at all callers of resource_build_bit_depth_reduction_params()=
,
> they all have access to the associated "struct pipe_ctx", which should gi=
ve
> access to pipe_ctx ->plane_state->format of an associated display plane. =
I
> could prepare a patch that passes the pipe_ctx from each caller
> into resource_build_bit_depth_reduction_params() and that function could
> check if a 16 bpc framebuffer is in use and switch to spatial dithering
> down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc
> otherwise.
> >>
> >> That doesn't really make sense, the output of the display HW colour
> pipeline has more than 10 bpc regardless of framebuffer format.
> >>
> >
> > The output will be determined by the link bandwidth, display-advertised
> supported bpc, and userspace-selected "max bpc" on a drm_connector. This
> could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the
> internal DCN HW representation of the values?
>
> I am indeed.
>
> > They're higher, but that's somewhat irrelevant.
>
> How so? Surely dithering is applied to those values, not to the original
> values sampled from the framebuffer.
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
>

--000000000000ee4641064e579b2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>To clarify: I do agree with Michel and Kruno that in =
most typical use cases you&#39;d probably want to get all or as much of the=
 internal HW pipelines precision as possible to the Eyes of the person in f=
ront of the display, or at least an approximation of it. My understanding o=
f current AMD hardware is that you can have an up to 16 bpc framebuffer, wh=
ich gets truncated/rounded down to 12 bpc somewhere in the pipeline (gamma =
tables, color transformation matrices, etc.) and then retained at 12 bpc un=
til shortly before the actual output, which can be 6, 8, 10 or 12 bpc depen=
ding on connection type, bandwidth, &quot;max bpc&quot; etc.</div><div><br>=
</div><div>If the final output depth is lower than 12 bpc one would usually=
 still want an approximation of 12 bpc reaching the &quot;eyes&quot; of the=
 person (/animal/retina in some of the use cases of my research users) in f=
ront of the display, and spatial dithering down from 12 bpc -&gt; 10/8/6 bp=
c is the way=C2=A0to go. That&#39;s also true=C2=A0for most of my users use=
 cases, and especially for the use cases involving 16 bpc framebuffers/surf=
aces.</div><div><br></div><div>Some more special use cases will require an =
absolutely perfect identity passthrough of pixel color values, where any ki=
nd of transformation in the pipeline, including spatial dithering, would be=
 bad. Some of your customers seem to require this for 10 bpc output. Some o=
f my users require this for 8 bpc output of a 8 bpc framebuffer. Specifical=
ly, some neuroscience research requires up to 16 bpc color or luminance pre=
cision, but all graphics cards and normal displays max out at 12 bpc. There=
 exist special display devices and converters that can do up to 16 bpc prec=
ision (native or via some form of spatial or temporal dithering), e.g., the=
 Bits# or Display++ from Cambridge Research Systems (UK) and Datapixx, View=
Pixx and ProPixx devices from VPixx in Canada. These are essentially active=
 DVI-D or DisplayPort 8 bpc to 14 bpc or 16 bpc VGA analog converters with =
14 or 16 DAC&#39;s, or special purpose LCD panels or DLP video projectors w=
hich can do 14/16 bpc precision. Because commercially available gpu&#39;s a=
nd PHY&#39;s do not support true 16 bpc output (the DP and HDMI standards s=
pecify such signal formats, but no actual transmitter hardware afaik), thes=
e devices encode 16 bpc color content on top of a 8 bpc framebuffer and lin=
k: The software renders 16 bpc unorm/fp or 32 bpc float content and then us=
es GLSL shaders to split up 16 bpc into 8 MSB and 8 LSB and puts the 8 MSB =
into the 8 bpc red channel and 8 LSB into the 8 bpc blue channel (and 8 bpc=
 color index overlay into the 8 bpc blue channel) to false-color encode a p=
ure grayscale image=C2=A0+ some 256 color index palette overlay. Or for tru=
e color images, it sacrifices half the horizontal resolution by putting 8 M=
SB of each color channel into the even pixel columns, and the 8 LSB into th=
e odd pixel columns. So a false color 8 rgb8 framebuffer -&gt; pixel identi=
ty passthrough -&gt; 8 bpc link output via DVI-D or DP, and the video sink =
then decodes and reassembles again into 16 bpc color/luminance content and =
uses special display hardware to these 16 bpc into the eyes of the being in=
 front of the display. Some medical imaging displays, e.g., for Radiology u=
se (e.g., cancer screening) in hospitals or at eye doctors, also use such s=
pecial framebuffer encodings to get &gt; 12 bpc content out of the gpu Siem=
ens Medical and similar companies sell these for research and medical use.<=
/div><div><br></div><div>Another use case of my users requiring perfect pix=
el=C2=A0identity passthrough is to encode side-band signals into the scanli=
nes of the vactive area of an image, encoding binary control data and packe=
ts as false color pixel values, similar to the various info packets transmi=
tted inside vblank. This for control data that is very custom and not stand=
ardized in any Vesa or HDMI standard, e.g., in my case to control special n=
euroscience hardware, e.g., sound microsecond synchronized to pictures, sen=
ding various analog waveforms to electrophysiology equipment or haptic stim=
ulation, or digital trigger signals to transmagnetic stimulators (magnetic =
pulses to brain regions), or start/stop/synchronize various recording equip=
ment (fMRI and MEG scanners, electrophysiological recordings, video capture=
 etc.)</div><div><br></div><div>For the pixel identity passthrough, the dif=
ference is that I only need it for 8 bpc framebuffers to 8 bpc (DVI-D or DP=
) outputs atm., and that works fine under OpenGL with an identity gamma tab=
le loaded, despite spatial dithering down to 8 bpc active. Right now, I nei=
ther have the need nor the equipment to verify 10 bpc identity passthrough,=
 as my capture hw can only process 8 bpc signals.</div><div><br></div><div>=
I don&#39;t think there is an automated way for the driver to guess the pro=
per configuration in all cases. The proper solution would be a drm connecto=
r property that can be queried/set to control dithering on/off/method/targe=
t depth, and plumb that through. Or maybe something that could be derived f=
rom existing connector properties? E.g., if a content property has somethin=
g standardized that essentially requires identity passthrough? In my case, =
it is important that such settings still fully work under native X11 via Ra=
ndR properties. Something that is only realistically accessible via an atom=
ic client or Wayland server is insufficient for me.</div><div><br></div><di=
v>So yes, as Michel points out, there is a disconnect between the framebuff=
er color depth and hw pipeline depth and what dither settings should be use=
d. But Harry&#39;s patch, if it worked, would be at least a good enough gue=
ss-o-matic or heuristic to make the situation better in the short term,=C2=
=A0even if it is not optimal. Or at least for my users use cases it would m=
ake it better, as for my use cases the framebuffer color depth usually corr=
esponds to what my users need as effective output precision. For me there i=
s also the urgency of wanting to have a not broken situation for Linux 7.0 =
and upcoming Ubuntu 26.04-LTS / Fedora Core 44. If I have the choice of hav=
ing the current state, or this patch, I&#39;d gladly have this patch as a s=
tep up.</div><div><br></div><div>I hoped this patch would be still simple a=
nd contained and early enough, to make it into drm-fixes for Linux 7.0, and=
 maybe be backportable to older kernels, as all kernels since late 2023 are=
 impaired from my use cases point of view. But as I said, my testing didn&#=
39;t confirm the patch is actually working - it always ends up enabling dit=
hering. Which, to be sneaky, would also be a step up for me, as that &quot;=
only&quot; breaks use cases that don&#39;t affect my users specifically :/<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Mar 31, 2026 at 9:16=E2=80=AFAM Michel D=
=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer@mailbox.org">michel.daenzer=
@mailbox.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 3/30/26 19:36, Harry Wentland wrote:<br>
&gt; On 2026-03-30 12:20, Michel D=C3=A4nzer wrote:<br>
&gt;&gt; On 3/24/26 20:20, Mario Kleiner wrote:<br>
&gt;&gt;&gt; On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav &lt;<=
a href=3D"mailto:Krunoslav.Kovac@amd.com" target=3D"_blank">Krunoslav.Kovac=
@amd.com</a> &lt;mailto:<a href=3D"mailto:Krunoslav.Kovac@amd.com" target=
=3D"_blank">Krunoslav.Kovac@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0I believe we don&#39;t have surface inf=
o in that code, but one way to work around it would be to use spatial dithe=
ring for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spa=
tial, some of the earlier complaints about 10-bit output having one-off bit=
 errors will be coming back.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Looking at all callers of=C2=A0resource_build_bit_depth_reduct=
ion_params(), they all have access to the associated &quot;struct pipe_ctx&=
quot;, which should give access to pipe_ctx -&gt;plane_state-&gt;format of =
an associated display plane. I could prepare a patch that passes the pipe_c=
tx from each caller into=C2=A0resource_build_bit_depth_reduction_params() a=
nd that function could check if a 16 bpc framebuffer is in use and switch t=
o spatial dithering down-to-10-bpc in this case, and leave the rounding/tru=
ncation to 10 bpc otherwise.<br>
&gt;&gt;<br>
&gt;&gt; That doesn&#39;t really make sense, the output of the display HW c=
olour pipeline has more than 10 bpc regardless of framebuffer format.<br>
&gt;&gt;<br>
&gt; <br>
&gt; The output will be determined by the link bandwidth, display-advertise=
d supported bpc, and userspace-selected &quot;max bpc&quot; on a drm_connec=
tor. This could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referrin=
g to the internal DCN HW representation of the values?<br>
<br>
I am indeed.<br>
<br>
&gt; They&#39;re higher, but that&#39;s somewhat irrelevant.<br>
<br>
How so? Surely dithering is applied to those values, not to the original va=
lues sampled from the framebuffer.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 GNOME / Xwayland / Mesa developer<br>
<a href=3D"https://redhat.com" rel=3D"noreferrer" target=3D"_blank">https:/=
/redhat.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Libre software enthusiast<br>
</blockquote></div>

--000000000000ee4641064e579b2a--
