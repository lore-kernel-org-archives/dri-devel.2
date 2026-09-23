Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024DC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB13610EE1E;
	Wed, 23 Sep 2026 12:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="buEj45uu";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4509E10EFDC
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:07:00 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43daa8f4so8549017b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165219; cv=none;
 d=google.com; s=arc-20260327;
 b=M3Rs8Dbsd+FrQXKWu3WIiMpjzhc1cD5UsQXruW4WdARRZH1xxER2gKUMOx2F14WRH3
 xsBRl4vAGGjopSk2yO0bLpR/tqC0qWO0lIiXKQ+WfiRlOgKxeG1YMDgGtfYWBdl6jVKF
 k2H/INUqzzTHPtF39IxLe/WLvPDr6+LHfBQBoDXR63lW3//REu0vyulnzol6upL75z7l
 F8+sCy+4BbxCiWMYNug++zTUFzHrQF5f/AEqynMSrjv74N+YbWn4KNxzPj0wPPJYWXQe
 DJaFl5K9FmqXZcvwn9npZ1kIpiheDJY0QDpypkNFs5GlV9NnEa1O/IronQho2bP/8uZt
 GtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=APoEacy14/RcB+dD0OIwIvaiR0VzuetbtQ0vQ49RIjk=;
 fh=2Q6NLzf6I/xOJHH4GZzze0Z+k3plONFrmQTC6MoZG2M=;
 b=kVPoxfGkx0uy1N0s233miSFo3o3gHQz+vz3Fzrj/ju0ruW0FpSOzkRlONFQgaVIJo7
 7piFQ88+1nuws+lviFG9y6kZ+yzfe7D1UbWIyMyIsmXjwse5+MKmG/pJ5a+BAxlVq4NM
 XLlqdL5bhIQ8E5cvpsBAvppUS85ZXX3cigi5t1z5q+zNUwyXyKNGfPOrB44V5vHKgRu9
 5gKqSC6Q0G/154rr0Y6QWf628uFMKvYuuIq3dHx09s7hLTCGFKhWXs+WNd6+pXAA5jOr
 M7Bq1cQ6ydHa6nkG9PuJeMpg6bBX/+p60Bz2s6kAVk48wPxWJtBgTh5cF8E8GE/XkQHx
 a2Bg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790165219; x=1790770019; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=APoEacy14/RcB+dD0OIwIvaiR0VzuetbtQ0vQ49RIjk=;
 b=buEj45uuKhklxqrHuBbqWYV19sKiq5VDvpa1GEjZzocrCybqFolWwsnpU/6LF1LhnK
 +ododvLd24HJ0QNJae4GdEkbzgFotMx6AK6MCJJNwZDkkh4CSeb1G2pDdFRMEh8GcRkJ
 XC8dTIqF8yXn7HHuNm4dgru5CPHitb050lP+bpnFLAUvSZHiCLSXhu7gauJrod+OMBPM
 uE/6wIK1Fom75quWa66aBjTV8VPm4f99Q/OWgwG0MznLdWIqcq2ArjTyhFAJR1NmAYKb
 7EykdMx58OgP/+u0eG9g9x1etROw0AwtdF1xavZwstxB1AarKWmMPKybXOAZn2TY8cky
 LJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165219; x=1790770019;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APoEacy14/RcB+dD0OIwIvaiR0VzuetbtQ0vQ49RIjk=;
 b=yTh4iinxuCKjnWsIUoHcW9d91GMj/mo4/VkxMgAmfJtwh5S7D125wrGWO25b1SWb88
 q7FjBZOhZzrAHwagMwXRqyxlu6m8UorZInqUz+fCAFMA+97qm6Wx74q1chWDRORoq5N/
 TfzQM1sOfW/8Ss27RjgkVoX6skxzp/MCDQJUww3EZ0Nie2iXgDXOWCvmOCuUlKhvStpt
 YKr5fh2XAkAkNH2ubJOeQrHM/N0jUnorORNV/vb4sSdDt27EYqn4M4Z2ZjXBo5fBL3pX
 3sTEFpToQ/hvvKfN6G1lqPmSYP6suaASrYZy8uLx6vx0iHo4uins7zcI/qSyEtuWOTPI
 U8gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6gkhRq8TzaDJhxx08esfItS7Om3NtHMJFbtndl4SZeYKkJg/ZsyGat+HPKKzLzPRIeQARBbsp6X4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuLBORrQ1RO3Dekg8//Y+io7BzOhORCn5qN1pRpKrbNs19SccJ
 oFykIM+ig6DdgoPpwsKGT1MhwEft/dKmAe/M8i27OFrMgqXPjLf2kXi7J2UCDOburbACU2dCMvW
 51u5V8lAUXiQ+qDMtVKRuoLrbBIjVt6w=
