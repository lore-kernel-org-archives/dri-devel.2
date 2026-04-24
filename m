Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA6FED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68B310F66A;
	Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VLsz1wEB";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263BD10E3D2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:40:49 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6720c7968e4so3668546a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777038047; cv=none;
 d=google.com; s=arc-20240605;
 b=c0PHz5B6HVz9JKWwmKI6s4uSjCtsYFqzbDZuTaVT8igOrEwoVDWKXFKkJQ71JMk0OP
 NRbw412P8toRwYbnqD6qt4Iozwh2Ly0x/9BUsfEsh+7+0DBAX5gkTXtFWJaHTJU6Y89v
 2sNaveYg3AJ6Fa0gh0XdizJWrlrpQ5Ulzu4C1J5jLR6spKPgG415xjpBiZxMhZINy4Mx
 6Ex249OYU458mIyYgXv9f9c9hSfntVtU9utyPpdcU7ZZkKLnfc2uEhQDrXhTcEcKFgQ9
 +Cht9/Y9Y9Xs5sN3vszGf3JbfNoypLBGRwTKxFo/6pTobG3kRDE06NU5udPrjADbFhmn
 ZTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zLOYpydKzXK5OxVrsM3Cabj7Lo2bQVnX65AABC5LhLM=;
 fh=TJVwvVG3P7z1hR3s6DNuDls5MDq0ktfyxR/JJDv6sqA=;
 b=IY+aLZYYV8iyjf6nKiyDka9rmhC5BAJf7OZAnnH+9mORivFL+67NohVRaymJ4kEz0l
 onaPObuBDx1KFChW5GdGZ07OHEIgUqARBUqni9OvDT+XdpAGJo20jMP1CDX+mLevbku5
 bclu6zbOwCVdWpCft8GBsJOWbYtcWgZTRSA0t3U/IAnQ6z1/seNhPbRXAB6+4YKnQI0P
 57y8y6bPhUKDXX7+rJ2Y4+WsRanuMoQ46zFI1cwOIPuF/QrV92i+HUobdQOTk7lSKjag
 6H5Cxwo2zcOdeD4CLojGDOu7ZGeiRJCNykROAGauMzUFOCNnN7woNhz2S1ZeuOHMieJy
 ICUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777038047; x=1777642847; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zLOYpydKzXK5OxVrsM3Cabj7Lo2bQVnX65AABC5LhLM=;
 b=VLsz1wEBZzBzWRIDNXIU4RwIIGsYpdIPs8VmLOSbzJd06zsDbuZz+rGpoo8mUYgeoP
 LO4dBgtplNwLkNkSAsI5hGxlncMoxx7wpVKFODK4/ZkfLSP44IjbNmiU9jilItPNxTxz
 IfeRpd/Ni4aIoUU7DdLfCGlecgOhXPYqDAk4Pp8i1e7q+eKONjERpCK1zMyGE4zuPrbQ
 aH2zx9qTq0FPkS5H08BceOBlzovVb2prcQy1oWT3lFxBUvXpM3pHchvZxtO83ULBe6Vp
 OQrGMm67d3rQv2u8lQ2rynORfc3NS+n/ESviyzbK76aYu4u6yi/vKMv3GbHYeMHMa4vR
 Cfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777038047; x=1777642847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLOYpydKzXK5OxVrsM3Cabj7Lo2bQVnX65AABC5LhLM=;
 b=ooXGd1qJCbi0HoUm2hY+gBPK08uhDvOp5rG7jRHtjhsNW5VoqHE1N9w+fdIbSJP4zl
 EdgVWZZkR5vHDNmbLxhE2m4Y7ZI1ML8lSXDBEvp7h5nqYG1diA6t6JioVKq4nw+IQITC
 Bx6MZ7Tn5fzLa4GnIZUH4HyF9pwsecois+ZP4Upf8kUh/sizFYyN8ceAOaxexFkd9M12
 ZoDaogdvKlp6odt+ACJLvmLTT8pC4+/f2/+iLwztRhAVWvqrD+hvW6woOjNoH1CshHjz
 nzWxqq4qcC4eq+kSxlSyEkr3Bpm7gdb5VCsvH1yKsDV3RxbiAWaSiV9TlhHNa/TLgQa2
 Sf4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eMWX9JyLuachMSo7BwPLdbCSHgYC4AF5+GFYDUpwqTOzGakoOCYwTyQ1fPLfKiEEq/o324x61bnU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzB2oofykLTZus+Eym5vW89MkS2tcMTc0y9HlyABQD2H765SE43
 mgduL1EL9BW1yhovVjXsvP61KrdyDdCpUNhnFWtO6Bq+cFyuUYc6Db2YWd0IgdTnHOrkCFtquNg
 DJV84P/ljJy5bt66V7/XRjxFXHuD3nA==
