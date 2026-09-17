Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB4CC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E71010F1C3;
	Fri, 18 Sep 2026 07:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QrTMu2O1";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5343A10E501
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:56:24 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466ccde2b71so101390fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789678583; cv=none;
 d=google.com; s=arc-20260327;
 b=f9By6kfoAH/8pGi/QVgCZRsNdqeWlly3w1adsJvyOSwTI082Z/ppU4GI61PvgAJ7fJ
 B9nDq/RyFrANW0d4+tW3tdIe6CMUwALYtWaSnWa0Mtifbq06/+gKmnkgoMZjq7zfLO5P
 36XPNL8oRS/nFc/w70cHtQeXVEh/qcOVo3NJtmZ76GD4nnrI+t3wowffTNUJCdvGlhm1
 OFY9w6nTHJmiy2P+rz0oOQSLRTTE2R4PeTiWoLw0f1adySPfnf9ab0RyMw5uTw3mn5Nc
 7QCiuEv/PtvP321MEsC0OFdopwzZSfkxeoNqdZYOZBYa69g3bHEQd4HrxuXgMYymcW7e
 UvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bipV4xstn7KvY63lgDiB5ZykyIixgb82qyxme0sUG0w=;
 fh=bgBp/Umm65x/MAvZo2HEu5lCiXTWm0zBCB+tRd6dEKU=;
 b=d0Ut7cNRy/Ld3b3oMeUmrTxLqLxlGNYxEEQx75p2M9QQbygymnrdJ2EySljUJxkMd/
 BaySNgWqjOMtBZoEylaSW1IOkNDtntikHANnOBNYRZNVqRVypRUUaufywoxKCWjvtji0
 iuJ5z9bUofQCV11Tql7DDcVxmloMgofT6ixO4HzzrRb3ZcpumojZLEOeb7m2VicRAuTR
 FtvoUg517cFv2rSQZmcBi9DULzWi/dFdoL10jcqiToRssjlXu8UhjYKAAYTmO5BzGUId
 0K1HK5/VRVwAyIX/eKt9VtmQe5D5Rh/Gd6mry+3Cc4248FGrpTl5kMTKUo5QWVe3auuu
 p+cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789678583; x=1790283383; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bipV4xstn7KvY63lgDiB5ZykyIixgb82qyxme0sUG0w=;
 b=QrTMu2O1ow5KllXWF98+VBJAjlOLud40d6xrk57NDiQ3RFY5u27Ok9ytw6UedBH8iN
 IJwVnMYGtGPwHA3dlnd4CXcD95k6nMgApYRfPo4UHD3zDj+IaiwR8r8VCUcV8K6DrWYX
 LpaRHzeL/Whxg2+sAtLkVfRqbKhk9CZQ08BFypDzZrcK8Itg7boIhm7yLRgS+VKTMr5x
 CImGi6M6ICcj2WG+dUWaaOuCNT3ejc7JmwWSZ3itJRvF49ZU6ZtcvEF18Pqv1gaJRwGg
 51bKA5XeJlBY7k7dBkuVKv8qupto3O6kDHYsVxJTlSfd5UYp2J6Yu8+RVxjfNAC7Oxmx
 THQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789678583; x=1790283383;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bipV4xstn7KvY63lgDiB5ZykyIixgb82qyxme0sUG0w=;
 b=ctY1SoEH8qH6BDxZ3qOACJE/CarJFcP9H/vuHEGZPZwugmdftZM8KybXTag6BzZcgv
 h12uXcMDzcAa+74wdKm7pCE4cBFd+Em5nfw9M41Kpw9WQwyRiJT5LNsIjR3rvumMlf2I
 GG6Nd9ueNX5yyCGwrPU61Ui51gjs9ECag4V/GO1J3NlsQupMRJT+2rVzH2HV9rJWIzLH
 tNssH4nj0vUBoIi2WnHrxwLGVW6D2giFf91byv7+6IwLpLB9+7rwS9uwKQxmwtyHU3Dv
 /FjyBNHm4GB2N/9XnV5Kf0WaVeUMH4zOblppBnidyugA0rBBtpnTI6xS8mid/wGlMEw7
 GkxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwD71rPu/MSHSrWJj9xPoPR7aehtZgzJEVbWXgWsnnxXqKpooTJzvHfNABJ3UCroRTb1Aov5G2S7w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEf90KUeZdW58m1Q3URACAGtLVrnvPmqn/pU6411C+ChBI9bP7
 3tuiVEB+WNuenQAY9Wz01D23cOQM0vYCsrbU17+VpNXPMcO0Au5YI6ReCwtq1wUTB4RLzeDtt38
 6mB8SsqaoRfui+3xTMiX8YJSWtxR4le4=
