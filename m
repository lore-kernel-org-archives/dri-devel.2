Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901E111227B
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA2110F002;
	Thu,  2 Apr 2026 02:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ua8I5YjT";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6AD10F002
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 02:55:55 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12a80c36350so566212c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 19:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775098554; cv=none;
 d=google.com; s=arc-20240605;
 b=KXUUliD09SLKdxX5od71H9uABtfJQ8aIvFqXsCnQABzKd9NuwuqIOi9yzeFB9UdA7Z
 +GPC9AmF9AXfBewdq3TGb7ibTbxJnRXZHVNa3P0nqDQWu2+9QYAt4hXpSFCmfIyYlnvE
 5eRxZga8kUgueDkjIQ4dlAIU0169fdkP/m0PZnFb17UERLUbX/qkTYDs4frkeEMYigNf
 Yxl4xHoa+gd/dKljr/tAfugWjdB9gt/u4BPBVwsw4qV1Dy5XrTb6mm9jqkoCoHAI19h0
 jtBXHsDJW7DuXiP3v+ur/0U3x1GMs6uIX7qhm2pAfkQlS6DPHCp3PREgTaSXc+0Prvm9
 bJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=myKP12FYjYg5SJEqXwe/Zdu/pWJlwOhfip/f5yBVUPc=;
 fh=WR0q35UNFHUdQ5QoeJWQzB8oMX5j0sgL6337QuaEbgo=;
 b=j+cjujoIcZVNLOGQf9czfcB3mVpGxyGDO5SNSKGioOc8nZJ+IuYtJSrQO1zMYJ5LAF
 wgFDtxDVdhEk2jAZPbNg38Ez+CLyKHDkDhLjO5cotvTU+jUN707VjhQng+tDKYxyMdEK
 RPU1knMxQJEb3/4rG2dCKC58TSRDkLzRgLCBYwnhM+2AoPTpFYtHnNXaL2LSDRcEEeQA
 Y5CSAYD+xAKmqNs+NY8kiLdv0SKiXsT4h/pCJbfTqnRtEAXdOhjXTNH1NvEuAhl4CMaM
 JcmiT/QarSUws5rXwm4qPCQ7TI7Yb4oIjZ69Rzd69NCrzUHaAjNAmPRuoSYS/j7nA/pL
 NxPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775098554; x=1775703354; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=myKP12FYjYg5SJEqXwe/Zdu/pWJlwOhfip/f5yBVUPc=;
 b=Ua8I5YjTdKfIyMOAWsD+/l53If1OspwRNc/qe8AQlKjO5bV8ts2Su9WXHpitiWjAUp
 wkbj2FBNL4abgRahF4n4syvRpWED39jJQQ9by/ugrDqe3TOpGP0XQRjAxAumkfk3aCvG
 15tqvoyFe/LJR0QItGQKu1cqo8O3ejOl/6TDvNAcvOn0LhsuV7nSiF3w0xkBrEGUtEaC
 hL1C4K7VKGxyh4Rrw5EDDoHVCeAy3Bxb95b7uvIdckdUy5zG8pERd5TOllEbiPcPUSWY
 en17ZztNnTJKtcNDS7Xs93dpbX9R49depPRHK49BhK3LEKA7l76VhBe6o3KzFRPHZzTd
 ctOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775098554; x=1775703354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myKP12FYjYg5SJEqXwe/Zdu/pWJlwOhfip/f5yBVUPc=;
 b=R3HbuOnPevzmpBkUwE9X/gvkegnmhbIT6FDdVpLQwdrmNDesJmS3E4LICeDdT0KnFT
 oeTB51C+HggJMg2UCLAAtZQxI6Gfl6fH9bwQh+qEYC1/bSZn24U7hnyxwaeNxydPzEDi
 3BHF/gq0vh4VWBQxV9A7D3ynmfUl2ydEPTsHOKq3rZTDyHPABvM/Pq4i9U1ABBJUbAQ9
 Bb8aTpLUaFnvrbBfPWygaYY1LePIrnBiZzmTbH/F8/zzVRkeuzNBayqqiG2QwHEI7Sa9
 CK7SSC+RNcQ+1zWrbPS7GD6TNir89nZIPe8/Az3KxcPf+FqlEIYa7ztW99kmFOgwbYwS
 pBuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSf0wuqgOM59jRL9+xi6pWeJjhTDxfC475xs/FZblzT7QcnWvGH6obutijRaTpj7gDNxeZiLV0DT0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyW/LrJ+y/Qx5qV/+7Yv3K8vr9hZ85xym7VSZQR4YjmYJkG/ki
 LX4+m0oxuxas7gX6dmx12brqA8FXNwhMQ6X3nQvSK7xLnH0SdNZTz08lW4gNJCe4I4cPee0kdL7
 8/PipGLRrFYo4AcHaYfcxgLzKzLH1lNE=
