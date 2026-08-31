Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2F1C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E516910E1D0;
	Mon, 31 Aug 2026 18:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ocvf7Opf";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD7C10E1D0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:07:14 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49cdc81f40eso3251365e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199633; cv=none;
 d=google.com; s=arc-20260327;
 b=NYxGIZukDlzydutFCEuoHyZgSso5BPIrm8SFIV05kQdvncTO0sH5fCwtfRMnw5g+Bl
 Uq7fshFh9F3hN1l9XgbMtUAcf5Zp0Cc2h5R2Z7sylRQJhb/IM0sltafrGAsZ23Etehi1
 QNOdJC6VuceUQDrJy4wiyFyCYcPtAGFPx70C961oaB9j4phTGf2iCcDkIFFRM3xWA1Qv
 MjZ75/qLBgn55PezlNZhrseFlwUX1aS9L/RzZcec0+qEpbsImPjkQUpEy9IlUGE8Cd3f
 8VXH6dRNcJwDNCL83wylN06eA55CHPzeQkWA9fBJ1W0E+SAVAnVawGPTWbbT+r0YRzkA
 YoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MOs1RX2Ne8814Xg54ENDH4lWTNul1cr86QzP+uWdymw=;
 fh=Dpf62X5Q/hEhc/pfkwwua7KayoF1pjp606bGUlzNvtM=;
 b=qzy/YPvIXtPJpM3cs9eVbRUgojAJbKIWn6YY7u1Jck2NOBEZaCuy7mE1FChTYkTMtQ
 +wKRGVnZgoGEg2ofG3q4Fkto/FTYxnO58MYlsSVdJLXIhl/cX6UDX8bMwB7Q3orXiK8D
 lX8SInu+kXsWcfm/OxVCifQzExt6hQzNI2eTgmI7cRcaMe6vhpDfztP1nQagITe06s80
 L4hfLhpA2JAe3luOgUdkq4plQOlSLa2hSbpNezipJ2N/dZ285EJJPJJurfWbgtqDWsPF
 3/E5AYXQNLwmsa8ml0sr9E5UEoDJsmFHwgekukx/Wmgz8UD8AFiig1hA5m5P9YSstE4d
 Y+Iw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788199633; x=1788804433;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MOs1RX2Ne8814Xg54ENDH4lWTNul1cr86QzP+uWdymw=;
 b=Ocvf7Opfcmqd6jtzuahuMvIZszfN9QMKx3JJ/9JMgCnXJDV1qJdKoJ5S5YG+XqNG4e
 vy02MBc5ULYJlu1LZn8F2nguuXC8N/Lhw0hP+yEMunncBA1Kfo8oxAzgkxy+s1NTek8O
 TyrDEQIMNxOmhN6VFHS9Rjw5tm+rzpReoHqtFh1tdIcm/R0cbpPj+4YDW3l3pEsm3oaP
 qC59VLQLnddaym5j76l0xpRjMS756OWvNsKl8NgLZB+W2klSt+Ijbd1/yu/hjzkOGN4L
 s1de3LBqZUBtsNK2Mg4bNjQIi7Mer5F5dlRKgw71Ef9EtxLzYAj4kbVReqZOJUbptQy4
 C3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199633; x=1788804433;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOs1RX2Ne8814Xg54ENDH4lWTNul1cr86QzP+uWdymw=;
 b=XYlpR9h7KlhxSybV3T4+ihPyMxDDqUZd3VjRicFRMUjqaUWeycPUoURgdVPlZOqQO/
 LgKwNY/LKG82VndoHnJeJokJ6+dO/I+ODQfJQ/pTt0Y3StD8FKtfp3XxMlIGSRl2Vua/
 8SKcvz1OT743GfLmAxU4huSdgLWw666n1q3e0gz9aO6ubolAUoQUydTaAUHIC+hUtCsf
 /EOItOVUaO5+UbIZ+QA/4tzVzjbVLtgRsn89YZXWWhP63Q6ev3RBBjNQ/eZ1VjU/kKFn
 0iA5Wz3jjTkZ9Q6Gsoe3+SPmFUgDCnvxCXYoqQWwRFT8OSgivYt/DOMqErJ8zff5QVPq
 Ti3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpd0X6zzjo2+oZJEP0jUiwvLN011Ven3kqOuqONgQXPtWXV50/0dpP9vouuRKNhm6xcIzQ0zzUik+E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHi/afiOO/EnqamTsHpS9hms/0y5X03DDuKFnkhaU8OUbYLVLn
 03k592W0NrldGKDruvrJXZF6BvqoZeLiAd+c3r3cMjfi8xssNVnq2yfJWpCVT45E28a0fsWgMJZ
 uiZ41VvNRewpAjIH1DLYdE9pp94Q7EY8/uT7F2g0=
X-Gm-Gg: AR+sD12tzL0ah19eJwI2pPtAXv6X+23BGRK/LzNweDGIA9BG1uIwErsWzEXWts8MkG7
 zfW1noBwd0QFm2hWQI5kxBjo5I+vuf451OhGv6SODNGVtOzmH3awQkOsr/BHwp/3tivfsr0Akxb
 XOj0VlmVDcn/TBGkf9/1mcT/RAwjG2CAuQ+stP1jswn2J4cKoDiIvDURYAGCm2/ZvzYaDH9ridn
 ryp+zpmXiTFujGOOtqBj4bGcDtLamUFss5gtRdK5TUBCcjNcapveNfNUb9TOqwVz+dTjGu9wRyD
 CsXUNiek7zQuvt/74xZnuio+wdS21UadBrOZkhOd8Iw0OQXi8f+v6WL0R6gLH/WGBwIXPmlH3Ly
 5asH4tlEi2ql+5IRFePTE0SyQ+9E6K1Cz0Nm6heDUx4baxKm2htq1/f4pCo4AeO6fFkcOgTyU6U
 tfWLcTsTg=
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49cdc558513mr42130995e9.10.1788199631795; Mon, 31 Aug 2026
 11:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-6-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-6-1877c7aa57b3@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 31 Aug 2026 11:07:00 -0700
X-Gm-Features: AcwNN1Wg4iJaNzmNZzJrTVjQXL1jIC5hAo_YHEcPLLOWDz_-7o6EWRPefvXOojc
Message-ID: <CANDhNCqD3QD-y_-wzLnvzQCObdp6EPMRRhjFmN2yu_tUazAeeg@mail.gmail.com>
Subject: Re: [PATCH v3 06/40] drm/hisilicon/kirin: Convert to
 atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, sumit.semwal@linaro.org, 
 xinliang.liu@linaro.org, yongqin.liu@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 31, 2026 at 9:18=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gp=
u/drm/hisilicon/kirin/kirin_drm_ade.c
> index 5f4e738bc94e..bca839dd600b 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -835,11 +835,11 @@ static const struct drm_plane_helper_funcs ade_plan=
e_helper_funcs =3D {
>
>  static struct drm_plane_funcs ade_plane_funcs =3D {
>         .update_plane   =3D drm_atomic_helper_update_plane,
>         .disable_plane  =3D drm_atomic_helper_disable_plane,
>         .destroy =3D drm_plane_cleanup,
> -       .reset =3D drm_atomic_helper_plane_reset,
> +       .atomic_create_state =3D drm_atomic_helper_plane_create_state,
>         .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_sta=
te,
>         .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };
>
>  static void *ade_hw_ctx_alloc(struct platform_device *pdev,

I no longer have hardware to test with, but this looks ok to me.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