X-Gm-Gg: AYBFou0d5MHF/hnPu8jcY1DnhKyk732DESBV4XN5ZuwnrWSFf9OrvvqIHSeOF2QETgc
 5UGg2S1r6SAnHh36EUgPCe4SPqfo1FYO0Y5v0CXS9r9s8+8gt5UGyjIwGq4yel/8CHL1MpufiET
 nYa0qgNR+rB8FVfMhd9eGcrJ5KzIpmPMaBoqnA3k+fVyfRcfhOqB3Zzc6bfYxMdHfNpKs/jD00U
 phwm42IPtumICAtwbXhf+tGGsL0qMNQtlWQhBDok88A3tZAkNnNdWkOwD7AfPFTEcErw53FlBOM
 fY7JRKoYBdNZXMIpfVpith8DuDNjiTIScCKV8NE975s+4lVfSTmLQkrwnwcEaJl2cDCPOIGOsbd
 GPlJ3bMN7XfpSSjMe2A==
X-Received: by 2002:a05:690e:439b:b0:672:99e1:11c9 with SMTP id
 956f58d0204a3-672d58eb1e6mr658555d50.102.1790165219011; Wed, 23 Sep 2026
 05:06:59 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:06:58 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:06:57 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260809002621.122832-1-qwe.aldo@gmail.com>
References: <20260809002621.122832-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 05:06:58 -0700
X-Gm-Features: AclHuK9pIfCdKgvAbV1br7WXHlzvcxNwSIlWxPPSsitZqejiYRQyXluY0dEHEKA
Message-ID: <CAP48HfvSRsV6Z3YaMsii=VRgYAL8Bf6v_5GdV9R-Z-LDavrbfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
To: airlied@redhat.com, kraxel@redhat.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000f7f1ab065c25513e"
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

--000000000000f7f1ab065c25513e
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Gerd,

Gentle ping on this v2 -- it has been sitting for ~6 weeks.
The fix promotes the backing-size computation to u64 to prevent the
modulo-2^32 wrap that lets userspace create a surface whose declared
size vastly exceeds its backing allocation.

Is there anything else needed, or can this go into drm-misc-fixes?

Thanks,
Aldo

On Sat, Aug 08, 2026 09:26 PM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> qxl_alloc_surf_ioctl() works out the backing size of a surface with
>
>         actual_stride = param->stride < 0 ? -param->stride : param->stride;
>         size = actual_stride * param->height + actual_stride;
>
> where size and actual_stride are int and param->height is __u32.  Every
> operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,
> which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no
> overflow check.
>
> The wrapped value is what reaches qxl_bo_create(), which only rounds it
> up to a page.  The original width, height and stride are kept verbatim
> in bo->surf and are later handed to the device by qxl_hw_surface_alloc()
> together with the address of that undersized allocation, so the driver
> tells the host about a surface far larger than the memory backing it.
>
> For example stride=4096, height=1048576 gives
> 4096 * (1048576 + 1) = 0x1_0000_1000, which truncates to 4096: a
> one-page buffer object described to the device as a 4 GiB surface.
> Measured on 6.12.101 by probing mmap() lengths against the resulting
> GEM object, the backing is 4096 bytes while the surface declared to the
> device is 4294967296 bytes.
>
> Two smaller problems are fixed at the same time.  Negating param->stride
> is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of
> a zero-sized request.
>
> Compute the size in u64, which cannot wrap for the u32 inputs, reject
> INT_MIN and zero dimensions, and bound the result so it still fits the
> int parameter of qxl_gem_object_create().
>
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2: compute the size in u64 instead of size_t, so the (height + 1)
>     addition cannot wrap on 32-bit either (reported by Sashiko AI review);
>     the v1 <linux/overflow.h> include is no longer needed.
>
>  drivers/gpu/drm/qxl/qxl_ioctl.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c
> b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index cd1901d5c7c0..75abfc1db0f5 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -385,12 +385,24 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev,
> void *data, struct drm_file *fi
>         struct drm_qxl_alloc_surf *param = data;
>         int handle;
>         int ret;
> -       int size, actual_stride;
> +       int actual_stride;
> +       u64 size;
>         struct qxl_surface surf;
>
>         /* work out size allocate bo with handle */
> +       if (param->stride == INT_MIN)
> +               return -EINVAL;
>         actual_stride = param->stride < 0 ? -param->stride : param->stride;
> -       size = actual_stride * param->height + actual_stride;
> +       if (!actual_stride || !param->width || !param->height)
> +               return -EINVAL;
> +       /*
> +        * size = actual_stride * (height + 1), computed in u64 so it
> cannot
> +        * wrap on any architecture, then bounded so it still fits the int
> +        * parameter of qxl_gem_object_create().
> +        */
> +       size = (u64)actual_stride * ((u64)param->height + 1);
> +       if (size > INT_MAX)
> +               return -EINVAL;
>
>         surf.format = param->format;
>         surf.width = param->width;
> --
> 2.43.0
>
>

