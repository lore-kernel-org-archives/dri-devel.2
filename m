Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D56C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B3D10E884;
	Mon, 28 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXC94Dln";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449ED10E1D5
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 22:25:09 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f55efe5so218415966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790375107; cv=none;
 d=google.com; s=arc-20260327;
 b=NX7Y/3mPv00CVxp0vmTE0KTEg+rXyKFsRnz1aXimuJkgaR8yKe3xPsB4lRk2+EH09m
 UX3ROjVsvZK7lJB9KZFga4ZHQJ6kWwA10vhwt12egMQdK7iOxHLEr2bRZfEMbJYWL+Fk
 1YPtebrC9ZEJansg3gBQRn4nBo3CoBbOXl9RYmFTJGl6ZU+gPR40QMNIcNUrO1jZ/jed
 h9qRjxu6kk9XxQ3QGU9jEy+JRTJa+LSdnGZCCmIJNUbs114r0npAx+75kiZ4dnUshK9/
 iQn8+7uhWwT+yFAVCVu41wxK8dSxqsPaG4ZlJZbmLIuwQIt301zNsIQBVwLhOpS/6eCo
 wOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xQ2iBZjllcn0cdKaDxZ05foMDqb4bzFuS9qMBmYuZTY=;
 fh=yPHlead+XDIWczVVgGSWkIzZoFJuIWngEoSCLXL51y0=;
 b=AAS5qte8fhAVzFcu05NK2c4cHvftngHp5IzK5f9YDleMgZmrQbN+IzxIqyIuiST6b+
 947VCfv+QWAG9H+lDS9h9ZyeyAD8XKu6fCyeVTAaDb7RClZMI4IZeaWP52auH7HJyQNO
 1SomXef1AJeluYIsXvu0wErAaDiYVNd+8hQ9Glzim6gsW3LLs5jPklQ5Vsl1gZ3b7UM8
 0RCbfrlOqzJUIZSQgYa/G8Og6eADad9wRfj0QGB9Fnijn7jw3DEPh/ZNFsIGDYn/8LBN
 auz0u42I2rGc5607jYZdQAXbwn5fJO0nEr+C6DzFqLbsUrsgHYq3VgVD9meK7EHhV8ZO
 wDdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790375107; x=1790979907; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xQ2iBZjllcn0cdKaDxZ05foMDqb4bzFuS9qMBmYuZTY=;
 b=gXC94Dlnd12j/kUEBDBh99CKIYQRnFd9at17c30P0Z//ifbraELqaLq34UIEehu6SC
 3lNEj3t2DPT78ooLzB87uYtdZazu5crBKjRGda5Bck1LzVm4/CjtIZXcEZ1ERvo9cbSx
 R2GpHuE+enmljYiPepKcJxEKjTqB0hIflUy7mBVKOH8H1kIZhYGzdYKrDwxzUrEHokrS
 smNW5af0PR5rupZfvoOhpx615rD6hMDqsOIBORoKH0V/j53ygbw80LuMGP26L3WgIm/d
 tbpLth+yar1EXzYcrXU09V2chRTtNsVbdHOR/W4EO696vjJsjZtlzAVfWnv/ZIjdYKux
 InWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790375107; x=1790979907;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xQ2iBZjllcn0cdKaDxZ05foMDqb4bzFuS9qMBmYuZTY=;
 b=Juz8/FVgyZElEVBbzyBOE8vdyZRRXlfgiVYJ2+bnGqm/+1EpDgSZNsMwGhbwFatc2p
 ll/PqyzfuJ5h7OCQ4yNV/ehZC05X02cKeCMQKHO0umlwgwiAsZqbmSdJ+SMVRgWC0026
 q9FILDILOjipCM+FkjN14UdGI39iKh9b7gg4C3rktBRBE+zefNCTFekqu8yPd0H87Ekx
 AmsPQwaQ0QiasakirwHTq47yHeghHb9ToXIySrYKvuegV6ZTnHb307SOXSxw9jZmGy7s
 cqCZD6h5reeTIzg4EmUn/N1xnaA/Y91bFtCi+RrP2JTW3+n5zOzZn0WPJvkNr098HpX3
 UpyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx33O06kuwGCCQWgR5SWsT4E+BDyYKZg+rzzrwVHk/mQeiW4MrHBwxYvI8mxzQtEXW1JSGJp1/feNg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0JYYgt7YBGjOXhaH2yibBFeVbitAPpHXtu2AbEvkby7RglqWi
 IWQv39w/LQA9gy/NZDJpPVR1rAdXlOTLrEbY1lgbMxKcSjN0cgL3ctnoBiV8+mESGwaGtiwmjkC
 jfGkZVgYncGUcnp7UdFTiKly7c8n23yA=
