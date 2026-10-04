Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABD3CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1619410EAFF;
	Sun,  4 Oct 2026 17:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p2lnEFrf";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD4710E034
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 05:56:49 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so158549866b.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 22:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791093408; cv=none;
 d=google.com; s=arc-20260327;
 b=IGGvJub8dij7/f1KUG0UD4tSG+UHiHfhM0kG8PC6xINtR58FQ7eZOdA3VkklJ3CQV7
 rVFn0BeAsQXuEyQHFMyY6/SJhbkcxx5xdkXGucFG8q5x+RCWkHOG2m5mUPKPN2yShc3L
 ExhfE8vob2Z4ocHcO35dg7Il2wPjtrFJzGWJvUSuNy+aC92ikJY3E6dSIGjlju45U8zI
 g9E8XpS87+CIWQbQhlTjAtHR3PI/jijjutH7L3yfc86IvzSBXM86qbeAWjb/opNzB48Y
 LnKq2mY1RBvbTcMM/bP3Cki7T92v1c59oqqTPnJ1yJRsLdeQ+h3XoDqMLe9MhiGE0ZDu
 gPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 fh=4nk+9A2+Qp+rTJ3RQ0JpkjXxKhckliI8xXTZ1ITe0fg=;
 b=A2yIaTvuX+LSNp54p++pURz4x1xc0vSiwkddG+0wueOEqlIpBVzVaPIC1HpbkeADt9
 U5bZU0IKg2L9iNQzJpc4ywtltQRb4G46Ezx8n9rye+GvvhKhI/2Mp2aHnc7u6JN8aMY7
 XMQDXEv0M+b465tWTY4DjPUUVAnc0Br8rF+iB1KZSenqBcS1h2dTqg3ZpipgyQf002gh
 OJ//BEGISvNpPaexQ6PEYTvvYjYS1+g/Z9OV/dJZPs4xL4zMy7p607TlenWPZ0ZQlCLX
 ikm6Hc1IiA7GnWdx4l1nLIRIc2/83FFdWcdqKaLXSsfsphMX/7Ci/kKQKpo1eUMOqVib
 lpeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791093408; x=1791698208; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 b=p2lnEFrf+iHZf703HhSiYO6BpGUVBjxWvWJy9AyATz8VwX7k5nbRg+NBdEZiN2IICA
 /GDLjvu0Dz9IHhfAGmJuHonkS/m/GGzl3Fe7flxuRQmJ7Jk9cQuHOglNWcdlx8rzRRFu
 85Su2Y9z/oBZThsF7J2FD29+QoPhnNEJqjaTR+WIIGaWOqVXYHALlK4KxPeFi/ryoagu
 GjK1wuc80Ab/0J0ZDWc/UCFjihpobjtYvGRxiHV3qcfyTX5ZBP5gMIJh455NeFPu7dln
 tZd6xqMYJzxWl6PwFaiMklsGXjw5ejgKRZYT75YpW/UO+NoknZ8fmDgKhtxPKVXG2Fwo
 ZyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791093408; x=1791698208;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 b=vzxh7xUDloLcg16ivEILsRxOoX1cPuXTtsw1fDwMBwOPH/hbM4AJOZeiYt5LJTgmhP
 uwoVv9qNoSmEgEZTl5uiZZF2oiFkRe84o4+qWRZqTgroqQ+vEHAhl9GN67tWVHKKOeuK
 q7qSm6o3Bpv8F8+axNBLkTHYip71jnLW0slBwvq+oxocNdsv60/+pIXdom65Dt/49DHh
 vgW5zzfBxHgsCzMmZpZ5PCSTYFZTZFKV7GuIufTIMKTLHXOSQ0VcgSN/jdkNZij6AJtN
 ORlqJiZEYTc7jzHVFdU2Ff/zXrBY1RjoFHctC1bZxqSKlI0LURjtovJK271pJTOi1Yhs
 x6bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5ZL3XDwxbJdqjXDmwVEM0pGwM77NyAV/oLF2hko8VWr9uN2zA1W9STI6FhZ2kqYSdxk/ecIo3UEM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHQT1MwT+BcYB3nHY6z38y/gedDMfuXh8FHeunEQg9/zyUaski
 9RFuqVB8ZcDwnQm8mp01hl6Mu4T64kpl6SwfnusPXdwkpKZp9LZj6DG5wknHoRnlyg9sFzsmZ8Z
 GCX6fKZmcujD+2Y8NL1lpHLaQgFXE/co=
