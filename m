Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71027CD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590BC10E6CE;
	Thu, 28 May 2026 20:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jGtoLau4";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10ACE10E6BF
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 20:19:07 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-439acb393f7so14487306fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779999546; cv=none;
 d=google.com; s=arc-20240605;
 b=MpbNsn9cAq0syF31qw54Ip5d6aM49cqkF7YkUuruLfZ7W+8tnbMiOaiiQUlmPWOw5C
 CE3J8iHxgqwqn9thhFKQad9mczIl1OFrbaKJjfzjB2YeWYPimwAiVj5hE7B2wHWNPov5
 orI/LNhdhHq+bBjMRO0Wlx0pg4W+AS2dkqr9XOaPrHG7ml7eby/2NlYu5Pqx6qCKgIsT
 RlZhoeDdShDpM9WBGAyoOLDO46VGqi2iN3xbDmdQAr/Q046jpCsDWp8Ux2iuSnDo4av0
 NyslN+ydYZoH5NkChARA5N6A81AWLe1RsGg+wik9e8XsdLkk0LZiP3Yv6aWEnPfgmSKV
 45hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NEzjnv+Kp0jO+B1kdAYqSGuPLxg2TUZ6vcH1EWXCMJY=;
 fh=nIW2/vZr9sJyo2BcaSA2X8QjMMbpzkn+wgJrbD5xjPk=;
 b=cJKDbXGP2UoQWu1UqOFuIsha3yjyvkCOYAGaZ3SACuJ30W+gSFw8rjjBZbyGFmFV5A
 5SOROzEeAR9VUaIr22bN8j9IoEXTe3N0rYIXXyF9CaOesellEyCM0tKFRfho5HPu8qdA
 jEeBQRBXZOAXuSlQjQl5MOmCeZIeX4xr9YxZLcsLEVqncjCDQKZX4dOm7FYyzE3zMXnA
 FDpYoB1CP9pZwvGUBg3kzh9r9kfxPKXDlt4zvDvGpWOhKeAR4kdT79/3JM7/gMeMBJme
 LQgjMKhhaylqNJp8/Zh/+nHV4OKpoguwwk13WwTWCFc+tOUgrPSvUGYYgEHGV7DgKYhF
 7SDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779999546; x=1780604346;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NEzjnv+Kp0jO+B1kdAYqSGuPLxg2TUZ6vcH1EWXCMJY=;
 b=jGtoLau4ObJUQQ46MhY4fwxt6t44MbpIZdfvmFpCAJtiKbiIFQN5gH+tftF+D1WJn2
 nT80GajDnC57Dzf2S62ckHT+OwTC1krCwbUVrmITtJ0te7vMm8dKB06bFRhvT7DGGxJu
 Um6DrDdywt/FItfEIbQupEuiUqSyM8p3O02fbgU0b5r4f5HeFUrAsSVShtj2xQUiUVuQ
 z/PCsCVY11chDdV1MDUR6vr8ipuFiBp4M74Sj1wFm7DvGb/LqalD7lme9TRIDqQvoB6q
 ehQXl4WhVb8HVV/kPtPBSLZJ4yp5+a/p+Qr3DQLnBQH9i5+IAbvDDsAABhdqMae5Yipb
 nmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999546; x=1780604346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEzjnv+Kp0jO+B1kdAYqSGuPLxg2TUZ6vcH1EWXCMJY=;
 b=fUL1aCMBH8WLsgrO1G56NP8Xy/n1gTLpnswm96aS0jepmIHLh1PNwwRp8ETCLYf9fH
 VGIOgAUHKsx6CRTowamF9PBPSM6toHAN3P4wp1qN+HbnEoa7BuprFR8OQ0iAALXxMi8g
 0g2iPjXo94i66FDxVDepjYc7Dzp5A4VsY0MD1VQNplD2uvx32ipKsNLrSoxOd5lqnCUJ
 aBYEAdoZMMrAt3LYWyisi19vGDI+nHFJpHRO5j+WuYsbHIFuuMqYcV/Thp2u7ybRP/b1
 mDWx7sfhf5Z/1rvjK5AfDt7zIAnx8YGyjVOy8/i4W6SmO1F4bDS3ZX5qQSjD7mTVtJpX
 ZxEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kLK3QQ9kSSh3uwJsTppqZUWldz49vsuGN0kCSZ7QaDJtmLRMlOV3xJ8A6tHzIjATNnY7ywK38eRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbtuofDXEDsGMR6yUtZZXejGMJsRsXcS8E+TdcrGaaL/75qzSc
 nIuYvS1ACHuT2XJqM9sDLCGzvAKRIq0KYnVOEkIRAX13xAizNhvA7gFSnLXT03uX++w8TgK59Gc
 2F3NzJ3P/faqctkEV+Xodi3I0do9BFcrLTZDBNnf2
