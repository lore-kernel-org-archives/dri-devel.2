Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A437606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNDkjr1U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515A910F00E;
	Mon,  9 Nov 2026 04:47:13 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8266010F00E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 04:47:07 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso70216866b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 20:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794199626; cv=none;
 d=google.com; s=arc-20260327;
 b=IznqvYBxTbVNJpiDwuv7dIacbgNhPJ+Az3nP7gmCbFHabTTqhwgV8aC5b/e5j4OZNl
 HJQ50dxOQ00W/suUTHziKEPGa9N7xkF9R+dDje4iKRdABn2HEyrxnD4PXwQYYccWHMJ1
 ftmdEsrfn+RC3A3zM+C5wGy/UjSYyCx3+AP7dx7RYvL2vdLJOlRKQFhd9CRJbEAnX7tf
 u+zwjl7da9pYnTPvAz4F8BqFaZ8WNX+Qr1VJYi2V6Earfjc6Pxg661wtFJgwgY74mMih
 IAT5b+EDzKb7p60LRS7TFmP5u58m5fQdXTncVzsac4Fmrbhe+U2E3QqwR89qf4UnyyMI
 rQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CrfIutPa9zzmKoZjuVxyntYvgSPp8Myo4B82If1gVcQ=;
 fh=cPBsh3kV1nVk2VxP2RhmKErIJU9yeY25ZyMxeEyjwKI=;
 b=Vg/12nSLLX9sNl1OvK5zvLY0SzoayMSP2iw4OsCiLAcoiD7uzusxl5PhS+kv9psvZk
 Rso0yTMjD9kI7d9RHVugvhumEr1aiA4kNgnPdb3Ov1z6xqa+Jo7zxOawaEzVb/Yx+hl6
 KmUHZwiaJpZHy+NOJiX2zyJaF7Fe1Q/LJ0sQFDEhLG+xmsll02jIeeAdfivi0/JXS1mf
 m6SvCLLwLhYYyHtdKz3hNP3Gy62mafTR7hU8rAzoycwpLGINvfa+nNEOWovytkhPXmEQ
 Jjzn7saE6mjNKOhhrNG14n9rvpMwWyMb8k8DYIbB+jxAXbm/ovmIE7T6Nfo1qmHKUfYu
 mDOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794199626; x=1794804426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CrfIutPa9zzmKoZjuVxyntYvgSPp8Myo4B82If1gVcQ=;
 b=JNDkjr1UArLInb9UEGgn4IRghLvhaLL473l86vEXqWLnHUhPKqV3d5XqoLO2Lfm3O1
 4TA4j3sK1aaj5uOP6xBdRnlxMUZb4aMV/w5aNVZ9ZsV5W8NwLCEt7Xws9FgoMgyq3mYD
 vCLKv1ji573alAQzn+pD5z5bpt1Ua2VN8trX7OQS5r9O2aB0Z4vyo7fuA9oNJbuYg/Yn
 2FX3v0S8eJdPlAtIFgL5njjAVCvCac0Fd2slxp4LQktEpMVF5iKty/EJf2oy3Bi8hq6Q
 dw6xYzE4k0y2C6gYuo7uwodPTbknuz0zItRQtWofMqZrZZSnp7EbaO2X78RqQQwz1MJc
 5pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794199626; x=1794804426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CrfIutPa9zzmKoZjuVxyntYvgSPp8Myo4B82If1gVcQ=;
 b=HbDEo+TvRcxoXwHardu6/zmeMZ8YkJoYqf6MhlxQSqaRzD9tZOnCGhgKVKFmqbbLUe
 aqT1HjaG3j8NL91jEodUh9YGW6Ax1OaXUDr6OcdTLehqhi8NUbu7JwzFtcq7C3pvgrHx
 WMkt/G3QtoHTFLeRTK+GsmtKqnkxxzifaW/6/JRrvRqCL+E3hzsBEI/qyrpuKX9m1+oN
 XkYPdZCSZ1RmuKTieWbJZGtkffss/JJnIHPgXRuiePOaKB3RY6XNnN9HRb+a3ME8Owp4
 J2rmHSR/M2ASzv61kkCJi5jLJPCktMSFPE9vHHNNWBwrgwmBFnLyn5Op3gWxKGhtM/n6
 OJAA==
