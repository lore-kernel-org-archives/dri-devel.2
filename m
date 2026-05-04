Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86DFF886F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 12:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B37F10E0BA;
	Mon,  4 May 2026 12:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aX+bDHR1";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69FC10E0BA
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 12:52:40 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so5085980a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 05:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899159; cv=none;
 d=google.com; s=arc-20240605;
 b=igDwF2lfyo3eDIKh8uIb0X+jtBNaAyQVnsnkMj8hOp9+CeAI2djpLUSVpiIAvImHRr
 ZCSWR2cALJShD375MnvPftlIbkOqpkmfplk3yn02eku1Sqs7UDyqoFVqWB1TehIrv+lu
 71M5v8ys30r0Tzwz0Ut1f7f6mBSfp+tS4hZ88GE6rYZZPY5DzGIBV9xNvic/KREpNvEG
 O2hhZ3YHEEjMse2GHrvFk4HdXNwKV0gN6L352lCFWXCr/jsZ5tet8jNdLVxk9qJFAkQS
 NUUQm8PW1F6fqVPJ/HAJWl0WOd57gqlgOvLYfrB5lBnfb15b+uc687v7JiweopfNLnOG
 IVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yWqeoteWdLUGjey8Xgq+57FvWn73nKu9DuqNXFR6k7U=;
 fh=IWYKfIT78A7YF1GwTElUTJzdFelEAYxJyhInv8+jQhk=;
 b=At+vMKdq63c0VxL3DlEcba7QiaP8yPmMVRAq3OIpqEnJe4sy4MjqAjExY741boBux5
 6ilAA7WChNmp1cPvwuYEvLGi+rUXK3J6v3onhYvO3wAnHXOsdrpPRR/pFr62Y1lZkmOb
 aqEckmDiLMpe7gpL/DWmGWW+JkzdGhTJ2NapEqj2gPkaMmJ5yD8xoeVqpeItY168PkcJ
 FlwCp9b7xloa99d0dyMzfLW1r2vtMBioXW7wSkzq8IJdbKL357dP29hS3R/zumucEldh
 fPD2c0iVLjgFaiuIrzW0QzW7Xun3RLBTxi4OJQ4gqawUbiNLAiRgRUEGdEynaB4kSy+i
 r4Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777899159; x=1778503959; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWqeoteWdLUGjey8Xgq+57FvWn73nKu9DuqNXFR6k7U=;
 b=aX+bDHR1O46D2SY7iyivcciBrPdsUIXw3hr3yrqsPJ4B1Ab49Tc/pZEQRGRtd1INxx
 5PEsnzZswNMsjAkCNz4EITTe5Qbbnn+WtDfmwscqrtLI0AhfHqf7+MMdhK/agfkiAiTo
 OPS9WFiCpiPBWAdimkLpuXr0RocPa73vd6MBt5ltw5FXHK1KFgPlV28bUlDBTEl7tLvW
 +Cfcz4a9Tmy8XksivSJMBlDij/HChwsjmc9kHdpUhRRRRYugVilLdRUCwxB+8VWNXexy
 28pjoVxg4OSgNLnG1GSYEzSB7G6bdOTvl4/orcDSuOUaUEP7Opb5NRQPpg5I+vBCGymh
 a8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899159; x=1778503959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWqeoteWdLUGjey8Xgq+57FvWn73nKu9DuqNXFR6k7U=;
 b=F+MHyjW8Dug76LNLGY2Ec7RsxRPf9eUe2/XeHFCY96ZpS+BvOXuRhlogPGnJ7zuXDB
 25HGuYQyCucfmcG8UU3Hsk6za/mk1IgoMui+bQ8+si74Vh8pnwUwViSbQN3u5XSSC31N
 fx1zl8afcyxGBTqWUlCnL3V9jj8/rD4luI+r7yporCVGV3wP7otak5IjUOgdDu2vhQ9u
 JYLZc88cBYsM+WOguCyIvKf9lLgfPdhTZdg8EnMyN/emOWfIvEUg8rtzbOzoYRw+szoL
 R+Wphb+L2Pwex1C5W+ek7XC7/o9oc68OkhDn03pnWpVtH5EzdSXJkUhN2UwdnSQjHRJq
 1sBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XzBlG5vP8ESqzil7sEr/X/i/TNOyBxOSmokw05PvpInrdetIOfDPKS7MsP99Pf/CcWb7IER7MH30=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHcZc+iwuhGqCO7VA7++s5q/PxZ+e6rk636z95/FwIqf/Jbq76
 UY1Fow9dVQxibapOSwZlzt2zAfmqD/LZlTHR4ZkmyP0k7SgTGjPTy1mgvKG81QWETPtRJ7Clnih
 Rn7eBUh+cBrkzgEnrfdQFUSGQU2paFw==
