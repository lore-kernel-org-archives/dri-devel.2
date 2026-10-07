Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F217CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F2610E533;
	Wed,  7 Oct 2026 12:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOy3HJc5";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9FE10E533
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:17:16 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8ad98c3fb15so16826047b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791375435; cv=none;
 d=google.com; s=arc-20260327;
 b=pAOMHpgClA0xIgnQVeks+bg/pMVKzGwAXyng5DTkRB2edTqgL0+P4D5LjkHrZWKzpD
 sdgpoczbpAZJ/7CzlFuK2pUKZKGEiYNw/xrqR9D3V2TFrtm6APwGH8vgmmSHM0dy/LC1
 cl2YxKGMwfobJRgjN6p8E44DWgSX1czwshwzYpXHzcLlg6KvBXKejzVRpQwQ+wicNEn6
 UM/fMCZXPKH2qhvqwMs5DyMlb77ifk1C0agEJc/1fipVmZsFvzdtnBie8hN4S6TgmmiL
 Ticdvnx/YAgMUgg0It3gd+uEVVMW2A56BPrn3Hgo73o6pHvWYogG+YtymxsJX3lycAiV
 +WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=zveon9c5MA6EqQWKPCV1u98XkUUNjQOwLTZ0vhCMQPM=;
 fh=7V6AGpEm2v32R42Wy6tRuIgaLaN0zyoAlaMabsxD81A=;
 b=HTXIlPLLHX5ewRehOMZKZ3bSniWsL6eN5wIvR6WXhgOlRZB/ONwvTQ/N5/UjQhKt3o
 XgISfwdhwEtJ/S35FaKUQ6WYFxuHBXZWIEf6ml2iXX5VYnlrq6El7MJahl4bYdLyVCo3
 QTlhgoGoYvq07mt0MqsstBzaXiiGPOHi5V7YMMJpzMjuiCx6O2Mt3/exUvTxwoRA5X7X
 euZ/xpANtjV1p09Oe8VJdn4vGlo4G6AShu4am1Y8XdcQyD3ZVR0/0DG893IoxEN5Kw9v
 iHkJXk9dbsTGYKz1Gbs3FyQq5eOCLj6wz37cRtQYrRackrjvROMKJG2Au/Wu7zJHW3nO
 LtsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791375435; x=1791980235; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zveon9c5MA6EqQWKPCV1u98XkUUNjQOwLTZ0vhCMQPM=;
 b=GOy3HJc5huxsg6+YXzycEjeQ4Kgem65gnzF89kVeI42E46JfKyExeEr7Zzuw7BIndO
 Npkb6EGfDxNaBF84XtwhU4fw/bKhYBDkisfHfw9vt/U/3kcRJKGS8Od6IWs/AumlP+1j
 6K5++r2RyKIb3z+UMgxVUVva37aWMxSc/uUDeGGn5WNsArxamqWpo/UBhCmmuPiHTRA8
 oaIyG4BPEWE5hVYMnwBtj7ng5iAwuIUIAyrkF9ishOjw2a7GyfXAPvS3NweG2uF2vQq9
 zt7vro2gCoIaFLxOYaRLXFn6Vldv9cB24GCgVB/+bCyTQkPzYnVpwh6/NpbGvpqYtQtG
 9Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791375435; x=1791980235;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zveon9c5MA6EqQWKPCV1u98XkUUNjQOwLTZ0vhCMQPM=;
 b=X3caYA8RJYhtv4I355Pa0uPH8YbYnhety0rdxoj/VrRK7e7DT6NvRh7cPE00N650Qa
 xprGq1FSgoSHyaGK4guxqzKmxKl+XSY0sPUu1BdebVAmIxRup3Jzp78uDpo5Az9xO4QY
 inDpXV+inEd88hrobkaWd0vXnC7qYKvRa2m9b8TGhPaqiE6CCnWJiAQ/s3xXmrjRyr1Q
 i94iGCYAnY2ETQBXvj/IDUjSTWBcy+OCAagcIlbGQxzKp+dnJe9OMT8XtrOvBhQNoGPb
 t2k/AedB7vp/bs51kSradQLfQDzXS4kxuy6lF7jrNb7ZgTyn++5TszZiozUA/INU6J4D
 lgeQ==
