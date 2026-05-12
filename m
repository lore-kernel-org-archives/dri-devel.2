Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D47CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94D610E02C;
	Tue, 12 May 2026 06:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+d+6sIE";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC42B10E02C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:36:12 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so794432666b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778567771; cv=none;
 d=google.com; s=arc-20240605;
 b=IQV2sVLhOSh0tBcy9WnVw0NQ7M1n7gQfPsUpm3bjTeQWsFoBcl5QPIpvl5q7kgqWKf
 7FvgG/eLl/XR6d8pqTCGTO8erDA+1wvjivS6cyb5Ch/rwXTENeAUzKt4gmmC4p/QqtsG
 ueVoqPmwNNSDz4MV/wxtiYhphLxCAGbtM3BZw7Wpqgjj+xBGxbd7THauNDW/MfUYY9Qz
 H2rq8u+cFq4IgcPIHcUDYegDTnXUfqP90QL5twH3WTzOr5/tjHjKYmSZ+HZpJUp0ox+Q
 q0cU9fWfmBHCnngPlffOkTP/SndukznYiDwCoLC+373nrBlId10tj6MSj7G7TNHEQMcr
 Lwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sx5o5aPm7ymYyPfKNR1Xg0WbG0dD44QgA1MLgaIOszY=;
 fh=tYfim0CTlD8Etci9OwO8a6QKlIL8p/qXNYYMK+8ajGI=;
 b=bTZVWma2QLyWS/3mdK2nmkmmFyHcCETQqFJrj1lnFNeHKq+Fyo/cQ9L8qW/4NhRKMQ
 ugF8TrMUwo1s94QXep6f5e9gNgNWmhI+vMwi/9zkTVAcMh0UGBqXZflLyjBnPT0xVQib
 bNvwd97yJClpSPL0jpQumbA1xlJ9ovhZwshFC2izYFZsNXpeALjEqtfwFXEtBmLUOM/P
 1bRJc8LVsq3GamPfd+szTLMToCKgYL82VnOOakPt1jfPwDQAHqH37II4NHbDS/vqiGrK
 AhUIOARwj5I20IPxMZ4OktllUYvAb96O6l1HMrzLt8iPtNbB2GAIT1FIfMs8t/kjkEvq
 V9EA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778567771; x=1779172571; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sx5o5aPm7ymYyPfKNR1Xg0WbG0dD44QgA1MLgaIOszY=;
 b=k+d+6sIEE1emr+x2tP7RV24LHvhEgJDFbemjcdma4bbzd/Z7b+NKqYG1wrbTefb9Ml
 PIv51s8IyBdGGjx4BhgHYvQoapojI44DtKRwFifm+pqTba9gCg2TG2BFgN8pm1PZBoKL
 a1RIDgRD4b4/VW09vs208YXTtfvHcJYYZMlXOKPIp0WFIA6aa+BN56AjtyAkwRZ1TzBH
 OIVkdzFE+pNyam8Y185cTpdrXeAiUn2V/bMnVP7uQleeYV3hca9DMJS93xqr0Ce9qaCi
 chtGk4LR9uIj2sgygsjO936k/iL8NDdHLq4oJ/bEP9kNw+g/y/666BUqhlR9OPuyRDpd
 u0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567771; x=1779172571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sx5o5aPm7ymYyPfKNR1Xg0WbG0dD44QgA1MLgaIOszY=;
 b=K4e2e5Os9nO1We1UVdBhandgR8VN4IOxTzBE08iIwdZBuhOC8So8IHHASxnYiRJ7LY
 wLZXov5UFcQVKrlU27Tlxvos92r8Ecl8+FeWtWMqKYR5dSD4ry/7ALnU2p5BmT0uq2+A
 wj8rQmWZoQs8Ae/JUs0CcWOweaMtlriw5MCJV/67YyYusqwwYOoJivwUd60hk8yH11eY
 /vTZ2L0SP0qbprYl2uXu3uXU2unznFT8Hh527qjUIJMLQA9GIV+lYLFQggH65Dzg6Eu6
 Oz3zGrPG4+qJHtMCzcIYzUV6tiWIHWlJe48Nyl6jJPjjLriF9rbMGyEDOHeafdDexhAJ
 OR1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WWfRC90TD7LvGMhq9ZyOlpolrF68tqg0MvowjG6856QGmn8tJKJad9i7qEp8mkGYgioCExbcPiXM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtINvixLosKddDQsVEL+Yr4kZKmPDYOYPwBT42iV5IIkzvD7Iy
 qphsDsrL0KiTfpjg5Oadb5atj182jEjmfT2wvmFyH89AAP/r0jqifoF+92MYyLLn04sjlpbEDU+
 gyeQABGZgavy7lBeBD2bZtZwzGhMeRw==