X-Gm-Gg: Acq92OHPnGNav4N2/oawpXtK6nJVbOik3dr16VBw2djOKer5hT8ep/htmfBA4gqdbIV
 8ULETNsSGmgcHOFVnIUx9WGulo8M9Q4445VNNsBq9vJ5Cj47Nrkw3gVEdateQ1iivm05B62xcND
 F/uTkrjJ2k8T9bXODsTTc9CHrLrqmPCQauRocZVwo7ugz9zw/kosSb+MxDOKR0C6FRAau/7jNko
 lnjyjTJfTkHImvIQF8NDtX2mhhUT3paAiuyP/iOJ1vZuNzgPA219o1bdjUjPcpxj7zT2oMvz4Nf
 0A1979YcWfd+nJGVPU5MAgtiQYAgkCj3szP/V3FubzjllgZ6iW71A0acC5WYZQVgBrokghYH+wz
 xyaQTynP9tw4Ke5MhK+8nzYac5PZTj4ky2KXGQlBXO9gjyXBJBrdQnqTPgCLOjpteSSq0fPU=
X-Received: by 2002:a05:6870:e08f:b0:43b:543c:5069 with SMTP id
 586e51a60fabf-43c85f2c4a1mr187366fac.15.1779999545649; Thu, 28 May 2026
 13:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <6d8e36e2aea806f9973b3c501aad4523f7316d6a@intel.com>
 <20260521194018.2445206-1-sean@poorly.run>
 <20260521194018.2445206-2-sean@poorly.run>
 <9b290b22-97a9-4ffc-9823-67efba98c70f@intel.com>
In-Reply-To: <9b290b22-97a9-4ffc-9823-67efba98c70f@intel.com>
From: Sean Paul <seanpaul@google.com>
Date: Thu, 28 May 2026 16:18:28 -0400
X-Gm-Features: AVHnY4Kao597dDx2SRbChuVFrf-Jrh9IUtXZpLh_1XKHqDfReuT3ymaWu95wqY8
Message-ID: <CAOw6vbLn+-iEk_Aky9r-TWuT3WXi4xkHZ3ZUDyX7EeKPKDpf1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/i915/color: Fix Pre-CSC degamma LUT bounds
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org, 
 jani.nikula@linux.intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a05c6b0652e670b8"
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

--000000000000a05c6b0652e670b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 1:23=E2=80=AFAM Borah, Chaitanya Kumar <
chaitanya.kumar.borah@intel.com> wrote:

> Hello Sean,
>
> On 5/22/2026 1:09 AM, Sean Paul wrote:
> > From: Sean Paul <seanpaul@google.com>
> >
> > Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut
> > for Segment 2 degamma programming, changing 'while (i++ > 130)' to
> > 'while (i++ < 130)'. Also clamp Segment 2 to the last user-provided
> > LUT entry value instead of hardcoding it to 1.0 (1 << 24) to fix
> > a step discontinuity.
>
> The commit message needs an update.
>

Ack.


> Is there an easy way to reproduce the problem you are seeing (e.g. IGT)?
>

Unfortunately I don't have an IGT test, it's reproducing readily with our
userspace.

Sean