X-Forwarded-Encrypted: i=1;
 AL+hErFgTkpXiqfwEzJaf01zl8YxPZ38154+m48e0y+I+VcoU2LaDP0YORa8fZ97VUqnQ8/S+mtdClPS3wI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dS0vtR0dcItib8QEtQnrGxgJqIdz890dIHopBOmOJsZsbqLkX
 IxNlh6u63lpbyFuAUqK8ZV0R2wykEpatFAf7K+Bxf8UYdr+A7fGNxWL98VPddFq20HvYO/UveGc
 Si+b5IBLuMm4n2upjfUVQBsUpQfKSbSI=
X-Gm-Gg: AYBFou1sMNLphAG7iicwSrCC6mJjFFW+BdWTXW/pVBQL3JCUVG3OxrnNutXHHpvmexo
 5BfgqWaSWTLE0QPg/iqZhaAULjwlqaqcfvSMs5NXAYIm4U+e/m+ceh4e9QcFWVX/wKHc6OiKqGf
 xw5VCapahC3zNuBzYrr8UIOjRstHtSLQcquHax7HfFZYi97xPF3aywnWidgJtOD0vAIT7JtLlHY
 2Cp2Lch99m/XJrjQW74xmpThn88NOOS4Qcwo18eRuq7z0jjZOBsO0muB/gzCbicFdTtYUraVvaz
 P7UR+P7MwM3u+iSZB3Fb7jvn6v5U7Ou6sjM2E1caOV3xKCET8dvuabgJZwGhruORLO0uqbUbt8z
 jQRnYNQoqZh01KI8h6x6DHf9gJx3QaZ9h2dcvTvT6epIpoDMmOxjZmO2DyJmFsnudGH8=
X-Received: by 2002:a17:907:3d91:b0:c3f:d8f2:f08e with SMTP id
 a640c23a62f3a-c4d6db3a64emr196944966b.44.1794199625715; Sun, 08 Nov 2026
 20:47:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012064334.3193085-1-thnkslprpt@gmail.com>
In-Reply-To: <20261012064334.3193085-1-thnkslprpt@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:46:28 +0900
X-Gm-Features: AclHuK-TjmziQBVGGqzRv77wQmyocEKBYuMMJR_pnwJjtYpt4X-8bxATAwTIBkE
Message-ID: <CAAQKjZMYrG6C5KWkbqcZX9Jdu0TVVimRksV7xNe=G=653S5PsA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: hdmi: free EDID on connector update failure
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

2026=EB=85=84 10=EC=9B=94 12=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:44, =
Avi Weiss <thnkslprpt@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> If drm_edid_connector_update() fails, hdmi_get_modes() returns
> without freeing the EDID allocated by drm_edid_read_ddc(). It's
> an unlikely error path but nevertheless possible and should be
> cleaned up fully.
>
> Free the EDID before returning, while keeping the existing return
> value of 0.

Merged.

Thanks,
Inki Dae

>
> Fixes: f6e4f57fd90dc ("drm/exynos: hdmi: convert to struct drm_edid")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index d4fce39c2b61..386557a7f5e8 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -893,8 +893,10 @@ static int hdmi_get_modes(struct drm_connector *conn=
ector)
>         drm_edid =3D drm_edid_read_ddc(connector, hdata->ddc_adpt);
>
>         ret =3D drm_edid_connector_update(connector, drm_edid);
> -       if (ret)
> +       if (ret) {
> +               drm_edid_free(drm_edid);
>                 return 0;
> +       }
>
>         cec_notifier_set_phys_addr(hdata->notifier, info->source_physical=
_address);
>
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> --
> 2.43.0
>
>