X-Gm-Gg: ATEYQzzoNwElNjYMdPopJmINRt89U3fTnBpalpN1VDzqzwasg2zmQivsll0L/qi2hS6
 sPRy0LS0MH+08d+clxknL53XA4GEI97r6o2VHOxVZIAo3sgilgI4EmO0yHQsFaQyZmD9JoNZY9n
 Qxvv7FW1Pj1uei1od0+pSj8dN4k/C8prF+2U9t9+jSdZpVRpA5t3ajRRx1BcJRY54x4ewtrHQkd
 0E3SCtW4RhvL8QNgYP4mHoT2FVBILQQ+pWiK0fT/l6EzcVVLBBuTJJW7PMTdrrgDy1ufOeVF2CF
 rcPqTz8onRzsjkG3UgZfcB020MYLdcMWKEKExLxy
X-Received: by 2002:a05:7022:e1b:b0:128:ceac:6db1 with SMTP id
 a92af1059eb24-12be64fcd2fmr3041032c88.28.1775098554282; Wed, 01 Apr 2026
 19:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
 <ac0kP-SWXrBwrN5C@intel.com>
 <CAPj87rNfJCCUFYqD+p6OM5XDE8CA75anmA7+ezrCTSZXBSDgTQ@mail.gmail.com>
In-Reply-To: <CAPj87rNfJCCUFYqD+p6OM5XDE8CA75anmA7+ezrCTSZXBSDgTQ@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Thu, 2 Apr 2026 04:55:17 +0200
X-Gm-Features: AQROBzAZp5-pueOOVH3WV_oDtNe79EY4T-CZTzxbgg0zQENktD0wJ_6phHreu7Q
Message-ID: <CAEsyxyjzi7sddNhtd5wX-HB4B0WSyHz+x83YXT08mvzHiHXv1A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Daniel Stone <daniel@fooishbar.org>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
Content-Type: multipart/alternative; boundary="000000000000c4f5a7064e715604"
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

--000000000000c4f5a7064e715604
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fwiw, I think Daniel and Pekka's statements well summarize my
opinions/wishes on this, from the application niche of research software.

In general, for the specific use case of scientific neuroscience /
bio-medical research, it would be great to have as many properties as
possible controllable by a userspace app, with a default "auto" setting
that lets drivers optimize for the "common case" - whatever that means
(e.g., optimize for low power consumption on battery or on low battery,
optimize for quality on regular power supply).

And as a first step, as much well defined feedback as possible, so software
can at least know if some settings are troublesome for specific use cases.

It would be *very* useful to be able to override dithering settings (target
dithering depth and strategy, or at least an on/off switch). The last few
days I was involved in some email thread with Harry and others from AMD,
and also Michel, related to dithering on AMD hw, which gives a bit of
context why my application cases need this. No size fits all, and any
automatic setting will do the wrong thing for some subset of legitimate use
cases. A change of default settings in AMD's drivers late 2023, to make
some previously unhappy AMD customers happy for some special use cases,
silently broke use cases of mine. A manual control over dithering would
solve these problems for everybody that cares about it, and at least a
feedback property would have prevented some mayhem for me, instead of me
missing the brokenness on recent hw for over 2 years. Right now,
Psychtoolbox on Linux goes as far as mmap()'ing the MMIO hardware registers
of some generations of display hardware, reading and decoding them, to find
out what kind of dither settings are active, if they are compatible with
the needs of the specific task, and sometimes reprogramming the hw behind
the back of the driver to force the hw behaviour it needs. While this
worked well enough for over a decade (all DCE display hardware and
pre-DCE), it has become impractical / impossible for modern presentation
models and with modern display hw of the last few years. At least NVidia's
proprietary drivers allow user control over such settings under native
X-Server and on MS-Windows, as do AMD's proprietary MS-Windows drivers and
as did past proprietary AMD "fglrx / Catalyst" drivers for Linux. Some of
the open-source kms + XOrg ddx drivers also used to have that in the past,
e.g., nouveau iirc.

