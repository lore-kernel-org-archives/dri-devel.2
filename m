Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1B606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNbB0MHO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C8910EB30;
	Mon,  9 Nov 2026 04:17:44 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AFA10EB30
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 04:17:38 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c4d7d591607so63716166b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 20:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794197856; cv=none;
 d=google.com; s=arc-20260327;
 b=gN+KTRDDcYN4xRV6KWs1e57LJbUnLTZovEMooK5XWUSAz+x+Vce+rQwRh0tZ47i/G+
 J6+9V7BcphueC10WLv1QzA1tQvpppt6BtY6TakZZsZ8AOKQYxvYQQtVdqKbRKPQj5ve7
 Wr6JFjsOqyhCyx8/44V6BcnXt/5YyZecP6Vr4RDG6Esq0P15oeUbbQ0jUqs7SzntPgdv
 IuHVL/m4RtB3pRBvDECDC2+5kqJ5eSB6DtesecJrI2sZxRNxx4U0VB05YMRFh1UrA6eJ
 cuLtv3RvxumphmeBtGx1GWfZ3eQJfylyoI3Ot8JwTKfihBQLewAVeYVn+/zJCfgTB+sC
 jxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LoqW5deJGeRyx4LL4mvcaMizyiaP0FzBVvAer8RqNLI=;
 fh=7Ss9UAjYxP4lHpJ5egJRAqSvY8JlcZIYXiK9XFgYvsY=;
 b=ay9nmF9FPnOchtGvDTn/mJwPoDx81Ki/+ZtX+CvqmfCJaVZcndamocl55ZP0GL5EEq
 MyMaWWH1/3M9ItSMD3I1t+VDPYbpZB+tpJm3D+mlddcs0dQSH7d3kIM8UZ39Gj+ffRhW
 KZIrwYgjfrBckJCLYg7asrSmHKnzPt11KusV178FAgQSVXMFXfX8qosJP2XuJ3BYOwri
 LNNyvFVFZZmVay1pIfTDDwWvpM1S5eHVmcokeM3fZ62HupwvW1ZdSFbgE43S3ixww90X
 QbIl/DcBV92javWS17oxKikwBKtj1179AtEsdPsKFmg/s6smiQI93KgS52UPlt3P0oMa
 9ypw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794197856; x=1794802656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LoqW5deJGeRyx4LL4mvcaMizyiaP0FzBVvAer8RqNLI=;
 b=KNbB0MHOGeek+unqeFSu01SQZ3UBusxYqnkCoXvGREy4QPWnYB8U0CxgCydYS9dh2E
 m4Kh+nJqvOwkuJoH2XRl88NrqoeBL1PjGEoxOwvW1Q8Z6BmuT1OyYHaG2reYZ9n0h+Fy
 Z6BqWIzb1sg7kHQIf8xRSq/UVxrBtVZT23CfyR7DWn862rvR9fosYEf5LBNY9oe3i4rs
 0jiFOt1kYZc9d88/a7ncS01eh6oSz4JU5AHUU1SAZm0DGFR08KEgesN3KXBIt6bY7vM1
 +9eHePbku2DUbLdKLwYFnCzB76CRCWli2oqnsT9n3fA87X7BDeQuXAXGYCkWW9xFySJb
 a+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794197856; x=1794802656;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LoqW5deJGeRyx4LL4mvcaMizyiaP0FzBVvAer8RqNLI=;
 b=fls5YhPzgNyXCzY3prkV1qsIEKnVhfxw31MobCzz8gCImwc5BUJFfEm9iT2+UGU+6T
 ey9YqtlY7mts5qb0V3z2yrbAJUs4yNUo5M9pjK9o7Sp/JB0gjm3t/hdQ6cXUIrNOJKoE
 n3fRtCWvePTH+6IQ+UXqsziJyaqjdzVoEIeK29gKspML3KJTsqf0sd/sz8yCxBr+49Wp
 jgCr0oLcMpzc9hl+irecAhPnIUjNHWXVDuldJcVnYnA+r7ebSxTJ5x3rv8kaT/vWrGC+
 P/qxZqJ/emlGVJS5I0JR3InrP4BJM8mpPC5Xmrse7F4qg9Lp6r7nxVItvrq5tJNEsByu
 bKWA==
