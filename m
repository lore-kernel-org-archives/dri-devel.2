Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062A7FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA0310E05F;
	Thu, 30 Apr 2026 13:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGVjYfMp";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8902710F234
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:52:57 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-674a44b84fcso1563435a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 06:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777557176; cv=none;
 d=google.com; s=arc-20240605;
 b=Obv2Uy2WfPhi1bna3a/ZH79m1DaQhx6iHNbvrfSRqZKRpSvChRdo6iabWB6l/m8cHT
 05Gi4uPAhLl/3040Q2qzrp63icXVa8mVOLPjgUAG+tHv2FKOFnbX4HA5TABx1sfha6zK
 77wNyyrA+VybwEQ/ckmDnbYYjY0Jo1djAWy6KC1f0MUiWgPK0RLE2JnKnyFF/mYNGuaV
 RoYluWmHQ5cfLEaPwOo86PUkqUJSLkUNqy6O6FIl0SsViTfYCbGYvtU7f+C7a7dnGiAP
 X3Apy9QPjfwWi9I2P+rB80Zfw/DGdDpomKIydSimrUxCgdgo3nztiYkU2v8b/TEhyOQx
 7p+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wA4ZSX4oHRUKGBEGJm4aHw/EZ6t7FRjmp9R7HU32+mM=;
 fh=o3Xx09Qf233eyXH9Xdxx1wUB+p1U7WaUkYD+F7Pqnps=;
 b=c5/cN+GPD2ZcUS7z2b/mE/AvW+4oIOs4i+RYzOC1Kpu1xLEYmQHbipzAr5an9PW7h+
 BKtzkZfA3EX2p2yY+2oh6c1Ha4zJGPg++I4ewsg/xhrq2KTBzw0hxIhKaldZ4ndevgRh
 rOBaW56Rcd7a1vkb33DgsIhbY8mXhUbsgG56ejkYxdNwwYcFmHNRgek6qp62xx4ml4gi
 YlySbDOtmzbA3KC9C8eepmbTaCd99kqemxxFDaOBinLx/0WISyMHhUDCav1AMY1HrBGg
 UA9T4Im8kDDGeMPmyD3BzQWlRJz7QJW7uGAa26/AQ0PVujS1HgeGrsAYajav5t6v2JwH
 en9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777557176; x=1778161976; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wA4ZSX4oHRUKGBEGJm4aHw/EZ6t7FRjmp9R7HU32+mM=;
 b=mGVjYfMpK+t6g/VFfkOGEzljr4ViRTlq01DF3GYsmCMD3HbuNXR/u9RcdJIpHetd3r
 78fd4ArG86wPc6ONi20RYjRLL3j83tg5N16oh10ujN+USR9VdzebvNTuTXgoopZ7rzAL
 l0H9lDNaMAVBAHIQR0fqk3O+xl0erGInfUcW0ymchOlodANaI0FMUMqgudMt1UGZziHn
 EphHI4gmgjJn34BO4YNBKQGRWSZZ2ayFR/vanJOs4ocw+zX7UVhPvSW/yXFM8aUGb6iW
 98JsoeVrc+g6z4HX9ELJiku/FLHnhRQgFL3OfR3N2IBkm0yc22K3yMGUtdxu7yd+n88I
 Z5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777557176; x=1778161976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA4ZSX4oHRUKGBEGJm4aHw/EZ6t7FRjmp9R7HU32+mM=;
 b=fVUyeAhjW4BcPOO8bY6TFcFOOHgcuPzBlG1r7TNtkrI8LGAolO5mtTotTkX1gPqRRj
 SynYn6c0tFk4m58ka6wJxtdRQz+h/gsaZ2CNmU6aRImUTEodQyMJ4Pd/XTlsn/TZDorr
 CRzYnVpNbthI405wwtI//lq3fMdxyINkBuYF+owl66lOE140qOyFEVdmyxGjOwQVLRwt
 IwoSF/gd3QLCJgftdot4hTy0s1ULy/GlZ7NAywBJHbgV+LVL02I0sce2HqE7Tc3JOkJ+
 SGJ+GpaYgC3UW5/kq+oEqrgw8gK73hn3uMTTdj6X5dQBgyVff7Ayycglx/rjC+HQ3Lxd
 UPiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5KgapqIgUIPuhiUqAzpmVAwTZ8XCyb52rKtw9DCYAT0LWTOtSPSIzzEyIOv1ltQQ1PsGiceGhBh4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXYrvw+/5NGYqK57jUQVvjn6HkaY04h8Lmn6Jc1YUkNuGeu+iQ
 b54hglcan0ruAV9SzcHermX9YDB5dd6wIR77Hqzup0x9lg2XV2yCucdRuQh5ZVCYc9vGMxOMsc9
 xve644GJ9llodgoWfTzblrqQfssBmlA==