I am wondering if we have to do the same on the pipe Gamma and Degamma.
>
> =3D=3D
> Chaitanya
>
> >
> > Link:
> https://lore.kernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.ru=
n/
> #v1
> > Signed-off-by: Sean Paul <seanpaul@google.com>
> >
> > Changes in v2:
> > - Split out into separate patches for pre/post csc fixes
> > - Dropped loop bounds fix in favor of [1]
> >
> > [1]-
> https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel.com
> > ---
> >   drivers/gpu/drm/i915/display/intel_color.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_color.c
> b/drivers/gpu/drm/i915/display/intel_color.c
> > index 90d5dc2ef3e4..469011c83f9b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_color.c
> > +++ b/drivers/gpu/drm/i915/display/intel_color.c
> > @@ -3953,6 +3953,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb
> *dsb,
> >       enum plane_id plane =3D to_intel_plane(state->plane)->id;
> >       const struct drm_color_lut32 *pre_csc_lut =3D
> plane_state->hw.degamma_lut->data;
> >       u32 i, lut_size;
> > +     u32 lut_val =3D 1 << 24;
> >
> >       if (icl_is_hdr_plane(display, plane)) {
> >               lut_size =3D 128;
> > @@ -3963,7 +3964,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb
> *dsb,
> >
> >               if (pre_csc_lut) {
> >                       for (i =3D 0; i < lut_size; i++) {
> > -                             u32 lut_val =3D
> drm_color_lut32_extract(pre_csc_lut[i].green, 24);
> > +                             lut_val =3D
> drm_color_lut32_extract(pre_csc_lut[i].green, 24);
> >
> >                               intel_de_write_dsb(display, dsb,
> >
> PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
> > @@ -3975,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb
> *dsb,
> >                       do {
> >                               intel_de_write_dsb(display, dsb,
> >
> PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
> > -                                                (1 << 24));
> > +                                                lut_val);
> >                       } while (i++ > 130);
> >               } else {
> >                       for (i =3D 0; i < lut_size; i++) {
>
>

--000000000000a05c6b0652e670b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 1:23=E2=80=AFAM Borah, Chaitanya Kumar &lt;<a href=3D"mailto:chait=
anya.kumar.borah@intel.com">chaitanya.kumar.borah@intel.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello Sean,<br>
<br>
On 5/22/2026 1:09 AM, Sean Paul wrote:<br>
&gt; From: Sean Paul &lt;<a href=3D"mailto:seanpaul@google.com" target=3D"_=
blank">seanpaul@google.com</a>&gt;<br>
&gt; <br>
&gt; Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut<br=
>
&gt; for Segment 2 degamma programming, changing &#39;while (i++ &gt; 130)&=
#39; to<br>
&gt; &#39;while (i++ &lt; 130)&#39;. Also clamp Segment 2 to the last user-=
provided<br>
&gt; LUT entry value instead of hardcoding it to 1.0 (1 &lt;&lt; 24) to fix=
<br>
&gt; a step discontinuity.<br>
<br>
The commit message needs an update.<br></blockquote><div><br></div><div>Ack=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Is there an easy way to reproduce the problem you are seeing (e.g. IGT)?<br=
></blockquote><div><br></div><div>Unfortunately I don&#39;t have an IGT tes=
t, it&#39;s reproducing readily with our userspace.</div><div><br></div><di=
v>Sean</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
I am wondering if we have to do the same on the pipe Gamma and Degamma.<br>
<br>
=3D=3D<br>
Chaitanya<br>
<br>
&gt; <br>
&gt; Link: <a href=3D"https://lore.kernel.org/intel-gfx/20260521180143.2143=
262-1-sean@poorly.run/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.run/</a> #v1<br>
&gt; Signed-off-by: Sean Paul &lt;<a href=3D"mailto:seanpaul@google.com" ta=
rget=3D"_blank">seanpaul@google.com</a>&gt;<br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Split out into separate patches for pre/post csc fixes<br>
&gt; - Dropped loop bounds fix in favor of [1]<br>
&gt; <br>
&gt; [1]- <a href=3D"https://lore.kernel.org/r/20260519075245.383864-1-pran=
ay.samala@intel.com" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/r/20260519075245.383864-1-pranay.samala@intel.com</a><br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/i915/display/intel_color.c | 5 +++--<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/=
drm/i915/display/intel_color.c<br>
&gt; index 90d5dc2ef3e4..469011c83f9b 100644<br>
&gt; --- a/drivers/gpu/drm/i915/display/intel_color.c<br>
&gt; +++ b/drivers/gpu/drm/i915/display/intel_color.c<br>
&gt; @@ -3953,6 +3953,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum plane_id plane =3D to_intel_plane(state=
-&gt;plane)-&gt;id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct drm_color_lut32 *pre_csc_lut =
=3D plane_state-&gt;hw.degamma_lut-&gt;data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 i, lut_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 lut_val =3D 1 &lt;&lt; 24;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (icl_is_hdr_plane(display, plane)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lut_size =3D 128=
;<br>
&gt; @@ -3963,7 +3964,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pre_csc_lut)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (i =3D 0; i &lt; lut_size; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 lut_val =3D drm_color_lut32_extract(=
pre_csc_lut[i].green, 24);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lut_val =3D drm_color_lut32_extract(pre_=
csc_lut[i].green, 24);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intel_de_write_dsb(display, dsb,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0)=
,<br>
&gt; @@ -3975,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0do {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intel_de_write_dsb(display, dsb,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0)=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 24));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 lut_val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} while (i++ &gt; 130);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (i =3D 0; i &lt; lut_size; i++) {<br>
<br>
</blockquote></div></div>

--000000000000a05c6b0652e670b8--
