Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705B606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a70raC/1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C871910E213;
	Mon,  9 Nov 2026 05:33:23 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2784210E213
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:33:18 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c468bd799ecso59432766b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:33:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794202396; cv=none;
 d=google.com; s=arc-20260327;
 b=DvGWrZekNYaqWOzEGwMfkbQZyEyA2ygJ8hcoRm1R353qXXmjQIN7oe4rlBBJa9J4jX
 Su0/OPUvesxjl2ADXsTHKFgJxoL74JF3b5IL0vtWvobPwxuBRxNDw45cD/ymCY9SrvUo
 B+NVTZbc5+cZMRGOjrK7H0lqxlDuUYpbKGOvDpAyyVHNR1XmriPF+WwpPOEiy3i6P/rC
 s0E4asEduVUOaXF5jRHBLq9rgzafRkMRgz3y+16pUFvq1RRJFfrn6ymlLp7IhLpek/xH
 HyXsNxEAIeoZsd0l/qdpaD7JX+p7m3UmPRL/Qna3/iKwPVQVPq3FfZEZVpb8IvXh6HEk
 rXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OM6oEuV+WEcl5iZPW6qWHn//Qd9/cDvZHfthnu4mT7k=;
 fh=coJ4cfaQ7SAtG3KA/2OI572D1zm7hPERgBXIl4qk7mw=;
 b=ZLGGOlwCoZFOyT6z/UloDDFHAnFaBPNVwJDSdevtZioM4YWW6mitUdXqOvL21qSLXi
 /OJN0oni0/W1zyBzULxx4UUG/IyJfLB2rNft/NSu62zC0ZM7ZZscmJa1U8sA1Me66haI
 ko8+R95y+tR51QkA5maHhKH6tGDlxKa4V7sSRWeLtHyvlqFL/A4M/rTpwpOyieIgHlSd
 +mpoo+RHqCI3PZ21kdWc60E34UlGFwk1aXnPFun1fHjMCpbxr7EUbMu5UTulMc26Al3B
 hvvALALNBzxfK03EbCeQiKC+T+9dAlVhFAqw0PhWKXP1od2N3+AeRLKGG8yGPVo7bwwA
 91Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794202396; x=1794807196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OM6oEuV+WEcl5iZPW6qWHn//Qd9/cDvZHfthnu4mT7k=;
 b=a70raC/19c+0yKUIj5YaPoLsgAuQrXmGtUCVkKMLkKlq7Bu0uM17ZqlVp0OjWdtHVW
 7VffkGpr4w+4R1IH+v1ORsSPIfdX/SjZMY2LIaah7t5FyInebJodEjEfIdUBlFgERDo9
 FraqwtLnjbUqGTRDe7VN88sWWlL3WllaJPk1FZEC92SM6Qvf61qCyatN7hTF/5bdZTWR
 XERH7O+evjae5aJArQygqBuIdjkCmNY4IeC5DLBwz0WTVN+diNjH7qEu+ONuNTKng8yP
 q1I41oRd8HkCk8IKneCar9ezpRUQTEKEpOPBSY2ZOelSU93pThX8LP80PPgc7lCl2d6l
 mOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794202396; x=1794807196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OM6oEuV+WEcl5iZPW6qWHn//Qd9/cDvZHfthnu4mT7k=;
 b=aqISyv1qP2vCdzTVE9zQW/Xoon0pFHIDW6WMiIo6cPDQ/Z5Nm1ioozAvCBL2dUlPhM
 PbIw1TeTOXGJxvfKRzajMX3Mg3NYnAA6BMgnSdxMcmixHc+vodTNAaKtL86/WzxT3ies
 8Y6Lr5z2kct1WLGMSnzv6M0ZqquaaxKSdRS58CBLgOZrVBc8PxSo7stJjw/4NO2iAW6y
 mygF1sYamne+1D7kj9CVLEmAxUFG5TLN1H2h9oIKHUrpuPxtRdOymlS9EeWU5PDERTP7
 F8NghJM3Nntkj+a0JBQ213RxvXNfKsfKKjfkOM0+PEzseUz8wXtRL5xZvT5oatsSoadn
 0a7w==