X-Gm-Gg: AYBFou0oNhH/NlffegIfqi46yCFUic/KXoEkAxNpIFi/0APteYilnf9Xr4NSlSZ0Jd3
 CaNrjGn9k3JsUdYQnrPnPe34yHzAq/V1SGhlr/iGp31jkEKfGazNunPg/li4w/KTVwOUUHJXv1z
 DuDC5fkIem//iU6vs/FjXPOeqrBxDOg3VyLOXkxImhLTK5TA97i1IUjHCYJsiSS6L15TX0pHhIq
 uaNB2BHRh3KMG8GDyZqt8MMy4KAgbuMdqq3t2FcQGGT60zKdzM4Dl9PiNeuO58DO/GSG9yggcf3
 EPa03Zd68ayD+vWUBPvaHaO6C+kPSK4ctmX5c5krT6qCWwLssoIlhVAZ2+/Br913fdl2R8EuQel
 OaXF/n7NXSs0txzB4BXV7iy/CvssU9OGrIc5u
X-Received: by 2002:a05:6870:e304:b0:485:d1ab:7943 with SMTP id
 586e51a60fabf-486e7529c38mr275601fac.36.1789678583375; Thu, 17 Sep 2026
 13:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
 <4170733fbe8a738f925986f0a17d03c39b066c17.camel@redhat.com>
In-Reply-To: <4170733fbe8a738f925986f0a17d03c39b066c17.camel@redhat.com>
From: tanodzh <tano.dzhinski@gmail.com>
Date: Thu, 17 Sep 2026 23:56:07 +0300
X-Gm-Features: AcwNN1Vfo4dvM619sBhxteR11Pe9KDeQ_j2eDrdXEFWSeyiF4dG_J9_oKcsTxkc
Message-ID: <CAJhzm-_fwJTUa_Pt22cGek0ZQHxYOUyCWZvU0QdKdNKEHfrFGg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
To: lyude@redhat.com
Cc: Danilo Krummrich <dakr@kernel.org>, Ben Skeggs <bskeggs@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000396c1c065bb404a7"
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

--000000000000396c1c065bb404a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: [PATCH] drm/nouveau/disp: don't reject HDMI config on cards
without SCDC

Hi Lyude,

Happy to - that was my intent, and I'd rather the credit sit with
Giuseppe.

The reason I sent it under my own authorship is that the public
list archive I could reach redacts his email address, so I had no
way to set From: and Signed-off-by: correctly. If you can point me
at it, or CC him on this thread, I'll resend as:

  From: Giuseppe Ranieri <...>
  Signed-off-by: Giuseppe Ranieri <...>
  Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
  Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>

For what it's worth on the testing side: I hit this on a GK104
(GTX 670MX) against a BenQ PD2700U and an EW2790U, and the uoutp.c
hunk is what restores audio there. I'll add a Tested-by to the v2.

Thanks,
Tano

=D0=9D=D0=B0 =D1=87=D1=82, 17.09.2026=E2=80=AF=D0=B3. =D0=B2 19:28 <lyude@r=
edhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:

> Hi - apologies for missing the patch previously, and thank you for
> bringing this to my attention!
>
> Would you mind re-sending with the original authorship + a Co-authored-
> by tag for yourself to make sure we give the original author credit?
>
> On Thu, 2026-09-17 at 13:50 +0000, Tano Dzhinski wrote:
> > nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
> > straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is
> > no
> > hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> > configuration with -EINVAL, and nv50_hdmi_enable() returns before
> > hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
> >
> > The result on such a card driving an SCDC-capable HDMI 2.0 sink is
> > that
> > HDMI audio silently stops working. Video is unaffected, and nothing
> > is
> > logged, which makes the failure hard to attribute.
> >
> > SCDC is optional, and the hdmi->scdc() call further down is already
> > guarded against a missing callback. Requesting it on a card that
> > cannot
> > do it need not invalidate the rest of the HDMI configuration, so drop
> > that term from the condition and let the existing guard skip SCDC
> > alone.
> >
> > Giuseppe Ranieri posted a fix for this to the nouveau list on
> > 2026-01-17, which received no review:
> > https://ratatoskr.run/nouveau/2026/01/16963412
> >
> > Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config
> > method")
> > Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > index 377d0e0cef84..9887b3898505 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void
> > *argv, u32 argc)
> >
> >       if (!ior->func->hdmi ||
> >           args->v0.max_ac_packet > 0x1f ||
> > -         args->v0.rekey > 0x7f ||
> > -         (args->v0.scdc && !ior->func->hdmi->scdc))
> > +         args->v0.rekey > 0x7f)
> >               return -EINVAL;
> >
> >       if (!args->v0.enable) {
>
>

--000000000000396c1c065bb404a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Subject: Re: [PATCH] drm/nouveau/disp: don&#39;t reject HD=
MI config on cards without SCDC<br><br>Hi Lyude,<br><br>Happy to - that was=
 my intent, and I&#39;d rather the credit sit with<br>Giuseppe.<br><br>The =
reason I sent it under my own authorship is that the public<br>list archive=
 I could reach redacts his email address, so I had no<br>way to set From: a=
nd Signed-off-by: correctly. If you can point me<br>at it, or CC him on thi=
s thread, I&#39;ll resend as:<br><br>=C2=A0 From: Giuseppe Ranieri &lt;...&=
gt;<br>=C2=A0 Signed-off-by: Giuseppe Ranieri &lt;...&gt;<br>=C2=A0 Co-auth=
ored-by: Tano Dzhinski &lt;<a href=3D"mailto:tano.dzhinski@gmail.com">tano.=
dzhinski@gmail.com</a>&gt;<br>=C2=A0 Signed-off-by: Tano Dzhinski &lt;<a hr=
ef=3D"mailto:tano.dzhinski@gmail.com">tano.dzhinski@gmail.com</a>&gt;<br><b=
r>For what it&#39;s worth on the testing side: I hit this on a GK104<br>(GT=
X 670MX) against a BenQ PD2700U and an EW2790U, and the uoutp.c<br>hunk is =
what restores audio there. I&#39;ll add a Tested-by to the v2.<br><br>Thank=
s,<br>Tano</div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D0=9D=D0=B0 =D1=87=D1=82, 17.09.2026=E2=80=
=AF=D0=B3. =D0=B2 19:28 &lt;<a href=3D"mailto:lyude@redhat.com">lyude@redha=
t.com</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi - apologies for missing the patch pr=
eviously, and thank you for<br>
bringing this to my attention!<br>
<br>
Would you mind re-sending with the original authorship + a Co-authored-<br>
by tag for yourself to make sure we give the original author credit?<br>
<br>
On Thu, 2026-09-17 at 13:50 +0000, Tano Dzhinski wrote:<br>
&gt; nv50_hdmi_enable() passes the sink&#39;s SCDC capability from its EDID=
<br>
&gt; straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is<=
br>
&gt; no<br>
&gt; hdmi-&gt;scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole<br=
>
&gt; configuration with -EINVAL, and nv50_hdmi_enable() returns before<br>
&gt; hdmi-&gt;ctrl() runs and before the AVI and VSI infoframes are sent.<b=
r>
&gt; <br>
&gt; The result on such a card driving an SCDC-capable HDMI 2.0 sink is<br>
&gt; that<br>
&gt; HDMI audio silently stops working. Video is unaffected, and nothing<br=
>
&gt; is<br>
&gt; logged, which makes the failure hard to attribute.<br>
&gt; <br>
&gt; SCDC is optional, and the hdmi-&gt;scdc() call further down is already=
<br>
&gt; guarded against a missing callback. Requesting it on a card that<br>
&gt; cannot<br>
&gt; do it need not invalidate the rest of the HDMI configuration, so drop<=
br>
&gt; that term from the condition and let the existing guard skip SCDC<br>
&gt; alone.<br>
&gt; <br>
&gt; Giuseppe Ranieri posted a fix for this to the nouveau list on<br>
&gt; 2026-01-17, which received no review:<br>
&gt; <a href=3D"https://ratatoskr.run/nouveau/2026/01/16963412" rel=3D"nore=
ferrer" target=3D"_blank">https://ratatoskr.run/nouveau/2026/01/16963412</a=
><br>
&gt; <br>
&gt; Fixes: 6c6abab20b99 (&quot;drm/nouveau/disp: add output hdmi config<br=
>
&gt; method&quot;)<br>
&gt; Signed-off-by: Tano Dzhinski &lt;<a href=3D"mailto:tano.dzhinski@gmail=
.com" target=3D"_blank">tano.dzhinski@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--<br>
&gt; =C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>
&gt; b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>
&gt; index 377d0e0cef84..9887b3898505 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>
&gt; +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>
&gt; @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void<=
br>
&gt; *argv, u32 argc)<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!ior-&gt;func-&gt;hdmi ||<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args-&gt;v0.max_ac_packet=
 &gt; 0x1f ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args-&gt;v0.rekey &gt; 0x7f ||=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (args-&gt;v0.scdc &amp;&amp; !=
ior-&gt;func-&gt;hdmi-&gt;scdc))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args-&gt;v0.rekey &gt; 0x7f)<b=
r>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!args-&gt;v0.enable) {<br>
<br>
</blockquote></div>

--000000000000396c1c065bb404a7--