It would be very useful to have at least a general on/off switch for DSC
and at least feedback of when it is active. My knowledge of how DSC works
is so far limited to skimming Wikipedia and a tiny bit of conversation with
some customers from VESA multiple years ago, and I don't have any practical
first hand experience with it, as all my hardware is too old to support it
afaik. I'm pretty sure though that "perceptually lossless" is probably a
charitable description of what it really is for various types of visual
stimuli under various conditions that deviate from the specific conditions
used during the user evaluation studies. And given that my software is used
for visual perception research, there are various scenarios where
researchers want to be as certain as possible that each pixel really emits
the color they programmed in their scripts, and no unknown proprietary DSC
algorithm introduces low level artifacts. E.g., I know from conversations
with VESA members that my software is used, among other things, for the
perceptual research and evaluation involved in development and improvement
of DSC methods and HDR display technology, so control and reporting of when
such a feature is active can be essential.

While techniques like dithering and DSC can be perfectly fine and even
helpful or necessary for many use cases of my users, there are also various
common use cases where they'd be what the iceberg was to the titanic.

And because methods like dithering and DSC are perceptual techniques for
boosting apparent color/luminance precision for certain types of visual
stimuli under certain viewing conditions, it would be imho very difficult
to have an accurate way to define what the true perceived "effective bpc"
after dithering/DSC etc. is, once light hits the retina of the human (or
animal, or cell culture in a petri-dish in some research use cases). So the
best one can probably do is to report 'link bpc' without taking dithering
or DSC into account. And at least for software like mine, 'link bpc' would
be useful info, especially if combined with knowledge about the enablement
state of dithering and DSC. It would give some reasonable feedback about
the minimum bpc achievable, so the software could try to warn the user if
the expected minimum bpc can't be achieved, or try to do something about
it, depending on the situation and requirements of the task at hand.

On Wed, Apr 1, 2026 at 4:24=E2=80=AFPM Daniel Stone <daniel@fooishbar.org> =
wrote:

> On Wed, 1 Apr 2026 at 14:58, Ville Syrj=C3=A4l=C3=A4
> <ville.syrjala@linux.intel.com> wrote:
> > I've been musing about userspace being able to provide some kind of
> > relative quality weights for each output. The driver could then use
> > those to figure out how to balance the final bpc and compression
> > between the outputs. Something like this would let userspace express
> > its preference while still allowing the driver to decide how to
> > actually get there.
> >
> > Simple 'desired bpc' seem somewhat insufficient because I would
> > imagine userspace just sets that to max for everything at the start,
> > so the driver might not be able to tell which outputs can be degraded
> > harder than others.
> >
> > I suppose a desired+min bpc might work, but would potentially force
> > userspace to tweak the parameters in some semi random fashion and
> > try again if the end result isn't appealing. And exactly what to
> > tweak is really hard for userspace to figure out since it has no
> > idea of the possibly complex internal/tbt/mst topologies, power
> > costs, etc.
>
> I agree with everything you've written, apart from 'I would imagine
> userspace just sets that to max for everything at the start'.
>
> I've taken it as axiomatic that all of these things should have an
> 'auto' value, and have it as their default setting. Userspace _may_
> know better than the IHV, but it's only going to know on a situational
> basis.
>

Another example from Psychtoolbox wrt. use of the 'max bpc' property: Some
use cases need to squeeze out as much effective color or luminance
precision from standard consumer display monitors as possible. Right now
that means use of RGBA16 unorm framebuffers with 16 bpc precision on Linux,
and video output at 12 bpc link depth on Displayport and HDMI monitors that
support this, with gpu's that support this - essentially AMD hardware of
the last ~10 years or so, iirc since the "Sea Islands" gpu family and ~
DCE-8 display engines. Afaik DisplayPort video sinks will usually report
the highest really supported bit depth that they can meaningfully process
and display (possibly also by employing some form of dithering). But afaik
the HDMI standard requires any HDMI monitor that does support *any* > 8 bpc
"deep color" mode to also always report support for 12 bpc deep color. That
means there are HDMI displays that can only truly handle and display 10
bpc, but they report 12 bpc capability, as mandated by the spec. If the
driver selects 12 bpc output without dithering on such a display, then the
display will internally truncate the true 12 bpc input to 10 bpc and one
ends with effective 10 bpc. For this case, users of Psychtoolbox can tell
the software that it is dealing with such a "fake 12 bpc" display. In this
case, Psychtoolbox will use the 'max bpc' connector property to enforce a
max 10 bpc output, to try to force the kms driver to enable spatial
dithering down to 10 bpc on the gpu side, so the effective bpc will be 12
bpc via dithering. And on older AMD hw generations with DCE display engines
will then use MMIO register reads and writes to make sure the dither
settings are what it needs.

