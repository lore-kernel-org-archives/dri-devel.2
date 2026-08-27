Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ADFC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48FB10E406;
	Thu, 27 Aug 2026 16:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+dtUL7V";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861B010E406
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:24:17 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso3730360a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787847856; x=1788452656;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mzMGBct2T5j19pFzqr+r438MOOPyyfPFxEllccYYNUA=;
 b=c+dtUL7Vfos3hV1p6L8eRpX9cb31XRZ6Gbu2d2SYopwr87I5u2zDWl3DrfJ2cMgldn
 7J3LS3GLbwPIkgi/psUHtgtB6LWyclerdpyhJIU3K58Si30NSZxQAVSGslmMjjcYcPZ1
 5hzQ4LgbALReNq37ce2O4w1Xswws1UJKk/Y+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847856; x=1788452656;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mzMGBct2T5j19pFzqr+r438MOOPyyfPFxEllccYYNUA=;
 b=ikWnXT6jhYoB12pwYLovlqt/Iefzd7nouAQ6g28PWGvZDdA9sKuq/f1ySPMTcaDGib
 NCT12TODDfK8Ck78nsmHbmTtqwT82YZhpL8zXpD0QhtiIKvfu8j4Zq2Fyirazt4AsJEY
 UPiSPbyEGSPjNb/y3GBCV66SqQfcF3r9s6OKY0ZehTHNoYO3KiJQW/s/xa0M/M5C6Bxh
 /AAMsOauKurYOBQ4/vM5i3ukaE2cTvBIyPraIJ+RUDu9f7QkOYNN/OFM1UHlG/12UycH
 Prmldb20u1P/joh0tVtbfPuuXSt5yBSqTdz/g7CxTtFRR9YYewVf55K8npHAoYDS+6F5
 SFSw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6UeUoZ9PWgIOrkkHV7GRSxnsjpevaE05X98ttpsdwqN5xWNtBa66cKESSs+8pYzuFCyUuu6e/o18=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lwlNbxQBe250nox96hoFt5zNQI8eb/QfzZP6wotfmDY3P3m3LV
 XknvB+wow2o6kX+MTUUrnlG2Iv4MRsE3YwFgGlkHw2AxkKSZb1wNNj1A2F5q9P/cObYQu9MSVX7
 F5kXecA==
X-Gm-Gg: AR+sD119EKRcsdvj3tq8hzOJx3HCxujNX2PqVlNfvHoEObx9xx/xOZQI8fUJjh8pBZ9
 FUBRz1eIKhn67r3PkE5r+lAjQN8oaTEZbOa6jMT6jfwNRo6vCnNJmz2dtvLZpoOx87Suci1F1dN
 lFFPVc1j4hfmYdN136VbRedAaPGOpRPQM7YRQ1EPUi9iCsvIpwNutuRIt5qHhKFWqnrV45FDQhU
 HRNq8sD2uqBZ0janTavxmnmMxMUFZVb2uy2Nq+kHgdojGkIYK+7upBCMM23PsQBa+FbeaXDT8vx
 oqz6LU+Pswdr90QjQSXJejchaDZWWulyGK7aeXshw2fsuGtOFco3ndZKgrLwHLj1WftbJ+i6028
 Yq7UkoUzHZ82nywZpyeMIzN+dER5YudxH9VPFSY5fGtnx9+hL7GtGuFTOh6FvbUriNbZiN5nFVa
 um8Xv5Xwa6slSXJxurGsUoyepHt9t9QxGW/nftOMcUjw7pm9YPYlkUIOvKEDKrnnAZfHLa5LOgC
 3K6mxSP1dzZOC7G9UOdPCx9XUk=
X-Received: by 2002:a17:907:3e28:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c250bb50751mr1511712366b.8.1787847855828; 
 Thu, 27 Aug 2026 09:24:15 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1188sm6754050a12.7.2026.08.27.09.24.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:24:14 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so22986535e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:24:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8PgCMIDRmbIvMOEMxYLBxbTgdDf/rdEOEmdy9nlQwMFRC+A9o8yxe8RiQ6dr05bn+kChnykCOPQo=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1d8c:b0:49b:916f:1471 with SMTP id
 5b1f17b1804b1-49b91c1df21mr2431435e9.3.1787847852763; Thu, 27 Aug 2026
 09:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-4-c6c88ba7ffd2@bootlin.com>
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-4-c6c88ba7ffd2@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 27 Aug 2026 09:24:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtDHWX5yXDE_CSMEZY9nTAd9372kkUAuti1K09zLywig@mail.gmail.com>
X-Gm-Features: AcwNN1VF3py5doozl6LD9Pr4fEpbkFlfT_OL-hoHyQ67imrOzi930oQk0T6UzBQ
Message-ID: <CAD=FV=VtDHWX5yXDE_CSMEZY9nTAd9372kkUAuti1K09zLywig@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] drm/bridge: ti-sn65dsi86: don't select unused
 DRM_PANEL
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sandeep Panda <spanda@codeaurora.org>,
 Franz Schnyder <franz.schnyder@toradex.com>, 
 John Ripple <john.ripple@keysight.com>, Michael Walle <mwalle@kernel.org>
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

On Tue, Aug 25, 2026 at 3:11=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> This driver does not use the drm_panel APIs at all, so no need to select
> DRM_PANEL.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>
> Cc: Franz Schnyder <franz.schnyder@toradex.com>
> Cc: John Ripple <john.ripple@keysight.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 043596801a65..d46aa2eb01b5 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -474,7 +474,6 @@ config DRM_TI_SN65DSI86
>         select DRM_BRIDGE_CONNECTOR
>         select DRM_KMS_HELPER
>         select REGMAP_I2C
> -       select DRM_PANEL
>         select DRM_MIPI_DSI
>         select AUXILIARY_BUS
>         select DRM_DISPLAY_DP_AUX_BUS

Looks right to me. Ages ago it used panel APIs directly, but not today.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume you have a plan for landing the series. If you want me to
land this patch on its own to drm-misc-next, please yell.
