Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE6CCDB466
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 08:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BBC10E1B0;
	Sat, 20 Jun 2026 08:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LEsnoo5i";
	dkim-atps=neutral
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713A310E17D
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 05:39:38 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-966db0b76daso2321554241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 22:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781933977; cv=none;
 d=google.com; s=arc-20240605;
 b=Z2P7LcrgB1rCN8nk0y8GqU2bP7t7WE7OUGHG6VbN+fj15WPUpxSlNkB1iq23zWLcoF
 htU/74n9DtIoWz5VBRasygFjKDtXFQpI27RYZbPYGJ4zbooobmrhKB5f//b/Wk1x3WXU
 LHcz69k+vIBkMe0vrHHTVGc1dqTrx2zfHi/X4PRpfarvlV9yfoe1Y8TXseFkMLLFSDF6
 Gshuk6yN0le7CN9IWx55aQCmRefcUdAr1UPN8v38YqWKSll6j1BLUNThqm9tuIqgBs55
 z821nbidxaRJyCyKmYBq9+HDgwwSkYEPNsxaxtPNEDmqCePgoxdYL1ZUkVa+Wdo/xLJM
 s1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4APW9WchUIjck1WXvCdDznMYknRjl/S7x9r5ba9yacU=;
 fh=rP2QHgMlCRqJOP4ak2yYQDM/BpXf5PblJcnBt2DQ4hY=;
 b=jIp0Wy1+DlN28CuugYSJIQQA+kl1hGdJ3wrqzryfgHCj4zUWAXPso+eNXG1F8mP9eX
 Ui4AUk8nolPzH/cRU7SMOTd8+Q9By6ehfR03A+pgbGekBpU/TS5yvRxZg/m6Rwj2+yfr
 rSNTWlYbx/SgoQXTMNX7sSq1razgz8Br9lPXP7zrlPGQARvVJkvdKrjvDRmUBRG98Hjo
 hhz9UZE/MAjzBPfDri6e4YteuEySy/ZZ+rDjWBwh9qhDMhCJkb3bsN4kZ95ucX1mhlJK
 bFLYVIZ31SrgzOy8gfH10kaMjy+SOTmnaBZwqQ26+shAHw1gxFJTRYXAOuGwu1lkUOqx
 9LMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781933977; x=1782538777; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4APW9WchUIjck1WXvCdDznMYknRjl/S7x9r5ba9yacU=;
 b=LEsnoo5iFdh0kWyHKf7HU8CksVATCuYRj8YVVT9Pwq/LjKesWtopKRlZvG9Hy8+fq0
 sAVYWeCDFcrI1QB3Pnd4gbnDgCG7+sSOa6hTxy1LbTpFQZ+ss9vYFnAqwk3bfyn0vkjf
 ot7/H9I+btuLGF4hBjkSWsdW2OGsJ3CVjKOcGf5/bOWOjkR2uvu62WdmVacj2nQczwxZ
 g72jYE3+UhmSnlfLuMjBdEuFr2q7tr4Nn6lpzHO30/aiPRkzJ0HsCna6Krt1BMWh37xc
 m6ucH9uPm0WTrAlps/6mXLsCvpSuxKZbQ74FZC8rWk9cmOcWrA4R5wz2JciAsouQ/ZLM
 Uqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781933977; x=1782538777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4APW9WchUIjck1WXvCdDznMYknRjl/S7x9r5ba9yacU=;
 b=EktoR8l6KFh0HnP2o1gkT0wvMsNw81MKbYGFMHkbMDp8vRZq0+jAbq/rMh5IGGEs58
 IQ1xW/KYzaq+VTW4pgBBmfnDVtcioCA+if3M0i0zGUcGNigTr0JzmL/U7vZWPrsbAYlr
 rfo6K94rdgTglK/THJbaSK5xC1I8ADj1wClRqR/XQD4HhuxMesoxj0aLX/4r3i8KZuPO
 oH48oT+XioqOID8wW0i+nYeGpK8yQWW4nrfDJX2kkooHOp2e9Jm/3FAqTcINKUMQ1nLm
 NclSNmB422mSCM0s2x6SCzN5sh9Ksg96+Nihu89ab5vdYbSb3Yl7g5dzOFxnWTJ0Fim8
 TQ/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X5YizMtnWxbrFfIbY24tuH85i2Hny9aUxjfg5rr941AjQ9oJZSxZ9ixUiqg6i5oJyLoQwd2YHAvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWAKqOUn0RO/fLSMPt2bpdi3253VTOWJTv6l1Gu8wdErYSRBOJ
 kzDuJd/oghv40dvOrYL48go/IH0ypLFYpWiM1IrVs9sd7l+lHzscO1iytXNeBxyP4/aUEevLbRi
 GEowrh3nKA+gVsUOhe7DevZA1uwWReaE=