X-Gm-Gg: AYBFou2ITJHe4b7WKg06d4OAgRA6f0ZkbA0JNeOyc7gvRwxFofKvYvhtE6HPqo/gUnk
 u60cUfvzBhJrPKL+ZY6b9BxbCUPsUgrWaIlzKLaAag9h/BvuRshET0+SsSCLGpWTn5fz2YIKV2Q
 hqRTCIwSlBntq0NPyaza4dtzQDZ8mlPurCdCZpGstCi6mxeIK1icgdQmilRKf0RyqEJKesKRM+E
 zVPE6H9N2HvvNbeQjGZuiJRYi6JC5tWgssdn86YRjscoba//cr/iWJKuPsj+QI3jttB1Uluyv3a
 Y/4O1Iyu1EXbacUK9eUYR0vsMpSlkA2O7DB8nQvzo4IE2NPqlC7iGA==
X-Received: by 2002:a17:907:96aa:b0:c2e:3d17:5259 with SMTP id
 a640c23a62f3a-c2e6ee1df6emr328319766b.41.1791093408045; Sat, 03 Oct 2026
 22:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072444.18982-1-ayhancicek@gmail.com>
 <CADnq5_PWzO-UqBJgduTy-X7bYnxSJyBZxL0TcsBue3S9cWyTUw@mail.gmail.com>
 <CAL556cf0rbxePZ9m-W81SOx+aX27Csc6x52QYdJypoX1pJQcsw@mail.gmail.com>
In-Reply-To: <CAL556cf0rbxePZ9m-W81SOx+aX27Csc6x52QYdJypoX1pJQcsw@mail.gmail.com>
From: =?UTF-8?B?QXloYW4gw4dpY2Vr?= <ayhancicek@gmail.com>
Date: Sun, 4 Oct 2026 08:56:36 +0300
X-Gm-Features: AclHuK8_p_i8K0raFZJ_C1DkTmqdNHoAVP46Ee6Q_RDueJhQThA6Rg8WdkJz7eA
Message-ID: <CAL556ccbh2w-dyoxodM+CAnVoL3er=HpR79_jzdQgjAHgVimPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/alternative; boundary="000000000000589c98065cfd6e67"
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

--000000000000589c98065cfd6e67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delayed response. I wasn=E2=80=99t able to test the patch
immediately because I had surgery, so it took me a little longer than
expected to get back to this. Thank you for your
patience.

I tested the generic patch on the affected MacBookPro11,5 with a
Radeon R9 M370X (VERDE).

The test was performed with the hardware cursor enabled and without
the Mutter software-cursor workaround.
Before and after repeated cursor movement, the kernel log remained at
zero occurrences of:
DC: Cursor address is 0!
DC failed to set cursor attributes

I also did not observe any cursor disappearance, flickering, or
instability during testing.

The generic patch appears to fix the issue on this hardware.
Tested-by: Ayhan =C3=87i=C3=A7ek ayhancicek@gmail.com


Thanks,
Ayhan


26 Eyl 2026 Cmt 01:24 tarihinde Ayhan =C3=87icek <ayhancicek@gmail.com> =C5=
=9Funu
yazd=C4=B1:

> Thanks, that approach makes sense and looks cleaner than handling
> individual ASICs.
> I'll test the attached generic patch on the affected MacBookPro11,5 with
> the Radeon R9 M370X (VERDE), with the hardware cursor enabled.
> I'll verify that the original symptoms do not return and that the kernel
> no longer reports:
> DC: Cursor address is 0!
> DC failed to set cursor attributes
> I'll report back with the test results and add my Tested-by if everything
> works as expected.
> Thanks,
> Ayhan
>
>
> Alex Deucher <alexdeucher@gmail.com>, 25 Eyl 2026 Cum, 16:19 tarihinde
> =C5=9Funu yazd=C4=B1:
>
>> On Fri, Sep 25, 2026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek <ayhancice=
k@gmail.com> wrote:
>> >
>> > The existing MacBook workaround reserves VRAM at address 0 for
>> > Polaris ASICs when the iGPU is enabled. This prevents cursor
>> > allocations from landing at address 0.
>> >
>> > A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
>> > failure mode. Hardware cursor updates repeatedly log
>> > "DC: Cursor address is 0!" followed by
>> > "DC failed to set cursor attributes".
>> >
>> > Extend the existing workaround to CHIP_VERDE. With this change,
>> > hardware cursor operation is stable, the cursor errors remain at
>> > zero during repeated cursor movement, and cursor disappearance
>> > and flicker are no longer observed.
>>
>> Sounds like this may be consistent for most or all Macs.  How about
>> something like the attached patch?
>>
>> Alex
>>
>> >
>> > Signed-off-by: Ayhan =C3=87i=C3=A7ek <ayhancicek@gmail.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > index 1bf2a42fa..9e7f9cc2b 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct
>> amdgpu_device *adev)
>> >         case CHIP_RENOIR:
>> >                 adev->mman.keep_stolen_vga_memory =3D true;
>> >                 break;
>> > +       case CHIP_VERDE:
>> >         case CHIP_POLARIS10:
>> >         case CHIP_POLARIS11:
>> >         case CHIP_POLARIS12:
>> > --
>> > 2.55.0
>> >
>>
>
>
> --
>
>
> Ayhan =C3=87=C4=B0=C3=87EK
> Software Architect
>
> +90 532 291 21 62
> http://www.ayhancicek.com
>
>
>

--000000000000589c98065cfd6e67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Apologies=C2=A0for=C2=A0the=C2=A0delayed=C2=A0respon=
se.=C2=A0I=C2=A0wasn=E2=80=99t=C2=A0able=C2=A0to=C2=A0test=C2=A0the=C2=A0pa=
tch=C2=A0immediately=C2=A0because=C2=A0I=C2=A0had=C2=A0surgery,=C2=A0so=C2=
=A0it=C2=A0took=C2=A0me=C2=A0a=C2=A0little=C2=A0longer=C2=A0than=C2=A0expec=
ted=C2=A0to=C2=A0get=C2=A0back=C2=A0to=C2=A0this.=C2=A0Thank=C2=A0you=C2=A0=
for=C2=A0your patience.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I=C2=A0tested=C2=A0the=C2=A0generic=C2=A0patch=C2=A0on=C2=A0the=C2=A0affect=
ed=C2=A0MacBookPro11,5=C2=A0with=C2=A0a=C2=A0Radeon=C2=A0R9=C2=A0M370X=C2=
=A0(VERDE).</div><div dir=3D"auto"><br></div><div dir=3D"auto">The=C2=A0tes=
t=C2=A0was=C2=A0performed=C2=A0with=C2=A0the=C2=A0hardware=C2=A0cursor=C2=
=A0enabled=C2=A0and=C2=A0without=C2=A0the=C2=A0Mutter=C2=A0software-cursor=
=C2=A0workaround.</div><div dir=3D"auto">Before=C2=A0and=C2=A0after=C2=A0re=
peated=C2=A0cursor=C2=A0movement,=C2=A0the=C2=A0kernel=C2=A0log=C2=A0remain=
ed=C2=A0at=C2=A0zero=C2=A0occurrences=C2=A0of:</div><div dir=3D"auto">DC:=
=C2=A0Cursor=C2=A0address=C2=A0is=C2=A00!</div><div dir=3D"auto">DC=C2=A0fa=
iled=C2=A0to=C2=A0set=C2=A0cursor=C2=A0attributes</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">I=C2=A0also=C2=A0did=C2=A0not=C2=A0observe=C2=A0a=
ny=C2=A0cursor=C2=A0disappearance,=C2=A0flickering,=C2=A0or=C2=A0instabilit=
y=C2=A0during=C2=A0testing.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">The=C2=A0generic=C2=A0patch=C2=A0appears=C2=A0to=C2=A0fix=C2=A0the=C2=
=A0issue=C2=A0on=C2=A0this=C2=A0hardware.</div><div dir=3D"auto">Tested-by:=
=C2=A0Ayhan=C2=A0=C3=87i=C3=A7ek=C2=A0<a href=3D"mailto:ayhancicek@gmail.co=
m">ayhancicek@gmail.com</a></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Ayhan</div><=
div><br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">26 Eyl 2026 Cmt 01:24 tarihinde Ayhan =
=C3=87icek &lt;<a href=3D"mailto:ayhancicek@gmail.com">ayhancicek@gmail.com=
</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr">Thanks, that approach makes sense and looks c=
leaner than handling individual ASICs.<br>I&#39;ll test the attached generi=
c patch on the affected MacBookPro11,5 with the Radeon R9 M370X (VERDE), wi=
th the hardware cursor enabled.<br>I&#39;ll verify that the original sympto=
ms do not return and that the kernel no longer reports:<br>DC: Cursor addre=
ss is 0!<br>DC failed to set cursor attributes<br>I&#39;ll report back with=
 the test results and add my Tested-by if everything works as expected.<br>=
