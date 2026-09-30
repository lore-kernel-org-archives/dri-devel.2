Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1852BCA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B97B10EA9F;
	Wed, 30 Sep 2026 19:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYppcFfQ";
	dkim-atps=neutral
Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com
 [74.125.228.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381BB10EA9F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:45:13 +0000 (UTC)
Received: by mail-ed2-f32.google.com with SMTP id
 4fb4d7f45d1cf-6acb6b726b5so3791463a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790797511; x=1791402311;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mHNTp1AZTn0ZS3nuL3EGnRpKBBCGGCs0wPlH2fLdFaY=;
 b=hYppcFfQRtWMoF9+sqTq+agcjQzPtkE1KQjIpi4IKYCiUvkLG0UL72APRKQIyMph6P
 kDlpkTLyva1VoixeTLc/emWfMH2PJcF8VW49uJ6OygM3sJU6+HkZtij1AJMCbjHOvF8U
 IKtb4HGG7xm5gsY86bDc71z4hRAmF1R8Je9sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797511; x=1791402311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mHNTp1AZTn0ZS3nuL3EGnRpKBBCGGCs0wPlH2fLdFaY=;
 b=dfJ1UY+HI1bfQjrAl+xni3bVuIAc/YLaMbI9cfPJ8qJ1++AnzxEQwq221u6uyEQj1z
 IB+ktg8qQS2lZel7KJ2IdqvVHI5eC/MXcs2ZznHqW5YFlKriZaGm05LTPVbVxmHFyfVS
 nujHRNhxQrKXP1j1/K3xzeqTxZKQTJ4GLT6r5+sgqLjBflMQGOjKZ7/v3CprBClRAyGr
 +k2UkfqtBjItiSIqTM7T4JNXhhGs1luOOQJSwWFyQ1rE6eia5ZNsb7MkB4+Bnta8GHq5
 yoNpyVKVh5ISnSiDeGoRon/Oqtt0hGB/2hQrBUFsIswYpQMrMcJzeDjKRPOVrFHO+2c+
 9HkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5bPrsE8JIM+eQkySx0H0pGyCCS5wq31mVCtEigCNJbm5/43vqZIlEpEgsMg54c5xhYe1Ny59hFZc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHncTwJR+I298dNwxvUlDFz2J8ZrBV6ua56/yZCYNTEEhqvG7M
 pcQR8hf1Vous/vcTjOs/hecTfdcfqtKD8JO++9eJL4l3ntN1PcCMchQ28EbY0TmdCC/1+bGhjb5
 yL9H4kA==
X-Gm-Gg: AYBFou3RMWvuhI6NK3ZXV2NhQS0qJwYhpPvTuevDkyFwrbEbAsA1xaRBKPqW+ky/GVm
 4+apa/U13dwqNGMxVfi06lg1KobFyPUbY4fc2//eVA9qlHIUQ3k3AhNPBKidEn69rd407Uzoqk/
 WidgZr0vws8ZQzaJ+LuiX6UbMDCgGLaouwXml3eD0uvA9sPf31QRCeaAsZnzDI9EKl4fWQqmXvF
 ZJxSsJL8oy9bln/YNzOBVwfJnRBZqx6/bFwO0PnhW9UJnwSW/2qgeUhluMX3vpdP1dMdrgWJVTR
 ORsVN7F7eSm4tj81yatjP+QpQmzM99Tcc+3Zt2stgczjAVjC4fP9fKWDWzW/QManjjhKdn4A+Zu
 3kDtN3eKSeehwktd2/n4JKAXBMOaBvMSIKwtRm0zyprTwscqzvCsTR/ccirIrAH4qNezzKqioIB
 SY6YL34ZHkqcAnPvnQQQXUvTjrFD+FvtOkHbaw4rIA+bKrXTKjElGbwaiRDsCM17nuACd1gsc5D
 omorNA7ht45ucBUxE16OVirw2SrUfYVl4ZJmUMnlZBo2trx
X-Received: by 2002:a17:907:608e:b0:c29:3e59:fd03 with SMTP id
 a640c23a62f3a-c2e23c23443mr184690166b.18.1790797511455; 
 Wed, 30 Sep 2026 12:45:11 -0700 (PDT)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com.
 [74.125.225.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31ce648esm49063266b.35.2026.09.30.12.45.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 12:45:10 -0700 (PDT)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afd5b1678so729346f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:45:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBySabWMIu3Pui1U0z0KRW863b6Go8jCo82Ta+OB+GFioZum3Xrk319J+4FjH46f2DkJO8jP2ZsmfnY=@lists.freedesktop.org
X-Received: by 2002:a05:6000:25c6:b0:48a:faf0:bdee with SMTP id
 ffacd0b85a97d-48b0252bc90mr4838704f8f.45.1790797509042; Wed, 30 Sep 2026
 12:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260930013029.3241267-1-hungen3108@gmail.com>
In-Reply-To: <20260930013029.3241267-1-hungen3108@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Sep 2026 12:44:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WoNqqYOYTXEnv+Z7Kx2cA1PkYhLqZ9VKTASixJuLJaDw@mail.gmail.com>
X-Gm-Features: AclHuK_q8n2VplupGbm1CQbFF7zgz0MF-_7CVjuB8tEzVBqsiKmLQaKI4IO57P8
Message-ID: <CAD=FV=WoNqqYOYTXEnv+Z7Kx2cA1PkYhLqZ9VKTASixJuLJaDw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()
To: Hsieh Hung-En <hungen3108@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

Hi,

On Tue, Sep 29, 2026 at 6:31=E2=80=AFPM Hsieh Hung-En <hungen3108@gmail.com=
> wrote:
>
> If rb070d30_panel_disable() returns an error, drm_panel_disable() skips
> clearing panel->enabled. unprepare() still powers the panel off, but the
> next drm_panel_enable() sees the panel as already enabled and does
> nothing, so the panel stays dark.
>
> Always return 0 from disable(). A failed ENTER_SLEEP_MODE is still logged
> by mipi_dsi_dcs_enter_sleep_mode_multi().
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
>
> Notes:
>     This applies on top of:
>     https://lore.kernel.org/all/20260929080143.559685-1-hungen3108@gmail.=
com/
>
>     As suggested by Doug in:
>     https://lore.kernel.org/all/CAD=3DFV=3DUU+NS0T-Ga8i12QKTNCYOu8kar_6=
=3DNsH0=3D4FVUFyKB7A@mail.gmail.com/
>
>     Compile-tested on arm64 with W=3D1; not tested on hardware.
>
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/d=
rm/panel/panel-ronbo-rb070d30.c
> index ebe6352db..2d54182fe 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -87,7 +87,7 @@ static int rb070d30_panel_disable(struct drm_panel *pan=
el)
>         struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
>
>         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> -       return dsi_ctx.accum_err;
> +       return 0;
>  }

It's probably worth adding a comment explaining why we are purposely
ignoring the error value. Something about
mipi_dsi_dcs_enter_sleep_mode_multi() already having logged the error
and how a failure here shouldn't really block us continuing on to
unprepare to power the panel off.

-Doug