I've also seen bad cabling or similar hardware fragility causing trouble,
where setting 'max bpc' to a lower value helped to get a workable picture.

It may also have helped in the past to achieve higher refresh rate +
resolution combos by sacrificing output bpc on some gpu's? Atm. at least
amdgpu prunes video modes prioritizing resolution and refresh rate by first
lowering link bpc to fit a resolution + refresh rate combo into the hw
limits.


> Compositors blindly setting random tuneables to MAX_AWESOME_POWER
> would be just as stupid as distros shipping ye olde Option
> "AGPFastWrite" and Option "AGPMode" "8" by default. I'd expect any
> userspace which blindly did that to immediately get as many bug
> reports as they have users, and for them to fix it accordingly.
>
> By analogy, we allow userspace to ignore EDID and set whatever cool
> awesome mode it wants to. But it doesn't do that unless it has a very
> very good reason to override the driver, and 99 times out of 100, that
> reason is 'the user has figured out that this is required'.
>

Indeed. Another unusual Psychtoolbox use case under native X11 + AMD +
Freesync/G-Sync/Adaptive sync: Using a special freesync_video mode of
amdgpu that allows to create custom modes with arbitrary video refresh
rates, implemented on top of VRR / FreeSync. PTB can auto-generate and add
potentially dozens or hundreds of modelines via X11 RandR that only differ
in refresh rate, e.g., in steps of 0.1 Hz, and then switch rather fast
between different refresh rates, as "modesets" between these "FRR on top of
VRR" modes are much faster than regular modesets. Some experimental
paradigms benefit greatly from the ability to switch very quickly between
different refresh rates at small deltas.

All this is highly situational of course. But I'd assume my software is not
the only odd non-standard use case that would benefit from various such
feedback mechanisms or manually controllable settings.

-mario


> Does that help?
>
> Cheers,
> Daniel
>

--000000000000c4f5a7064e715604
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Fwiw, I think Daniel and Pekka&#39;s=
 statements well summarize my opinions/wishes on this, from the application=
 niche of research software.</div><div><br></div></div><div>In general, for=
 the specific use case of scientific neuroscience / bio-medical research, i=
t would be great to have as many properties as possible controllable by a u=
serspace app, with a default &quot;auto&quot; setting that lets drivers opt=
imize for the &quot;common case&quot; - whatever that=C2=A0means (e.g., opt=
imize for low power consumption on battery or on low battery, optimize for =
quality on regular power supply).</div><div><br></div><div>And as a first s=
tep, as much well defined feedback as possible, so software can at least kn=
ow if some settings are troublesome for specific use cases.</div><div><br><=
/div><div>It would be *very* useful to be able to override dithering settin=
gs (target dithering depth and strategy, or at least an on/off switch). The=
 last few days I was involved in some email thread with Harry and others fr=
om AMD, and also Michel, related to dithering on=C2=A0AMD hw,=C2=A0which gi=
ves a bit of context why my=C2=A0application cases need this. No size fits =
all, and any automatic setting will do the wrong thing for some subset of l=
egitimate use cases. A change of default settings in AMD&#39;s drivers late=
 2023, to make some previously unhappy AMD customers happy for some special=
 use cases, silently broke use cases of mine. A manual control over ditheri=
ng would solve these problems for everybody that cares about it, and at lea=
st a feedback property would have prevented some mayhem for me, instead of =
me missing the brokenness on recent hw for over 2 years. Right now, Psychto=
olbox on Linux goes as far as mmap()&#39;ing the MMIO hardware registers of=
 some generations of display hardware, reading and decoding them, to find o=
ut what kind of dither settings are active, if they are compatible with the=
 needs of the specific task, and sometimes reprogramming the hw behind the =
