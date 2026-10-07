Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A84CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122BB10F541;
	Wed,  7 Oct 2026 12:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="beYNtYWz";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7517D10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:17:19 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-888cbacf70eso26219537b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791375438; cv=none;
 d=google.com; s=arc-20260327;
 b=hM0oNxNLn4egAEsNoQX4qIqNhX2kdnljDOjCdQ/UWo5dZV5k5DwS6HQdDtBh/TOfb4
 8mjrQMmDNofJcvavLuNITv5u1WH4e7cC7CWXFVodwxyRhGEAd4dL1O1HfSlZBDksgGbK
 Mb4C0z5klMlmLIqwCXrAEjcoO2EaKgijoLP8LATWqulFMNKuB2R1YRAkm2jXOc01d2Ae
 ++jKuEreTsN7ASqM6VygPLcpcBdXYSSuklMP1RxAjwrwnZjnixPu4ix23Y37BCXmWrG9
 L4fy+m71aC5PwuHiXml+4PAszG6E8pJBidOnLWWY1puYLxPZn0iaVQRPUigPitsg2ghp
 XVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=G3hIYvO6rofR6yiVxkZZs211kr6wt7mGWtePbRp507o=;
 fh=nPsyXw9BE60uconoaVxi2X5OwwE+8C1yJ+NFhcw4pf0=;
 b=adyevnds+mLmM3z/+mYhLG1Qmgztw5Y9f3X9Kcp62YVYuEtcZEuMdl1K2Wgnsyp3G+
 HaibRjYB+kDa3GernzN3urqzKJTbUQYDKhL4tzq9gYloWSLuDG/VFPoRTmYH9w/VRyF8
 g49wd+tA9Mx0yz1oFW/JlKFi7JZsYdyzuHfSC7x3L6az8Y39Z8qqCBkqrJdLVXTGPkZp
 +sErkMaJgasC0xrnEB0Xx3CDsAHmzOFqj6vWBqf+lBddSYzTssnLvVVoyox6rQpIP2ar
 gMj0dDNcL95QpgJlnG2M+a2mK9A4N+oWM8IVOSOamSLMOyeQyzTV6gq2sVJF3NX30peC
 ie4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791375438; x=1791980238; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G3hIYvO6rofR6yiVxkZZs211kr6wt7mGWtePbRp507o=;
 b=beYNtYWzPdh7R1SK3/Rua+/Pr9BAYqbfl4WVzglXrg17gqhLitnJhrr3qnJMECbtpD
 5A2iKd4vg+OC0LT9+kKfANYyjLWaL9ceaizRIy8PihvvLGMp7XsXoKbd3J0ukGNwCy2s
 L0atSOpo0+QljC2Vt1Nk/yvuWozRoUSNwbV803afrJlaV6eQ70F4zxhXEPliSr7X2eZZ
 9lfh94/A4a8aoL7yD+NPpjw3G7u7Xs2R2/3iz782aP4J1t5rn/nX5iG4FBrK7lLW35oi
 e5RQS19wB5HOllmPx7VZpurdXf8hM+YIwbPkzX1MAzqZBeaRbtn08upbEaamF+I/9Eh4
 wzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791375438; x=1791980238;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3hIYvO6rofR6yiVxkZZs211kr6wt7mGWtePbRp507o=;
 b=z+/UFebpriiL4qRTdIS5KU/Lba6GsJeS0upOUxt75E6RqrHQ86gc74e+YOh/kY8yRX
 72E/9XHrIu1VI+ciFUw7mxbkpsCdcy90q3Ac7th0aYs999kL2dH7QujK3mVO5y3Qh4oQ
 SHDd0UbFCkGhe+jEbXvkQAaqJaXEolegqGbcJ2LyLJ5xiVAyBwAT0FShqq2dDfRONyP8
 X9m5p9v9MMSnMh3tkQ3rUC+kakwXo8CDY6XZEgSBkkQwRQRjQWtbZuUzcE52RzBIPT2d
 KXf3CAEJ/DKh5DAnqYjKV9kb2Yz1LeQAowWYDqIjhdDhGeo4gNqFwlrvCtEgMFkkAzmz
 GG3g==
X-Gm-Message-State: AFq9FYIH4o0hPAmAJn6cCcHjeKVCd2XmQhb6sV/2ULN+4EX+bAvofGnz
 mUYGfZ5WUK7HVp/BjW1UG9CUmLU/YyU4czEARq4leCmj/vtje1iqanwOY+UJv1NPPiWK5b85qLd
 fOIiCS/JcmW5GK3JBIZ3yC6MrSJbqP14o5taTFRM=
X-Gm-Gg: AYBFou2NaC+oB85d5y/c+GHLwpR9KVfpMGLg9gzJCP9HUmaQg0nE1PZcXegxHEnsljh
 wamydAKouUBnBAZsG+crWVdqMt/xtmeHHhBtb4jfObIMETxSY8x57rt9q7AILcaM5DqjNJn+OTT
 n9hn3ZBxbhkrm6IEiivP9cNv/Fdu8+H3YHw+Z1o8Tana0gh77dtN798bfOLLJZITtP1Un47CgpQ
 r43Koy37tX6KBxWlPB8ypO5j/bcSmYB7fC9Rwu8puo7iK84MjEliRkQfX16sWOMjBLdd4xt7ffJ
 wgXzRu6qH3UBUPqK6eLeGv9Y/z+u8y4ffDzkJMI22rvGgu144l6j84VgkworVVNbAEsXLJnxjkL
 ctMZV0DA=
