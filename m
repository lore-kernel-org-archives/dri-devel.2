Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB8910E19D;
	Mon, 20 Jul 2026 15:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC4dmFBN";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5242810E19D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:15:28 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so5149067fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784560527; cv=none;
 d=google.com; s=arc-20260327;
 b=NZWXw9hpoSvh+nXzymdAsvcEAJciAf28pA5BQyBTiBXzkNlTurHADi5uG53fANJlYL
 lneQVcOf5IvbDYbHaKXrJcs99dQqTjomikQAZu234KPKmGEhrY1XpH6IUKgX8IWjME9d
 acgrSqB6C46eOUhIlEOqDYy8YuD2ZjUkcDZHW3anFNMTgS7b4DZEVVQBTSlx0uzIqRj6
 KfMQmz2hLkv3FkTXo3Xt0udDf3bxqYa2f9Gix4yfJ25N4r/VDzLQ0K8WQyAdksKdpejS
 9EkL5g51kzXZXJDrz18FINL4HhHMIJwNiDhtO4lsxlew9ckHtFFyq94201jwvmVDAjlT
 VHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
 fh=A3iqhkrqk9kKbQIkIZvsFOZBkndwxtGIisGAK+77P6g=;
 b=NbYYELdk5PtHXK/eVsnaROuWnjm3qCchZWZ+v/oB1TuQoOjApfmSK0hn7fuzksuliy
 qlYjIx/zqkGIzufoVQgyXMzIcBVRfjjPUnFndJcP4/GlDDnAkjALAOu9Ei6GcIiMfcF0
 18e4KtoTuNxeYTxdltoSmqCZmxoNASMJN18TP4P8CNlCOaney7rMZJat4FAyuPk1xiKx
 lmzJIREZbitD2C7E66kivWL2UV4dNVc+ASHiOXYtu0E93BiXJhEz1YRo/ULfLw5JrDXM
 qCJ5ktBKRmwb3RYt1VJqG5779VW5//4xHMShAFd5WCSBHNI9sWQlH8bce+QrN0GR8bOU
 S0VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784560527; x=1785165327; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
 b=VC4dmFBNBDaoXB3gSIAcl8xRJE2vOu3sRotsWHKjbxoWDfZf6bqKhgrPV+v6ukS9qH
 E3UbWuWXw5mumsx9+0O4T0TY7jd63bJnLrjE5Jj3jDhPCB+XmO++wLlj0Zfb9aGV4jjX
 TAnLqNW/rPpw7wPVoJQWFzsasTYsS+cN8Mg1T06/moc5wDqhyzxwFBGuySFshpTLKb5Q
 xLYku0etBy4TIa2xJFYW7g7L75xNWKyZBAGJ7U4jkndN3hBR5KBOlct/14GSMI6QXdHg
 7nyO9V9QHUEMBMI/7q4vHsM+J9pgcIT1dRzn4usFtQ3XLc9Ne5E70H8TVN7YWY5FdEWF
 gI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784560527; x=1785165327;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
 b=B8hDKASikzr7dATJ8ysD+25xroCPw9ABmNl2065CRrKJ3AbSYWdhldm3SIgUNukMG7
 vyN6vYJo4Z3Krg4/zKjmSxz/nUkz5ZuoV31eb3BJ9eUABmFFOzbxoatgBu5BizRVrYS2
 SEsP3syVKEg4dCegtt/7ZJn6HgOHRJYCQyW2GUyaNTKM35OwgK4th2tnObazlgBJ9uTL
 ZCVwwh41jQ/lGBZkU8FvrIkFGPim1+LF5DUzZK+zCDC0YODS2a2xALNP5tbVxZzMdxa2
 QXlRYbvaR8IpI/qJRdtgxY9+FGYhQTT/GNR7w5SQIj1k209UoO+VuXDq+2ejsmp1Ci8D
 ZG/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RopIyRicvEB0x/7MQKnY+OsKWt6dVEP+28J+cKqbucNsywBTADFfaYknP6z3ABA5QgLUJDDPcwcWXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzB3n7ToZQhNDgM6aIF4QVh/B8S+jhh/GIj8KoAuTuTbcFxav4T
 nzgW27Ccu1l0oZMl9HSdQI9M35Sn1+Kl/nB9RKcgFe+MMDyltSdD5dxNheJAm0cBbFSrDVqDIiV
 01OGA4ra+bB/L9HanHvXg92PYZit5x70=
X-Gm-Gg: AfdE7cmlIDokiO/ysPo9B/j23EUdR8oWsrrpyl62gta/qiRz98IrN4KH5F3PdFzHh+M
 ewb57gwUoDQ8tEY4c4aizHZ1a86CRhlXYb/YsVIOiTnwZIqorGqZUi/b3Qr2e6J8fdODc75kTI8
 3SBf1Ov9Yb0nSzo6yDuX8lnXSUk/v2Mw1R9JwLoZoO1/o3gUCFsHdT+idWIWv+qxTNwZ62N2GN8
 3oP6jo2SYIgtp9Y2FNl7HpqSZjpMlopBpGobBSPgvm5AaZ3aXe2sOg3f3A9UcHNFFAIrUsvdFCs
 2iIH3uBmESKE+vsSOFsaVmfCQmE=
X-Received: by 2002:a05:687c:260d:b0:435:bfb7:695d with SMTP id
 586e51a60fabf-45661144d55mr7411947fac.27.1784560527422; Mon, 20 Jul 2026
 08:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-1-a78c509e3062@gmail.com>
 <4af254a4-beb7-4f77-830f-42d5bacb10a4@suse.de>
In-Reply-To: <4af254a4-beb7-4f77-830f-42d5bacb10a4@suse.de>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:15:13 +0200
X-Gm-Features: AUfX_mw73hUQoweWxVmRQ0kaDeRwypjcxis2alI1xmtq6INWQD6CfuNjqz3kn5o
Message-ID: <CAJpoHp73S2_cavgV3aVwC5PS8H1GRqTdDV-Xu8n6nXavBnV2=g@mail.gmail.com>
Subject: Re: [PATCH 01/15] drm/exynos: remove dependency on DRM simple helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Liu Ying <victor.liu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
 John Stultz <jstultz@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 virtualization@lists.linux.dev, imx@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hey,

> Again, you rather want drm_err() with drm_dev here.
>
> I've briefly looked over the series and many patches seem affected.
> Please prefer drm_ logging functions and DRM devices over the plain
> device equivalents.

Thanks. I will submit a v2 with consistent usage of drm_err().

Also, is there any ongoing task or would it be useful to submit patches
changing the usage of DRM_DEV_* functions with drm_* equivalents?
Or from dev_* to drm_* when possible ?

BR,
Diogo
