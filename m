Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0734606A322
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VfuELCnO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C8710E1D6;
	Sat, 24 Oct 2026 20:52:43 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B449E10E485
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:52:37 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso19948097b3.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875157; cv=none;
 d=google.com; s=arc-20260327;
 b=cJpSy7ad6714ZJi4w7DyG0Msz5/oYM3aFzhYK+xG8RBMuI9M8W2AtbwFXnRAvmlCDy
 wFFvVPqmlmOvquAMtOAkQlNoMO4CsBtr8bXaeCK2tM/VoUmpb1HxcVVl811TXVIwOEE4
 ffeFrLeQ9JWS8GW9OxNcgwit3Os/F5czSWCCnAmjxUXI40+6p94PnB0l26BKuqFO0GcE
 5LVKT6A73qJWPDRSmVAzdsjMAUPHNinZtrmoq6f3tpazNnNzeDhfMYAWNGslgzTRIj2k
 kbjDLohEFBvPz94CK8i/mjPpK+6f/Ngjw9G5AoMMfBNiE70Y5i1LcbD8+Dx8JuCYILxV
 mLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=08IR+RBNHSmamHUpWnz06U8NJXK1122R99WF/ONGWGY=;
 fh=0NDCw7vJp9AirW9NTUtQjwBRY3SSciw/eWALbOIGY8k=;
 b=ks3PApMI1NKPo3nBecnVyGrrprSuV+JQMb8P+/sEAaZWbMyx005uZslfIP8SWMCar/
 FsU7ItXVjCEUuCMqpQaJdg2jWdRWZegxanTTXckFxyYBG1Kby625daZvVhLplzJfgaXT
 GyfJvJe/hmWsGl+HNf/C0JmW9gv7Q7F+hcSRuXvi+3gDZ9+n6pTYuQsh49I6S3ELSqNi
 XLqAMue5ZtqCcn7vGx4vDMPE5RL6Sg2PMtkGJGen23SfOpJCDC2pQpSVwStThEoyw/+s
 mcSPWuCkMoDwtvjNZugqSRLBPw7AH6NbmWLIWV8pb2lP5pX0Jf3KAoG4jGYLv76q3Uy8
 HuMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875157; x=1793479957; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=08IR+RBNHSmamHUpWnz06U8NJXK1122R99WF/ONGWGY=;
 b=VfuELCnOKa88DmNtWBshqTi0Fiy8C3evpKHO5GuYSt81Dh0pOO0wsnOWEF8V6DQF15
 7s4wZ2JP0lQ3JXLEDgj4pU6otOZjv3wR6d2VblvtOO5yTuUC3v83akBB7cSrrfgJeBKC
 LEaECUNPkZZLC/XK6Y4TZ6G1tHHKXhWOiKDyBQ5UmtQ3gg7bhfkzBrZGvgGLyoZLLYud
 mVQ5Ic7b0SLc7USPi0IG61qsXdViKHZ2rgpnfasK2fV8mlJaKUnvh61YXl1nsqQHHCEy
 3GDk9nntIt3/x3idnzwyoJvkn/rZYhQwmLnCKWwjtmHz+NRPNW8dqU4oXm5sz0d5kNi7
 mJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875157; x=1793479957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=08IR+RBNHSmamHUpWnz06U8NJXK1122R99WF/ONGWGY=;
 b=MnIFsZgdlAZatM75IZ6YN8N5Wnei7rNsMEDNOL7uyaFFN83tnj0KRnQtgI9cOEQHIo
 2KOKNoKxYMUx2lTb3rlkGDb0s2A80JagzA6aItJccqfrzA3Ul91fAUcbSdxdRr5Nbh5P
 4My4PdJkWL5cqVyZ4ZnlJwACXJcEtqlPSblMYXNp79JOeSFoXEwrwzAnXnlu1O2KQuXY
 ofKP4qYitNRppW20jcjAAkOktVr5m6P/XA9OPWWgqKewTx0t6AphvYcZ0v0e6mtYdynB
 iE+Cqtl9yCgkf1Suvm18suR4qlouDHrZlVRD/rJtm2NGOnZetiVsrULlJ/Ua94kxI/Lk
 8Dmg==
X-Gm-Message-State: AFq9FYLTxKNbFQyCKznuca2Gt1ITgNDQKDMvjABrwju6BTlugHNz9IRk
 lyVDhe5pU2sCv66P1ulUUK/KaTKTOgu3RSxiVYvxhjB2blqqrcLWFiZvBsAEsBGdCfP3jpEvGGz
 jQPa5U9TWOWbCWtL7jXtSc60FTFoAgJo=
X-Gm-Gg: AYBFou0MACyYVXQe9/wiPyVk3pFFeQlnaSybmKnOeIEa49j55XCbhtM5Cc1gYCzKXu1
 tzGJmTU4dCcTzaMElOjvnTCqb5r65HiMEZihemGtdUIfA2oxV3OAl1gko1izUVuS/0tkZvh7O6z
 R7riTq9uzxaES6sHa1/wbEVzr5bW4ngX1eePuvGUnazTJPujBhP+whYiyp0jc6eJgJfKi54UROX
 39HDM60ltqR+WzAu+UAmQbZdMeF0BxFQ9AYfZeggJoGff9z5Ngnp9MQMxGx4umSwId3vAUz9Gmm
 MvRgjptJ0A6EWaOdPptQbncq5VApcLAptBd5ll2deIr7atgV7lEWwljmPPdkag72pZc6YSpvZSj
 wq+c8A6hbimFbziUgFLHdCw73TZb3qCQCeVazM42bOGgrC0L/LDjtOxLA
