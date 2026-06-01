Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBCCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B2610E07D;
	Mon,  1 Jun 2026 14:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="EtFwXScf";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC62B10E07D
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:59:48 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7dc18e2498bso55847047b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 07:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325988; cv=none;
 d=google.com; s=arc-20240605;
 b=bJ28IRvibl9MkRch68UULU1+ZXfBKgJaUuMRZH8Oi+HvHFOqEp7cHdDjlD+DoGRiH1
 UgbyS1SYpaf0H82xc0G3jRha8gMvwS6n9ubkcVvIBggoz5DZx0WLwwUrNMtjU53KX4UA
 TYdV1vL6zZlSMB7192GdnlmOeIISg5JDMBN9cs5sLU8VkrWbFnwdGcD9E3MMxKQ/wMeC
 IXurSsvzmYH2d/vGs3kfPtcWUtEsKMmQ7kfYyz6SnzN+KK1MsKcmsSB195fOeTqGmFzg
 Wx5PORZYI/6WsfHJhtn13+6DlHCK9s6ag3EwCL8/mya19ucCSZSd+Td+FN5c3tbI2lrJ
 fddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=15bUL6fB14cRc6Y8LNqA99Ampxn+eFOhbs8o9dIDS+I=;
 fh=UgofCISW9AeoMAKdaZ092diUenJ4RCs+NK6/KSgqTTE=;
 b=Fxw3NhfqDU8vT1TETzy4B6nOFS0bngJZFEcku6c+HzsfqQLc07tgz3rtK2RqyAmolZ
 x+/cFwY3nlNfRGowZTLvdVXPKWKFAeJY6gdsi98edc65Fe0pxx66J8sixEiePvkCUbCB
 MCHXD3Rq5xZux/9dmINFBOI+p89KaJ36CJ5b0VVop2fqbYl66PPPuiCi8Vognmod8bIE
 dQtH8sUJFZlm2nAXQeZaUOlhwqSGpjZ60UKevrTrKGsjQCAN7AhElSQndplRHl867Jkf
 X70aJp+mxB+bcl07swbcVBjleMY9av7rx0VPCnpw13bP1nkPtPT9U59VIZuvvzmC9tpy
 3Flw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1780325988; x=1780930788;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15bUL6fB14cRc6Y8LNqA99Ampxn+eFOhbs8o9dIDS+I=;
 b=EtFwXScfHVS3uWL+jh1WBZM+6qjwBNTXPl+8WWRGHzj5nEDjo+VEojhPT/kmUEmC39
 rzYfHZgH1zS008RsVKII9Db/Dxp9u7QKch8CE+w8JUqCsT6W3xzgegYip6EbwzvlwjcR
 KiPL1LKjQ59eS3gQxaeQ+6Xd2CFp+sVFDsOut4Ke2CEPl1SjLCAhe7QnBKyRmVXYO3ya
 F41zunfGOxIDjbSRyDINf0Hx6hwc5xMGpnfpHpLeMumbF5v1pbxIta5AafdL6oyxZYIh
 QFdsjkv+/w0MKjRMtrXs/xKRDUFEsPO0cSOoYAiGdWFEL4NVtXtb/g3Fme2ZAgs0/PMN
 9tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325988; x=1780930788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=15bUL6fB14cRc6Y8LNqA99Ampxn+eFOhbs8o9dIDS+I=;
 b=pe+ML27JTsECK6F4vDRHZqy4M9p7XbmB5nvZuzzXoSs5gEIpW5nFAphlFqd4dhAxvU
 5rnG8WS48WgQeK5XE1matMDWax25/M5N9oCYP3ugdSb6A/tVkT7roy6EFCJNBPGM2c9S
 4QL4aYj0oO2nPJ5up6SJ21mRb316xeilqtAgMFptJRW5NIQMmr5gGNgLevOpwIGdtzw/
 XMYwkfhUwKMNCkDRbPZ319cPbVdt4UnmK+I44E4URk4tdheCddT349kb8TdOsx8Lp4oe
 wTWp/NOEJhhvIt01wmVoHt5V3GX25nwQFM/lbxVF5PkIV+YgNnVaZeVGBS4ca2oOZpGm
 ENtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RNZUmRNA3yftIUEngqPfc2O50m2BBAPGkLdwh9G1VIPCv63rNg9y89vGefLPKT5LnBRTXVL/sOwA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuANfNw9LXyaT3IQX64WmnMn910dSVoakE19CMbQzV8w/8Fl1N
 ZYQuDDpJj87xgRtkbzMlSz8akyq/ARrbdY5FstIK2MK0wMMI2Hgi8tJULqmbT+IpE5GwSl4HZVu
 N+zMQBccrrI/VHflMW62TVrOpthCWk8VWHxpuUmLW+Q==
X-Gm-Gg: Acq92OF+vgF8ekVTAWHbMk/MMmZUWbjwGx4bDEMu+2nNHPB/SmfhdvKRLV+FvosZorJ
 4IK+AoVH2nqHIYciutiFwewtBQ9BM4xrlMlb9ypP4DOqE65ebyFJaFzRu9P5Q1rwylTHwq0mM+V
 bd3Caog2Ily4RL/byn34+bY/pmF42HhFnE1Qf8TgYc+g4B0RvUmHbmyIBY96c+/G3eY39AYPv2/
 Q3Fkjws4nNRFtVFl43OklBAGL6my9iNQ85sfJzhU0XMRaZroppPcVRLUvDnUVesJyXYVKCTXvTx
 J6BToFLLnVHJr/Ly9f2fY06q4C8HcBjtKZ7vpyq/G0EFpGvyWfRzxRZlttu1kAqlzx5MIiGRZ6G
 RybpM6Kv1TtjCZMi3OPneFI9qDXntvHEiRQ==
X-Received: by 2002:a05:690c:3349:b0:79b:d56a:a7c2 with SMTP id
 00721157ae682-7e05f9cbdb0mr106501137b3.48.1780325987714; Mon, 01 Jun 2026
 07:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-69-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-69-875d828d31bc@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 1 Jun 2026 15:59:31 +0100
X-Gm-Features: AVHnY4L7rft6Jk1EdZwk0wleXxcwAKXDX1Od_AVtUHdvbHG-ld44A0J50_yaD5c
Message-ID: <CAPY8ntA9xcB2GC7AjTa=VFr6JJobOBPkT4SSuPmrBoyjsbOMNw@mail.gmail.com>
Subject: Re: [PATCH 69/76] drm/vc4: dsi: Switch to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
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

On Sat, 30 May 2026 at 15:03, Maxime Ripard <mripard@kernel.org> wrote:
>
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
> To: Maxime Ripard <mripard@kernel.org>
> To: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: "Ma=C3=ADra Canal" <mcanal@igalia.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.=
c
> index fc76018b044c..0148f2befed1 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -1409,11 +1409,11 @@ static const struct mipi_dsi_host_ops vc4_dsi_hos=
t_ops =3D {
>  };
>
>  static const struct drm_bridge_funcs vc4_dsi_bridge_funcs =3D {
>         .atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_st=
ate,
>         .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -       .atomic_reset =3D drm_atomic_helper_bridge_reset,
> +       .atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>         .atomic_pre_enable =3D vc4_dsi_bridge_pre_enable,
>         .atomic_enable =3D vc4_dsi_bridge_enable,
>         .atomic_disable =3D vc4_dsi_bridge_disable,
>         .atomic_post_disable =3D vc4_dsi_bridge_post_disable,
>         .attach =3D vc4_dsi_bridge_attach,
>
> --
> 2.54.0
>