X-Gm-Gg: Acq92OGAHFuIzBTbQSDf/WavfAGqHp/Jt/DSkuXN4kW16KAFiTwdQ7E71rxxB6dD2C1
 qqQAA2y4/ZMk2GUOmmiYOV9aYqt56okfzXCC+wYjVGAgSSMMPFEtQ2B1xSJQ5TSdCdAVtXwMhB+
 t1FgAWIEWGBqDNWjfDZ0mNd/hAXZEYzMUjFNsgC9RByx9Xj+Ce1mt/il5qGEnR87YpLXcJTlsrA
 VpaMgX3Q3/aObnfN3s8qiKodEUAqsSFtOMUchO+fDKQ/U/kjbJyZQG1puN/sYI/muR9Mz+rdhQu
 PsInqM47Tk3eYzBwgmsWymmsBaiJbtrZ+B188+WjFvb2sPfNsA==
X-Received: by 2002:a17:906:f59a:b0:ba5:1970:2bb6 with SMTP id
 a640c23a62f3a-bd28f6967aemr81796366b.34.1778567770933; Mon, 11 May 2026
 23:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260511170152.16957-1-mhun512@gmail.com>
 <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
 <eb236f5d-e185-418c-9ea1-780e8b1f985b@suse.de>
In-Reply-To: <eb236f5d-e185-418c-9ea1-780e8b1f985b@suse.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 12 May 2026 15:35:59 +0900
X-Gm-Features: AVHnY4JGcr-utocqGbdFL5KVpAjH4SDyn-A0dH0db8ax19oFwBDBVe8qe_RB83U
Message-ID: <CAGEsz8FcBBtdJ5S6HM89Jfu+q-2BdDtp-sy3ZMpyrEUqJrG7Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: clean up KMS polling on probe failure
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, dri-devel@lists.freedesktop.org, 
 Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000032102406519914d0"
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

--00000000000032102406519914d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Icenowy, Thomas,

Thanks for the review.

I agree that using drmm_kms_helper_poll_init() is the better fix here. It
keeps the polling cleanup tied to the DRM device lifetime and avoids adding
manual unwind and remove-path cleanup.

I sent a v2 that switches lsdc_pci_probe() to drmm_kms_helper_poll_init().

Thanks,
Myeonghun


2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:26, T=
homas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:

> Hi
>
> Am 11.05.26 um 19:22 schrieb Icenowy Zheng:
> > =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 02:01 +0900=EF=BC=8CMyeonghun Pa=
k=E5=86=99=E9=81=93=EF=BC=9A
> >> lsdc_pci_probe() initializes KMS polling before setting up vblank
> >> support,
> >> requesting the IRQ and registering the DRM device. If any of those
> >> later
> >> steps fails, probe returns without finalizing polling. The remove
> >> path has
> >> the same lifetime gap when tearing down a successfully registered
> >> device.
> >>
> >> Route those probe failures through a poll cleanup label. Also
> >> finalize
> >> polling from remove before unregistering the DRM device.
> > Interesting, but it looks like a `drmm_kms_helper_poll_init` function
> > exists (while rarely used).
> >
> > Maybe it's better to switch to this? Or maybe there's some reason not
> > to use this?
>
> Agreed. DRM drivers are advised to use managed cleanup for their data
> structures. So rather switch to drmm_kms_helper_poll_init(). That also
> resolves the problem that loongson never calls poll_fini on regular
> removals.
>
> Best regards
> Thomas
>
> >
> > Thanks,
> > Icenowy
> >
> >> This issue was identified during our ongoing static-analysis research
> >> while
> >> reviewing kernel code.
> >>
> >> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> >> controller")
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> >> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> >> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >> ---
> >>   drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
> >>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c
> >> b/drivers/gpu/drm/loongson/lsdc_drv.c
> >> index abf5bf68ee..3db1f8690a 100644
> >> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> >> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> >> @@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> >> const struct pci_device_id *ent)
> >>      if (loongson_vblank) {
> >>              ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> >>              if (ret)
> >> -                    return ret;
> >> +                    goto err_poll_fini;
> >>
> >>              ret =3D devm_request_irq(&pdev->dev, pdev->irq,
> >>                                     descp->funcs->irq_handler,
> >> @@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> >> const struct pci_device_id *ent)
> >>                                     dev_name(&pdev->dev), ddev);
> >>              if (ret) {
> >>                      drm_err(ddev, "Failed to register interrupt:
> >> %d\n", ret);
> >> -                    return ret;
> >> +                    goto err_poll_fini;
> >>              }
> >>
> >>              drm_info(ddev, "registered irq: %u\n", pdev->irq);
> >> @@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> >> const struct pci_device_id *ent)
> >>
> >>      ret =3D drm_dev_register(ddev, 0);
> >>      if (ret)
> >> -            return ret;
> >> +            goto err_poll_fini;
> >>
> >>      drm_client_setup(ddev, NULL);
> >>
> >>      return 0;
> >> +
> >> +err_poll_fini:
> >> +    drm_kms_helper_poll_fini(ddev);
> >> +    return ret;
> >>   }
> >>
> >>   static void lsdc_pci_remove(struct pci_dev *pdev)
> >>   {
> >>      struct drm_device *ddev =3D pci_get_drvdata(pdev);
> >>
> >> +    drm_kms_helper_poll_fini(ddev);
> >>      drm_dev_unregister(ddev);
> >>      drm_atomic_helper_shutdown(ddev);
> >>   }
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