X-Gm-Message-State: AFq9FYLUpuajgU3rSGA0JLcNmw7SUXgIiSZ1oOvhYrkqX7KWsPd+DG0Y
 gBqdfJETIFsjo6tB6Dl7M9J3vSCQMcN8LefyoiQ/psPLxj0X7A9icYIiInFW16MUw8N823jkhDD
 /FVp5W60y09EqH4XgfxMMjYeYBoj8HMA=
X-Gm-Gg: AYBFou0sXu0VM5bnPW+hKXfJ0ZyKx+z1SDNJB3c4Ur0MKQ8WHHC4uTLpu/yqtBmzW08
 CNDcoWy8Vd0qW0vutIzKjrBV37Sg+C/QudMV5mqGORpAzHmBdxYh76nnkcEd1UX+O3wGhAzG2YL
 FKyvRixj0tsU7dlifoB12ztvd4SErz5SUrWgWbSWFZWG5bjgx8xebN6b7XYUK/cGmO5uXKwesKL
 WtwxX2FEYLLUmK4LOkwTayzQBvFFldt7cr4mdTNlC6QU2rxmqfb5B5fpmwcWaOKVxop3dX0c0xP
 Yu0FlVF4Z2bn0zvzQ0gYKjJDkQpi29Q3om1WyVEfPHYLLmriUqGjP8hvriMiWjreHpRXEBEW1QS
 sGWBGD8M=
X-Received: by 2002:a05:690c:402d:b0:8a7:ef2a:ffa5 with SMTP id
 00721157ae682-8b05af852eemr12235007b3.46.1791375435017; Wed, 07 Oct 2026
 05:17:15 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:13 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:17:13 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <20260923152941.1297199-1-qwe.aldo@gmail.com>
References: <20260923152941.1297199-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Date: Wed, 7 Oct 2026 05:17:13 -0700
X-Gm-Features: AclHuK9fmQyR812BrP9AziMQwrwHFUjo3rqy5WW49rcH-6n9GAB66clx5s6HiP8
Message-ID: <CAP48HfutC0KsevMLRfQWECjhvBzfffF9GMhEyOH=rPQBNh4u8w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: use correct offset when stamping drawable
 mm_time
To: airlied@redhat.com, kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: multipart/alternative; boundary="00000000000076b2fa065d3f18e0"
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

--00000000000076b2fa065d3f18e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping =E2=80=94 any feedback on this patch?

thanks,
Aldo

On Wed, Sep 23, 2026 12:29 PM, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:

> qxl_process_single_command() maps the page containing the current
> release slot and copies the userspace command into it at the
> release_offset within the page:
>
>     fb_cmd =3D qxl_bo_kmap_atomic_page(qdev, cmd_bo,
>                 (release->release_offset & PAGE_MASK));
>     copy_from_user(..., fb_cmd + sizeof(union qxl_release_info) +
>                    (release->release_offset & ~PAGE_MASK), ...);
>
> However, the subsequent mm_time stamp casts the page-start pointer
> directly:
>
>     struct qxl_drawable *draw =3D fb_cmd;
>
> This writes mm_time at the page start rather than into the drawable
> that was just copied. The drawable begins at the page-relative
> release_offset (struct qxl_drawable embeds the release_info header
> as its first member, so no additional sizeof skip is needed for the
> struct pointer).
>
> Apply the page-relative offset so mm_time lands in the right place.
>
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2: drop the sizeof(union qxl_release_info) term =E2=80=94 qxl_drawable
>     embeds release_info as its first member, so the struct pointer
>     only needs the page-relative offset (found by Sashiko AI review).
>
>  drivers/gpu/drm/qxl/qxl_ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c
> b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index 591b026..65e9bfd 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -188,7 +188,8 @@ static int qxl_process_single_command(struct
> qxl_device *qdev,
>                  u64_to_user_ptr(cmd->command), cmd->command_size);
>
>         {
> -               struct qxl_drawable *draw =3D fb_cmd;
> +               struct qxl_drawable *draw =3D (void *)fb_cmd +
> +                       (release->release_offset & ~PAGE_MASK);
>
>                 draw->mm_time =3D qdev->rom->mm_clock;
>         }
> --
> 2.43.0
>

