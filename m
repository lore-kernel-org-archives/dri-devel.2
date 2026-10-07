Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BB9CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859EA10F537;
	Wed,  7 Oct 2026 12:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EuqJ+im6";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E8A10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:17:17 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8ab43af5e97so21663397b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791375436; cv=none;
 d=google.com; s=arc-20260327;
 b=beUyXe2sAcSKd9f1XqtZZjVks4aUhMqGUFLE8OGGoeJM+11pmmEb1b2WRiYm8BZIEg
 +QjYyH6c+LBZZpzXXuvfrpHVOP3Y9XjSYx1QBwJL0tbhV/AtcWU9zgMM98f7iHzVRJNp
 tRa/HaaOlAd1qOoV+Eh6LACij9WR2pbJ991MP9dmR5O0DfrOORKanp8wJndTd6TAVPjF
 IYYEBwmJ/hBiu1j9HTGDWbDStUae1GrT60+uk25A3qgK7e7afgqRKoiDAH6BWr8UZBSI
 3okuPnwcgKAJ+rsnh0eB0GW96u0YLEbpR4lcxlC75g2EMyyGVThbMk4ETmQNSG94GySP
 0AsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=jwU7kHtSmq1rXGOPFEDTY5oLYrfzMia4r39p7RElK7E=;
 fh=h2gO+9F+msVmw5XdlZOBMG/83BLrUru9hig3XocwVus=;
 b=D2EumcCR2xwGTgLTQItDXwqdROmG8J1l+/7cv/j3pXIQBPdgzsSp2sRrozvXirIHjs
 phQsy4eyDy8+D2AqQFMF2Oe2vaS+RdE02EL5PVpUZMki6HzJD+K97WehtavHg7S8VJMd
 Fv5FF6FWg7MqlJH0p/lTxYQ/DMZEKMlxcz0FY71PQKQk2tq5R4tRNtKs8+sYjpFt/0Pp
 3ChEOx+P4sTX40hkLXd0GcA4x4KWC0n7BvqpT40n9r8tcRT1wUyj+KekULZ+GLe9KS/o
 2C/JotgRqFq97rqz5JRIWtbe01dJy5GPPML8n9HZwZIvy8Yjkvg09XQfVXTeJdNelbJg
 kCqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791375436; x=1791980236; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jwU7kHtSmq1rXGOPFEDTY5oLYrfzMia4r39p7RElK7E=;
 b=EuqJ+im6/xfV5dI/ehBp7lVit/mnY4N1GxYusXGzrImSH42wNwlsoH2FAfD1ya0Swp
 UcdUgIabhp7OAqukRD3EvYJMvlaGd8HqH/uFF83oIuGQzQlb7CvWOErUEWEwk3jEEhdF
 Dp0DeAOF/vCMrvwija0fyJ6NChJksPfQJ2viEyaqgUshVDhgFAMHzUBjPZ6PQyYWSYYI
 g5CeujUifsoR1/zld/YHCeFOQupRdgidgaVuc3lYPd5wvAl7r075MB47e8c6i95CrZR7
 0akoqLM914II/pqY27WasF0D7wKKQaDYm5T0TcAK9I/QAM+bt9P6WLIsswgV4RLCWciC
 +vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791375436; x=1791980236;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwU7kHtSmq1rXGOPFEDTY5oLYrfzMia4r39p7RElK7E=;
 b=wLK3u5G8MKVq8XDE6RhwWskRMz4YjYDVhBFg6/qJPv6S/FdD25+yFN7hYu8LuZ/zGc
 UJR0WmSzOADgH008GJ0Yl6RX95AEOz7nziKFgnxlFClWdgRtxbJvEYO37ERFfRzRbomm
 orJZjn3EfnO7Rt30tI3xvzH0IYh4Nfx4rGV6OI87KDr6+d/XdD7bN8lbBDXlxWU5KLnm
 mknGYNAwhBcNU3SLWDlNC5zkEsCQ+2lVuEdPpbxwZDU0zVMdgFQ6aNPGDSUHnVVygka4
 Sq5bdKCmM7zxfehxV8PuYfRO7eI/LPyNKpWDZMeyGbBAg6Ge0Ay2A0rzf+xGcuzaufBl
 5UaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8smxf35g3u7AsbUfrU2544USotTj/2u/RuqNYsxQm8pzmN1uRWJ53oaw+PlNupxDJG+Rznq8QQao=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8TdhQEztQ35x9eH15+XKUXha15tnkhLp70g3qgHtvW4uJMfMj
 wmixlD+UfWP3qWFxVBc9wv1OY9jVbSb6FW37uIMsmaln7kHx5TgWr91Ol1evrgV/glZ1GMSC3Nz
 Gbsl2SzqJItPq4AuzrG0+g0Rf/Sp+G2g=
