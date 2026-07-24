Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72BCC5321C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8787310E2F8;
	Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jRgYAWCj";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7445510F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:23:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so985295e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784877823; cv=none;
 d=google.com; s=arc-20260327;
 b=eKvR0DlO3s6+q3TiBnpUCqXm4SPqNqFCruljabn7HOrDARnOGhtUOvCId3Vtw3ULl/
 v3c+aYIz/vm4+P+NfGXhMGUbsSRM4wHAd6zJZAajeLXqbFm0S+tOXrbRVy2GWCPuB8fM
 FH8LXQk0RWlyEJhLz+JAhCEhcHaN9Y/ptw8alTsIrxdS+HGaFjLR+XPuyWdKQFFKguJG
 87qLY3LI/j1XNw8zrwU/HXnW64bZ/mOupTbRlL5lFf76QX2yU26i8k8QYkksg4metB6o
 58LLzNN44akr+KX6QEwy5tv2JBjmQLzi9GmJjrNtZlSTjDQUYaxpM7jNiLlWqLFiggVn
 BkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2/UpSMjCxZMiRZJFhdL06C85kCywDkfMhy0VNYMUkfQ=;
 fh=/hMMvQ3Q4h0gMfhQxykDnD7R1lUKiZls2U5a4LYwn60=;
 b=QZYuC4LsHvrQACkYolXRBxwuDVV6yvyz50/BdsGoVg0QawICbcM2Spb/WtJTrl5lkt
 5rpyqeJBhLxt/alfePvxtMJ0yAVnpVNq1uMC1Qn30zFEGTZPlSBy3QuytW1wGR50g2M7
 kiF0gfuR+rJzmcyiDniwxLK9DfcJPS1mnC3kUzt+0nm96BN3ibZPU2+sIZ5RApZQmXBy
 kcJUVvaNYJoqvpDyBdW0vl6mg9juy94Whfj7gODFJNlVcaiMwisT0zyFnANHpEgXjEvi
 E5xtJtTbtgnos++ep7CTvgsTyGG18ZOK4cUFkzjmGTtGVv3kX5fin45XAdOLw6l6HukM
 OYpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784877823; x=1785482623; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2/UpSMjCxZMiRZJFhdL06C85kCywDkfMhy0VNYMUkfQ=;
 b=jRgYAWCjM//fyd0m14OKIqE6eKsYb6yKgG3XtxFkZoVEqXx4FfyYb1ZCYWt2BObGIk
 KCEow118SOp1CXqk6cywSQ02BJiYR7GWQw0SqVOnxpWe2LtIq10aBWWZwhnbvM1hcFwC
 /VbolgYhYO36dQvAhsyGbB37dIXOFHi5Eyis9wuf55uEZ3Rl48JpeDjIfgWmRl4AieYS
 Udhc3FsyymeL7VJFZ/4VMzkOJ3TItpc7v2SDeQ2Gau5HIsxGX+BNU+vsz9fF/IGM9RBN
 6tRqQfBzXJFEAHwrehB2FpZ5dq1jtV09dLBFaTARXnU5XJFYhNbHcafkxwsbNLp1Du9k
 8WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784877823; x=1785482623;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2/UpSMjCxZMiRZJFhdL06C85kCywDkfMhy0VNYMUkfQ=;
 b=QCqHmm+C1EMt15LQ4CmaWzb+rlPBax9iNtCQFd11ogrmNm2HoqMv7WyqyKiTCr8UdV
 dE90l31lT7Ki7kNLPai+MyJrrHxBjjsYAHTZP2u+5x3hefoZU4wpOz+xE9igrReOhpVp
 YoRGlmFXhiYHbecPUN2xif4tcpAKY/Ksm4F6C9T0nVZp4VCobI3oic95/pbhAn3rMwxq
 Ho9mUd/WqNWSs/ty3yK8ySSFs78GjB2yie/QMgAB4eLWhwko6Ozc7MAl1huaBHROoWUs
 9p4pYhwlHLclZ73Uc6lCSJboVsIPBBM8p1+0zzt4p2po8p7H4gvpOVIHJb9Z/ZO/6PDc
 L4mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDGp97HmAl1Vl2Fnk0AizxILZWalIZ+Z5fmac/rU7edemFJEaqAs+2NA3y5gFNfVxaZYHvtXgtN4Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykNKQu5TdwxtAmyHjJUUAdtE0vrbBc5G9NgE3urOk3ifcqMc3y
 4Ud3PgEu3q/yGl6xaP+1Sd1WPiM9+ra0M/J09BprPyT35XCxA3nkzU8eCzUY8Jb8Pt59tmvQIh2
 oEzaG9v43nIOB6NFzqyXYFXKZ+B6kRuk=
