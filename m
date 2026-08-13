Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD66C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228ED10F334;
	Fri, 14 Aug 2026 07:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7BnIhk7";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D4B10E4C0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:18:27 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so2572461cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786645107; cv=none;
 d=google.com; s=arc-20260327;
 b=lpwFChkJSliq/4G6RqVC7DSs2T8cJzYVhdNZfk2HRJSojXo5CPXPZfduF7k0yJoWVi
 aX9EqxeH0n5QWcv0620/WtSVuv/vAJbOEysgdwHYli4xflBc+vo+sQ1Av4oEEc4OWcC8
 JhPGkmHe+7sAMAaCgmFYDSDS2LVcWBoM5GYaYDZjfvZT9GmadGQzcWseiTp3hbb/Yu7+
 mo6S89lhx/QgO01FdjK5p9jhyItA/y1tvD1exiCLrsIGnxDSTI34u5tftaHMVtXdGJnG
 RprIgu1eDpGtDCz4sKdqF4oGNsMhoFg+B1syTZN0vNNTqAFYZW3jyGbzxt7N/W9bKqz5
 o92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PCay4RrAo4GZ9BdL8qvGYsH6Vxs4Vtyx/Y65EBXVVW8=;
 fh=0cyeOjsV3LsmUaXYFd3unUCVW6ZXcFbA7JPLV1bm4Yk=;
 b=eP6IFSFHIYThdFCckM5mZb4lPZZPWwcev56QU22qWpgeSpUmCt6HDiKm8kRt8CwTJ4
 GfgaVn9iknh9j9eYz1ZxgVc8/MOwB8oTcOpwjOm9npupzewU+O5srbllohqJM91fW+sW
 s3w/hsaRnN3Qz3HOoJuwefqznf9N1jpHmXKqWd17cYFVG8+pXjOsIUUGCxtWCZeQQSbd
 uPaNNWcFAMz/CW2/gHn+QPg+aQ+ixy4LS+UaUo3Jmmoo0NCvIG4CeG22qHdWwfZFg11o
 28OlIX1+4EsYZKxuT1jxWCDFbXejOfHlieuet5BvsSseWudHGYgUo3Cy2ROCKQFntwgo
 dHiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786645107; x=1787249907; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PCay4RrAo4GZ9BdL8qvGYsH6Vxs4Vtyx/Y65EBXVVW8=;
 b=D7BnIhk7Iz45dEYkD3NZEaf2N5JtFZr0FJYy3Ahbp1Min5bKVUx11kINMLy3plDyGr
 kfGfLhGimx1GeGFjYVo5brQVzX2frrzzx6Dl972S6pQDf1WgcsMw7s56YqyJQGDGXy6q
 oS0RGvxysm4g+mQgCuEPMLowhPUyJBSopCoI8CLuQlterTrPWJ/UfSpVCpkaJXyLvUoY
 sMBnzUBx2qP83oGXLIyT+ERuIZLl+VttqTAeii5exF+eQV8mn0YJZfpDFzSATE1valqG
 /4RFKrWQffoNP9HoNIjls3ckHWEwHsa+N7ANmBpIN69CMVixcOXkz0b1j9QoDNpOfWpx
 OlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645107; x=1787249907;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PCay4RrAo4GZ9BdL8qvGYsH6Vxs4Vtyx/Y65EBXVVW8=;
 b=H4wfxEw0NCH9XmAmWCpExmJ5UiS5P3Ydp0LX/LUlAWr64rJGBxSdLz8pShHzEh0SuM
 kkJ5u6sfGo2hOkeMwCv4g53qKgUJha0NKA3vwEJXnCwyayV3ezeY7aT/Xu7TCY8gC27+
 ort4aDkN+IAFa4LLqXMnuQIzknNPuT7dvLsNZUPLjclLMdLUw0I58gYSgAUBs+mhumev
 BXkKzUDwgDughFPyGufBQ6d1juBdaDsXmNGYSl3CwgtAjpW079/ZSY82l6xDF2Svsuul
 pQEj83jCwLD7vrSIzOUSX2xC7GIKswGwYcDmQBIrdizq53c6m9cupkXusVrEqGLfABJ9
 TLEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRZ8M1WTJY+H5YzqTwALQ4aLQy+w5orqeO3m1dYVJOezNYOankeyUwiF6WXGmylXtYAJYd+oqu/hg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRy5e2UHf2o8WsX3eYp7xmv+LzsCizZDH/Ci1ijd9UrrlaWjAH
 tVrG8MRBXg4X+N4NDTdtNGE3KIzvT95aqTxTt/r0RNziqQaHTlqA7L5sdNWnmqWICB2lx0xXb3M
 VNOwM7WD4+9n9aAU4F4M4IM2LrF84P1A=