X-Gm-Gg: AeBDievnDo3RV+drnand9Ka6u3u9mZH2+kSv21tLCtKLbEgQuU11XKnJjDBtXwJ48p3
 Mc9hbaqFHKxA9UH7rXtjvoSVUaUUSCe+QwtsNzpEHTt+hu2zEqrevrgh2dHsKL3RVevDMoQQ2kt
 BsCyGKS3Hfk28J8KlbIxdr3D8XwckUKuMpve63psza4lLOQjyqNaWRjJU/xgiwBWzWSTPpwKJug
 KNOX5qDBc65fplPDGzw5IiI2zUOhA3KgprV56/fiNeYG4khjo+431O8uibsv700BUvsLxa3JFqE
 AWfD7YFU+ZIEXCYtGzuCdRzOZWKTWi79duhO1UHEwUmtcG4=
X-Received: by 2002:a05:6402:540e:b0:678:9826:b758 with SMTP id
 4fb4d7f45d1cf-67b5d7cfb59mr1471347a12.6.1777557175553; Thu, 30 Apr 2026
 06:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260424123506.32275-1-mhun512@gmail.com>
 <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
 <CAGEsz8FrkbQEWZbxV3Q0NkSxhQka575uemKMQtTJQaCm44ByxQ@mail.gmail.com>
 <5ca1cea2-9761-46ff-a575-53af23e79b36@suse.de>
In-Reply-To: <5ca1cea2-9761-46ff-a575-53af23e79b36@suse.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 30 Apr 2026 22:52:43 +0900
X-Gm-Features: AVHnY4LFBk4Y3HrOwENjC_JhjhFAcFeUHfImHkQ2rXV_DlB4vL9GpVnuHBozw20
Message-ID: <CAGEsz8F54LaiJYGD6i-nW7hDiLTu6FOi4Z8fzb8b4=+9-OEH+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Drop manual put on probe error path
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 virtualization@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000000451fd0650adc8c7"
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

--0000000000000451fd0650adc8c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation.

I see your point now. My patch treated uart_add_one_port() failure as a
fatal
probe failure, but the current code is intentionally trying to keep the
driver
alive so that other MAX3100 ports can still be available even if one port
cannot
be instantiated.

Please drop this patch. I will not pursue this direction.

Thanks,
Myeonghun

2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:59, =
Thomas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

> Hi
>
> Am 24.04.26 um 15:40 schrieb Myeonghun Pak:
> > Hi Thomas,
> >
> > Thank you for your reply. I will ensure that the requested |Fixes| tag
> > and |stable| CC are included in the next patch I send.
> >
> > Regarding your request for information about AI usage and how the
> > issue was identified:
> >
> >   * This issue was identified during our ongoing static-analysis
> >     research while reviewing kernel code.
> >     1
> >     <
> https://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959>
> >   * Specifically, it was found by an experimental static analysis tool
> >     that we are currently developing. The tool is not public yet, so I
> >     prefer not to disclose further project details at this stage.
> >
> >   * AI was used only for cross-review, not as the primary means of
> >     finding or fixing the bug.
> >   * I manually reviewed the code and verified the issue before sending
> >     the patch.
> >
> > I will incorporate your requests and this additional context, and then
> > resend the modified patch.
>
> Thanks a lot.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Best regards
> Thomas
>
> >
> > Thank you.
> >
> > Myeonghun Pak
> >
> >
> > 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:=
25, Thomas Zimmermann
> > <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> >     Hi,
> >
> >     please add fixes tags to all these patches you're sending. You
> >     also need
> >     to CC stable so that they can be backported easily. Also list the A=
I
> >     you're using to find and create these patches.
> >
> >     Best regards
> >     Thomas
> >
> >     Am 24.04.26 um 14:34 schrieb Myeonghun Pak:
> >     > bochs_pci_probe() allocates the DRM device with
> >     devm_drm_dev_alloc(),
> >     > which registers a devres action to drop the initial DRM device
> >     reference
> >     > on driver detach or probe failure.
> >     >
> >     > The error path currently calls drm_dev_put() manually. If probe
> then
> >     > returns an error, devres will run the registered release action
> >     and put
> >     > the same device again, after the first put may already have
> >     released it.
> >     >
> >     > Return the probe error directly and let devres own the final put.
> >     >
> >     > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >     > ---
> >     >   drivers/gpu/drm/tiny/bochs.c | 10 +++-------
> >     >   1 file changed, 3 insertions(+), 7 deletions(-)
> >     >
> >     > diff --git a/drivers/gpu/drm/tiny/bochs.c
> >     b/drivers/gpu/drm/tiny/bochs.c
> >     > index 222e4ae1ab..5d8dc5efec 100644
> >     > --- a/drivers/gpu/drm/tiny/bochs.c
> >     > +++ b/drivers/gpu/drm/tiny/bochs.c
> >     > @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev
> >     *pdev, const struct pci_device_id *ent
> >     >
> >     >       ret =3D pcim_enable_device(pdev);
> >     >       if (ret)
> >     > -             goto err_free_dev;
> >     > +             return ret;
> >     >
> >     >       pci_set_drvdata(pdev, dev);
> >     >
> >     >       ret =3D bochs_load(bochs);
> >     >       if (ret)
> >     > -             goto err_free_dev;
> >     > +             return ret;
> >     >
> >     >       ret =3D drm_dev_register(dev, 0);
> >     >       if (ret)
> >     > -             goto err_free_dev;
> >     > +             return ret;
> >     >
> >     >       drm_client_setup(dev, NULL);
> >     >
> >     >       return ret;
> >     > -
> >     > -err_free_dev:
> >     > -     drm_dev_put(dev);
> >     > -     return ret;
> >     >   }
> >     >
> >     >   static void bochs_pci_remove(struct pci_dev *pdev)
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

