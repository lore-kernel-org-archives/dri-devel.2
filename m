Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444D5D6AAFA
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 02:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C4E10F312;
	Fri,  3 Apr 2026 02:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFCbe7Dm";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DAD10E36C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 02:07:28 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1271195d2a7so2189132c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 19:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775182047; cv=none;
 d=google.com; s=arc-20240605;
 b=L6t3JYUhxVFTt4J/1UckZQDyBCoP1SEzMYPejk4CEA869e+tfzarK2xS24QZY++UAN
 HmUJI9rhek9X60L7yFVQPwhocZ3uDF0ktfZhrqhJ98FP6H1hnR5dCLKiRPMQZ7w/Kiy7
 Q5qHtEMPLPA3CmV7aQ8h5UHjXnHEcY/Nc5vtD9KHk0MruvalXlvVzRu8bclb3MI6tEqO
 uT2Z+nOOe6uZzfueM3YGu4kJ1vyo5N6LzgU5b0oVpEGT8hBm+mIwHDuhhBeY+nq99nMC
 GHzqWxiwOpOI98YHsCrXlTqtUZVP1lAKukw36vyeY2OiPGBDzsXPPJPDFwl2g69IaelN
 uv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 fh=DklnO+5AsYCxb5yTbysAsRdMw+AYgz/RdLh7/63Nr8M=;
 b=T/djDD8g7BmmgxtpHSfjG/76PX+yOwhnIN1JV56kszetEuHv16o+2rEdC4eLztU8Gk
 HQVtYum2iE7W/EE5cwjtsNMQ8nwy6FBzDbEjqsbkgJrTFuqpVkar7CRauo5KpZd1mb02
 4IlvKAyWTj02zrhRMso7p1UHU2vvbqchMrpKVIag9M0HRkRJ7N1CJYBtNInCLwKY0LXH
 dI8Gc5PSpLYPzJwWNHj3R93S6dO7xraeq/mB2v3WjNmn9kdvwEEt+uCoN7xs9siPpsgU
 JSJkda2HRn6toTFtqfWJKSdK5FpG0jBcklO08NgO95b+x9/BIJOuRcoK2/V/rfG/X+4C
 Z3yg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775182047; x=1775786847; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 b=gFCbe7DmVN4Xi1xdbq3LjLZYhavFicbXHMJYXbGBUxliE0KASQZsq05vqP3smJHtOr
 uinALXkTqneUoehCdxA9HiHGY1bvUc3/f8ztlIdUHJR6J4BMpHhg6vCbLuIS4uREPmVs
 /9aorn4cb7wJWnj3OhjGSfO3MBeuis4O2b57LIsLNrPEhG49ZBSyqCEDKDrc+eBxmjIY
 9hON6hdhFimba82F0uAFpdUYxenU2lWJIoj9U5fJVfG1F3dY1dM3QetWhgQOOM8f5Ekf
 k7i3NIrPykLMV/N3wv19eVcxzNr99zIxyyq7XRrQY0ZGO3W6yOucPYoPIN2o44hwEL4Y
 VTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775182047; x=1775786847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 b=IeYeIakB91JNAZT4d0zn74E/bFNTCAUmXwhGnL/3G6KQNBEIYnlfKIFhBEUN7x7+sQ
 l3FtcNOc/EBDaYk7QW/2tCwCZV7qqz6Y6q25enU0GxKLDbPIebfJm8quYZgaxf7yfMH1
 9cOyPOoP1zuTRmjmEsUItUi0DLIKh8QmW6perjs9H558ZjF1FYrYxPqeS9WnvrdGMz1J
 wVkym7Z2c8ERhha6TQdxQ5UFlUDsKWQHb4DPzZcVw+xoxhLB3h5kf/KIl5XLO2WYccr7
 728CuXQMZbxbQCetzfG1iGHax1uYw4YY4ZheLpuV4/I5OgqhCf4K3rHQwOCGkwqj3Ths
 JMIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSFEZeoH1IkYodIs3piGHGBjsQHkEafMfEBm61gMx6r0NZTy/tjo0Wdb+5A56O+NR/YgsC6rpGQKs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoXuw/F5QFBNJzdZdVSl1ow7HwkvemQIURU4OT1B5PmGyBpc7l
 InCVaK4CZaprB3TPG9+h8jRo7Glf/0q1gIYtuVZavpoEr+wM7ClzVu65uwT7iUL3Ve/9rb3qbFD
 ZUVlOXkOnDzijEFKn/9IUY9rqA4o6R3Q=