X-Received: by 2002:a05:690c:6604:b0:8a6:1901:30d9 with SMTP id
 00721157ae682-8b05b070098mr14444897b3.37.1791375438354; Wed, 07 Oct 2026
 05:17:18 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 07:17:17 -0500
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:17 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260923134952.1750600-1-qwe.aldo@gmail.com>
References: <20260923134952.1750600-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 7 Oct 2026 07:17:17 -0500
X-Gm-Features: AclHuK-whEsKYznu3QH-_btnyvcnHGgYyZGFkLrAUxAWU2MoQ8yHbn7rl_DfUYY
Message-ID: <CAP48HfuRRZozM0BZOBEGANMbPKXCvGfyS7TjnGnobEYMNCFKow@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove double page-size scaling in kmap fallback
 paths
To: airlied@redhat.com, kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, sashiko-bot@kernel.org
Content-Type: multipart/alternative; boundary="000000000000a9a08f065d3f18b7"
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

--000000000000a9a08f065d3f18b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping =E2=80=94 any feedback on this patch?

thanks,
Aldo

On Wed, Sep 23, 2026 10:50 AM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
> compute as a byte offset aligned to a page boundary:
>
>     reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
>                                          info->dst_offset & PAGE_MASK);
>
> The VRAM/PRIV path adds it directly to the mapping base (both in
> bytes), which is correct:
>
>     offset =3D bo->tbo.resource->start << PAGE_SHIFT;
>     return io_mapping_map_atomic_wc(map, offset + page_offset);
>
> But the two system-memory fallback paths multiply it by PAGE_SIZE
> again:
>
>     rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
>
> For page_offset =3D 0x5000 (page 5), this computes
> 0x5000 * 0x1000 =3D 0x5000000, a 80 MiB offset instead of 20 KiB,
> producing a massive out-of-bounds access into kernel memory.
>
> Remove the spurious multiplication so the fallback paths use the
> same byte-offset semantics as the io_mapping path.
>
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c
> b/drivers/gpu/drm/qxl/qxl_object.c
> index XXXXXXX..YYYYYYY 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev=
,
>         return io_mapping_map_atomic_wc(map, offset + page_offset);
>  fallback:
>         if (bo->kptr) {
> -               rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
> +               rptr =3D bo->kptr + page_offset;
>                 return rptr;
>         }
>
> @@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev=
,
>                 return NULL;
>         rptr =3D bo_map.vaddr; /* TODO: Use mapping abstraction properly =
*/
>
> -       rptr +=3D page_offset * PAGE_SIZE;
> +       rptr +=3D page_offset;
>         return rptr;
>  }
>
> --
> 2.43.0
>

--000000000000a9a08f065d3f18b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Gentle ping =E2=80=94 any feedback on this pa=
tch?<br><br>thanks,<br>Aldo</div></body></html><br><div class=3D"gmail_extr=
a"><div>On Wed, Sep 23, 2026 10:50 AM, Aldo Ariel Panzardo &lt;<a href=3D"m=
ailto:qwe.aldo@gmail.com">qwe.aldo@gmail.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">qxl_bo_kmap_atomic_page() takes a page_offset parameter =
that callers<br>
compute as a byte offset aligned to a page boundary:<br>
<br>
=C2=A0 =C2=A0 reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info-&gt;dst_bo,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
fo-&gt;dst_offset &amp; PAGE_MASK);<br>
<br>
The VRAM/PRIV path adds it directly to the mapping base (both in<br>
bytes), which is correct:<br>
<br>
=C2=A0 =C2=A0 offset =3D bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT;=
<br>
=C2=A0 =C2=A0 return io_mapping_map_atomic_wc(map, offset + page_offset);<b=
r>
<br>
But the two system-memory fallback paths multiply it by PAGE_SIZE<br>
again:<br>
<br>
=C2=A0 =C2=A0 rptr =3D bo-&gt;kptr + (page_offset * PAGE_SIZE);<br>
<br>
For page_offset =3D 0x5000 (page 5), this computes<br>
0x5000 * 0x1000 =3D 0x5000000, a 80 MiB offset instead of 20 KiB,<br>
producing a massive out-of-bounds access into kernel memory.<br>
<br>
Remove the spurious multiplication so the fallback paths use the<br>
same byte-offset semantics as the io_mapping path.<br>
<br>
Fixes: f64122c1f6ad (&quot;drm: add new QXL driver. (v1.4)&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" target=
=3D"_blank">sashiko-bot@kernel.org</a>&gt;<br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/qxl/qxl_objec<wbr>t.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/qxl/qxl_obje<wbr>ct.c b/drivers/gpu/drm/qxl/qx=
l_obje<wbr>ct.c<br>
index XXXXXXX..YYYYYYY 100644<br>
--- a/drivers/gpu/drm/qxl/qxl_obje<wbr>ct.c<br>
+++ b/drivers/gpu/drm/qxl/qxl_obje<wbr>ct.c<br>
@@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struc<wbr>t qxl_device *q=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return io_mapping_map_atomic_wc(map, offset + p=
age_offset);<br>
=C2=A0fallback:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bo-&gt;kptr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rptr =3D bo-&gt;kpt=
r + (page_offset * PAGE_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rptr =3D bo-&gt;kpt=
r + page_offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rptr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struc<wbr>t qxl_device *q=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rptr =3D bo_map.vaddr; /* TODO: Use mapping abs=
traction properly */<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rptr +=3D page_offset * PAGE_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rptr +=3D page_offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rptr;<br>
=C2=A0}<br>
<br>
--<br>
2.43.0<br>
</blockquote></div></div>

--000000000000a9a08f065d3f18b7--
