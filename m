Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D1606A332
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTftKQNV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F81C10E55C;
	Mon,  9 Nov 2026 05:44:21 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9228B10E55C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:44:15 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso486248a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794203054; cv=none;
 d=google.com; s=arc-20260327;
 b=o+h7sP7vBpdhmIgtsVkreGz9/A6SbccObjTCo8fxYVwTYH8l2wxjhzuc9h1Z8qcwvt
 VoOz2G/1VM/erUdUwOQchycRKnqdptr62mYgYTu1qhUXwBqCBZ6C4B0iIqVJAFE0RJHd
 8YXUJvKpfK9ru7bFMpqbGneBIhXFLN5kDCPRxl4vnLO/aC91OBjvdp9ErR/ZnxbWYoPS
 6UqETr/97UwXiYgqxGnn9N30/wXzMNHvcrSANHMlW25USbZGtDKI5z5aORVRDWmzsEZ4
 Q8FVK4V5n3En0h/Pwqz9oJlYzbDiGVBodJbYB8ybiUe+OKGtS/H7K5/WHoNW/oDDu+eD
 wlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GaHnyYDJUGL+w/bA52PUwEBtFj3m3UWp7S/56d6GX2s=;
 fh=HKwiqDLw4RcuZFmB7v0alLYnPD3ujZjQVFyBSSvk+aE=;
 b=SoxI+xiiJZlq2hrEB/wEGQv0p7bZiGGE35Bns/fZRa1ipAYxNCzgpSDys3cKPJzMx8
 z9T6H1AqTCp+vydp+38bMpPp/WheSGAd9ddaMQzC6u+sM0b5Sp4KGuhQtWLW9Q5k1fdt
 PTswgz5+l9KiCoVgeRSHm+xoZ4lZFWzwFl1CV2Gt8qOLz/FIssqjPQ+IwtlrpJuXDilW
 IzYC/8dIkdmDR313HY0c4f4IlNfqAHzO80oNzh8hzlKAdfmlq/IiQMlp0I4ngJTGR0XR
 gotno9WnvEflaSJVP+dQopdXrhFlpdooR4h4wmclJDTPHvZCaEf+I8ZPRAPxr8wLh/Rs
 ai6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203054; x=1794807854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GaHnyYDJUGL+w/bA52PUwEBtFj3m3UWp7S/56d6GX2s=;
 b=HTftKQNV4FtZAHVHmP02x1yoFTyN5Y5/b3CXAkAFkwmdgAJfUUyb4YqhYktmep3Vec
 yYInHlu2kHVqqm5eZqlLFU5jYdBGS2RVhTFGa0DQyCgYtrAL5RLtZbjkzLCjeOyqAWpF
 dKEIkzArqIFlGUu0DPnYekm40Y0qzi0glGG9DsAAjhexC7HIgjtZdamP2+r76eXjMDBY
 d8TwXYk3bW3B7Y3yGGD1nZ8fY5lfDFcKGNwC35wRVE0jqHoqV17Ratwl1GSrpeKHHr0M
 Wwf7uftp5DW28ti8GT6NQzA3X+wd9ZjTPNd60kiMvSgRnDesSSCwKv92N9t2uex2Hkc4
 sy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203054; x=1794807854;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GaHnyYDJUGL+w/bA52PUwEBtFj3m3UWp7S/56d6GX2s=;
 b=uyFoKb4SEU/qQUtzCuGMjGKfyoG4052M1wmVJIq0stgQj9GLh8r9XiVqdMs6my877l
 Q3+kd0eOODAUiH1hNmFvO0MbAuseoUmA1SaFooBZSuacXO8tvpcP/cRt2q/Z44pMIae7
 rFT9rIa7zv9Eu2rTZSN5+cRSHQaGPgQreqVyds1sAXuzRpa8CXYlCDJsXpVKYiGgU0m7
 fBf/neRL8TO53gk83wVrE7/FB0ZM70R4eKhQrxa+FQoPrYAHM7dQvXsViyI06oAxinW7
 /ADVessCCfUlBkAZrLV1PONv76XQ/E3mq1qFy/N73/KJG5fQan3hFoqxwU4H+BcxauTi
 jrzA==
X-Gm-Message-State: APuU4Z9Y9rlR+HdWvnyWLIQ6KLLuvGvFZTftzWxMi6FCpU5EA7fwNdik
 MbN/yFPLx0zHx+MK73q1erFwZF2DwrsW3BmpRu01SyHdoZcTomwjyAfDnmttc7mfvFzGDGMk45O
 khbkVXVXSXvq5e05ZLV1+Mxyqkg7K6Ug=