back of the driver to force the hw behaviour it needs. While this worked we=
ll enough for over a decade (all DCE display hardware and pre-DCE), it has =
become impractical / impossible for modern presentation models and with mod=
ern display hw of the last few years. At least NVidia&#39;s proprietary dri=
vers allow user control over such settings under native X-Server and on MS-=
Windows, as do AMD&#39;s proprietary MS-Windows drivers and as did past pro=
prietary AMD &quot;fglrx / Catalyst&quot; drivers for Linux. Some of the op=
en-source kms + XOrg ddx drivers also used to have that in the past, e.g., =
nouveau iirc.</div><div><br></div><div>It would be very useful to have at l=
east a general on/off switch for DSC and at least feedback of when it is ac=
tive. My knowledge of how DSC works is so far limited to skimming Wikipedia=
 and a tiny bit of conversation with some customers from VESA multiple year=
s ago, and I don&#39;t have any practical first hand experience with it, as=
 all my hardware is too old to support it afaik. I&#39;m pretty sure though=
 that &quot;perceptually lossless&quot; is probably a charitable descriptio=
n of what it really is for various types of visual stimuli under various co=
nditions that=C2=A0deviate from the specific conditions used during the use=
r evaluation studies. And given that my software is used for visual percept=
ion research, there are various scenarios where researchers want to be as c=
ertain as possible that each pixel really emits the color they programmed i=
n their scripts, and no unknown proprietary DSC algorithm introduces low le=
vel artifacts. E.g., I know from conversations with VESA members that my so=
ftware is used, among other things, for the perceptual research and evaluat=
ion involved in development and improvement of DSC methods and HDR display =
technology, so control and reporting of when such a feature is active can b=
e essential.</div><div><br></div><div>While techniques like dithering and D=
SC can be perfectly fine and even helpful or necessary for many use cases o=
f my users, there are also various common use cases where they&#39;d be wha=
t the iceberg was to the titanic.</div><div><br></div><div>And because meth=
ods like dithering and DSC are perceptual techniques for boosting apparent =
color/luminance precision for certain types of visual stimuli under certain=
 viewing conditions, it would be imho very difficult to have an accurate wa=
y to define what the true perceived &quot;effective bpc&quot; after ditheri=
ng/DSC etc. is, once light hits the retina of the human (or animal, or cell=
 culture in a petri-dish in some research use cases). So the best one can p=
robably do is to report &#39;link bpc&#39; without taking dithering or DSC =
into=C2=A0account. And at least for software like mine, &#39;link bpc&#39; =
would be useful info, especially if combined with knowledge about the enabl=
ement state of dithering and DSC. It would give some reasonable feedback ab=
out the minimum bpc achievable, so the software could try to warn the user =
if the expected minimum bpc can&#39;t be achieved, or try to do something a=
bout it, depending on the situation and requirements of the task at hand.</=
div><div><br></div><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Apr 1, 2026 at 4:24=E2=80=AFPM Danie=
l Stone &lt;<a href=3D"mailto:daniel@fooishbar.org">daniel@fooishbar.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Wed, 1 Apr 2026 at 14:58, Ville Syrj=C3=A4l=C3=A4<br>
&lt;<a href=3D"mailto:ville.syrjala@linux.intel.com" target=3D"_blank">vill=
e.syrjala@linux.intel.com</a>&gt; wrote:<br>
&gt; I&#39;ve been musing about userspace being able to provide some kind o=
f<br>
&gt; relative quality weights for each output. The driver could then use<br=
>
&gt; those to figure out how to balance the final bpc and compression<br>
&gt; between the outputs. Something like this would let userspace express<b=
r>
&gt; its preference while still allowing the driver to decide how to<br>
&gt; actually get there.<br>
&gt;<br>
&gt; Simple &#39;desired bpc&#39; seem somewhat insufficient because I woul=
d<br>
&gt; imagine userspace just sets that to max for everything at the start,<b=
r>
&gt; so the driver might not be able to tell which outputs can be degraded<=
br>
&gt; harder than others.<br>
&gt;<br>
&gt; I suppose a desired+min bpc might work, but would potentially force<br=
>
&gt; userspace to tweak the parameters in some semi random fashion and<br>
&gt; try again if the end result isn&#39;t appealing. And exactly what to<b=
r>
&gt; tweak is really hard for userspace to figure out since it has no<br>
&gt; idea of the possibly complex internal/tbt/mst topologies, power<br>
&gt; costs, etc.<br>
<br>
I agree with everything you&#39;ve written, apart from &#39;I would imagine=
<br>
userspace just sets that to max for everything at the start&#39;.<br>
<br>
I&#39;ve taken it as axiomatic that all of these things should have an<br>
&#39;auto&#39; value, and have it as their default setting. Userspace _may_=
<br>
know better than the IHV, but it&#39;s only going to know on a situational<=
br>
basis.<br></blockquote><div><br></div><div>Another example from Psychtoolbo=
x wrt. use of the &#39;max bpc&#39; property: Some use cases need to squeez=
e out as much effective color or luminance precision from standard consumer=
 display monitors as possible. Right now that means use of RGBA16 unorm fra=