X-Forwarded-Encrypted: i=1;
 AL+hErHb+y5OpvgW5Hz4k7tAtqwBfZ+EQjvbI4T5Q+TrVbNW/DGO+Hr51W1gWQ/bIAeA4BK6JlzGkpN1QD8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2I+KLj9+FBbFSSvn/m7UJ6OI3XEZBM4DkZX2nhtBxOBW4zd8X
 2QsxmFh7BYrFi2NeXM8sQgOwQrdOByYpmmqF79ioE6lf3UqJ+rY4Rw3Ph9u0I3cxg7G2hL7lys0
 8Mkrk1dZV9isOVB7n0ivsbRaND3J2KZo=
X-Gm-Gg: AYBFou0WoQZ24I60A/LL/Pk/Oa+Y0qbngXM+YcFKOLQ8kFXklfalHjnJLR1GxAGZJeJ
 BM494Fh+hgIiZ7c8tJCVrvix5mhGyWjgfcGAgSq+m45Qcc0cdHQtFnAjYq1jHzRzoAbKtHs18yC
 iHWYmnT33Pubu6fz6PJxtF2Pl3NRLuijoAnnjjxBV+8ZC3Rz6c46WRVuhicFeYTbrzHP1zw2qbA
 qkuKsUKyWuDLxxv0Mvopm2em4hSYzVXvwT4KY8lMfkUvzdTI1hJbO0z28CgXwzH/HcRKvATepPl
 V9JqGNPCPul8ytzrnLY/pd9nlydBndQoHaXFA/nksFHSmyZzcGVP+KMmqeJZbCvnWgxGFltKuvu
 7gTNYEle2y0+rx5K/Ejt+3z8So2L3af9DSHX1AViLYt1lSM8qT2w2Gqa8g57mLBO0V34=
X-Received: by 2002:a17:907:6d1f:b0:c31:7495:e5b with SMTP id
 a640c23a62f3a-c4d6d4a3b57mr182492066b.10.1794197856252; Sun, 08 Nov 2026
 20:17:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261003080927.430719-1-yaojiale02@163.com>
In-Reply-To: <20261003080927.430719-1-yaojiale02@163.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:17:00 +0900
X-Gm-Features: AclHuK_-J55s4cWgSUjxGa52TLLl1osPNTJb75kFDeEkQ09-Bw0YuPtbJyTYZXU
Message-ID: <CAAQKjZM991J2BoFkqnsyP35Lv91FYmmdpN93vqRVxRsTV-pu8A@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fimd: handle runtime resume failure for DP
 clock
To: Jiale Yao <yaojiale02@163.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org, 
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

HI,

2026=EB=85=84 10=EC=9B=94 3=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:13, J=
iale Yao <yaojiale02@163.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> fimd_dp_clock_enable() ignores runtime resume failures and still writes
> the DP clock register and updates dp_clk_enabled. This can access an
> unavailable device, record a state that was not applied to hardware,
> and later drop a runtime PM reference that was never acquired.
>
> Return without changing the clock state when runtime resume fails.
>
> Fixes: 5d91394f2361 ("drm/exynos: fimd: Guard display clock control with =
runtime PM calls")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimd.c
> index b6abdc4f2b0a..ea2b961f0cbc 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -1049,12 +1049,18 @@ static void fimd_dp_clock_enable(struct exynos_dr=
m_clk *clk, bool enable)
>         struct fimd_context *ctx =3D container_of(clk, struct fimd_contex=
t,
>                                                 dp_clk);
>         u32 val =3D enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
> +       int ret;
>
>         if (enable =3D=3D ctx->dp_clk_enabled)
>                 return;
>
> -       if (enable)
> -               pm_runtime_resume_and_get(ctx->dev);
> +       if (enable) {
> +               ret =3D pm_runtime_resume_and_get(ctx->dev);
> +               if (ret < 0) {
> +                       dev_warn(ctx->dev, "failed to enable FIMD device:=
 %d\n", ret);
> +                       return;
> +               }
> +       }

The early return on runtime resume failure avoids accessing the FIMD
register while the device is unavailable. It also leaves
dp_clk_enabled unchanged, so a later disable will not drop a PM
reference that was never acquired. The change looks good to me.
Merged.

Thanks,
Inki Dae

>
>         ctx->dp_clk_enabled =3D enable;
>         writel(val, ctx->regs + DP_MIE_CLKCON);
> --
> 2.34.1
>
>