--000000000000f7f1ab065c25513e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Dave, Gerd,<br><br>Gentle ping on this v2 =
-- it has been sitting for ~6 weeks.<br>The fix promotes the backing-size c=
omputation to u64 to prevent the<br>modulo-2^32 wrap that lets userspace cr=
eate a surface whose declared<br>size vastly exceeds its backing allocation=
.<br><br>Is there anything else needed, or can this go into drm-misc-fixes?=
<br><br>Thanks,<br>Aldo</div></body></html><br><div class=3D"gmail_extra"><=
div>On Sat, Aug 08, 2026 09:26 PM, Aldo Ariel Panzardo &lt;<a href=3D"mailt=
o:qwe.aldo@gmail.com">qwe.aldo@gmail.com</a>&gt; wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">qxl_alloc_surf_ioctl() works out the backing size of a surfa=
ce with<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_stride =3D param-&gt;stride &lt; 0 ? -pa=
ram-&gt;stride : param-&gt;stride;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D actual_stride * param-&gt;height + act=
ual_stride;<br>
<br>
where size and actual_stride are int and param-&gt;height is __u32.=C2=A0 E=
very<br>
operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,<br>
which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no<br>
overflow check.<br>
<br>
The wrapped value is what reaches qxl_bo_create(), which only rounds it<br>
up to a page.=C2=A0 The original width, height and stride are kept verbatim=
<br>
in bo-&gt;surf and are later handed to the device by qxl_hw_surface_alloc()=
<br>
together with the address of that undersized allocation, so the driver<br>
tells the host about a surface far larger than the memory backing it.<br>
<br>
For example stride=3D4096, height=3D1048576 gives<br>
4096 * (1048576 + 1) =3D 0x1_0000_1000, which truncates to 4096: a<br>
one-page buffer object described to the device as a 4 GiB surface.<br>
Measured on 6.12.101 by probing mmap() lengths against the resulting<br>
GEM object, the backing is 4096 bytes while the surface declared to the<br>
device is 4294967296 bytes.<br>
<br>
Two smaller problems are fixed at the same time.=C2=A0 Negating param-&gt;s=
tride<br>
is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of<br>
a zero-sized request.<br>
<br>
Compute the size in u64, which cannot wrap for the u32 inputs, reject<br>
INT_MIN and zero dimensions, and bound the result so it still fits the<br>
int parameter of qxl_gem_object_create().<br>
<br>
Fixes: f64122c1f6ad (&quot;drm: add new QXL driver. (v1.4)&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
v2: compute the size in u64 instead of size_t, so the (height + 1)<br>
=C2=A0 =C2=A0 addition cannot wrap on 32-bit either (reported by Sashiko AI=
 review);<br>
=C2=A0 =C2=A0 the v1 &lt;linux/overflow.h&gt; include is no longer needed.<=
br>
<br>
=C2=A0drivers/gpu/drm/qxl/qxl_<wbr>ioctl.c | 16 ++++++++++++++--<br>
=C2=A01 file changed, 14 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c b/drivers/gpu/drm/qxl/qxl=
_ioct<wbr>l.c<br>
index cd1901d5c7c0..75abfc1db0f5 100644<br>
--- a/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c<br>
+++ b/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c<br>
@@ -385,12 +385,24 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_qxl_alloc_surf *param =3D data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int handle;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int size, actual_stride;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int actual_stride;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct qxl_surface surf;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* work out size allocate bo with handle */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (param-&gt;stride =3D=3D INT_MIN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 actual_stride =3D param-&gt;stride &lt; 0 ? -pa=
ram-&gt;stride : param-&gt;stride;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D actual_stride * param-&gt;height + act=
ual_stride;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!actual_stride || !param-&gt;width || !para=
m-&gt;height)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * size =3D actual_stride * (height + 1), compu=
ted in u64 so it cannot<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * wrap on any architecture, then bounded so it=
 still fits the int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * parameter of qxl_gem_object_create().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D (u64)actual_stride * ((u64)param-&gt;h=
eight + 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &gt; INT_MAX)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 surf.format =3D param-&gt;format;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 surf.width =3D param-&gt;width;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000f7f1ab065c25513e--