--00000000000032102406519914d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Icenowy, Thomas,<br><br>Thanks for the review.<br><br>I=
 agree that using drmm_kms_helper_poll_init() is the better fix here. It ke=
eps the polling cleanup tied to the DRM device lifetime and avoids adding m=
anual unwind and remove-path cleanup.<br><br>I sent a v2 that switches lsdc=
_pci_probe() to drmm_kms_helper_poll_init().<br><br>Thanks,<br>Myeonghun<br=
></div><br><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94)=
 =EC=98=A4=ED=9B=84 3:26, Thomas Zimmermann &lt;<a href=3D"mailto:tzimmerma=
nn@suse.de">tzimmermann@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
Am 11.05.26 um 19:22 schrieb Icenowy Zheng:<br>
&gt; =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 02:01 +0900=EF=BC=8CMyeonghun P=
ak=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt; lsdc_pci_probe() initializes KMS polling before setting up vblank<=
br>
&gt;&gt; support,<br>
&gt;&gt; requesting the IRQ and registering the DRM device. If any of those=
<br>
&gt;&gt; later<br>
&gt;&gt; steps fails, probe returns without finalizing polling. The remove<=
br>
&gt;&gt; path has<br>
&gt;&gt; the same lifetime gap when tearing down a successfully registered<=
br>
&gt;&gt; device.<br>
&gt;&gt;<br>
&gt;&gt; Route those probe failures through a poll cleanup label. Also<br>
&gt;&gt; finalize<br>
&gt;&gt; polling from remove before unregistering the DRM device.<br>
&gt; Interesting, but it looks like a `drmm_kms_helper_poll_init` function<=
br>
&gt; exists (while rarely used).<br>
&gt;<br>
&gt; Maybe it&#39;s better to switch to this? Or maybe there&#39;s some rea=
son not<br>
&gt; to use this?<br>
<br>
Agreed. DRM drivers are advised to use managed cleanup for their data <br>
structures. So rather switch to drmm_kms_helper_poll_init(). That also <br>
resolves the problem that loongson never calls poll_fini on regular <br>
removals.<br>
<br>
Best regards<br>
Thomas<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Icenowy<br>
&gt;<br>
&gt;&gt; This issue was identified during our ongoing static-analysis resea=
rch<br>
&gt;&gt; while<br>
&gt;&gt; reviewing kernel code.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: f39db26c5428 (&quot;drm: Add kms driver for loongson displa=
y<br>
&gt;&gt; controller&quot;)<br>
&gt;&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">st=
able@vger.kernel.org</a><br>
&gt;&gt; Co-developed-by: Ijae Kim &lt;<a href=3D"mailto:ae878000@gmail.com=
" target=3D"_blank">ae878000@gmail.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Ijae Kim &lt;<a href=3D"mailto:ae878000@gmail.com" =
target=3D"_blank">ae878000@gmail.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.c=
om" target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---<b=
r>
&gt;&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c<br>
&gt;&gt; b/drivers/gpu/drm/loongson/lsdc_drv.c<br>
&gt;&gt; index abf5bf68ee..3db1f8690a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/loongson/lsdc_drv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/loongson/lsdc_drv.c<br>
&gt;&gt; @@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev=
,<br>
&gt;&gt; const struct pci_device_id *ent)<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0if (loongson_vblank) {<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_v=
blank_init(ddev, descp-&gt;num_of_crtc);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return ret;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto err_poll_fini;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D devm_=
request_irq(&amp;pdev-&gt;dev, pdev-&gt;irq,<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 descp-&gt;funcs-&gt;irq_handler,<br>
&gt;&gt; @@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev=
,<br>
&gt;&gt; const struct pci_device_id *ent)<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_name(&amp;pdev-&gt;dev), ddev);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br=
>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0drm_err(ddev, &quot;Failed to register interrupt:<br>
&gt;&gt; %d\n&quot;, ret);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return ret;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto err_poll_fini;<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_info(ddev=
, &quot;registered irq: %u\n&quot;, pdev-&gt;irq);<br>
&gt;&gt; @@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pd=
ev,<br>
&gt;&gt; const struct pci_device_id *ent)<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0ret =3D drm_dev_register(ddev, 0);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0if (ret)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_poll_fini;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0drm_client_setup(ddev, NULL);<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +err_poll_fini:<br>
&gt;&gt; +=C2=A0 =C2=A0 drm_kms_helper_poll_fini(ddev);<br>
&gt;&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0static void lsdc_pci_remove(struct pci_dev *pdev)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0struct drm_device *ddev =3D pci_get_drvda=
ta(pdev);<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; +=C2=A0 =C2=A0 drm_kms_helper_poll_fini(ddev);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0drm_dev_unregister(ddev);<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0 =C2=A0drm_atomic_helper_shutdown(ddev);<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
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

--00000000000032102406519914d0--
