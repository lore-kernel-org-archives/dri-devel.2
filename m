Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456A2FEC0F7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A047310E490;
	Tue, 24 Mar 2026 19:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xg2mwzzo";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C842A10E62A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:20:46 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso9926835c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380046; cv=none;
 d=google.com; s=arc-20240605;
 b=K4V2eNV5+Aqh0hRcjmm6i69/nitmsvfOdMZp/2GrNL98xocm6jHcm+SS4ADMaJ2gOn
 pdO5Tt7zcUH5y0t4FmnW4KdWJGQ8ARsQUL9zVIbIrttjqdg1I33zRoAqYiQhTTQf1l9K
 UXBYLhcjjxNCaszu7MCRe1OZDEy5ppuumIOevbKgFEKysrLMqD0ms+bcmbqdHBujTqoj
 fxXb2nScomN+FNy6Lq6lV1iG+C8YrBULmODGHFu9mGpsWaIkz4omcpZSzSMYt9qG4ou0
 7Xu2OfjTErDMKb/9UsVAtBVv8bpyoRKH3UiGlAHPRDjZhQgba3H8vnY6Z0EIc7hD4GIb
 NjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9D/ZIUAE7xAQiwv6bAWGv0vvG0GT7T+nCofEi3+jrDc=;
 fh=+RbqVeF8aWD7DH2cLGzxl316tCUS947caWyw3USUkps=;
 b=B6SjSSHDcdaCnb5iLT1EtVeLNpCxC5AnOCSgo8tvcDGStTqfuwnlbDCBN0mUbK5hta
 G+boAVOiPRgOX0qFdhEn76aqHufkSuh6FJ4EivQw52KbVhul1a7vh0saIemxTv9V7SfB
 ACFxfjwW9WTqSM3Rb49cnwPc4Ux0sMoFIrUpHBCbu2BnnCk2oyaH15ErtfZoSXaj4Yc0
 zqOWGvnNFRXoKoFkVr/UTtxt6iQ6Bepj0rv2HPKLcsxEBvLb9baiBxeL0Z3bM+lLvkYd
 XlbQ2r9RKRj/huMXIL8R1/XPjstBpqPNQjVHDtM1F8J4M6m7PGX8Q+OSpTgtFE6GX5EJ
 dmiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774380046; x=1774984846; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9D/ZIUAE7xAQiwv6bAWGv0vvG0GT7T+nCofEi3+jrDc=;
 b=Xg2mwzzoJo259ajKHNZxdGTUsqA+FGGlYxKwvknMb3MeYL21RFxV/F4uKqTEZ3BKRe
 cdSeAukNDbWBNHFkLoG5kjm5b9PD5OynkvgtMFQDYAwHJLSMUejorCeOx1eXvGeHXY2a
 EGITc6qhEm38Yq6YT3cq+YS5DbyYNsDNumFunTqHDrbl2O35mIfKOct6CwgC11p2iPnz
 lZNGFTroQzJjeWqX/v3c3Fmmxab0RDJ8lgcfOozE49AYIcrLiMw1xr4J5h/xeDeu1Q6q
 o7GvhPH3JKIeVyXHOkyNxb+MhjyDjm/ifmC2RcPWipqGSp5zUnKkMVNGyyZJjt7N8f3V
 cHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380046; x=1774984846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D/ZIUAE7xAQiwv6bAWGv0vvG0GT7T+nCofEi3+jrDc=;
 b=FCP3mdKXxkcDaIAcR9FGvveFrmYcGO1IlbRxyEMmu2xYnW2EcIwsjiGqOFIIxJb97D
 ETSsM4hWO7lKaaDsiWlA2lhil5xXTMXJJ78aErAJ6CnQNPNSpJ1IWeYV+szEJ2XdP6du
 wVRbhLbJ0NXt/mYwHijVTVgRWyV3KGDCV8zuoftoPdtVf2Ehr7BcFAcvwhGtyf3V6unc
 sO5G6wQ3//1/GwE+2uQIQ0Lo0gpnxKb9SvhQKpJ9fO9l5VNH39FTMg1mYrlZaLOBdy3w
 43TK6GHOiEDQZwaBH/mhMWW54Due4N0N0m4ZZOzCiCHsOGerjexeaX5teDdzvQT5T2dO
 oObA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZKWfVk16nmqStq8O8ZlCZzy+Z4quBs6djXi9lmemjg30PrmxDJsFBRJKOWSOIe8/bU3a+IX5gDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/XhPK/mkd/rwiPM+ZV4yYGMj4/+7o0wb47lN0vWsZqheu+dk5
 mlVwvQPtsudKrYUnYCF6k7ehxNnQIUSZxXwkYWazQJslaTkb2c1vz0c5TaU/+gelh6WQROyxEmi
 iJqzYIn2kn57pbOckMFy1qDl/TZZVEGQ=