mebuffers with 16 bpc precision on Linux, and video output at 12 bpc link d=
epth on Displayport and HDMI monitors that support this, with gpu&#39;s tha=
t support this - essentially AMD hardware of the last ~10 years or so, iirc=
 since the &quot;Sea Islands&quot; gpu family and ~ DCE-8 display engines. =
Afaik DisplayPort video sinks will usually report the highest really suppor=
ted bit depth that they can meaningfully process and display (possibly also=
 by employing some form of dithering). But afaik the HDMI standard requires=
 any HDMI monitor that does support *any* &gt; 8 bpc &quot;deep color&quot;=
 mode to also always report support for 12 bpc deep color. That means there=
 are HDMI displays that can only truly handle and display 10 bpc, but they =
report 12 bpc capability, as mandated by the spec. If the driver selects 12=
 bpc output without dithering on such a display, then the display will inte=
rnally truncate the true 12 bpc input to 10 bpc and one ends with effective=
 10 bpc. For this case, users of Psychtoolbox can tell the software that it=
 is dealing with such a &quot;fake 12 bpc&quot; display. In this case, Psyc=
htoolbox will use the &#39;max bpc&#39; connector property to enforce a max=
 10 bpc output, to try to force the kms driver to enable spatial dithering =
down to 10 bpc on the gpu side, so the effective bpc will be 12 bpc via dit=
hering. And on older AMD hw generations with=C2=A0DCE display engines will =
then use MMIO register reads and writes to make sure the dither settings ar=
e what it needs.</div><div><br></div><div>I&#39;ve also seen bad cabling or=
 similar hardware fragility causing trouble, where setting &#39;max bpc&#39=
; to a lower value helped to get a workable picture.</div><div><br></div><d=
iv>It may also have helped in the past to achieve higher refresh rate=C2=A0=
+ resolution combos by sacrificing output bpc on some gpu&#39;s? Atm. at le=
ast amdgpu prunes video modes prioritizing resolution and refresh rate by f=
irst lowering link bpc to fit a resolution=C2=A0+ refresh rate combo into t=
he hw limits.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Compositors blindly setting random tuneables to MAX_AWESOME_POWER<br>
would be just as stupid as distros shipping ye olde Option<br>
&quot;AGPFastWrite&quot; and Option &quot;AGPMode&quot; &quot;8&quot; by de=
fault. I&#39;d expect any<br>
userspace which blindly did that to immediately get as many bug<br>
reports as they have users, and for them to fix it accordingly.<br>
<br>
By analogy, we allow userspace to ignore EDID and set whatever cool<br>
awesome mode it wants to. But it doesn&#39;t do that unless it has a very<b=
r>
very good reason to override the driver, and 99 times out of 100, that<br>
reason is &#39;the user has figured out that this is required&#39;.<br></bl=
ockquote><div><br></div><div>Indeed. Another unusual Psychtoolbox use case =
under native X11=C2=A0+ AMD + Freesync/G-Sync/Adaptive sync: Using a specia=
l freesync_video mode of amdgpu that allows to create custom modes with arb=
itrary video refresh rates, implemented on top of VRR / FreeSync. PTB can a=
uto-generate and add potentially dozens or hundreds of modelines via X11 Ra=
ndR that only differ in refresh rate, e.g., in steps of 0.1 Hz, and then sw=
itch rather fast between different refresh rates, as &quot;modesets&quot; b=
etween these &quot;FRR on top of VRR&quot; modes are much faster than regul=
ar modesets. Some experimental paradigms benefit greatly from the ability t=
o switch very quickly between different refresh rates at small deltas.</div=
><div><br></div><div>All this is highly situational of course. But I&#39;d =
assume my software is not the only odd non-standard use case that would ben=
efit from various such feedback mechanisms or manually controllable setting=
s.</div><div><br></div><div>-mario</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Does that help?<br>
<br>
Cheers,<br>
Daniel<br>
</blockquote></div></div>

--000000000000c4f5a7064e715604--