X-Gm-Gg: AYBFou1Yu3YOnt9G6dwPKPLugX5kagHEWYzdvxMFy09w0ELSDgqmACuZzV3RxEE9051
 whq3Xzv7kOsHkiYaKfSOzOoRJPIgM4ihIWM8oCaolo1lSxXF+JNP6oCqoITYA03jA7YMxu9ARJ2
 24zZlvl61jbA98JDVoB4k0utWyw/c8GTWLVW1SrudcJw4NFKWkJSP1W9h7xJ3IFTG57pQPafu7B
 v6AoiRLKo1Z8gDydgSTx6iPLKrsXrkFFkebpRMurB6nxhTVKZZic52agBq337I0X4FukEtlrHtd
 BPWK/6PGgwUudMIjDDWHWYWP+SxQ5rs7MLY6Cb/i+Ma1g2+8VDa5+2pdmZJZhAK1v02/+8N0C01
 JTekFZ6WF
X-Received: by 2002:a05:690c:60c5:b0:8a9:a1e9:2665 with SMTP id
 00721157ae682-8af71ffb501mr36883327b3.6.1791375436501; Wed, 07 Oct 2026
 05:17:16 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:16 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:15 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260923115839.3363885-1-qwe.aldo@gmail.com>
References: <20260923115839.3363885-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 7 Oct 2026 05:17:15 -0700
X-Gm-Features: AclHuK_bufy_aCspoZGFicsjFc-5jJxlrZXBY2WNsa-dRhlfj-JmrFrY_evlL44
Message-ID: <CAP48Hfvm9oJxsQZP5OzFvuf3_dFNiGhwvqW-fehtSi8JpGW0vQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] drm/vmwgfx: return an error when a shared GB
 surface has no backup buffer
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000008d5870065d3f1803"
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

--0000000000008d5870065d3f1803
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping =E2=80=94 any feedback on this patch?

thanks,
Aldo