X-Gm-Gg: ATEYQzyF4LgQPB4eiSAkHsHBg7QeIPeJL19NH8GOwGWuMhEVxRvIJrvThHQ7pZ+nt1A
 oIw/bxLO4x1la00SF+4bM5RAB2dPrMqzCGnhoTc+v7UyBVab1oxDxDSGFscSzMQ1IxmAPGQIzLp
 5p7nG8u6NkmY4+MwuENHaxrKzfNrz0R+PpRyBov7gXqjvPi+Mr+D0GbmocKXEeDxQb2tyIBLsIb
 rMhMsqeuxKZmlEIIffyIPVbqdKQq5PemHwTlAb0kua/bTWx/ss03iGIVoP7PIJyhtsu/0dIYOaK
 Y+fuzOGaNtByEJVByIjJl5/EEgt4n7oHA2VmLdXA
X-Received: by 2002:a05:7022:6897:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-12a96e48d0dmr362775c88.8.1774380045772; Tue, 24 Mar 2026
 12:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Tue, 24 Mar 2026 20:20:09 +0100
X-Gm-Features: AaiRm51UomdHKaOJFBp9QK1wXa3WzYDWuXYFzHnZe6JfIN9-TP9IJrQuXr5bpy4
Message-ID: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>
Content-Type: multipart/alternative; boundary="000000000000532c9d064dca0c4b"
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

--000000000000532c9d064dca0c4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krunoslav,

(dropped Rodrigo from the mail thread, as he seems no longer with AMD's
display team, and stable kernel for the moment).

On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav <Krunoslav.Kovac@a=
md.com>
wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Mario,
>
> I'm not on that mailing list, not sure how to reply, so I'll start by
> replying directly here.
>
> Thanks for the reply.


> There is a reason for the change that is alluded in the commit, but
> perhaps I should've been clearer.
> If you have an ARGB2101010 surface and monitor is 10bpc, one of the HW
> design goals is that we can output this in a bit-perfect way, i.e., for
> every surface pixel value K=3D0..1023, monitor will receive K at its end.
> It's also one of the things some customers have checked for and complaine=
d
> about historically. This is very hard to see visually or even with a
> colorimeter but is readily apparent with a HW capture card.
>
> Our HW can accomplish this 10-bit perfect requirement if set up correctly=
,
> however, it can only do so if we use rounding, not dithering.
> For example, say you have a 10-bit code 200, our pipeline precision and
> error accumulation may result with 200.15, which in 12bpc before ditherin=
g
> would be 801 and the nature of the spatial dithering is that now and then
> RNG result will push that to 201 output, it's just the way it works.
> Rounding is several times less sensitive to this, and without this
> randomness component, we can verify we're always accurate enough at 10bpc
> level.
>

Ok, that makes a lot more sense. I can understand that. My own software and
users have the same critical requirement for some use cases, of being able
to pass through ARGB8888 surfaces to 8 bpc video sinks. They connect
special neuroscience display equipment that parses special binary control
information out of false-color coded framebuffer images, or implements very
high color precision display up to 16 bpc per color channel on top of 8 bpc
framebuffers and some shader magic. Luckily, using a standard 8 bpc
framebuffer under the native X-Server, a 8 bpc DVI-D or DP video sink, and
loading a specifically crafted gamma table achieved this for our case,
despite the spatial dithering-down-to-8bpc being active. DC has some
special detection function (__is_lut_linear() in amdgpu_dm_color.c) that
detects if a user provided gamma lut is essentially meant to be a linear
identity mapping lut, and if so, enables lut bypass or identity mapping
iirc, and that does the trick well enough for us atm. At least under
OpenGL + Xorg on modern DCN display engines. For older DCE engines, my
software does its own low-level MMIO register programming to get rid of
unwanted dithering, or to enforce the dithering it needs, but this has
become impractical/infeasible for DCN.