X-Gm-Gg: AYBFou2TpX4XGSBTDOIV1IRHW+qHKYgn3r/4xiYg6LYjhDOXDhqE2aaxqcLgbuMbOXg
 RA9d9Ma4UqgpUQAenysBUG91RqrqCoYDMeNx+fgbL/ytU7k/Fk5x/Kpws+3wKCO3zyfolbF+cu5
 ToPfpxRq2wClGwo8gnW9wqxc4jvlV35kUCQPeb4BvXIs13HEjsJNNrhlQpbdwze1BOqG3FFxcpO
 zcAvQmJG80mkkvbCXSzDibT3P8zEaUzH5NvWJO0fk5JbniNpGBM15Q3nVKw0b4+eMD6xr1NrPel
 U2s7RkxVf4/v0WUocn8oIjGFbn+H8Taag50V5YBho5v3Dva8QyfJ
X-Received: by 2002:a17:907:86a5:b0:c29:5af0:3b44 with SMTP id
 a640c23a62f3a-c2ac251e640mr628131566b.41.1790375107299; Fri, 25 Sep 2026
 15:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072444.18982-1-ayhancicek@gmail.com>
 <CADnq5_PWzO-UqBJgduTy-X7bYnxSJyBZxL0TcsBue3S9cWyTUw@mail.gmail.com>
In-Reply-To: <CADnq5_PWzO-UqBJgduTy-X7bYnxSJyBZxL0TcsBue3S9cWyTUw@mail.gmail.com>
From: =?UTF-8?B?QXloYW4gw4dpY2Vr?= <ayhancicek@gmail.com>
Date: Sat, 26 Sep 2026 01:24:31 +0300
X-Gm-Features: AclHuK8B5LiZidiPdKYhiISXgdT5Ar_79Y0LOr08gaC6VjB8HChm3j-ANkVrGCE
Message-ID: <CAL556cf0rbxePZ9m-W81SOx+aX27Csc6x52QYdJypoX1pJQcsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/alternative; boundary="000000000000490dad065c5630e8"
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

--000000000000490dad065c5630e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that approach makes sense and looks cleaner than handling
individual ASICs.
I'll test the attached generic patch on the affected MacBookPro11,5 with
the Radeon R9 M370X (VERDE), with the hardware cursor enabled.
I'll verify that the original symptoms do not return and that the kernel no
longer reports:
DC: Cursor address is 0!
DC failed to set cursor attributes
I'll report back with the test results and add my Tested-by if everything
works as expected.
Thanks,
Ayhan


Alex Deucher <alexdeucher@gmail.com>, 25 Eyl 2026 Cum, 16:19 tarihinde =C5=
=9Funu
yazd=C4=B1:

> On Fri, Sep 25, 2026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek <ayhancicek=
@gmail.com> wrote:
> >
> > The existing MacBook workaround reserves VRAM at address 0 for
> > Polaris ASICs when the iGPU is enabled. This prevents cursor
> > allocations from landing at address 0.
> >
> > A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
> > failure mode. Hardware cursor updates repeatedly log
> > "DC: Cursor address is 0!" followed by
> > "DC failed to set cursor attributes".
> >
> > Extend the existing workaround to CHIP_VERDE. With this change,
> > hardware cursor operation is stable, the cursor errors remain at
> > zero during repeated cursor movement, and cursor disappearance
> > and flicker are no longer observed.
>
> Sounds like this may be consistent for most or all Macs.  How about
> something like the attached patch?
>
> Alex
>
> >
> > Signed-off-by: Ayhan =C3=87i=C3=A7ek <ayhancicek@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 1bf2a42fa..9e7f9cc2b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct
> amdgpu_device *adev)
> >         case CHIP_RENOIR:
> >                 adev->mman.keep_stolen_vga_memory =3D true;
> >                 break;
> > +       case CHIP_VERDE:
> >         case CHIP_POLARIS10:
> >         case CHIP_POLARIS11:
> >         case CHIP_POLARIS12:
> > --
> > 2.55.0
> >
>


--=20


Ayhan =C3=87=C4=B0=C3=87EK
Software Architect

+90 532 291 21 62
http://www.ayhancicek.com

--000000000000490dad065c5630e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks, that approach makes sense and loo=
ks cleaner than handling individual ASICs.<br>I&#39;ll test the attached ge=
neric patch on the affected MacBookPro11,5 with the Radeon R9 M370X (VERDE)=
, with the hardware cursor enabled.<br>I&#39;ll verify that the original sy=
mptoms do not return and that the kernel no longer reports:<br>DC: Cursor a=
ddress is 0!<br>DC failed to set cursor attributes<br>I&#39;ll report back =
with the test results and add my Tested-by if everything works as expected.=
<br>Thanks,<br>Ayhan</div><div dir=3D"ltr"><br></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Alex D=
eucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</=
a>&gt;, 25 Eyl 2026 Cum, 16:19 tarihinde =C5=9Funu yazd=C4=B1:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 25, 2026 at 3:46=
=E2=80=AFAM Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancicek@gmail.co=
m" target=3D"_blank">ayhancicek@gmail.com</a>&gt; wrote:<br>
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
gmail.com" target=3D"_blank">ayhancicek@gmail.com</a>&gt;<br>
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
k.com/" target=3D"_blank">http://www.ayhancicek.com</a></font></div><div><b=
r></div><div><br></div></div></div></div></div></div></div></div>

--000000000000490dad065c5630e8--
