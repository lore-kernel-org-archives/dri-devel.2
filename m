Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C4FCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7EB10EEF7;
	Wed,  7 Oct 2026 12:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PI3ZwTIi";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677CF10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:17:18 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8871ada1a26so31965877b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791375437; cv=none;
 d=google.com; s=arc-20260327;
 b=CKqMOQk3hxrm9Oyv0Uf6xcPAr4kM9YtgHnW0R9IKEBaXRcLko0tBEzf306LMEL+PHp
 uzli3UaXyTFAXwAEaIO4mnHaEFDJ/rLGAk9a0SvRhsE/LiuGv1l5yeUGkMnYzl9qx3vX
 BDq46p1wcuJZaN81rbNlAtL2MOpCbc7st1IlzY2XqBR1ElL5+14ZpDF0/u1pOKEZlPZv
 3BrU78DzWXZyWRccKgshCcDTeD/htwBawAfqSCwNh8RpR3DUhxS/8ZsAKu2p7q34C0Cf
 7JgU2PHoy8rJsDN4wPPlCmWlAble/OVbvcWDShLf3silF/GMQbTykE/n3vlBe7BsCGRK
 N+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=+JOBxpD0r6JvnPCRTEPGURiAyVQwSmPsu6G+kWp4XAo=;
 fh=NKZUF/DpUtOi9/ckuQngtLF/8sowU7pMI/oBXodBM3c=;
 b=YnPu9YS4iUpxlT4zrkC2DRlISq+k2BOxSeJiLdVOITIVNFe3U99BWL+mgGUbeiJOCT
 0i/m5CBjcDYE+C+XL2YAx0PeVbs597vSDUggeoXnHGm+dg6XFY7KzEx5aa1+D9Q4aHXK
 Szop+C0PyMd1aeGnNImZp9V5wYG0zKmXo0CP17/aJmOf4qsD8QLLTLeI+m4uHGmq8sFB
 E9m5CRVucCK3AJwtHK2Q/UixFdRGdFmRRa2QufWs2s7/szt9esOC7z2bBaFR81caas+/
 D4OOJMIqmVEumJdqUnJQfyFLYfQUi9DsblOJz0ZeYb7mBFBkMZLMcRMMRCPx7ep260nz
 28OA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791375437; x=1791980237; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+JOBxpD0r6JvnPCRTEPGURiAyVQwSmPsu6G+kWp4XAo=;
 b=PI3ZwTIiUJ4arEuZ5hNSsMQKMTX5DUmNxH+g9O+dXNAhGLHqvtItSlXqjsgRxl/RD8
 3Qgc+dVJGFzwJQMNHJA+NoKSe/WcdkL7bDXEKzjiFJSBLSFaBURTrtf94mMwWitquRkO
 PBx5nSPjp/PVJos/HZvQXc0jswCedKVV77m/w76vK1nciULwMuD2XD3NSj+hGeQtB3wR
 gmyYKVzw8PIX2Q9KSDnR1cr2AQx58snGcoswmR2CQygJ70/Sk6I/vAw+/5rUSJiaGxlp
 grjDrnxeMz3N5lJiDx863Fo+EHcnKYDCdVWEIKdz71P6XAAKYfqMXL1noBUV/mRbNLSL
 nD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791375437; x=1791980237;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JOBxpD0r6JvnPCRTEPGURiAyVQwSmPsu6G+kWp4XAo=;
 b=NUOjBeaEfS/pSvUt5ZL2dsNYd2JUwYPvJ6r5KVPbOLEOaRSty0lltg8t9iMvk8dZBo
 jkSt0EDa+svF/fDN5VzfCW5uOMrKUhJ8qyahTxOVqRq+zV/kcqxlTBCzWU/ni7HyPh8I
 9njErvjAzKKDkf4My11gCBajl4P0iyC8xtTbOis2ScUpA4lAL3QFaS76bAopugHCI2iZ
 7kqq0/nJleO9VnGDTk10HZGcPeJSCIfjNR3sB9xWsQ8iQEScywptokD/n08DkO5kR4U5
 1uNHgmXbpeJQbHHQdKPv+EWshg9/RVU/qHXO8SLgYEkvYZsLBdE3pmerzUea2xbeAzpu
 ZzSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2bm8QIGGnpftHQCIEWKp/KTNTrAVRxsdHWNvKc7J/7TDXLER0Yv2ZQzDgt3sO4UNArFz/TFpnQb4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIesmSuxG5CY5Ofai0yHY3kmQWWEnMmfDqb0xAemS8VsD3g1x+y
 BPtSFmBYI1h67l6xMREtj+GVyepN+6zrhyG0102hAmECQdSKfu4rU57YTJ/47JGz+VPkbglnbob
 y4+qH1nxhMIDptxn5AiCT/LFvl5ZloFg=