X-Forwarded-Encrypted: i=1;
 AL+hErFxK89yhWgpjLtPOtjL2gu5Hk7Oo1y/IQY7Kj5V1UJmUbBKFMV04A7aI+gPqHHSKf+pZimeSShmkAI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kSLYsAZOmh+BDe/uCCk1a1QFZ22lXZATePww326f4vTauFT/2
 YRk9VedEZCKZlveDQ6/VXMDBi810H9bDsdmTUiyU+JjNT3D3K+Rzhe+erLiaL6fppTiwlOe1DVf
 rP4zzAoe9CvnX3AhluseqzehB4pa1o7U=
X-Gm-Gg: AYBFou3PXGDMFUV5GUixInpSW1Bm+Wh9fzpmmBQn3ZqVbI5WmH7BMwqk9137tWVhEcM
 8SYOn6utq31dSnLYtjdshgs6rGnw4/8H4ssD6my7GjTskcEuGYCZWmxj4V13SbO+t2Q3UQoEvNm
 dQJVv8Owdojx3DzKsKpBkhli/eyeDMgtdVBriRxm1JmzWBmbo4kxfE/QP4LzhRLL+tHI/wWs8cL
 rNoHMBn/Lk0b3JQf2hpUZIXdkQwxzObD8vnBrqtZMf5D6R7WXFIffY3n+xrLmzksKqF5wcTG1qx
 LUMxDb9StoQVYCXRcGvRZNEuGUK6vTfFPGp1Zeamls2wZqzvmi/i6uhHqFScYRqSk+dDipNx7IL
 Fe19S3D22TZbv789jE0eDf2/Me1PYCjPc+zf8Q9RIM+Js6o4ofvfZGEh2kq8zoS43E8gkGIL8Pu
 PQ6Au2ZvarcjGf
X-Received: by 2002:a17:907:6d07:b0:c40:4965:72cb with SMTP id
 a640c23a62f3a-c4d6db36f84mr196935166b.21.1794202396398; Sun, 08 Nov 2026
 21:33:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102104642.925-1-laixiangwu@cmss.chinamobile.com>
In-Reply-To: <20261102104642.925-1-laixiangwu@cmss.chinamobile.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 14:32:39 +0900
X-Gm-Features: AclHuK81e7ha_bd7N8D98DCzYoOYBA4JG5Pa3ARfHZchUTi79ZwM-36h02cCqWc
Message-ID: <CAAQKjZPOqEYe+iabUsdyfoxQyRRWUnX3Fe3eqEN8Uw-NU7vSFw@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: scaler: Fix runtime PM reference leak in
 scaler_commit
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

2026=EB=85=84 11=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 7:48, X=
iangwu Lai <laixiangwu@cmss.chinamobile.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> scaler_commit() calls pm_runtime_resume_and_get(), but when the
> scaler_reset() soft reset does not complete it returns -EIO directly
> without dropping the reference.  On the success path the reference is
> only dropped from the frame-end interrupt handler, and scaler->task
> is not yet assigned on the error path, so the interrupt handler will
> not drop it either.
>
> Each failed scaler commit therefore leaks one runtime PM reference and
> the scaler can never runtime suspend afterwards.
>
> This restores the pm_runtime_put() call that was already present in
> the error path before the conversion to
> pm_runtime_resume_and_get().
>
> Fixes: 445d3bed75de ("drm/exynos: use pm_runtime_resume_and_get()")
> Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>

Merged.

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm=
/exynos/exynos_drm_scaler.c
> index c8a1b6b0a..dc8189685 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
> @@ -372,8 +372,10 @@ static int scaler_commit(struct exynos_drm_ipp *ipp,
>         if (ret < 0)
>                 return ret;
>
> -       if (scaler_reset(scaler))
> +       if (scaler_reset(scaler)) {
> +               pm_runtime_put(scaler->dev);
>                 return -EIO;
> +       }
>
>         scaler->task =3D task;
>
>
>
>