--0000000000000451fd0650adc8c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the explanation.<br><br>I see your point now. M=
y patch treated uart_add_one_port() failure as a fatal<br>probe failure, bu=
t the current code is intentionally trying to keep the driver<br>alive so t=
hat other MAX3100 ports can still be available even if one port cannot<br>b=
e instantiated.<br><br>Please drop this patch. I will not pursue this direc=
tion.<br><br>Thanks,<br>Myeonghun<br></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 4=
=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:59, Thomas Zimmerma=
nn &lt;<a href=3D"mailto:tzimmermann@suse.de">tzimmermann@suse.de</a>&gt;=
=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi<br>
<br>
Am 24.04.26 um 15:40 schrieb Myeonghun Pak:<br>
&gt; Hi Thomas,<br>
&gt;<br>
&gt; Thank you for your reply. I will ensure that the requested |Fixes|=C2=
=A0tag <br>
&gt; and |stable|=C2=A0CC are included in the next patch I send.<br>
&gt;<br>
&gt; Regarding your request for information about AI usage and how the <br>
&gt; issue was identified:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* This issue was identified during our ongoing static-anal=
ysis<br>
&gt;=C2=A0 =C2=A0 =C2=A0research while reviewing kernel code.<br>
&gt;=C2=A0 =C2=A0 =C2=A01<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://mail.google.com/mail/u/0/#al=
l/%23thread-f:1863355320119932959" rel=3D"noreferrer" target=3D"_blank">htt=
ps://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0* Specifically, it was found by an experimental static ana=
lysis tool<br>
&gt;=C2=A0 =C2=A0 =C2=A0that we are currently developing. The tool is not p=
ublic yet, so I<br>
&gt;=C2=A0 =C2=A0 =C2=A0prefer not to disclose further project details at t=
his stage.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* AI was used only for cross-review, not as the primary me=
ans of<br>
&gt;=C2=A0 =C2=A0 =C2=A0finding or fixing the bug.<br>
&gt;=C2=A0 =C2=A0* I manually reviewed the code and verified the issue befo=
re sending<br>
&gt;=C2=A0 =C2=A0 =C2=A0the patch.<br>
&gt;<br>
&gt; I will incorporate your requests and this additional context, and then=
 <br>
&gt; resend the modified patch.<br>
<br>
Thanks a lot.<br>
<br>
Reviewed-by: Thomas Zimmermann &lt;<a href=3D"mailto:tzimmermann@suse.de" t=
arget=3D"_blank">tzimmermann@suse.de</a>&gt;<br>
<br>
Best regards<br>
Thomas<br>
<br>
&gt;<br>
&gt; Thank you.<br>
&gt;<br>
&gt; Myeonghun Pak<br>
&gt;<br>
&gt;<br>
&gt; 2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10=
:25, Thomas Zimmermann <br>
&gt; &lt;<a href=3D"mailto:tzimmermann@suse.de" target=3D"_blank">tzimmerma=
nn@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0please add fixes tags to all these patches you&#39;=
re sending. You<br>
&gt;=C2=A0 =C2=A0 =C2=A0also need<br>
&gt;=C2=A0 =C2=A0 =C2=A0to CC stable so that they can be backported easily.=
 Also list the AI<br>
&gt;=C2=A0 =C2=A0 =C2=A0you&#39;re using to find and create these patches.<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thomas<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Am 24.04.26 um 14:34 schrieb Myeonghun Pak:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; bochs_pci_probe() allocates the DRM device wit=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0devm_drm_dev_alloc(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; which registers a devres action to drop the in=
itial DRM device<br>
&gt;=C2=A0 =C2=A0 =C2=A0reference<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; on driver detach or probe failure.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The error path currently calls drm_dev_put() m=
anually. If probe then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; returns an error, devres will run the register=
ed release action<br>
&gt;=C2=A0 =C2=A0 =C2=A0and put<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the same device again, after the first put may=
 already have<br>
&gt;=C2=A0 =C2=A0 =C2=A0released it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Return the probe error directly and let devres=
 own the final put.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"ma=
ilto:mhun512@gmail.com" target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0drivers/gpu/drm/tiny/bochs.c | 10 =
+++-------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 7=
 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 222e4ae1ab..5d8dc5efec 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/tiny/bochs.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -761,25 +761,21 @@ static int bochs_pci_pro=
be(struct pci_dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0*pdev, const struct pci_device_id *ent<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pcim_enable_=
device(pdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_drvdata(pdev=
, dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bochs_load(b=
ochs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_dev_regi=
ster(dev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto err_free_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_client_setup(dev=
, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -err_free_dev:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0drm_dev_put(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0static void bochs_pci_remove(struc=
t pci_dev *pdev)<br>
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

--0000000000000451fd0650adc8c7--