X-Gm-Gg: AfdE7cn8/eAlVHoLIeR6Wo1/2DmqdalqhjojRlZ/tioPoIFzl8U6O7WUAJ6M7oCCM7Y
 t025W9psH9gjrfIIgXXKiOkZJSiVJOV2WsEfWT05Xe98q1ODQc/1JYvk+74pAGQ0W25tgmhhf9L
 Y2RPV2WpyJ/MW7YevRunvOwuq/ujz4ye5ZyVeUrxokqf1UID0dK6L5NK102EzbwvOjyyL6c5iJU
 pS2IBu/D3bDVNHJJDFIw+bWg+krWy2+mS5zZzCRMhFk2hxZxAum9X9ySULKWP1OTjnKH3tEBL83
X-Received: by 2002:a05:6102:17c5:b0:6cd:23a8:3a31 with SMTP id
 ada2fe7eead31-72a26e045f4mr1781055137.1.1781933977271; Fri, 19 Jun 2026
 22:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260617193335.1662613-1-ruoyuw560@gmail.com>
 <cee10e27-1bf9-47de-9d72-4f2c7ac606ef@amd.com>
 <PH7PR12MB8796700AA79490AF65E12D64B0E32@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796700AA79490AF65E12D64B0E32@PH7PR12MB8796.namprd12.prod.outlook.com>
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Sat, 20 Jun 2026 13:39:23 +0800
X-Gm-Features: AVVi8CfYD_GAaQEP05j_5Lp7OoC_f0RZTesbVzNHdBDTKSPBat01vDG37k3SiEs
Message-ID: <CAK_7xqxJMr+CgjKDbsWUGsbPt3U_xA_rE_CH__F7bmPW5AxJ0A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ba82dc0654a8d5dd"
X-Mailman-Approved-At: Sat, 20 Jun 2026 08:50:30 +0000
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

--000000000000ba82dc0654a8d5dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tao,

Thanks for taking a look.

I will initialize ret to -EINVAL in v3 to keep the behavior
aligned with the original logic.

Thanks Christian for the Ack as well.

Thanks,
Ruoyu Wang

On Thu, Jun 18, 2026 at 7:02=E2=80=AFPM Zhou1, Tao <Tao.Zhou1@amd.com> wrot=
e:

> AMD General
>
> [Tao] In order to align with the original logic, I prefer to "ret =3D
> -EINVAL"
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Christian
> > K=C3=B6nig
> > Sent: Thursday, June 18, 2026 3:37 PM
> > To: Ruoyu Wang <ruoyuw560@gmail.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; David Airlie <airlied@gmail.com>; Simona
> Vetter
> > <simona@ffwll.ch>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Lazar,
> > Lijo <Lijo.Lazar@amd.com>
> > Subject: Re: [PATCH v2] drm/amdgpu: initialize ret before UMC error
> record loop
> >
> > On 6/17/26 21:33, Ruoyu Wang wrote:
> > > umc_v12_0_fill_error_record() returns ret after walking the pages
> > > reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
> > > return zero entries, leaving the loop skipped and ret uninitialized.
> > >
> > > Set ret to 0 immediately before the loop so the zero-page path report=
s
> > > a deterministic status instead of returning stack data.
> > >
> > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Someone more familiar with ras should take a look as well, could be tha=
t
> returning -
> > ENOENT is more appropriate here.
> >
> > > ---
> > > v2:
> > > - Set ret immediately before the loop instead of initializing it in t=
he
> > >   declaration, as suggested by Christian.
> > > - Avoid describing the zero-entry case as an allocation-failure fix.
> > >
> > >  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > > index 14092150336a5..4842340d9d65f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > > @@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct
> > amdgpu_device *adev,
> > >         count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
> > >                                 ecc_err->pa_pfn <<
> AMDGPU_GPU_PAGE_SHIFT,
> > >                                 page_pfn, ARRAY_SIZE(page_pfn));
> > > +       ret =3D 0;
> > >
> > >         for (i =3D 0; i < count; i++) {
> > >                 ret =3D amdgpu_umc_fill_error_record(err_data,
> > > --
> > > 2.51.0
>
>

--000000000000ba82dc0654a8d5dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Hi Tao,</p><p class=3D"gm=
ail-isSelectedEnd">Thanks for taking a look.</p><p class=3D"gmail-isSelecte=
dEnd">I will initialize ret to -EINVAL in v3 to keep the behavior<br>aligne=
d with the original logic.</p><p class=3D"gmail-isSelectedEnd">Thanks Chris=
tian for the Ack as well.</p><p>Thanks,<br>Ruoyu Wang</p></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Jun 18, 2026 at 7:02=E2=80=AFPM Zhou1, Tao &lt;<a href=3D"mailt=
o:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">AMD General<br>
<br>
[Tao] In order to align with the original logic, I prefer to &quot;ret =3D =
-EINVAL&quot;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org" target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Beh=
alf Of Christian<br>
&gt; K=C3=B6nig<br>
&gt; Sent: Thursday, June 18, 2026 3:37 PM<br>
&gt; To: Ruoyu Wang &lt;<a href=3D"mailto:ruoyuw560@gmail.com" target=3D"_b=
lank">ruoyuw560@gmail.com</a>&gt;; Deucher, Alexander<br>
&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank">Ale=
xander.Deucher@amd.com</a>&gt;; David Airlie &lt;<a href=3D"mailto:airlied@=
gmail.com" target=3D"_blank">airlied@gmail.com</a>&gt;; Simona Vetter<br>
&gt; &lt;<a href=3D"mailto:simona@ffwll.ch" target=3D"_blank">simona@ffwll.=
ch</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_bla=
nk">amd-gfx@lists.freedesktop.org</a>; <a href=3D"mailto:dri-devel@lists.fr=
eedesktop.org" target=3D"_blank">dri-devel@lists.freedesktop.org</a>;<br>
&gt; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">linu=
x-kernel@vger.kernel.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang@amd.com" target=3D"_blank">Hawking.Zhang@amd.com</a>&gt;; Lazar,<br>
&gt; Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"_blank">Lijo.=
Lazar@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH v2] drm/amdgpu: initialize ret before UMC error re=
cord loop<br>
&gt;<br>
&gt; On 6/17/26 21:33, Ruoyu Wang wrote:<br>
&gt; &gt; umc_v12_0_fill_error_record() returns ret after walking the pages=
<br>
&gt; &gt; reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper c=
an<br>
&gt; &gt; return zero entries, leaving the loop skipped and ret uninitializ=
ed.<br>
&gt; &gt;<br>
&gt; &gt; Set ret to 0 immediately before the loop so the zero-page path re=
ports<br>
&gt; &gt; a deterministic status instead of returning stack data.<br>
&gt; &gt;<br>
&gt; &gt; Suggested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christia=
n.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Ruoyu Wang &lt;<a href=3D"mailto:ruoyuw560@gmail.c=
om" target=3D"_blank">ruoyuw560@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Acked-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt;<br>
&gt; Someone more familiar with ras should take a look as well, could be th=
at returning -<br>
&gt; ENOENT is more appropriate here.<br>
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; v2:<br>
&gt; &gt; - Set ret immediately before the loop instead of initializing it =
in the<br>
&gt; &gt;=C2=A0 =C2=A0declaration, as suggested by Christian.<br>
&gt; &gt; - Avoid describing the zero-entry case as an allocation-failure f=
ix.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
&gt; &gt; index 14092150336a5..4842340d9d65f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
&gt; &gt; @@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct=
<br>
&gt; amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D amdgpu_umc_lookup_bad_=
pages_in_a_row(adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecc_err-&gt;pa_pfn &lt;=
&lt; AMDGPU_GPU_PAGE_SHIFT,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_pfn, ARRAY_SIZE(pa=
ge_pfn));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; i++)=
 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D amdgpu_umc_fill_error_record(err_data,<br>
&gt; &gt; --<br>
&gt; &gt; 2.51.0<br>
<br>
</blockquote></div>

--000000000000ba82dc0654a8d5dd--