X-Gm-Gg: AeBDieufjy1xr88FTh2ZdLL8JNgJ+HvXA+LUbfVwwws7mHMtfaHWs8JlLbuSSt6t+M5
 8b6j5WNlJKgBDM9XyHiZLHAb9n067c3qC75UZBbLs6eD0Ovrgk5ZdBxOeprkCKBXaEPaL21wrdy
 ezajpOO0XvNmk4+PL4N08pQsO9OJoIFqew2KoGddBDiKZ3674+yI32dgk1umqbpAq26rA+l5qo5
 0wADkil28xJmohChpUkt0H701qL4rBvpTXTX9lOen7A3TZBmks+rVb4YHArKKlrzTydkyyFfgyL
 pP+w26lEEZJkLLPBAeCh8/wVUHdqr0jrZUtRU92YpXlyFcE=
X-Received: by 2002:a05:6402:28cc:b0:678:b2c5:6915 with SMTP id
 4fb4d7f45d1cf-67c1aab3a37mr3884545a12.22.1777899159025; Mon, 04 May 2026
 05:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260424123506.32275-1-mhun512@gmail.com>
 <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
 <CAGEsz8FrkbQEWZbxV3Q0NkSxhQka575uemKMQtTJQaCm44ByxQ@mail.gmail.com>
 <5ca1cea2-9761-46ff-a575-53af23e79b36@suse.de>
 <CAGEsz8F54LaiJYGD6i-nW7hDiLTu6FOi4Z8fzb8b4=+9-OEH+Q@mail.gmail.com>
 <42cab775-8673-477a-837a-908bd0273e95@suse.de>
In-Reply-To: <42cab775-8673-477a-837a-908bd0273e95@suse.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 4 May 2026 21:52:26 +0900
X-Gm-Features: AVHnY4Knrx4dwicX36IBaRoEhcGx1MDE-k3YzzP6m2_XE6ier4HIf9ei_3pEETk
Message-ID: <CAGEsz8F7ka0WYF_5Tb7eNKQ194VEooM7ReCZy3e1qC-Aq_gBrg@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Drop manual put on probe error path
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 virtualization@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000d1ff8b0650fd6705"
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

--000000000000d1ff8b0650fd6705
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

You are right. I got confused and sent the wrong reply. Sorry for the noise=
.

Thanks,
Myeonghun