--00000000000076b2fa065d3f18e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Gentle ping =E2=80=94 any feedback on this pa=
tch?<br><br>thanks,<br>Aldo</div></body></html><br><div class=3D"gmail_extr=
a"><div>On Wed, Sep 23, 2026 12:29 PM, Aldo Ariel Panzardo &lt;<a href=3D"m=
ailto:qwe.aldo@gmail.com">qwe.aldo@gmail.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">qxl_process_single_command() maps the page containing th=
e current<br>
release slot and copies the userspace command into it at the<br>
release_offset within the page:<br>
<br>
=C2=A0 =C2=A0 fb_cmd =3D qxl_bo_kmap_atomic_page(qdev, cmd_bo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (release-&gt;releas=
e_offset &amp; PAGE_MASK));<br>
=C2=A0 =C2=A0 copy_from_user(..., fb_cmd + sizeof(union qxl_release_info) +=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(relea=
se-&gt;release_offset &amp; ~PAGE_MASK), ...);<br>
<br>
However, the subsequent mm_time stamp casts the page-start pointer<br>
directly:<br>
<br>
=C2=A0 =C2=A0 struct qxl_drawable *draw =3D fb_cmd;<br>
<br>
This writes mm_time at the page start rather than into the drawable<br>
that was just copied. The drawable begins at the page-relative<br>
release_offset (struct qxl_drawable embeds the release_info header<br>
as its first member, so no additional sizeof skip is needed for the<br>
struct pointer).<br>
<br>
Apply the page-relative offset so mm_time lands in the right place.<br>
<br>
Fixes: f64122c1f6ad (&quot;drm: add new QXL driver. (v1.4)&quot;)<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger=
.kernel.org</a><br>
Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" target=
=3D"_blank">sashiko-bot@kernel.org</a>&gt;<br>
Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmail.com=
" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
---<br>
v2: drop the sizeof(union qxl_release_info) term =E2=80=94 qxl_drawable<br>
=C2=A0 =C2=A0 embeds release_info as its first member, so the struct pointe=
r<br>
=C2=A0 =C2=A0 only needs the page-relative offset (found by Sashiko AI revi=
ew).<br>
<br>
=C2=A0drivers/gpu/drm/qxl/qxl_<wbr>ioctl.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c b/drivers/gpu/drm/qxl/qxl=
_ioct<wbr>l.c<br>
index 591b026..65e9bfd 100644<br>
--- a/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c<br>
+++ b/drivers/gpu/drm/qxl/qxl_ioct<wbr>l.c<br>
@@ -188,7 +188,8 @@ static int qxl_process_single_command(str<wbr>uct qxl_d=
evice *qdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64_to_user_p=
tr(cmd-&gt;command)<wbr>, cmd-&gt;command_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct qxl_drawable=
 *draw =3D fb_cmd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct qxl_drawable=
 *draw =3D (void *)fb_cmd +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(release-&gt;release_offset &amp; ~PAGE_MASK);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 draw-&gt;mm_time =
=3D qdev-&gt;rom-&gt;mm_clock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.43.0<br>
</blockquote></div></div>

--00000000000076b2fa065d3f18e0--