X-Gm-Gg: AYBFou0r1UHmyI3VEqSYAyCS7OS4nG7Bk05YBtcqukyJwA036za/yr6i7a+2LDmuWUu
 Rk1krIq5SwWWjBtAYrKj6dG66ou4mzwx8nnLjjp+aQRhrhQjNWldtXwr0IbWfrIh9Ths30XrOSd
 96j5ZxRHJEifQHETlecVXAtALb/rEsL+0HqHJYDG4wtddWU8wNP8J9O5Yv/zxk4F+kkZqWQll5n
 F2mzsl343U2swDeZDXJSZSAWpmD0TPpy5Fvr16V57MNC5sqIo9faE9g3bowKWyQbzw18kLX/E4l
 byQHkeRLq8ADy31EOXkEXLLv6QkyZ0bFIqXXYQIT6kOxXS8L6YVBAc8AIsx/TvrQspTSK9lVOmE
 /oB1NAJQ=
X-Received: by 2002:a05:690c:5705:b0:873:5bb2:6c31 with SMTP id
 00721157ae682-8b05b1170e8mr10616657b3.56.1791375437280; Wed, 07 Oct 2026
 05:17:17 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:14 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:14 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260923135012.1823971-1-qwe.aldo@gmail.com>
References: <20260923135012.1823971-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 7 Oct 2026 05:17:14 -0700
X-Gm-Features: AclHuK-AFWed68ca_4WeEA4IYsynR__QYJhBOzcyWCdu8rNiiExtnPUDdsUfyQg
Message-ID: <CAP48HftDHsv+SCY2d169kxKSWFMqQUN0zafezqcRw0eME=C3cQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface
 reference ioctl
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: multipart/alternative; boundary="000000000000993ace065d3f1825"
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

--000000000000993ace065d3f1825
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping =E2=80=94 any feedback on this patch?

thanks,
Aldo