Thanks,<br>Ayhan</div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexdeucher@=
gmail.com</a>&gt;, 25 Eyl 2026 Cum, 16:19 tarihinde =C5=9Funu yazd=C4=B1:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 25, 2=
026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancic=
ek@gmail.com" target=3D"_blank" rel=3D"noreferrer">ayhancicek@gmail.com</a>=
&gt; wrote:<br>
&gt;<br>
&gt; The existing MacBook workaround reserves VRAM at address 0 for<br>
&gt; Polaris ASICs when the iGPU is enabled. This prevents cursor<br>
&gt; allocations from landing at address 0.<br>
&gt;<br>
&gt; A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same<br>
&gt; failure mode. Hardware cursor updates repeatedly log<br>
&gt; &quot;DC: Cursor address is 0!&quot; followed by<br>
&gt; &quot;DC failed to set cursor attributes&quot;.<br>
&gt;<br>
&gt; Extend the existing workaround to CHIP_VERDE. With this change,<br>
&gt; hardware cursor operation is stable, the cursor errors remain at<br>
&gt; zero during repeated cursor movement, and cursor disappearance<br>
&gt; and flicker are no longer observed.<br>
<br>
Sounds like this may be consistent for most or all Macs.=C2=A0 How about<br=
>
something like the attached patch?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Signed-off-by: Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancicek@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">ayhancicek@gmail.com</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 1bf2a42fa..9e7f9cc2b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct amd=
gpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_RENOIR:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;=
mman.keep_stolen_vga_memory =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_VERDE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS10:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS11:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS12:<br>
&gt; --<br>
&gt; 2.55.0<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><br><div><font size=3D"2"><br><font face=3D"verd=
ana, sans-serif" color=3D"#444444">Ayhan =C3=87=C4=B0=C3=87EK<br>Software A=
rchitect</font></font><div><font color=3D"#444444" face=3D"verdana, sans-se=
rif" size=3D"2"><br></font><div><font face=3D"verdana, sans-serif" color=3D=
"#444444" size=3D"2">+90 532 291 21 62</font><div><div><font face=3D"verdan=
a, sans-serif" color=3D"#444444" size=3D"2"><a href=3D"http://www.ayhancice=
k.com/" target=3D"_blank" rel=3D"noreferrer">http://www.ayhancicek.com</a><=
/font></div><div><br></div><div><br></div></div></div></div></div></div></d=
iv></div>
</blockquote></div>

--000000000000589c98065cfd6e67--
