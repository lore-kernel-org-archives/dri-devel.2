Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257BBC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677AB10E74B;
	Thu, 17 Sep 2026 21:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XWxyucMS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C5410E74B
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789679152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oBv2rkX57Nn855JMqaWKszQ94o53D3ytZe/vFNcYBko=;
 b=XWxyucMSAnRJ19czdrMP0pchnvAgEqBKM4mD2UnVeBJwIp4ZFlgT8fm9vRIVUv2X6A8rBu
 6ivyv5/qCHMBw6eAiM5MXRLtmC5GVyKEdY4aa5OMxKyV89ueMLJxfsVNTiQ/QHP3o6n6zO
 pNpp6EIAo2HCLrB0g+Ha32z+A7G4uSA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-_KPYbQINML2ap9U8mJg_Sg-1; Thu, 17 Sep 2026 17:05:51 -0400
X-MC-Unique: _KPYbQINML2ap9U8mJg_Sg-1
X-Mimecast-MFC-AGG-ID: _KPYbQINML2ap9U8mJg_Sg_1789679151
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ffe24490bso517601cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679151; x=1790283951;
 h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
 :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oBv2rkX57Nn855JMqaWKszQ94o53D3ytZe/vFNcYBko=;
 b=tZaJeku9idU1yZcI7/H2SljhQUtgHS76eL2378gfw/edWeBIE2+mXXP8sKRGu0bueP
 +QE0xYyliWVl91+qsZSNOE+x71D3MBHt8f9HTimA3DmfqvtPMP4k41TJINR8wvmB/yA8
 WwPQ96GZpzy+pOK7GFAeQ4mY5L+JOMsNnhLgGrgn4RBfi5froNP6VUOrYVaXIkgT42TI
 riaFj+1oYLXgMqe0Rxktp9UhDHyRoLH58aiuDCjOnlsIh+J25HaCJrJhlcI2aYp8Fj5I
 PSNQ3Z6qEJ1P+kuOxVT4wcBYhuWoLcQDQ6yrZ26jm39L5mAOeCrPuvdLBKi2ie6TeB1s
 3RYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXAnIVMrzeAAyt13T96ZuA4/fauBNG9B+Jq5c1LuDpmMkc/P71A2cBiUv+pbGv8aGeqD6gf6NIUcg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mY3dHEIn7fXLIujkiB+DLVstfZkp4VWO9ndF1URrl592EEG7RS
 EBQ68YJ6pCr2aWKO8ffIlls1R7Mz3JZsmTlIksZOYimnuo+6V9K1HZBSnZABNpWNhYx+JhlFg4e
 Ghh4tFr28m93x2ZiGtX16mfBHQhcdabVLaDPAyhNzEG17DP8l/OfwU3E+Dt2CSvvu+oP8rA==
X-Gm-Gg: AYBFou3l6mfJTh+/9h3nyffwKd3xFNiUNpQRlLxCqmn8qtBIYwDBt8h6j/tMiXo88n7
 nAMnsh8Qpvn2kG11FW2QA175fwi3Dgrf98k5D41A6Oo0vBHcneHSP/GIAmvoSYo65oa+CL5O2Ke
 GdNvIyb1S0oehkq8N/ngmfDHcf+lsz/PBYJYdj2EbKwOYVSzfKu6UChYTq2ncZYhOm4GIYqedE6
 Eqj6TeP8FTOKkrF+KV9OGkJUz6vT+7aiFsrQUBx2hd5MlVnuoh5hLQJ+rMJLAnZwpNtYp2B7DNP
 nLH083xyRfMe93bBiVOyGb8bv0bbvDJjv851WJmLqk/Pe/8HX6mxdaI/ZemZXDQJhFAjyUR/
X-Received: by 2002:a05:622a:410d:b0:532:9add:cde2 with SMTP id
 d75a77b69052e-5329e3fddc8mr8848931cf.71.1789679150752; 
 Thu, 17 Sep 2026 14:05:50 -0700 (PDT)
X-Received: by 2002:a05:622a:410d:b0:532:9add:cde2 with SMTP id
 d75a77b69052e-5329e3fddc8mr8848211cf.71.1789679150024; 
 Thu, 17 Sep 2026 14:05:50 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53262008855sm57660831cf.11.2026.09.17.14.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:05:49 -0700 (PDT)
Message-ID: <758da7db4ac3b1b36608e29f5bee752f38b37a65.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
From: lyude@redhat.com
To: tanodzh <tano.dzhinski@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Ben Skeggs <bskeggs@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 17:05:48 -0400
In-Reply-To: <CAJhzm-_fwJTUa_Pt22cGek0ZQHxYOUyCWZvU0QdKdNKEHfrFGg@mail.gmail.com>
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
 <4170733fbe8a738f925986f0a17d03c39b066c17.camel@redhat.com>
 <CAJhzm-_fwJTUa_Pt22cGek0ZQHxYOUyCWZvU0QdKdNKEHfrFGg@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qleAu2DIya_9Nl34jXtPpoMlCCCOBknYRRjusPVOKGQ_1789679151
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="=-Y+33hzVw9jWkmO67eF+b"
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