X-Gm-Gg: AeBDies/nvA806aj9C2KhkUQ1AJcsd6Q8UKtsUuGPDhpv5cPecQybLVIbSMsTHkYbEc
 pGbobDle7HyaqqxZtt0OTs0dRIqn6E/YBeTmKykgZO3TY51kxc7VnQ+LnBDLJc3SmmtVr+rsxU3
 vIOopkt3VLcqQrhtmA5sAi1+y1hLpP3O7NNSzKy3psZjvhEUZTWhfDXOFBdkXllgfZvkif/Edhb
 o7P+Lbl/WSXugUz5wv87jzlyd3f0Ael4Yz3cN0tdVGYOHD2f8nHZ7xK/5UkzPChGaAOedSWqT4T
 s7RaFlc3/r1lP/xBL4/e6JQK9aKh5iquhNFP1AOBhlh9L3g=
X-Received: by 2002:a05:6402:31b9:b0:676:3bf4:7ce9 with SMTP id
 4fb4d7f45d1cf-6763bf47d9dmr6494515a12.3.1777038047137; Fri, 24 Apr 2026
 06:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260424123506.32275-1-mhun512@gmail.com>
 <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
In-Reply-To: <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 24 Apr 2026 22:40:35 +0900
X-Gm-Features: AQROBzDf3t3niaQvUFfXynj685lLsgCnqNKmpSpizPD0BY3KFr-rCuTk-Y3S_gA
Message-ID: <CAGEsz8FrkbQEWZbxV3Q0NkSxhQka575uemKMQtTJQaCm44ByxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Drop manual put on probe error path
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 virtualization@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000008d52b2065034e9e0"
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

--0000000000008d52b2065034e9e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thank you for your reply. I will ensure that the requested Fixes tag and
stable CC are included in the next patch I send.

Regarding your request for information about AI usage and how the issue was
identified:

   - This issue was identified during our ongoing static-analysis research
   while reviewing kernel code.
   1 <https://mail.google.com/mail/u/0/#all/%23thread-f:1863355320119932959=
>
   - Specifically, it was found by an experimental static analysis tool
   that we are currently developing. The tool is not public yet, so I prefe=
r
   not to disclose further project details at this stage.


   - AI was used only for cross-review, not as the primary means of finding
   or fixing the bug.
   - I manually reviewed the code and verified the issue before sending the
   patch.

I will incorporate your requests and this additional context, and then
resend the modified patch.

Thank you.

Myeonghun Pak


2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:25, =
Thomas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