X-Received: by 2002:a05:690c:6d81:b0:8b0:a5d3:71c1 with SMTP id
 00721157ae682-8b166d4d56bmr18633737b3.37.1792875156614; Sat, 24 Oct 2026
 13:52:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923134952.1750600-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923134952.1750600-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:52:25 -0300
X-Gm-Features: AclHuK9wL7McoU55DUeXxGKmE3Xe2IyuR78pMeRIDBBZSs-gN8n6r2qslBkkiAs
Message-ID: <CAP48Hfs2_ux-YoY5spDUuGF7U_inNEJX3x6hw-X3GDcgRpQHqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove double page-size scaling in kmap fallback
 paths
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000d6333c065e9c4656"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d6333c065e9c4656
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Gerd,

Following up on this fix. Some list copies of my previous follow-up
were rejected because they contained HTML, so I'm following up in
plain text.

Is there any additional validation or any change that would help
move the review forward? I'm happy to help.

Thanks,
Aldo



On Wed, 23 Sep 2026 10:49:52 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
> compute as a byte offset aligned to a page boundary:
>
>     reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
>                                          info->dst_offset & PAGE_MASK);
>
> The VRAM/PRIV path adds it directly to the mapping base (both in
> bytes), which is correct:
>
>     offset = bo->tbo.resource->start << PAGE_SHIFT;
>     return io_mapping_map_atomic_wc(map, offset + page_offset);
>
> But the two system-memory fallback paths multiply it by PAGE_SIZE
> again:
>
>     rptr = bo->kptr + (page_offset * PAGE_SIZE);
>
> For page_offset = 0x5000 (page 5), this computes
> 0x5000 * 0x1000 = 0x5000000, a 80 MiB offset instead of 20 KiB,
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
b/drivers/gpu/drm/qxl/qxl_object.c
> index XXXXXXX..YYYYYYY 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
>       return io_mapping_map_atomic_wc(map, offset + page_offset);
>  fallback:
>       if (bo->kptr) {
> -             rptr = bo->kptr + (page_offset * PAGE_SIZE);
> +             rptr = bo->kptr + page_offset;
>               return rptr;
>       }
>
> @@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
>               return NULL;
>       rptr = bo_map.vaddr; /* TODO: Use mapping abstraction properly */
>
> -     rptr += page_offset * PAGE_SIZE;
> +     rptr += page_offset;
>       return rptr;
>  }
>
> --
> 2.43.0

--000000000000d6333c065e9c4656
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Dave, Gerd,<br>
<br>
Following up on this fix. Some list copies of my previous follow-up<br>
were rejected because they contained HTML, so I&#39;m following up in<br>
plain text.<br>
<br>
Is there any additional validation or any change that would help<br>
move the review forward? I&#39;m happy to help.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Wed, 23 Sep 2026 10:49:52 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers<b=
r>
&gt; compute as a byte offset aligned to a page boundary:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info-&=
gt;dst_bo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 info-&gt;dst_offset &amp; PAGE_MASK);<br>
&gt; <br>
&gt; The VRAM/PRIV path adds it directly to the mapping base (both in<br>
&gt; bytes), which is correct:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0offset =3D bo-&gt;tbo.resource-&gt;start &lt;&lt; P=
AGE_SHIFT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return io_mapping_map_atomic_wc(map, offset + page_=
offset);<br>
&gt; <br>
&gt; But the two system-memory fallback paths multiply it by PAGE_SIZE<br>
&gt; again:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0rptr =3D bo-&gt;kptr + (page_offset * PAGE_SIZE);<b=
r>
&gt; <br>
&gt; For page_offset =3D 0x5000 (page 5), this computes<br>
&gt; 0x5000 * 0x1000 =3D 0x5000000, a 80 MiB offset instead of 20 KiB,<br>
&gt; producing a massive out-of-bounds access into kernel memory.<br>
&gt; <br>
&gt; Remove the spurious multiplication so the fallback paths use the<br>
&gt; same byte-offset semantics as the io_mapping path.<br>
&gt; <br>
&gt; Fixes: f64122c1f6ad (&quot;drm: add new QXL driver. (v1.4)&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" tar=
get=3D"_blank" rel=3D"noreferrer">sashiko-bot@kernel.org</a>&gt;<br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qx=
l_object.c<br>
&gt; index XXXXXXX..YYYYYYY 100644<br>
&gt; --- a/drivers/gpu/drm/qxl/qxl_object.c<br>
&gt; +++ b/drivers/gpu/drm/qxl/qxl_object.c<br>
&gt; @@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *q=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return io_mapping_map_atomic_wc(map, offset =
+ page_offset);<br>
&gt;=C2=A0 fallback:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;kptr) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rptr =3D bo-&gt;kptr =
+ (page_offset * PAGE_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rptr =3D bo-&gt;kptr =
+ page_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rptr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; @@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *q=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rptr =3D bo_map.vaddr; /* TODO: Use mapping =
abstraction properly */<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0rptr +=3D page_offset * PAGE_SIZE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rptr +=3D page_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rptr;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; --<br>
&gt; 2.43.0

--000000000000d6333c065e9c4656--