2026=EB=85=84 5=EC=9B=94 4=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:36, Th=
omas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi
>
> Am 30.04.26 um 15:52 schrieb Myeonghun Pak:
> > Thanks for the explanation.
> >
> > I see your point now. My patch treated uart_add_one_port() failure as
> > a fatal
> > probe failure, but the current code is intentionally trying to keep
> > the driver
> > alive so that other MAX3100 ports can still be available even if one
> > port cannot
> > be instantiated.
> >
> > Please drop this patch. I will not pursue this direction.
>
> Why? The was patch was good AFAICT. It's just missing a Fixes tag.
>
> Best regards
> Thomas
>
> >
> > Thanks,
> > Myeonghun
> >
> > 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:=
59, Thomas Zimmermann
> > <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> >     Hi
> >
> >     Am 24.04.26 um 15:40 schrieb Myeonghun Pak:
> >     > Hi Thomas,
> >     >
> >     > Thank you for your reply. I will ensure that the requested
> >     |Fixes| tag
> >     > and |stable| CC are included in the next patch I send.
> >     >
> >     > Regarding your request for information about AI usage and how the
> >     > issue was identified:
> >     >
> >     >   * This issue was identified during our ongoing static-analysis
> >     >     research while reviewing kernel code.
> >     >     1
> >     >
> >      <
> https://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959>
> >     >   * Specifically, it was found by an experimental static
> >     analysis tool
> >     >     that we are currently developing. The tool is not public
> >     yet, so I
> >     >     prefer not to disclose further project details at this stage.
> >     >
> >     >   * AI was used only for cross-review, not as the primary means o=
f
> >     >     finding or fixing the bug.
> >     >   * I manually reviewed the code and verified the issue before
> >     sending
> >     >     the patch.
> >     >
> >     > I will incorporate your requests and this additional context,
> >     and then
> >     > resend the modified patch.
> >
> >     Thanks a lot.
> >
> >     Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> >     Best regards
> >     Thomas
> >
> >     >
> >     > Thank you.
> >     >
> >     > Myeonghun Pak
> >     >
> >     >
> >     > 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=
=84 10:25, Thomas Zimmermann
> >     > <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >     >
> >     >     Hi,
> >     >
> >     >     please add fixes tags to all these patches you're sending. Yo=
u
> >     >     also need
> >     >     to CC stable so that they can be backported easily. Also
> >     list the AI
> >     >     you're using to find and create these patches.
> >     >
> >     >     Best regards
> >     >     Thomas
> >     >
> >     >     Am 24.04.26 um 14:34 schrieb Myeonghun Pak:
> >     >     > bochs_pci_probe() allocates the DRM device with
> >     >     devm_drm_dev_alloc(),
> >     >     > which registers a devres action to drop the initial DRM
> device
> >     >     reference
> >     >     > on driver detach or probe failure.
> >     >     >
> >     >     > The error path currently calls drm_dev_put() manually. If
> >     probe then
> >     >     > returns an error, devres will run the registered release
> >     action
> >     >     and put
> >     >     > the same device again, after the first put may already have
> >     >     released it.
> >     >     >
> >     >     > Return the probe error directly and let devres own the
> >     final put.
> >     >     >
> >     >     > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >     >     > ---
> >     >     >   drivers/gpu/drm/tiny/bochs.c | 10 +++-------
> >     >     >   1 file changed, 3 insertions(+), 7 deletions(-)
> >     >     >
> >     >     > diff --git a/drivers/gpu/drm/tiny/bochs.c
> >     >     b/drivers/gpu/drm/tiny/bochs.c
> >     >     > index 222e4ae1ab..5d8dc5efec 100644
> >     >     > --- a/drivers/gpu/drm/tiny/bochs.c
> >     >     > +++ b/drivers/gpu/drm/tiny/bochs.c
> >     >     > @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct
> >     pci_dev
> >     >     *pdev, const struct pci_device_id *ent
> >     >     >
> >     >     >       ret =3D pcim_enable_device(pdev);
> >     >     >       if (ret)
> >     >     > -             goto err_free_dev;
> >     >     > +             return ret;
> >     >     >
> >     >     >       pci_set_drvdata(pdev, dev);
> >     >     >
> >     >     >       ret =3D bochs_load(bochs);
> >     >     >       if (ret)
> >     >     > -             goto err_free_dev;
> >     >     > +             return ret;
> >     >     >
> >     >     >       ret =3D drm_dev_register(dev, 0);
> >     >     >       if (ret)
> >     >     > -             goto err_free_dev;
> >     >     > +             return ret;
> >     >     >
> >     >     >       drm_client_setup(dev, NULL);
> >     >     >
> >     >     >       return ret;
> >     >     > -
> >     >     > -err_free_dev:
> >     >     > -     drm_dev_put(dev);
> >     >     > -     return ret;
> >     >     >   }
> >     >     >
> >     >     >   static void bochs_pci_remove(struct pci_dev *pdev)
> >     >
> >     >     --
> >     >     --
> >     >     Thomas Zimmermann
> >     >     Graphics Driver Developer
> >     >     SUSE Software Solutions Germany GmbH
> >     >     Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> >     <http://www.suse.com>
> >     >     <http://www.suse.com>
> >     >     GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB
> >     36809, AG
> >     >     N=C3=BCrnberg)
> >     >
> >     >
> >
> >     --
> >     --
> >     Thomas Zimmermann
> >     Graphics Driver Developer
> >     SUSE Software Solutions Germany GmbH
> >     Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> >     <http://www.suse.com>
> >     GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG
> >     N=C3=BCrnberg)
> >
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG
> N=C3=BCrnberg)
>
>
>

