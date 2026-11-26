Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B2606A332
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TyjIkEZl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54608112827;
	Fri, 27 Nov 2026 08:29:12 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB2C10E27B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:17:45 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3ae2ab35d82so54276381fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:17:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695463; cv=none;
 d=google.com; s=arc-20260327;
 b=F7mHiuqZl6eXyVMHqpPgX26eqFrDQOD53bt5ay4YsdK83WqNdcBXsGc1O2fnTNdYmb
 ZaWXVanANfhOpTc6HHx7qUdiqPciTUrjhh73gBy63TycuG5XuoylYIRpPsiLnmHa+Upx
 6Vq5TS+WS6JHVrSyd+8l4wtBE6qqvuqEYCEQzOBbX1vOlgh50pWJnR2CqH0d9N8AZosZ
 162NoRigtGMLOWmHQk69BURG9wfNk/pCQvblwFizvhkDDrEK/FQyODNdW1wrXS9ES757
 2W6u8p+cggLcEukQYiKzv3yfVF32UXIZ5jwMSkGJtMR45CxYDe5U8YRUludgNxMeH6iS
 slsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tS4DK/Z/nXg+Nlh3W/S6wz1eeL7t9aOqjv0btWUE9V4=;
 fh=+/IHfRuGAfEb0+HreNk3E62tBbe2vqMcFy2cLkCBeFo=;
 b=JmClaqHSC/B6klpioAF+JJh16qrPDbDpSH4A4fySBVYG5F8WZGE+FSGy9YE15mxXEo
 E8rx83bGDRmoxSykOVX5Y7Vfej1vUI4vzmaDd9JARc35sxSGGEUDaixLEkBpzRzrzUlB
 QIoym8feeZQHH4SC6IVIIw3P8TPuqjYLb0/ILkC16GP3mzvLN1dBBoDVnQdi28GZnIFY
 twwatjBrDdRchj9Z1yqmrYuPArySNowiDMkmuibK7Cg4gxK5MQoaKmuUs5ba0tNwVdTY
 6MSu7lkSM/nKFjnAC5RjSlXJLdu1ZrP4hbh7DIf3BX2HxAe+kLRJYesmLyxygoivLTUh
 iE7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795695463; x=1796300263; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tS4DK/Z/nXg+Nlh3W/S6wz1eeL7t9aOqjv0btWUE9V4=;
 b=TyjIkEZlJCZlTBniCRCV4SpPWLZZUmMYt3kdON2kcYO5MXWW+07TjRk7EnnZRAyVQX
 iTDLWCzpmkJnqcXpoGioh41QnJ7grBHWiNeaVP5icdXG2DpNLXt3rA1TaiU3u1Kufrd/
 b46C6F65yw4En5qNWMhdD9tMsRbgZmGqqBPTP5aSscb+/Nbg79FqcpJEmozA8ih3xkMg
 G5eRiQhn0WKln0PNBn4Jwenm+Lbo7xEA3xFGIWv8LVmxh/+Z7wkllqWKnpgoZOLxMAE/
 pbdan++1638ANZ+DbHoNnqkrdCraAjFRcpxNHgDYUEeVXf7LJZeJ3jn29fBoBbLpqoPA
 3hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695463; x=1796300263;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tS4DK/Z/nXg+Nlh3W/S6wz1eeL7t9aOqjv0btWUE9V4=;
 b=sS8VgculMfifJD9TrWUGpjCA/WhFvuHiawvyQ7Tm3oVKhp//DJ3oaGMu9QEy1lEQ6l
 uNWdissSFX0kDYZOS3UkmoYC3wpHl1TqZNR6+E7Ny7vrLqTYB8c1HoOjToI5A8NPjtI0
 Mx0x3f5FNF8I3dU+Wjzp/yZPcyC8rbp+pdVs2/uYYXiWHSw2qU3npfQoxmkbEHNdpA1D
 y9pGK1o+Ec1BlxPHsq6vPxEuu7Vj0hKUBPIsxUX4aTsbx/+kMSQ9T4YEnTKuw/ISHkur
 ag9HRyPmmtU65un5G5HyOlpBvT6CcXlTLW4YdoWg7lHiAjSJVYIGIuu2cLBQLd+4O/yd
 VlYA==
X-Forwarded-Encrypted: i=1;
 AL+hErEvI8vk87rZAkgRX4AOC/MvJzwKnn/PJpIruNbBBMtGFVpq6K3gvBkf7uTdXR85coZMbxT17acZe4c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9GbmN4EdvhZmX/yvnH1fj5Zb+73DsyN859p48UqEIhqFNtCygy
 tCuA49IyD6hGGKK+So2LpUy+kzqLz+IAHprBDMqc5cWMFOmfGF2TMWWN4wErnsYLo42Lw6vV9cz
 3DkpgfPhYK3Kc9JSfYC7zDdfWPXJFZg==