I haven't tested this yet under Wayland, as the Wayland eco system is not
ready for the more demanding use cases, and we still have to cling to the
native X-Server for possibly quite a while longer.

Do you know what use cases those customers have for 10 bpc identity
passthrough? I wonder if they are very similar to my use cases for 8 bpc
identity passthrough.

The rounding mode poses a problem for some of my users though, the research
labs that can't afford or use highly specialized display equipment for the
price of an upper class car, and possibly not even the price of
"conventional" high end display monitors ("reference monitors", "broadcast
monitors" as used in movie and tv/streaming post-production etc.) with true
12 bpc input and processing. Or situations where video bandwidth limits
enforce an only 10 bpc output even for 12 bpc capable sinks. Those can be
fine with 10 bpc + gpu dithering.


> I believe we don't have surface info in that code, but one way to work
> around it would be to use spatial dithering for FP16/ARGB16 and rounding
> for 10 bits. But if we just switch to spatial, some of the earlier
> complaints about 10-bit output having one-off bit errors will be coming
> back.
>

Looking at all callers of resource_build_bit_depth_reduction_params(), they
all have access to the associated "struct pipe_ctx", which should give
access to pipe_ctx ->plane_state->format of an associated display plane. I
could prepare a patch that passes the pipe_ctx from each caller
into resource_build_bit_depth_reduction_params() and that function could
check if a 16 bpc framebuffer is in use and switch to spatial dithering
down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc
otherwise.

This workaround, that you also propose, would be the least bad of all bad
solutions.

One goal of the current patch was to be easy to backport, and also to still
make it into drm-fixes before Linux 7. Linux 7.0 will be the standard
distribution kernel for the upcoming Ubuntu 26.04-LTS, and therefore
important for my users.

I think what would really be needed in the long term is a drm connector
property to control dithering. Some kms drivers had this in the olden days,
many years ago. I don't think a guess-o-matic will always guess right,
given that having > 10 bpc precision via dithering will be also beneficial
on 8 or 10 bpc framebuffers + gamma tables for most use cases.

Thanks,
mario


> Thanks,
> Kruno
>
> -----Original Message-----
> From: Mario Kleiner <mario.kleiner.de@gmail.com>
> Sent: Saturday, March 21, 2026 1:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; mario.kleiner.de@gmail.com;
> stable@vger.kernel.org; Cyr, Aric <Aric.Cyr@amd.com>; Koo, Anthony <
> Anthony.Koo@amd.com>; Rodrigo Siqueira <rodrigo.siqueira@amd.com>; Kovac,
> Krunoslav <Krunoslav.Kovac@amd.com>; Deucher, Alexander <
> Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
> back to dithering
>
> [You don't often get email from mario.kleiner.de@gmail.com. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round") degraded display of 12 bpc color precision output to 10 bpc sinks
> by switching 10 bpc output from dithering to "truncate to 10 bpc".
>
> I don't find the argumentation in that commit convincing, but the
> consequences highly unfortunate, especially for applications that require
> effective > 10 bpc precision output of > 10 bpc framebuffers.
>
> The argument wasn't something strong like "there are hardware design
> defects or limitations which require us to work around broken dithering t=
o
> 10 bpc", or "there are some special use cases which do require truncation
> to 10 bpc", but essentially "at some point in the past we used truncation
> in Polaris/Vega times and it looks like it got inadvertently changed for
> Navi, so let's do that again". I couldn't find evidence for that in the g=
it
> commit logs for this. The commit message also acknowledges that using
> dithering "...makes some sense for FP16...
> ...but not for ARGB2101010 surfaces..."
>
> The problem with this is that it makes fp16 surfaces, and especially
> rgba16 fixed point surfaces, less useful. These are now well supported by
> Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by OSS AMDVLK
> Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland, and they
> used to provide more than 10 bpc effective precision at the output.
>
> Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
> e.g., gamma tables, CTM, can be used for color correction and will benefi=
t
> from an effective > 10 bpc output precision via dithering, retaining some
> precision that would get lost on the way through the pipeline, e.g., due =
to
> non-linear gamma functions.
>
> Scientific apps rely on this for > 10 bpc display precision. Truncating t=
o
> 10 bpc, instead of dithering the pipeline internal 12 bpc precision down =
to
> 10 bpc, causes a serious loss of precision. This also creates the
> undesirable and slightly absurd situation that using a cheap monitor with
> only 8 bpc input and display panel will yield roughly 12 bpc precision vi=
a
> dithering from 12 -> 8 bpc, whereas investment into a more expensive
> monitor with 10 bpc input and native 10 bpc display will only yield 10 bp=
c,
> even if a fp16 or rgb16 framebuffer and/or a properly set up color pipeli=
ne
> (gamma tables, CTM's etc. with more than 10 bpc out
> precision) would allow effective 12 bpc precision output.
>
> Therefore this patch proposes reverting that commit and going back to
> dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bp=
c
> output.
>
> Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with =
a
> native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer and
> measuring resulting color precision with a photometer. No apparent visual
> artifacts or problems were observed, and effective precision was measured
> to be 12 bpc again, as expected.
>
> Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
> round")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index c9fbb64d706a..29db5404c4a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5056,7 +5056,7 @@ void
> resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
>                         option =3D DITHER_OPTION_SPATIAL8;
>                         break;
>                 case COLOR_DEPTH_101010:
> -                       option =3D DITHER_OPTION_TRUN10;
> +                       option =3D DITHER_OPTION_SPATIAL10;
>                         break;
>                 default:
>                         option =3D DITHER_OPTION_DISABLE;
> --
> 2.43.0
>
>

--000000000000532c9d064dca0c4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Krunoslav,</div><div><br></div><div>(dropped Rodri=
go=C2=A0from the mail thread, as he seems no longer with AMD&#39;s display =
team, and stable kernel for the moment).</div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 2=
2, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav &lt;<a href=3D"mailto:Krunoslav=
.Kovac@amd.com">Krunoslav.Kovac@amd.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">[AMD Official Use Only - AMD Interna=
l Distribution Only]<br>
<br>
Hi Mario,<br>
<br>
I&#39;m not on that mailing list, not sure how to reply, so I&#39;ll start =
by replying directly here.<br>
<br></blockquote><div>Thanks for the reply.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
There is a reason for the change that is alluded in the commit, but perhaps=
 I should&#39;ve been clearer.<br>
If you have an ARGB2101010 surface and monitor is 10bpc, one of the HW desi=
gn goals is that we can output this in a bit-perfect way, i.e., for every s=
urface pixel value K=3D0..1023, monitor will receive K at its end. It&#39;s=
 also one of the things some customers have checked for and complained abou=
t historically. This is very hard to see visually or even with a colorimete=
r but is readily apparent with a HW capture card.<br>
<br>
Our HW can accomplish this 10-bit perfect requirement if set up correctly, =
however, it can only do so if we use rounding, not dithering.<br>
For example, say you have a 10-bit code 200, our pipeline precision and err=
or accumulation may result with 200.15, which in 12bpc before dithering wou=
ld be 801 and the nature of the spatial dithering is that now and then RNG =
result will push that to 201 output, it&#39;s just the way it works. Roundi=
ng is several times less sensitive to this, and without this randomness com=
ponent, we can verify we&#39;re always accurate enough at 10bpc level.<br><=
/blockquote><div><br></div><div>Ok, that makes a lot more sense. I can unde=
rstand that. My own software and users have the same critical requirement f=
or some use cases, of being able to pass through ARGB8888 surfaces to 8 bpc=
 video sinks. They connect special neuroscience display equipment that pars=
es special binary control information out of false-color coded framebuffer =
images, or implements very high color precision display up to 16 bpc per co=
lor channel on top of 8 bpc framebuffers and some shader magic. Luckily, us=
ing a standard 8 bpc framebuffer under the native X-Server, a 8 bpc DVI-D o=
r DP video sink, and loading a specifically crafted gamma table achieved th=
is for our case, despite the spatial dithering-down-to-8bpc being active. D=
C has some special detection function (__is_lut_linear() in amdgpu_dm_color=
.c) that detects if a user provided gamma lut is essentially meant to be a =
linear identity mapping lut, and if so, enables lut bypass or identity mapp=
ing iirc, and that does the trick well enough for us atm. At least under Op=
enGL=C2=A0+ Xorg on modern DCN display engines. For older DCE engines, my s=
oftware does its own low-level MMIO register programming to get rid of unwa=
nted dithering, or to enforce the dithering it needs, but this has become i=
mpractical/infeasible for DCN.</div><div><br></div><div>I haven&#39;t teste=
d this yet under Wayland, as the Wayland eco system=C2=A0is not ready for t=
he more demanding use cases, and we still have to cling to the native X-Ser=
ver for possibly quite a while longer.</div><div><br></div><div>Do you know=
 what use cases those customers have for 10 bpc identity=20
passthrough? I wonder if they are very similar to my use cases for 8 bpc
 identity passthrough.</div><div><br></div><div>The rounding mode poses a p=
roblem for some of my users though, the research labs that can&#39;t afford=
 or use highly specialized display equipment for the price of an upper clas=
s car, and possibly not even the price of &quot;conventional&quot; high end=
 display monitors (&quot;reference monitors&quot;, &quot;broadcast monitors=
&quot; as used in movie and tv/streaming post-production etc.) with true 12=
 bpc input and processing. Or situations where video bandwidth limits enfor=
ce an only 10 bpc output even for 12 bpc capable sinks. Those can be fine w=
ith 10 bpc=C2=A0+ gpu dithering.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
I believe we don&#39;t have surface info in that code, but one way to work =
around it would be to use spatial dithering for FP16/ARGB16 and rounding fo=
r 10 bits. But if we just switch to spatial, some of the earlier complaints=
 about 10-bit output having one-off bit errors will be coming back.<br></bl=
ockquote><div><br></div><div>Looking at all callers of=C2=A0resource_build_=
bit_depth_reduction_params(), they all have access to the associated &quot;=
struct pipe_ctx&quot;, which should give access to pipe_ctx -&gt;plane_stat=
e-&gt;format of an associated display plane. I could prepare a patch that p=
asses the pipe_ctx from each caller into=C2=A0resource_build_bit_depth_redu=
ction_params() and that function could check if a 16 bpc framebuffer is in =
use and switch to spatial dithering down-to-10-bpc in this case, and leave =
the rounding/truncation to 10 bpc otherwise.</div><div><br></div><div>This =
workaround, that you also propose, would be the least bad of all bad soluti=
ons.</div><div><br></div><div>One goal of the current patch was to be easy =
to backport, and also to still make it into drm-fixes before Linux 7. Linux=
 7.0 will be the standard distribution kernel for the upcoming Ubuntu 26.04=
-LTS, and therefore important for my users.</div><div><br></div><div>I thin=
k what would really be needed in the long term is a drm connector property =
to control dithering. Some kms drivers had this in the olden days, many yea=
rs ago. I don&#39;t think a guess-o-matic will always guess right, given th=
at having &gt; 10 bpc precision via dithering will be also beneficial on 8 =
or 10 bpc framebuffers=C2=A0+ gamma tables for most use cases.</div><div><b=
r></div><div>Thanks,</div><div>mario</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Kruno<br>
<br>
-----Original Message-----<br>
From: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" targe=
t=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
Sent: Saturday, March 21, 2026 1:21 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-=
gfx@lists.freedesktop.org</a><br>
Cc: <a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dr=
i-devel@lists.freedesktop.org</a>; <a href=3D"mailto:mario.kleiner.de@gmail=
.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>; <a href=3D"mailto:s=
table@vger.kernel.org" target=3D"_blank">stable@vger.kernel.org</a>; Cyr, A=
ric &lt;<a href=3D"mailto:Aric.Cyr@amd.com" target=3D"_blank">Aric.Cyr@amd.=
com</a>&gt;; Koo, Anthony &lt;<a href=3D"mailto:Anthony.Koo@amd.com" target=
=3D"_blank">Anthony.Koo@amd.com</a>&gt;; Rodrigo Siqueira &lt;<a href=3D"ma=
ilto:rodrigo.siqueira@amd.com" target=3D"_blank">rodrigo.siqueira@amd.com</=
a>&gt;; Kovac, Krunoslav &lt;<a href=3D"mailto:Krunoslav.Kovac@amd.com" tar=
get=3D"_blank">Krunoslav.Kovac@amd.com</a>&gt;; Deucher, Alexander &lt;<a h=
ref=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank">Alexander.Deuche=
r@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amd/display: Change dither policy for 10 bpc output ba=
ck to dithering<br>
<br>
[You don&#39;t often get email from <a href=3D"mailto:mario.kleiner.de@gmai=
l.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>. Learn why this is =
important at <a href=3D"https://aka.ms/LearnAboutSenderIdentification" rel=
=3D"noreferrer" target=3D"_blank">https://aka.ms/LearnAboutSenderIdentifica=
tion</a> ]<br>
<br>
Commit d5df648ec830 (&quot;drm/amd/display: Change dither policy for 10bpc =
to<br>
round&quot;) degraded display of 12 bpc color precision output to 10 bpc si=
nks by switching 10 bpc output from dithering to &quot;truncate to 10 bpc&q=
uot;.<br>
<br>
I don&#39;t find the argumentation in that commit convincing, but the conse=
quences highly unfortunate, especially for applications that require effect=
ive &gt; 10 bpc precision output of &gt; 10 bpc framebuffers.<br>
<br>
The argument wasn&#39;t something strong like &quot;there are hardware desi=
gn defects or limitations which require us to work around broken dithering =
to 10 bpc&quot;, or &quot;there are some special use cases which do require=
 truncation to 10 bpc&quot;, but essentially &quot;at some point in the pas=
t we used truncation in Polaris/Vega times and it looks like it got inadver=
tently changed for Navi, so let&#39;s do that again&quot;. I couldn&#39;t f=
ind evidence for that in the git commit logs for this. The commit message a=
lso acknowledges that using dithering &quot;...makes some sense for FP16...=
<br>
...but not for ARGB2101010 surfaces...&quot;<br>
<br>
The problem with this is that it makes fp16 surfaces, and especially<br>
rgba16 fixed point surfaces, less useful. These are now well supported by M=
esa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by OSS AMDVLK Vulkan/W=
SI/display, and also by GNOME 50 mutter under Wayland, and they used to pro=
vide more than 10 bpc effective precision at the output.<br>
<br>
Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer, e=
.g., gamma tables, CTM, can be used for color correction and will benefit f=
rom an effective &gt; 10 bpc output precision via dithering, retaining some=
 precision that would get lost on the way through the pipeline, e.g., due t=
o non-linear gamma functions.<br>
<br>
Scientific apps rely on this for &gt; 10 bpc display precision. Truncating =
to 10 bpc, instead of dithering the pipeline internal 12 bpc precision down=
 to 10 bpc, causes a serious loss of precision. This also creates the undes=
irable and slightly absurd situation that using a cheap monitor with only 8=
 bpc input and display panel will yield roughly 12 bpc precision via dither=
ing from 12 -&gt; 8 bpc, whereas investment into a more expensive monitor w=
ith 10 bpc input and native 10 bpc display will only yield 10 bpc, even if =
a fp16 or rgb16 framebuffer and/or a properly set up color pipeline (gamma =
tables, CTM&#39;s etc. with more than 10 bpc out<br>
precision) would allow effective 12 bpc precision output.<br>
<br>
Therefore this patch proposes reverting that commit and going back to dithe=
ring down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bpc outpu=
t.<br>
<br>
Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with a =
native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer and me=
asuring resulting color precision with a photometer. No apparent visual art=
ifacts or problems were observed, and effective precision was measured to b=
e 12 bpc again, as expected.<br>
<br>
Fixes: d5df648ec830 (&quot;drm/amd/display: Change dither policy for 10bpc =
to round&quot;)<br>
Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.c=
om" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
Tested-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" =
target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Cc: Aric Cyr &lt;<a href=3D"mailto:aric.cyr@amd.com" target=3D"_blank">aric=
.cyr@amd.com</a>&gt;<br>
Cc: Anthony Koo &lt;<a href=3D"mailto:anthony.koo@amd.com" target=3D"_blank=
">anthony.koo@amd.com</a>&gt;<br>
Cc: Rodrigo Siqueira &lt;<a href=3D"mailto:rodrigo.siqueira@amd.com" target=
=3D"_blank">rodrigo.siqueira@amd.com</a>&gt;<br>
Cc: Krunoslav Kovac &lt;<a href=3D"mailto:krunoslav.kovac@amd.com" target=
=3D"_blank">krunoslav.kovac@amd.com</a>&gt;<br>
Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" target=3D=
"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c<br>
index c9fbb64d706a..29db5404c4a0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
@@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(struct=
 dc_stream_state *stream,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 option =3D DITHER_OPTION_SPATIAL8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case COLOR_DEPTH_10=
1010:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0option =3D DITHER_OPTION_TRUN10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0option =3D DITHER_OPTION_SPATIAL10;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 option =3D DITHER_OPTION_DISABLE;<br>
--<br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000532c9d064dca0c4b--