On Wed, Sep 23, 2026 08:58 AM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> vmw_gb_surface_reference_internal() rejects a surface that has no backup
> buffer by logging an error and jumping to out_bad_resource, but it never
> sets ret on that path. ret is still 0 from the earlier successful
> vmw_surface_handle_reference(), so the ioctl returns success while
> leaving the reply structure uninitialised. drm_ioctl() then copies the
> 72-byte reply back to user space; on a CONFIG_INIT_STACK_NONE build that
> is an information leak of stale stack contents, and on every build user
> space is handed a "successful" reply that was never produced.
> DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so an unprivileged local
> user can reach it.
>
> Set ret to -EINVAL and, on the error paths, drop the reference that
> vmw_surface_handle_reference() took; once the ioctl fails user space no
> longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by
> ret so the shared success fall-through keeps the reference the caller
> still owns, and it also plugs the same leak on the drm_gem_handle_create(=
)
> failure path.
>
> Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and
> reference")
> Cc: stable@vger.kernel.org
> Suggested-by: Zack Rusin <zack.rusin@broadcom.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2:
>  - Shortened the commit message (Zack Rusin).
>  - Also drop the reference taken by vmw_surface_handle_reference() on the
>    error paths; with the ioctl now returning an error, user space no
>    longer releases it via DRM_VMW_UNREF_SURFACE (Zack Rusin). This also
>    plugs the same pre-existing leak on the drm_gem_handle_create() path.
>
> v1: https://lore.kernel.org/all/20260808231002.67559-1-qwe.aldo@gmail.com=
/
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index bd0563741e..164886a3e6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device
> *dev,
>         srf =3D &user_srf->srf;
>         if (!srf->res.guest_memory_bo) {
>                 DRM_ERROR("Shared GB surface is missing a backup
> buffer.\n");
> +               ret =3D -EINVAL;
>                 goto out_bad_resource;
>         }
>         metadata =3D &srf->metadata;
> @@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_internal(struct drm_device
> *dev,
>         rep->creq.must_be_zero =3D 0;
>
>  out_bad_resource:
> +       if (ret)
> +               ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
> +                                         base->handle);
>         ttm_base_object_unref(&base);
>
>         return ret;
> --
> 2.43.0
>
>

--0000000000008d5870065d3f1803
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Gentle ping =E2=80=94 any feedback on this pa=
tch?<br><br>thanks,<br>Aldo</div></body></html><br><div class=3D"gmail_extr=
a"><div>On Wed, Sep 23, 2026 08:58 AM, Aldo Ariel Panzardo &lt;<a href=3D"m=
ailto:qwe.aldo@gmail.com">qwe.aldo@gmail.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">vmw_gb_surface_reference_inter<wbr>nal() rejects a surfa=
ce that has no backup<br>
buffer by logging an error and jumping to out_bad_resource, but it never<br=
>
sets ret on that path. ret is still 0 from the earlier successful<br>
vmw_surface_handle_reference()<wbr>, so the ioctl returns success while<br>
leaving the reply structure uninitialised. drm_ioctl() then copies the<br>
72-byte reply back to user space; on a CONFIG_INIT_STACK_NONE build that<br=
>
is an information leak of stale stack contents, and on every build user<br>
space is handed a &quot;successful&quot; reply that was never produced.<br>
DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so an unprivileged local<br>
user can reach it.<br>
<br>
Set ret to -EINVAL and, on the error paths, drop the reference that<br>
vmw_surface_handle_reference() took; once the ioctl fails user space no<br>
longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by<br>
ret so the shared success fall-through keeps the reference the caller<br>
still owns, and it also plugs the same leak on the drm_gem_handle_create()<=
br>
failure path.<br>
<br>
Fixes: 14b1c33e8429 (&quot;drm/vmwgfx: Add new ioctl for GB surface create =
and reference&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Suggested-by: Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com" tar=
get=3D"_blank">zack.rusin@broadcom.com</a>&gt;<br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
v2:<br>
=C2=A0- Shortened the commit message (Zack Rusin).<br>
=C2=A0- Also drop the reference taken by vmw_surface_handle_reference() on =
the<br>
=C2=A0 =C2=A0error paths; with the ioctl now returning an error, user space=
 no<br>
=C2=A0 =C2=A0longer releases it via DRM_VMW_UNREF_SURFACE (Zack Rusin). Thi=
s also<br>
=C2=A0 =C2=A0plugs the same pre-existing leak on the drm_gem_handle_create(=
) path.<br>
<br>
v1: <a href=3D"https://lore.kernel.org/all/20260808231002.67559-1-qwe.aldo@=
gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/al=
l/20<wbr>260808231002.67559-1-qwe.aldo@<wbr>gmail.com/</a><br>
<br>
=C2=A0drivers/gpu/drm/vmwgfx/<wbr>vmwgfx_surface.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c b/drivers/gpu/drm=
/vmwgfx/vmwgf<wbr>x_surface.c<br>
index bd0563741e..164886a3e6 100644<br>
--- a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c<br>
+++ b/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_surface.c<br>
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_inter<wbr>nal(struct drm_dev=
ice *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 srf =3D &amp;user_srf-&gt;srf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!srf-&gt;res.guest_memory_bo) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Sha=
red GB surface is missing a backup buffer.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_bad_resour=
ce;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata =3D &amp;srf-&gt;metadata;<br>
@@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_inter<wbr>nal(struct drm_dev=
ice *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rep-&gt;creq.must_be_zero =3D 0;<br>
<br>
=C2=A0out_bad_resource:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_ref_object_base=
_unref(<wbr>vmw_fpriv(file_priv)-&gt;tfile,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ba=
se-&gt;handle);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttm_base_object_unref(&amp;base);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000008d5870065d3f1803--