--=-Y+33hzVw9jWkmO67eF+b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

JFYI - Be careful when sending HTML emails, I think the kernel list
rejects them so it's usually better to send plain-text.

Anyway - I think it's fine to unanonymize the email IMO? He's posted
the patch once, which means I'm pretty sure his email is already out
there (unless it's somehow hidden from public list archives already?)

On Thu, 2026-09-17 at 23:56 +0300, tanodzh wrote:
> Subject: Re: [PATCH] drm/nouveau/disp: don't reject HDMI config on
> cards without SCDC
>=20
> Hi Lyude,
>=20
> Happy to - that was my intent, and I'd rather the credit sit with
> Giuseppe.
>=20
> The reason I sent it under my own authorship is that the public
> list archive I could reach redacts his email address, so I had no
> way to set From: and Signed-off-by: correctly. If you can point me
> at it, or CC him on this thread, I'll resend as:
>=20
> =C2=A0 From: Giuseppe Ranieri <...>
> =C2=A0 Signed-off-by: Giuseppe Ranieri <...>
> =C2=A0 Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> =C2=A0 Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
>=20
> For what it's worth on the testing side: I hit this on a GK104
> (GTX 670MX) against a BenQ PD2700U and an EW2790U, and the uoutp.c
> hunk is what restores audio there. I'll add a Tested-by to the v2.
>=20
> Thanks,
> Tano
>=20
> =D0=9D=D0=B0 =D1=87=D1=82, 17.09.2026=E2=80=AF=D0=B3. =D0=B2 19:28 <lyude=
@redhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
> > Hi - apologies for missing the patch previously, and thank you for
> > bringing this to my attention!
> >=20
> > Would you mind re-sending with the original authorship + a Co-
> > authored-
> > by tag for yourself to make sure we give the original author
> > credit?
> >=20
> > On Thu, 2026-09-17 at 13:50 +0000, Tano Dzhinski wrote:
> > > nv50_hdmi_enable() passes the sink's SCDC capability from its
> > EDID
> > > straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards
> > there is
> > > no
> > > hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> > > configuration with -EINVAL, and nv50_hdmi_enable() returns before
> > > hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
> > >=20
> > > The result on such a card driving an SCDC-capable HDMI 2.0 sink
> > is
> > > that
> > > HDMI audio silently stops working. Video is unaffected, and
> > nothing
> > > is
> > > logged, which makes the failure hard to attribute.
> > >=20
> > > SCDC is optional, and the hdmi->scdc() call further down is
> > already
> > > guarded against a missing callback. Requesting it on a card that
> > > cannot
> > > do it need not invalidate the rest of the HDMI configuration, so
> > drop
> > > that term from the condition and let the existing guard skip SCDC
> > > alone.
> > >=20
> > > Giuseppe Ranieri posted a fix for this to the nouveau list on
> > > 2026-01-17, which received no review:
> > > https://ratatoskr.run/nouveau/2026/01/16963412
> > >=20
> > > Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config
> > > method")
> > > Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
> > > =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > > index 377d0e0cef84..9887b3898505 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > > @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp,
> > void
> > > *argv, u32 argc)
> > > =C2=A0
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0if (!ior->func->hdmi ||
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args->v0.max_ac_packet >=
 0x1f ||
> > > -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f ||
> > > -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (args->v0.scdc && !ior->func-=
>hdmi->scdc))
> > > +=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f)
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> > > =C2=A0
> > > =C2=A0=C2=A0 =C2=A0 =C2=A0if (!args->v0.enable) {
> >=20

--=-Y+33hzVw9jWkmO67eF+b
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>JFYI - Be careful when sending HTML emails, I thi=
nk the kernel list rejects them so it's usually better to send plain-text.<=
/div><div><br></div><div>Anyway - I think it's fine to unanonymize the emai=
l IMO? He's posted the patch once, which means I'm pretty sure his email is=
 already out there (unless it's somehow hidden from public list archives al=
ready?)</div><div><br></div><div>On Thu, 2026-09-17 at 23:56 +0300, tanodzh=
 wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-l=
eft:2px #729fcf solid;padding-left:1ex"><div dir=3D"ltr">Subject: Re: [PATC=
H] drm/nouveau/disp: don't reject HDMI config on cards without SCDC<br><br>=
Hi Lyude,<br><br>Happy to - that was my intent, and I'd rather the credit s=
it with<br>Giuseppe.<br><br>The reason I sent it under my own authorship is=
 that the public<br>list archive I could reach redacts his email address, s=