X-Gm-Gg: AYBFou3qOwa7Xv2IileMKN9lMm3ai6s2XH3ENKRTAy8OfiCcJ4rsklU+/USMDzqw+GX
 Akkqdk7y9LJRWXLtp8BTM3T/usir3oXTTTzOv13mndKPz3Uyggs520+vc7J0eQWL2qfj593V+Vu
 PQZOy4eNiMjsxCL+nVcxAl5w01exX+ejhocgvtUcU+Wp/5ZrD+WqgqXoS0SsvkFexkYSHZ3eIDi
 YbIKcMujHBulnmMAPIch/UNRBh+iXUWdoGeYzLRVWQr0akzTO1+3QEkWByx/x1xCvTeTsiiC6xp
 G2NyiLnf6MtDkr3H9KIxbYvwNflecTA/UxtZ0fPTav4z6lJ7eVBAVo86Yjv2/kwmXmSxk33IKJA
 Z/dX4X0d7XI/HW4MGhcLf960n3cKNbA2nBHn4ax9ct/C1+CKIpqANSfn7EYsiNkEWjcA5HY3DK+
 JTwUA5Szy8S9hP
X-Received: by 2002:a05:6402:1950:b0:6b6:ef7f:600d with SMTP id
 4fb4d7f45d1cf-6b722450928mr1861820a12.21.1794203053889; Sun, 08 Nov 2026
 21:44:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916072012.1967169-1-vulab@iscas.ac.cn>
 <rc-review-20261105-14-00955ac4adbd@gmail.com>
In-Reply-To: <rc-review-20261105-14-00955ac4adbd@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 14:43:36 +0900
X-Gm-Features: AclHuK-P9ELAlBzpu3kDklHAW6kBOMQIDNRsiWYypfDAoEI-hiru14eAfArO-Rw
Message-ID: <CAAQKjZP_djWPUxr+B8jH_m_=MAPFcWmxst7fR727uNbP59xagw@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: dpi: release the node after looking up the
 panel
To: Yige Jiang <yigejiang86@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
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

2026=EB=85=84 11=EC=9B=94 5=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:07, Y=
ige Jiang <yigejiang86@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> exynos_dpi_parse_dt() acquires the remote panel node. The posted
> display-timings fix releases it on that branch, but the panel lookup
> path still retains it on success and failure, including deferred
> probe. of_drm_find_panel() does not consume the node reference.
>
> Put the node immediately after the lookup and clear the unused
> pointer. This covers both lookup outcomes while leaving the
> separate panel reference and its existing remove-time put unchanged.
>
> Fixes: 14b6873a0198 ("drm/exynos: restore parallel output interface suppo=
rt")
> Link: https://patchwork.kernel.org/series/1166158/
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
> Based on linux-next next-20261102 (2637bdec0535).
> Compile-tested: arm64, GCC 14.2.0, W=3D1, CONFIG_OF_DYNAMIC=3Dy.
> COMPILE_TEST=3Dy.
> Baseline and patched target objects built from this exact base.
> No full kernel/module-link, hardware or runtime test was performed.
> AI assistance was used for analysis and patch preparation.
>
> This is an incremental patch based on the following posted fixes:
>   [PATCH 10/20] drm/exynos: dpi: Fix OF node leak in exynos_dpi_parse_dt(=
)
>   <20260916072012.1967169-1-vulab@iscas.ac.cn>
>
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_dpi.c
> index 92e8bbe9d35b..e98a9be0a705 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> @@ -243,6 +243,8 @@ struct drm_encoder *exynos_dpi_probe(struct device *d=
ev)
>
>         if (ctx->panel_node) {
>                 ctx->panel =3D of_drm_find_panel(ctx->panel_node);
> +               of_node_put(ctx->panel_node);
> +               ctx->panel_node =3D NULL;


A patch covering this same of_node_put() change in exynos_dpi_probe()
was posted earlier by Wentao Liang[1].

[1] https://lore-kernel.gnuweeb.org/linux-arm-kernel/a46a7710-0c2f-4fd3-911=
6-7678adca9390@kernel.org/T/

Thanks,
Inki Dae

>                 if (IS_ERR(ctx->panel))
>                         return ERR_CAST(ctx->panel);
>         }
>
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> prerequisite-patch-id: 8f90819fd9f71f55560dc3af57c5a0bad07bc568
>