X-Gm-Gg: AR+sD138UCXQHI5WgTbc+V85lV6w+yFwit5GIIW8pFdz0+mehpySLPHT/uNctZ2EzF7
 AFmnA9FSHZMWzK7HVnH/ifSQShvFERm+kCKUybu4kn9KDb8PGT9tzfFwTVyTEa0IY6DDA2ZJAA3
 r29/uuCRsyWN252LAWxZfMTE07jC8uT14w3OR+cHW8+DcRUIAdO5mTWJ96uKMn3bZC9ZVqEhngm
 Cr6xjBU7kmZBWC9u1Xu38b16oE5dop5MMo/E1qIEgLxAJT8pHzrBpHf8lhXPmghiMQy9JBvBADC
 QqNnOYfo+d93GI+9EU1yIQ+N9ukAtB+GwaX3ARoqwAWpnao27ZR3y4ZxOrlTvLJTAILoAE/0cYw
 =
X-Received: by 2002:a05:622a:4d8d:b0:51c:1a11:75cf with SMTP id
 d75a77b69052e-52d73c38bc3mr97385791cf.7.1786645106421; Thu, 13 Aug 2026
 11:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
 <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
In-Reply-To: <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
From: =?UTF-8?B?0JDRhdC80LXQtCDQltC40YLQsNC10LI=?= <zhitaevakh@gmail.com>
Date: Thu, 13 Aug 2026 23:18:15 +0500
X-Gm-Features: AUfX_mxu0mo-MJqrfFbr6G6YAcG8U7wjIYJiCEBA9_I0e0yPPLsi5YokD-eJzhY
Message-ID: <CAGJKGUwgv2tngxmujbo3z0EQvn_hAuh76K8qYWmYxTgKEs1kBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000e874350658f1ba74"
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

--000000000000e874350658f1ba74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this is still needed.

f1b5d8f9cc54 fixes the advertised max_brightness mismatch by restoring the
full userspace range [0..max].

The issue fixed by this patch is different: the custom brightness curve
input is still normalized by (max - min). On panels with a non-zero PWM
minimum, valid userspace requests near the top of the [0..max] range can
therefore produce a curve input above 255.

On my panel, min=3D3084 and max=3D65535. Without this patch, requests above=
 the
upper boundary caused the backlight to drop dark; with this patch, the full
range maps into [0..255] and the issue no longer reproduces.

I also tested with the f1b5d8f9cc54 semantics present, so the regression is
still present without this change.


=D1=87=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:45, Mar=
io Limonciello <mario.limonciello@amd.com>:

>
>
> On 8/13/26 12:09, Akhmed Zhitaev wrote:
> > Custom brightness curves use an 8-bit input signal.  After exporting th=
e
> > full PWM range to userspace, the curve normalizer still divides request=
s
> > by the physical PWM span.  On panels with a nonzero minimum PWM level,
> > this can produce a curve input greater than 255 and send an invalid
> > backlight level to DC.
> >
> > Scale the userspace [0..max] range to the curve's [0..255] range
> > instead.  This retains the full advertised range and keeps the reverse
> > readback conversion unchanged.
> >
> > Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to
> userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40d82a3ee..533c69f0b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct
> amdgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> > -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> > +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> > +static inline u32 scale_input_to_fw(int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max -
> min);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
> >   }
> >
> >   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> > @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struc=
t
> amdgpu_dm_backlight_caps *cap
> >                                     unsigned int min, unsigned int max,
> >                                     uint32_t *user_brightness)
> >   {
> > -     u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> > +     u32 brightness =3D scale_input_to_fw(max, *user_brightness);
> >       u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> >       int left, right;
> >
>
> Is this still needed with
>
> "drm/amd/display: Fix backlight max_brightness to match exported range"
>
>
> https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae48=
8e1bf625
>

--000000000000e874350658f1ba74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-PDq2pG_selectionAnchorContainer">Yes, th=
is is still needed.<span aria-hidden=3D"true" class=3D"gmail-PDq2pG_selecti=
onAnchor"></span></p>
<p><code>f1b5d8f9cc54</code> fixes the advertised <code>max_brightness</cod=
e> mismatch by restoring the full userspace range <code>[0..max]</code>.</p=
>
<p>The issue fixed by this patch is different: the custom brightness curve =
input is still normalized by <code>(max - min)</code>. On panels with a non=
-zero PWM minimum, valid userspace requests near the top of the <code>[0..m=
ax]</code> range can therefore produce a curve input above 255.</p>
<p>On my panel, <code>min=3D3084</code> and <code>max=3D65535</code>. Witho=
ut this patch, requests above the upper boundary caused the backlight to dr=
op dark; with this patch, the full range maps into <code>[0..255]</code> an=
d the issue no longer reproduces.</p>
<p>I also tested with the <code>f1b5d8f9cc54</code> semantics present, so t=
he regression is still present without this change.</p><br></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">=D1=87=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:4=
5, Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mario=
.limonciello@amd.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
<br>
On 8/13/26 12:09, Akhmed Zhitaev wrote:<br>
&gt; Custom brightness curves use an 8-bit input signal.=C2=A0 After export=
ing the<br>
&gt; full PWM range to userspace, the curve normalizer still divides reques=
ts<br>
&gt; by the physical PWM span.=C2=A0 On panels with a nonzero minimum PWM l=
evel,<br>
&gt; this can produce a curve input greater than 255 and send an invalid<br=
>
&gt; backlight level to DC.<br>
&gt; <br>
&gt; Scale the userspace [0..max] range to the curve&#39;s [0..255] range<b=
r>
&gt; instead.=C2=A0 This retains the full advertised range and keeps the re=
verse<br>
&gt; readback conversion unchanged.<br>
&gt; <br>
&gt; Fixes: 8dbd72cb7900 (&quot;drm/amd/display: Export full brightness ran=
ge to userspace&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Signed-off-by: Akhmed Zhitaev &lt;<a href=3D"mailto:zhitaevakh@gmail.c=
om" target=3D"_blank">zhitaevakh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++=
----<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 40d82a3ee..533c69f0b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct a=
mdgpu_dm_backlight_caps *caps,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */<br>
&gt; -static inline u32 scale_input_to_fw(int min, int max, u64 input)<br>
&gt; +/* Rescale userspace [0..max] to the firmware curve&#39;s [0..255]. *=
/<br>
&gt; +static inline u32 scale_input_to_fw(int max, u64 input)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_B=
L_LEVEL, max - min);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_B=
L_LEVEL, max);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */<=
br>
&gt; @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const stru=
ct amdgpu_dm_backlight_caps *cap<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =
min, unsigned int max,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *use=
r_brightness)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u32 brightness =3D scale_input_to_fw(min, max, *u=
ser_brightness);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 brightness =3D scale_input_to_fw(max, *user_b=
rightness);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 lower_signal, upper_signal, upper_lum, lo=
wer_lum, lum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int left, right;<br>
&gt;=C2=A0 =C2=A0<br>
<br>
Is this still needed with<br>
<br>
&quot;drm/amd/display: Fix backlight max_brightness to match exported range=
&quot;<br>
<br>
<a href=3D"https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac1=
26867ae488e1bf625" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae488e1bf625</a><br>
</blockquote></div>

--000000000000e874350658f1ba74--