o I had no<br>way to set From: and Signed-off-by: correctly. If you can poi=
nt me<br>at it, or CC him on this thread, I'll resend as:<br><br>&nbsp; Fro=
m: Giuseppe Ranieri &lt;...&gt;<br>&nbsp; Signed-off-by: Giuseppe Ranieri &=
lt;...&gt;<br>&nbsp; Co-authored-by: Tano Dzhinski &lt;<a href=3D"mailto:ta=
no.dzhinski@gmail.com">tano.dzhinski@gmail.com</a>&gt;<br>&nbsp; Signed-off=
-by: Tano Dzhinski &lt;<a href=3D"mailto:tano.dzhinski@gmail.com">tano.dzhi=
nski@gmail.com</a>&gt;<br><br>For what it's worth on the testing side: I hi=
t this on a GK104<br>(GTX 670MX) against a BenQ PD2700U and an EW2790U, and=
 the uoutp.c<br>hunk is what restores audio there. I'll add a Tested-by to =
the v2.<br><br>Thanks,<br>Tano</div><div><br></div><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=9D=D0=B0=
 =D1=87=D1=82, 17.09.2026=E2=80=AF=D0=B3. =D0=B2 19:28 &lt;<a href=3D"mailt=
o:lyude@redhat.com">lyude@redhat.com</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0:<br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bord=
er-left:2px #729fcf solid;padding-left:1ex"><div>Hi - apologies for missing=
 the patch previously, and thank you for<br>bringing this to my attention!<=
br></div><div><br>Would you mind re-sending with the original authorship + =
a Co-authored-<br>by tag for yourself to make sure we give the original aut=
hor credit?<br></div><div><br>On Thu, 2026-09-17 at 13:50 +0000, Tano Dzhin=
ski wrote:<br>&gt; nv50_hdmi_enable() passes the sink's SCDC capability fro=
m its EDID<br>&gt; straight through to nvif_outp_hdmi(). On pre-Maxwell-2 c=
ards there is<br>&gt; no<br>&gt; hdmi-&gt;scdc callback, so nvkm_uoutp_mthd=
_hdmi() rejects the whole<br>&gt; configuration with -EINVAL, and nv50_hdmi=
_enable() returns before<br>&gt; hdmi-&gt;ctrl() runs and before the AVI an=
d VSI infoframes are sent.<br>&gt; <br>&gt; The result on such a card drivi=
ng an SCDC-capable HDMI 2.0 sink is<br>&gt; that<br>&gt; HDMI audio silentl=
y stops working. Video is unaffected, and nothing<br>&gt; is<br>&gt; logged=
, which makes the failure hard to attribute.<br>&gt; <br>&gt; SCDC is optio=
nal, and the hdmi-&gt;scdc() call further down is already<br>&gt; guarded a=
gainst a missing callback. Requesting it on a card that<br>&gt; cannot<br>&=
gt; do it need not invalidate the rest of the HDMI configuration, so drop<b=
r>&gt; that term from the condition and let the existing guard skip SCDC<br=
>&gt; alone.<br>&gt; <br>&gt; Giuseppe Ranieri posted a fix for this to the=
 nouveau list on<br>&gt; 2026-01-17, which received no review:<br>&gt; <a h=
ref=3D"https://ratatoskr.run/nouveau/2026/01/16963412" rel=3D"noreferrer" t=
arget=3D"_blank">https://ratatoskr.run/nouveau/2026/01/16963412</a><br>&gt;=
 <br>&gt; Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config<br=
>&gt; method")<br>&gt; Signed-off-by: Tano Dzhinski &lt;<a href=3D"mailto:t=
ano.dzhinski@gmail.com" target=3D"_blank">tano.dzhinski@gmail.com</a>&gt;<b=
r>&gt; ---<br>&gt; &nbsp;drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c |=
 3 +--<br>&gt; &nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>&gt;=
 <br>&gt; diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>=
&gt; b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c<br>&gt; index 377d0=
e0cef84..9887b3898505 100644<br>&gt; --- a/drivers/gpu/drm/nouveau/nvkm/eng=
ine/disp/uoutp.c<br>&gt; +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uou=
tp.c<br>&gt; @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *out=
p, void<br>&gt; *argv, u32 argc)<br>&gt; &nbsp;<br>&gt; &nbsp;&nbsp; &nbsp;=
 &nbsp;if (!ior-&gt;func-&gt;hdmi ||<br>&gt; &nbsp;&nbsp; &nbsp; &nbsp;&nbs=
p;&nbsp;&nbsp; args-&gt;v0.max_ac_packet &gt; 0x1f ||<br>&gt; -&nbsp; &nbsp=
; &nbsp;&nbsp;&nbsp;&nbsp; args-&gt;v0.rekey &gt; 0x7f ||<br>&gt; -&nbsp; &=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (args-&gt;v0.scdc &amp;&amp; !ior-&gt;func-&=
gt;hdmi-&gt;scdc))<br>&gt; +&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; args-&gt=
;v0.rekey &gt; 0x7f)<br>&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;return -EINVAL;<br>&gt; &nbsp;<br>&gt; &nbsp;&nbsp; &nbsp; &nbsp;if=
 (!args-&gt;v0.enable) {<br></div><div><br></div></blockquote></div></block=
quote><div><br></div><div><span></span></div></body></html>

--=-Y+33hzVw9jWkmO67eF+b--