> Hi,
>
> please add fixes tags to all these patches you're sending. You also need
> to CC stable so that they can be backported easily. Also list the AI
> you're using to find and create these patches.
>
> Best regards
> Thomas
>
> Am 24.04.26 um 14:34 schrieb Myeonghun Pak:
> > bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
> > which registers a devres action to drop the initial DRM device referenc=
e
> > on driver detach or probe failure.
> >
> > The error path currently calls drm_dev_put() manually. If probe then
> > returns an error, devres will run the registered release action and put
> > the same device again, after the first put may already have released it=
.
> >
> > Return the probe error directly and let devres own the final put.
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >   drivers/gpu/drm/tiny/bochs.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.=
c
> > index 222e4ae1ab..5d8dc5efec 100644
> > --- a/drivers/gpu/drm/tiny/bochs.c
> > +++ b/drivers/gpu/drm/tiny/bochs.c
> > @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent
> >
> >       ret =3D pcim_enable_device(pdev);
> >       if (ret)
> > -             goto err_free_dev;
> > +             return ret;
> >
> >       pci_set_drvdata(pdev, dev);
> >
> >       ret =3D bochs_load(bochs);
> >       if (ret)
> > -             goto err_free_dev;
> > +             return ret;
> >
> >       ret =3D drm_dev_register(dev, 0);
> >       if (ret)
> > -             goto err_free_dev;
> > +             return ret;
> >
> >       drm_client_setup(dev, NULL);
> >
> >       return ret;
> > -
> > -err_free_dev:
> > -     drm_dev_put(dev);
> > -     return ret;
> >   }
> >
> >   static void bochs_pci_remove(struct pci_dev *pdev)
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

--0000000000008d52b2065034e9e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);=
font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-variant-li=
gatures:no-contextual">Hi Thomas,</span><div class=3D"gmail-gWqWw gmail-rnc=
2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Robot=
o,Arial,sans-serif;font-variant-ligatures:no-contextual"><br></div><span cl=
ass=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google =
Sans&quot;,Roboto,Arial,sans-serif;font-variant-ligatures:no-contextual">Th=
ank you for your reply. I will ensure that the requested=C2=A0</span><code =
class=3D"gmail-dfqOJc" style=3D"display:inline-block;background-color:rgb(2=
21,227,234);border-radius:4px;color:rgb(68,71,70);padding:1px 4px;letter-sp=
acing:0.00625rem;line-height:1rem;font-family:&quot;Google Sans Mono&quot;,=
monospace;white-space:pre-wrap;margin:unset;font-variant-ligatures:no-conte=
xtual">Fixes</code><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31=
);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-variant-=
ligatures:no-contextual">=C2=A0tag and=C2=A0</span><code class=3D"gmail-dfq=
OJc" style=3D"display:inline-block;background-color:rgb(221,227,234);border=
-radius:4px;color:rgb(68,71,70);padding:1px 4px;letter-spacing:0.00625rem;l=
ine-height:1rem;font-family:&quot;Google Sans Mono&quot;,monospace;white-sp=
ace:pre-wrap;margin:unset;font-variant-ligatures:no-contextual">stable</cod=
e><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&qu=
ot;Google Sans&quot;,Roboto,Arial,sans-serif;font-variant-ligatures:no-cont=
extual">=C2=A0CC are included in the next patch I send.</span><div class=3D=
"gmail-gWqWw gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;G=
oogle Sans&quot;,Roboto,Arial,sans-serif;font-variant-ligatures:no-contextu=
al"><br></div><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);fon=
t-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-variant-ligat=
ures:no-contextual">Regarding your request for information about AI usage a=
nd how the issue was identified:</span><ul class=3D"gmail-gdAMzb" style=3D"=
color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-s=
erif;font-variant-ligatures:no-contextual"><li class=3D"gmail-rnc2Gd" style=
=3D"mask-repeat: no-repeat;"><span class=3D"gmail-rnc2Gd" style=3D"mask-rep=
eat: no-repeat;">This issue was identified during our ongoing static-analys=
is research while reviewing kernel code.</span><div class=3D"gmail-Wv1ane g=
mail-i03hic gmail-rnc2Gd" style=3D"display:inline;border-radius:28px"><a cl=
ass=3D"gmail-tOXXf" tabindex=3D"0" aria-label=3D"=EC=86=8C=EC=8A=A4 1=EB=B2=
=88=EC=9C=BC=EB=A1=9C =EC=9D=B4=EB=8F=99" href=3D"https://mail.google.com/m=
ail/u/0/#all/%23thread-f:1863355320119932959" target=3D"_blank" style=3D"le=
tter-spacing:0.00625rem;line-height:1rem;text-decoration:none;display:inlin=
e-flex;vertical-align:text-top;border-radius:28px;background-color:rgb(240,=
244,249);text-align:center;color:rgb(31,31,31)">1</a></div></li><li class=
=3D"gmail-rnc2Gd" style=3D"mask-repeat: no-repeat;"><span class=3D"gmail-rn=
c2Gd" style=3D"mask-repeat: no-repeat;">Specifically, it was found by an ex=
perimental static analysis tool that we are currently developing. The tool =
is not public yet, so I prefer not to disclose further project details at t=
his stage.</span></li></ul><ul class=3D"gmail-gdAMzb" style=3D"margin-block=
: 16px; padding-inline-start: 16px;"><li class=3D"gmail-rnc2Gd" style=3D"ma=
sk-repeat: no-repeat;"><span class=3D"gmail-rnc2Gd" style=3D"mask-repeat: n=
o-repeat;">AI was used only for cross-review, not as the primary means of f=
inding or fixing the bug.</span></li><li class=3D"gmail-rnc2Gd" style=3D"ma=
sk-repeat: no-repeat;"><span class=3D"gmail-rnc2Gd" style=3D"mask-repeat: n=
o-repeat;">I manually reviewed the code and verified the issue before sendi=
ng the patch.</span></li></ul><span class=3D"gmail-rnc2Gd" style=3D"mask-re=
peat: no-repeat;">I will incorporate your requests and this additional cont=
ext, and then resend the modified patch.<br><br>Thank you.<br><br>Myeonghun=
 Pak<br></span><div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"mask-repeat=