X-Gm-Gg: AZFdTZfAlDwBs474AR1TvMzqwxMG9dtQWUhantxM513NIhWUgjhTLfsrLAkR/KzhO2a
 yeCNoPm8Bg+m33ThcCp7MxDSQzV6VA1JVWg6lj06KF2o6U9cJAcWU4frzbM+iWxCj2RJN/ifHjK
 qFbW86Aia8PJp0klDZm6gEX0QSq1/INHCfRXbcbxQfXdxGv2Fx9r3DEu5Z+5WOd1UTO+Zlru89c
 1OT7F7OiZfcQtc6IN80xTW2O+VVpVptkmf3j1do0pvwWBqE9rUkeA1em7ICWbB6lmLtSmW5eyy8
 z3+Zy4C5op2K9D8DLI1QpuhDyXQroySBAwUfc55kRpNT6wu/KjebibYZc1T2t6h7CVYwruT972Z
 oyxrb7M8OkGRWBi/Fs/xGW5/RuA+3aN0HgGxnwUFStPIJAXlDzo9yAYHupNAFZl/4sABDNj8l3/
 0UZpZVQE5aa0vaRwvkZgDA1ArQZ65oisKpok0nLg5Z0aMSiHm0iQfsHsFInjLgFMGIn4E14MjF2
 Sk5CjRmsRZyP3OWi3iSN+3EsYhXOu4Jp2E6UXeb
X-Received: by 2002:a05:651c:419b:b0:3ae:25db:67c9 with SMTP id
 38308e7fff4ca-3ae7f9f4364mr53306791fa.14.1795695463309; Thu, 26 Nov 2026
 04:17:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015135029.22698-1-jakovnovak30@gmail.com>
In-Reply-To: <20261015135029.22698-1-jakovnovak30@gmail.com>
From: jakov novak <jakovnovak30@gmail.com>
Date: Thu, 26 Nov 2026 13:16:01 +0100
X-Gm-Features: Aa3M54qkDF2IEm1HZ9RdUf31B00MvNvCVEgPhtML_f1T5jE08bwhU-raaLcZEXs
Message-ID: <CAPUiDP1_t1YNG5=HfQZ6wp_TRH2qoSseojJjWgpzQ535NE1RqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_exec: fix kernel-doc string in drm_exec_retry
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, 
 Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000003724ed06612cee00"
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003724ed06612cee00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:51=E2=80=AFPM Jakov Novak <jakovnovak30@gmail.com=
> wrote:

> Building the documentation currently with make htmldocs gives the
> following errors:
>
>   WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not
> described in 'drm_exec_retry'
>   WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec'
> description in 'drm_exec_retry' (did you mean one of: '_exec')
>   WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not
> described in 'drm_exec_retry'
>   WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec'
> description in 'drm_exec_retry' (did you mean one of: '_exec')
>
> This is because the parameter is defined without the underscore in the
> kernel-doc string. Change the parameter name to add the missing
> underscore.
>
> Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry
> pointer")
> Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
> ---
>  include/drm/drm_exec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index cc2937185a9f..ae1d074ade5a 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct
> drm_exec *exec)
>
>  /**
>   * drm_exec_retry() - Unconditionally restart the loop to grab all locks=
.
> - * @exec: drm_exec object
> + * @_exec: drm_exec object
>   *
>   * Unconditionally retry the loop to lock all objects. For consistency,
>   * the exec object needs to be newly initialized.
> --
> 2.56.0
>
> gentle ping...

--0000000000003724ed06612cee00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15,=
 2026 at 3:51=E2=80=AFPM Jakov Novak &lt;<a href=3D"mailto:jakovnovak30@gma=
il.com">jakovnovak30@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Building the documentation currently with mak=
e htmldocs gives the<br>
following errors:<br>
<br>
=C2=A0 WARNING: ./include/drm/drm_exec.h:159 function parameter &#39;_exec&=
#39; not described in &#39;drm_exec_retry&#39;<br>
=C2=A0 WARNING: ./include/drm/drm_exec.h:159 Excess function parameter &#39=
;exec&#39; description in &#39;drm_exec_retry&#39; (did you mean one of: &#=
39;_exec&#39;)<br>
=C2=A0 WARNING: ./include/drm/drm_exec.h:159 function parameter &#39;_exec&=
#39; not described in &#39;drm_exec_retry&#39;<br>
=C2=A0 WARNING: ./include/drm/drm_exec.h:159 Excess function parameter &#39=
;exec&#39; description in &#39;drm_exec_retry&#39; (did you mean one of: &#=
39;_exec&#39;)<br>
<br>
This is because the parameter is defined without the underscore in the<br>
kernel-doc string. Change the parameter name to add the missing<br>
underscore.<br>
<br>
Fixes: bba175a2d4be (&quot;drm/exec, drm/xe: Avoid abusing the drm_exec ret=
ry pointer&quot;)<br>
Signed-off-by: Jakov Novak &lt;<a href=3D"mailto:jakovnovak30@gmail.com" ta=
rget=3D"_blank">jakovnovak30@gmail.com</a>&gt;<br>
---<br>
=C2=A0include/drm/drm_exec.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h<br>
index cc2937185a9f..ae1d074ade5a 100644<br>
--- a/include/drm/drm_exec.h<br>
+++ b/include/drm/drm_exec.h<br>
@@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct drm_exe=
c *exec)<br>
<br>
=C2=A0/**<br>
=C2=A0 * drm_exec_retry() - Unconditionally restart the loop to grab all lo=
cks.<br>
- * @exec: drm_exec object<br>
+ * @_exec: drm_exec object<br>
=C2=A0 *<br>
=C2=A0 * Unconditionally retry the loop to lock all objects. For consistenc=
y,<br>
=C2=A0 * the exec object needs to be newly initialized.<br>
-- <br>
2.56.0<br>
<br></blockquote><div>gentle ping...=C2=A0</div></div></div>

--0000000000003724ed06612cee00--