X-Gm-Gg: ATEYQzyZS2QWHWw5chsIyKtHIbofk0tRBCtd3g+yHZ92WiaQsF7VMh46x1U7MnKNPX5
 KI2rGMIBlNLMh9G6J0ykQcwpqSQely5iEAPX8SOkZTQ2A4C9VR6iP2EiqSuJstPj0Us0TBJfSiK
 q961IH4nH/MG0Qjm8bO4LRJfggRvaLxjz77piQK1Z9AHY0Vt76+EAX6Sggx3yKdwMyYsSAB25h0
 OpFat58kiO1sTOhDm11niZTjKqMcEb4/ocGeKUUTdP3102byKrASiL4HzMg8a/Me+91Ed1QQ3yE
 O2IjJe/744C5sK980A/jN/sltTQBoIOLcgmknvvz3A==
X-Received: by 2002:a05:7022:b9c:b0:128:cf86:d1cb with SMTP id
 a92af1059eb24-12bfb76b78amr632139c88.31.1775182047343; Thu, 02 Apr 2026
 19:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <f4861fc9-a602-44b9-b5c3-6b9c7f233b15@amd.com>
In-Reply-To: <f4861fc9-a602-44b9-b5c3-6b9c7f233b15@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 3 Apr 2026 04:06:50 +0200
X-Gm-Features: AQROBzBYKvLcn-fpWdDlHhBv6oqIOkFDp46xmMBpkM_oFXmS8VBAM6auqfiTp6Y
Message-ID: <CAEsyxyidQQMYH5TZt9D-4iGSmhPRp-iQ7meqer-YdJ9FPc6cZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>, 
 Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="00000000000057fa0b064e84c7cc"
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

--00000000000057fa0b064e84c7cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's great to hear! Maybe still a happy end for my users and Ubuntu
26.04-LTS.

Thanks Harry!

On Wed, Apr 1, 2026 at 9:32=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om>
wrote:

>
>
> On 2026-03-21 01:20, Mario Kleiner wrote:
> > Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc t=
o
> > round") degraded display of 12 bpc color precision output to 10 bpc sin=
ks
> > by switching 10 bpc output from dithering to "truncate to 10 bpc".
> >
> > I don't find the argumentation in that commit convincing, but the
> > consequences highly unfortunate, especially for applications that
> > require effective > 10 bpc precision output of > 10 bpc framebuffers.
> >
> > The argument wasn't something strong like "there are hardware design
> > defects or limitations which require us to work around broken dithering
> > to 10 bpc", or "there are some special use cases which do require
> > truncation to 10 bpc", but essentially "at some point in the past we
> > used truncation in Polaris/Vega times and it looks like it got
> > inadvertently changed for Navi, so let's do that again". I couldn't fin=
d
> > evidence for that in the git commit logs for this. The commit message
> also
> > acknowledges that using dithering "...makes some sense for FP16...
> > ...but not for ARGB2101010 surfaces..."
> >
> > The problem with this is that it makes fp16 surfaces, and especially
> > rgba16 fixed point surfaces, less useful. These are now well
> > supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> > OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Waylan=
d,
> > and they used to provide more than 10 bpc effective precision at the
> > output.
> >
> > Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffe=
r,
> > e.g., gamma tables, CTM, can be used for color correction and will
> > benefit from an effective > 10 bpc output precision via dithering,
> > retaining some precision that would get lost on the way through the
> > pipeline, e.g., due to non-linear gamma functions.
> >
> > Scientific apps rely on this for > 10 bpc display precision. Truncating
> > to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> > down to 10 bpc, causes a serious loss of precision. This also creates t=
he
> > undesirable and slightly absurd situation that using a cheap monitor
> > with only 8 bpc input and display panel will yield roughly 12 bpc
> > precision via dithering from 12 -> 8 bpc, whereas investment into a
> > more expensive monitor with 10 bpc input and native 10 bpc display will
> > only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properl=
y
> > set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc o=
ut
> > precision) would allow effective 12 bpc precision output.
> >
> > Therefore this patch proposes reverting that commit and going back to
> > dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8
> bpc
> > output.
> >
> > Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 wit=
h
> > a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer
> and
> > measuring resulting color precision with a photometer. No apparent visu=
al
> > artifacts or problems were observed, and effective precision was measur=
ed
> > to be 12 bpc again, as expected.
> >
> > Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc t=
o
> round")
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Cc: stable@vger.kernel.org
> > Cc: Aric Cyr <aric.cyr@amd.com>
> > Cc: Anthony Koo <anthony.koo@amd.com>
> > Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Kruno and I chatted a bit more about this and the best way forward
> seems to be to re-enable SPATIAL10 dither and then override that
> when needed in our Windows driver.
>
> Patches is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Will pull it in today.
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index c9fbb64d706a..29db5404c4a0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -5056,7 +5056,7 @@ void
> resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
> >                       option =3D DITHER_OPTION_SPATIAL8;
> >                       break;
> >               case COLOR_DEPTH_101010:
> > -                     option =3D DITHER_OPTION_TRUN10;
> > +                     option =3D DITHER_OPTION_SPATIAL10;
> >                       break;
> >               default:
> >                       option =3D DITHER_OPTION_DISABLE;
>
>

--00000000000057fa0b064e84c7cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>That&#39;s great to hear! Maybe still a happy end for=
 my users and Ubuntu 26.04-LTS.</div><div><br></div><div>Thanks Harry!</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Wed, Apr 1, 2026 at 9:32=E2=80=AFPM Harry Wentlan=
d &lt;<a href=3D"mailto:harry.wentland@amd.com">harry.wentland@amd.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026-03-21 01:20, Mario Kleiner wrote:<br>
&gt; Commit d5df648ec830 (&quot;drm/amd/display: Change dither policy for 1=
0bpc to<br>
&gt; round&quot;) degraded display of 12 bpc color precision output to 10 b=
pc sinks<br>
&gt; by switching 10 bpc output from dithering to &quot;truncate to 10 bpc&=
quot;.<br>
&gt; <br>
&gt; I don&#39;t find the argumentation in that commit convincing, but the<=
br>
&gt; consequences highly unfortunate, especially for applications that<br>
&gt; require effective &gt; 10 bpc precision output of &gt; 10 bpc framebuf=
fers.<br>
&gt; <br>
&gt; The argument wasn&#39;t something strong like &quot;there are hardware=
 design<br>
&gt; defects or limitations which require us to work around broken ditherin=
g<br>
&gt; to 10 bpc&quot;, or &quot;there are some special use cases which do re=
quire<br>
&gt; truncation to 10 bpc&quot;, but essentially &quot;at some point in the=
 past we<br>