: no-repeat;"><font color=3D"#1f1f1f" face=3D"Google Sans, Roboto, Arial, s=
ans-serif" size=3D"3"><br></font></div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 =
4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:25, Thomas Zimmerm=
ann &lt;<a href=3D"mailto:tzimmermann@suse.de">tzimmermann@suse.de</a>&gt;=
=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi,<br>
<br>
please add fixes tags to all these patches you&#39;re sending. You also nee=
d <br>
to CC stable so that they can be backported easily. Also list the AI <br>
you&#39;re using to find and create these patches.<br>
<br>
Best regards<br>
Thomas<br>
<br>
Am 24.04.26 um 14:34 schrieb Myeonghun Pak:<br>
&gt; bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),<=
br>
&gt; which registers a devres action to drop the initial DRM device referen=
ce<br>
&gt; on driver detach or probe failure.<br>
&gt;<br>
&gt; The error path currently calls drm_dev_put() manually. If probe then<b=
r>
&gt; returns an error, devres will run the registered release action and pu=
t<br>
&gt; the same device again, after the first put may already have released i=
t.<br>
&gt;<br>
&gt; Return the probe error directly and let devres own the final put.<br>
&gt;<br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/tiny/bochs.c | 10 +++-------<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs=
.c<br>
&gt; index 222e4ae1ab..5d8dc5efec 100644<br>
&gt; --- a/drivers/gpu/drm/tiny/bochs.c<br>
&gt; +++ b/drivers/gpu/drm/tiny/bochs.c<br>
&gt; @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev,=
 const struct pci_device_id *ent<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pcim_enable_device(pdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_drvdata(pdev, dev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bochs_load(bochs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_dev_register(dev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_dev;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_client_setup(dev, NULL);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -<br>
&gt; -err_free_dev:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0drm_dev_put(dev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void bochs_pci_remove(struct pci_dev *pdev)<br>
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

--0000000000008d52b2065034e9e0--