--000000000000d1ff8b0650fd6705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Thomas,<br><br>You are right. I got confused and sent t=
he wrong reply. Sorry for the noise.<br><br>Thanks,<br>Myeonghun<br></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">2026=EB=85=84 5=EC=9B=94 4=EC=9D=BC (=EC=9B=94) =EC=98=A4=
=ED=9B=84 5:36, Thomas Zimmermann &lt;<a href=3D"mailto:tzimmermann@suse.de=
">tzimmermann@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
Am 30.04.26 um 15:52 schrieb Myeonghun Pak:<br>
&gt; Thanks for the explanation.<br>
&gt;<br>
&gt; I see your point now. My patch treated uart_add_one_port() failure as =
<br>
&gt; a fatal<br>
&gt; probe failure, but the current code is intentionally trying to keep <b=
r>
&gt; the driver<br>
&gt; alive so that other MAX3100 ports can still be available even if one <=
br>
&gt; port cannot<br>
&gt; be instantiated.<br>
&gt;<br>
&gt; Please drop this patch. I will not pursue this direction.<br>
<br>
Why? The was patch was good AFAICT. It&#39;s just missing a Fixes tag.<br>
<br>
Best regards<br>
Thomas<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Myeonghun<br>
&gt;<br>
&gt; 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11=
:59, Thomas Zimmermann <br>
&gt; &lt;<a href=3D"mailto:tzimmermann@suse.de" target=3D"_blank">tzimmerma=
nn@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Am 24.04.26 um 15:40 schrieb Myeonghun Pak:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Thomas,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thank you for your reply. I will ensure that t=
he requested<br>
&gt;=C2=A0 =C2=A0 =C2=A0|Fixes|=C2=A0tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and |stable|=C2=A0CC are included in the next =
patch I send.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Regarding your request for information about A=
I usage and how the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; issue was identified:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* This issue was identified during=
 our ongoing static-analysis<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0research while reviewing ke=
rnel code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A01<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0&lt;<a href=3D"https://mail.google.com/mail/u=
/0/#all/%23thread-f:1863355320119932959" rel=3D"noreferrer" target=3D"_blan=
k">https://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Specifically, it was found by an=
 experimental static<br>
&gt;=C2=A0 =C2=A0 =C2=A0analysis tool<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0that we are currently devel=
oping. The tool is not public<br>
&gt;=C2=A0 =C2=A0 =C2=A0yet, so I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0prefer not to disclose furt=
her project details at this stage.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* AI was used only for cross-revie=
w, not as the primary means of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0finding or fixing the bug.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* I manually reviewed the code and=
 verified the issue before<br>