On Wed, Sep 23, 2026 10:50 AM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo for
> NULL and reads its buffer_map_handle and buffer_size outside the
> cmdbuf_mutex scope that protects the backup pointer.
>
> A concurrent surface eviction can NULL out guest_memory_bo between the
> check and the use, causing a NULL pointer dereference in
> drm_gem_handle_create(). The post-mutex reads of vma_node and base.size
> race with any concurrent backup change.
>
> Move the NULL check inside the mutex, and read buffer_map_handle and
> buffer_size while still holding it.
>
> Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and
> reference")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index bd05637..fff4402 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_internal(struct
> drm_device *dev,
>
>         user_srf =3D container_of(base, struct vmw_user_surface, prime.ba=
se);
>         srf =3D &user_srf->srf;
> +       metadata =3D &srf->metadata;
> +
> +       mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect
> res->guest_memory_bo */
>         if (!srf->res.guest_memory_bo) {
> +               mutex_unlock(&dev_priv->cmdbuf_mutex);
>                 DRM_ERROR("Shared GB surface is missing a backup
> buffer.\n");
>                 goto out_bad_resource;
>         }
> -       metadata =3D &srf->metadata;
> -
> -       mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->backup */
>         ret =3D drm_gem_handle_create(file_priv,
> &srf->res.guest_memory_bo->tbo.base,
>                                     &backup_handle);
> +       if (!ret) {
> +               rep->crep.buffer_map_handle =3D
> +                       drm_vma_node_offset_addr(&
> srf->res.guest_memory_bo->tbo.base.vma_node);
> +               rep->crep.buffer_size =3D srf->res.guest_memory_bo->tbo.
> base.size;
> +       }
>         mutex_unlock(&dev_priv->cmdbuf_mutex);
>         if (ret !=3D 0) {
>                 drm_err(dev, "Wasn't able to create a backing handle for
> surface sid =3D %u.\n",
> @@ -1746,10 +1752,7 @@ vmw_gb_surface_reference_internal(struct
> drm_device *dev,
>         rep->crep.handle =3D user_srf->prime.base.handle;
>         rep->crep.backup_size =3D srf->res.guest_memory_size;
>         rep->crep.buffer_handle =3D backup_handle;
> -       rep->crep.buffer_map_handle =3D
> -               drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.
> base.vma_node);
> -       rep->crep.buffer_size =3D srf->res.guest_memory_bo->tbo.base.size=
;
> -
> +       /* buffer_map_handle and buffer_size set inside the mutex above *=
/
>         rep->creq.version =3D drm_vmw_gb_surface_v1;
>         rep->creq.svga3d_flags_upper_32_bits =3D
>                 SVGA3D_FLAGS_UPPER_32(metadata->flags);
> --
> 2.43.0
>

--000000000000993ace065d3f1825
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Gentle ping =E2=80=94 any feedback on this pa=
tch?<br><br>thanks,<br>Aldo</div></body></html><br><div class=3D"gmail_extr=
a"><div>On Wed, Sep 23, 2026 10:50 AM, Aldo Ariel Panzardo &lt;<a href=3D"m=
ailto:qwe.aldo@gmail.com">qwe.aldo@gmail.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">vmw_gb_surface_reference_inter<wbr>nal() checks srf-&gt;=
res.guest_memory_bo for<br>
NULL and reads its buffer_map_handle and buffer_size outside the<br>
cmdbuf_mutex scope that protects the backup pointer.<br>
<br>
A concurrent surface eviction can NULL out guest_memory_bo between the<br>
check and the use, causing a NULL pointer dereference in<br>
drm_gem_handle_create(). The post-mutex reads of vma_node and base.size<br>
race with any concurrent backup change.<br>
<br>
Move the NULL check inside the mutex, and read buffer_map_handle and<br>
buffer_size while still holding it.<br>
<br>
Fixes: 14b1c33e8429 (&quot;drm/vmwgfx: Add new ioctl for GB surface create =
and reference&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" target=
=3D"_blank">sashiko-bot@kernel.org</a>&gt;<br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/vmwgfx/<wbr>vmwgfx_surface.c | 19 +++++++++++--------=
<br>
=C2=A01 file changed, 11 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c b/drivers/gpu/drm=
/vmwgfx/vmwgf<wbr>x_surface.c<br>
index bd05637..fff4402 100644<br>
--- a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c<br>
+++ b/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c<br>
@@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_inter<wbr>nal(struct drm_d=
evice *dev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 user_srf =3D container_of(base, struct vmw_user=
_surface, prime.base);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 srf =3D &amp;user_srf-&gt;srf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0metadata =3D &amp;srf-&gt;metadata;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;dev_priv-&gt;cmdbuf_<wbr>mutex)=
; /* Protect res-&gt;guest_memory_bo */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!srf-&gt;res.guest_memory_bo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;d=
ev_priv-&gt;cmdbu<wbr>f_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Sha=
red GB surface is missing a backup buffer.\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_bad_resour=
ce;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0metadata =3D &amp;srf-&gt;metadata;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;dev_priv-&gt;cmdbuf_<wbr>mutex)=
; /* Protect res-&gt;backup */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drm_gem_handle_create(file_pri<wbr>v, &=
amp;srf-&gt;res.guest_memory_bo-&gt;tbo<wbr>.base,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;backup_handle);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;crep.buffer=
_map_handle =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drm_vma_node_offset_addr(&amp;<wbr>srf-&gt;res.guest_memory_bo-&g=
t;tbo.<wbr>base.vma_node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;crep.buffer=
_size =3D srf-&gt;res.guest_memory_bo-&gt;tbo.<wbr>base.size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;dev_priv-&gt;cmdbuf<wbr>_mute=
x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_err(dev, &quot;=
Wasn&#39;t able to create a backing handle for surface sid =3D %u.\n&quot;,=
<br>
@@ -1746,10 +1752,7 @@ vmw_gb_surface_reference_inter<wbr>nal(struct drm_de=
vice *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;crep.handle =3D user_srf-&gt;prime.base=
.handle;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;crep.backup_size =3D srf-&gt;res.guest_=
memory_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;crep.buffer_handle =3D backup_handle;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;crep.buffer_map_handle =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_vma_node_offset=
_addr(&amp;<wbr>srf-&gt;res.guest_memory_bo-&gt;tbo.<wbr>base.vma_node);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;crep.buffer_size =3D srf-&gt;res.guest_=
memory_bo-&gt;tbo.<wbr>base.size;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* buffer_map_handle and buffer_size set inside=
 the mutex above */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;creq.version =3D drm_vmw_gb_surface_v1;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;creq.svga3d_flags_upper_3<wbr>2_bits =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SVGA3D_FLAGS_UPPER_=
32(metadata<wbr>-&gt;flags);<br>
-- <br>
2.43.0<br>
</blockquote></div></div>

--000000000000993ace065d3f1825--