X-Gm-Gg: AR+sD12pno+4g2f2EFac/OpN3GVNAzYlsyCIDyi8yNsjNw0QYBbaDZT2IKCgyH/2I7V
 Un4jl8FRHeKG5otv2VPLU1wleo3iWRfFYqjWXBb+zhePmZ8uACh1B+qXi25r9FFdHLnFAlZufOe
 kfK3y4UVvsuksS4yCBAtl7sJE5mgolDBBndfS8dhJfXoE0gYq07GvXiIarwMeL6Lx+SneJzPU4t
 2E7uPTcIxf9Ij0qyIP7W68kVbl/cQJZoiFg/3IOKIEuCZxkKBOA9fyCUjfW5m7F44rM7/tJsRVZ
 VAq/m1zZQQeDl09Okg==
X-Received: by 2002:a7b:c4ce:0:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-49573cd9a7dmr46548245e9.21.1784877822748; Fri, 24 Jul 2026
 00:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260705110221.153481-1-mdshahid03@gmail.com>
In-Reply-To: <20260705110221.153481-1-mdshahid03@gmail.com>
From: md shahid <mdshahid03@gmail.com>
Date: Fri, 24 Jul 2026 12:53:30 +0530
X-Gm-Features: AUfX_mzKPqBVavqb7cnjCOiYKIX7GogF5DN3GlQeg9u0shliq5jCnnhlVjuNdio
Message-ID: <CACRLeC5+RFdLPZu=3BAbVw+vXPhp+SP2PhghYE1a7mLGP05oLg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc()
 and copy_from_user()
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000097aed506575640cc"
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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
Reply-To: mdshahid@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--00000000000097aed506575640cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Could someone please review it when time permits?

Thanks!
Shahid.

On Sun, Jul 5, 2026 at 4:32=E2=80=AFPM <mdshahid03@gmail.com> wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use memdup_user() to replace the open-coded kmalloc() and
> copy_from_user() sequence.
>
> This simplifies the code while preserving the existing behavior.
>
> This issue was reported by memdup_user.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> index 67bbf9b8bc0e..183671de711e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -273,14 +273,9 @@ int vidi_connection_ioctl(struct drm_device *drm_dev=
,
> void *data,
>
>                 size =3D (hdr.extensions + 1) * EDID_LENGTH;
>
> -               edid_buf =3D kmalloc(size, GFP_KERNEL);
> -               if (!edid_buf)
> -                       return -ENOMEM;
> -
> -               if (copy_from_user(edid_buf, edid_userptr, size)) {
> -                       kfree(edid_buf);
> -                       return -EFAULT;
> -               }
> +               edid_buf =3D memdup_user(edid_userptr, size);
> +               if (IS_ERR(edid_buf))
> +                       return PTR_ERR(edid_buf);
>
>                 drm_edid =3D drm_edid_alloc(edid_buf, size);
>                 kfree(edid_buf);
> --
> 2.43.0
>
>

--00000000000097aed506575640cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,<br><br>Gentle ping on this patch=
.</div><div><br>Could someone please review it when time permits?<br><br>Th=
anks!<br></div>Shahid.</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 5, 2026 at 4:32=E2=
=80=AFPM &lt;<a href=3D"mailto:mdshahid03@gmail.com">mdshahid03@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fr=
om: Mohammad Shahid &lt;<a href=3D"mailto:mdshahid03@gmail.com" target=3D"_=
blank">mdshahid03@gmail.com</a>&gt;<br>
<br>
Use memdup_user() to replace the open-coded kmalloc() and<br>
copy_from_user() sequence.<br>
<br>
This simplifies the code while preserving the existing behavior.<br>
<br>
This issue was reported by memdup_user.cocci.<br>
<br>
Signed-off-by: Mohammad Shahid &lt;<a href=3D"mailto:mdshahid03@gmail.com" =
target=3D"_blank">mdshahid03@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/exynos/exynos_drm_vidi.c | 11 +++--------<br>
=C2=A01 file changed, 3 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exy=
nos/exynos_drm_vidi.c<br>
index 67bbf9b8bc0e..183671de711e 100644<br>
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c<br>
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c<br>
@@ -273,14 +273,9 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, =
void *data,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (hdr.exten=
sions + 1) * EDID_LENGTH;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0edid_buf =3D kmallo=
c(size, GFP_KERNEL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!edid_buf)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENOMEM;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from_user(=
edid_buf, edid_userptr, size)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kfree(edid_buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0edid_buf =3D memdup=
_user(edid_userptr, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(edid_buf=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return PTR_ERR(edid_buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_edid =3D drm_ed=
id_alloc(edid_buf, size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(edid_buf);<br=
>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000097aed506575640cc--