&gt;=C2=A0 =C2=A0 =C2=A0sending<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0the patch.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I will incorporate your requests and this addi=
tional context,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; resend the modified patch.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks a lot.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Thomas Zimmermann &lt;<a href=3D"mailt=
o:tzimmermann@suse.de" target=3D"_blank">tzimmermann@suse.de</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thomas<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thank you.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Myeonghun Pak<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=
=88) =EC=98=A4=ED=9B=84 10:25, Thomas Zimmermann<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;<a href=3D"mailto:tzimmermann@suse.de" tar=
get=3D"_blank">tzimmermann@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0please add fixes tags to al=
l these patches you&#39;re sending. You<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0also need<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0to CC stable so that they c=
an be backported easily. Also<br>
&gt;=C2=A0 =C2=A0 =C2=A0list the AI<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0you&#39;re using to find an=
d create these patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Thomas<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Am 24.04.26 um 14:34 schrie=
b Myeonghun Pak:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; bochs_pci_probe() allo=
cates the DRM device with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0devm_drm_dev_alloc(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; which registers a devr=
es action to drop the initial DRM device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0reference<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; on driver detach or pr=
obe failure.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; The error path current=
ly calls drm_dev_put() manually. If<br>
&gt;=C2=A0 =C2=A0 =C2=A0probe then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; returns an error, devr=
es will run the registered release<br>
&gt;=C2=A0 =C2=A0 =C2=A0action<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0and put<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; the same device again,=
 after the first put may already have<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0released it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Return the probe error=
 directly and let devres own the<br>
&gt;=C2=A0 =C2=A0 =C2=A0final put.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Myeongh=
un Pak &lt;<a href=3D"mailto:mhun512@gmail.com" target=3D"_blank">mhun512@g=
mail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0drivers/gp=
u/drm/tiny/bochs.c | 10 +++-------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A01 file cha=
nged, 3 insertions(+), 7 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/g=
pu/drm/tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/tiny/boch=
s.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 222e4ae1ab..5d8d=
c5efec 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/=
tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/=
tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -761,25 +761,21 @@ =
static int bochs_pci_probe(struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0pci_dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*pdev, const struct pci_dev=
ice_id *ent<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ret =3D pcim_enable_device(pdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0pci_set_drvdata(pdev, dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ret =3D bochs_load(bochs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ret =3D drm_dev_register(dev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0drm_client_setup(dev, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -err_free_dev:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0d=
rm_dev_put(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0r=
eturn ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0static voi=
d bochs_pci_remove(struct pci_dev *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Thomas Zimmermann<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Graphics Driver Developer<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0SUSE Software Solutions Ger=
many GmbH<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Frankenstr. 146, 90461 N=C3=
=BCrnberg, Germany, <a href=3D"http://www.suse.com" rel=3D"noreferrer" targ=
et=3D"_blank">www.suse.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.suse.com" rel=3D"noreferr=
er" target=3D"_blank">http://www.suse.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.s=
use.com" rel=3D"noreferrer" target=3D"_blank">http://www.suse.com</a>&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0GF: Jochen Jaser, Andrew Mc=
Donald, Werner Knoblich, (HRB<br>
&gt;=C2=A0 =C2=A0 =C2=A036809, AG<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0N=C3=BCrnberg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thomas Zimmermann<br>
&gt;=C2=A0 =C2=A0 =C2=A0Graphics Driver Developer<br>
&gt;=C2=A0 =C2=A0 =C2=A0SUSE Software Solutions Germany GmbH<br>
&gt;=C2=A0 =C2=A0 =C2=A0Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, <a h=
ref=3D"http://www.suse.com" rel=3D"noreferrer" target=3D"_blank">www.suse.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.suse.com" rel=3D"noreferr=
er" target=3D"_blank">http://www.suse.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0GF: Jochen Jaser, Andrew McDonald, Werner Knoblich,=
 (HRB 36809, AG<br>
&gt;=C2=A0 =C2=A0 =C2=A0N=C3=BCrnberg)<br>
&gt;<br>
&gt;<br>
<br>
-- <br>
--<br>
Thomas Zimmermann<br>
Graphics Driver Developer<br>
SUSE Software Solutions Germany GmbH<br>
Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, <a href=3D"http://www.suse.c=
om" rel=3D"noreferrer" target=3D"_blank">www.suse.com</a><br>
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=BCr=
nberg)<br>
<br>
<br>
</blockquote></div>

--000000000000d1ff8b0650fd6705--