&gt; used truncation in Polaris/Vega times and it looks like it got<br>
&gt; inadvertently changed for Navi, so let&#39;s do that again&quot;. I co=
uldn&#39;t find<br>
&gt; evidence for that in the git commit logs for this. The commit message =
also<br>
&gt; acknowledges that using dithering &quot;...makes some sense for FP16..=
.<br>
&gt; ...but not for ARGB2101010 surfaces...&quot;<br>
&gt; <br>
&gt; The problem with this is that it makes fp16 surfaces, and especially<b=
r>
&gt; rgba16 fixed point surfaces, less useful. These are now well<br>
&gt; supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by<=
br>
&gt; OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayla=
nd,<br>
&gt; and they used to provide more than 10 bpc effective precision at the<b=
r>
&gt; output.<br>
&gt; <br>
&gt; Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuff=
er,<br>
&gt; e.g., gamma tables, CTM, can be used for color correction and will<br>
&gt; benefit from an effective &gt; 10 bpc output precision via dithering,<=
br>
&gt; retaining some precision that would get lost on the way through the<br=
>
&gt; pipeline, e.g., due to non-linear gamma functions.<br>
&gt; <br>
&gt; Scientific apps rely on this for &gt; 10 bpc display precision. Trunca=
ting<br>
&gt; to 10 bpc, instead of dithering the pipeline internal 12 bpc precision=
<br>
&gt; down to 10 bpc, causes a serious loss of precision. This also creates =
the<br>
&gt; undesirable and slightly absurd situation that using a cheap monitor<b=
r>
&gt; with only 8 bpc input and display panel will yield roughly 12 bpc<br>
&gt; precision via dithering from 12 -&gt; 8 bpc, whereas investment into a=
<br>
&gt; more expensive monitor with 10 bpc input and native 10 bpc display wil=
l<br>
&gt; only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a proper=
ly<br>
&gt; set up color pipeline (gamma tables, CTM&#39;s etc. with more than 10 =
bpc out<br>
&gt; precision) would allow effective 12 bpc precision output.<br>
&gt; <br>
&gt; Therefore this patch proposes reverting that commit and going back to<=
br>
&gt; dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8=
 bpc<br>
&gt; output.<br>
&gt; <br>
&gt; Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 wi=
th<br>
&gt; a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer=
 and<br>
&gt; measuring resulting color precision with a photometer. No apparent vis=
ual<br>
&gt; artifacts or problems were observed, and effective precision was measu=
red<br>
&gt; to be 12 bpc again, as expected.<br>
&gt; <br>
&gt; Fixes: d5df648ec830 (&quot;drm/amd/display: Change dither policy for 1=
0bpc to round&quot;)<br>
&gt; Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gm=
ail.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Tested-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.=
com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Cc: Aric Cyr &lt;<a href=3D"mailto:aric.cyr@amd.com" target=3D"_blank"=
>aric.cyr@amd.com</a>&gt;<br>
&gt; Cc: Anthony Koo &lt;<a href=3D"mailto:anthony.koo@amd.com" target=3D"_=
blank">anthony.koo@amd.com</a>&gt;<br>
&gt; Cc: Rodrigo Siqueira &lt;<a href=3D"mailto:rodrigo.siqueira@amd.com" t=
arget=3D"_blank">rodrigo.siqueira@amd.com</a>&gt;<br>
&gt; Cc: Krunoslav Kovac &lt;<a href=3D"mailto:krunoslav.kovac@amd.com" tar=
get=3D"_blank">krunoslav.kovac@amd.com</a>&gt;<br>
&gt; Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" targ=
et=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
Kruno and I chatted a bit more about this and the best way forward<br>
seems to be to re-enable SPATIAL10 dither and then override that<br>
when needed in our Windows driver.<br>
<br>
Patches is<br>
Reviewed-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland@amd.com" t=
arget=3D"_blank">harry.wentland@amd.com</a>&gt;<br>
<br>
Will pull it in today.<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; index c9fbb64d706a..29db5404c4a0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(s=
truct dc_stream_state *stream,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option =3D DITHER_OPTION_SPATIAL8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case COLOR_DEPTH=
_101010:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0option =3D DITHER_OPTION_TRUN10;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0option =3D DITHER_OPTION_SPATIAL10;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option =3D DITHER_OPTION_DISABLE;<br>
<br>
</blockquote></div>

--00000000000057fa0b064e84c7cc--
