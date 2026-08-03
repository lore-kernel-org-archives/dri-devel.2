Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11BEC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DCE10E03A;
	Mon,  3 Aug 2026 12:54:29 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5135610E03A
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 12:54:27 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5c375a9e76cso1947944e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 05:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761666; x=1786366466;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WGVqxVKLC2Gks94xayPEyUqyvnJiYIaVHNXa8plDaec=;
 b=YZx9tzb9Dl1xV6FfIFC5s4tkqFEIUOm2tbKusnfRly4nrw64hAKKLieWC6eHVaQP7c
 KJPwzLHDNS/VYHVB76u+ZawZeb7Rb144HegcVDnW4EyLFg9vFJ2MIsxE1Im476sRFAPZ
 6peLGRlfsxQvF21ABKzfiXh/DKTu9uUWrLjSZOpIjLnYpHb0nlfsjnW1bFIHgCRwG411
 1nNZLy/prWua2JejZPkGr3T80W7MvQa6BvrCjJEjX2py55y81HadL1zYKNu5U7GWcQhh
 R5ZhSuWS0+x4FGQFOJ8kfqykDNm+Sqbjjd0I6l/aC8Gr/8/zaVkLfQ+Hb5dcw85VSeyx
 oXxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWAXJOpcMt97UYUfbAAOZWTvVdwZrsbIcyt7bvnYb8XvY/OV0x6fBuBc3i5ZssOm+RYrXUcQ5zHVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzs5dRyrBDkHvluc+bx6NA/3u4euGuyOKvD7xyWXVpbrQgZyy+Q
 0b3ZWrgT1ScFkUvJudQeJgPnywN4hxvD3g9PVHbnDHnyU62DiSk0jvaLklFLb96k
X-Gm-Gg: AR+sD13tBfV1EQfAzmJRP4Zesn3YLJXqOubFUuXasSJV3JRD0G25LiMrfBiFemPmuKJ
 v5VFw5JycyP8RB8+HlOtHkEzXBlocMaxyfIAFkl1uUNYk0TbwSoaStcz24YcUqWEYFoW1HadQov
 tPXH0WubIcLWI4pTIkmXoesT0AvbrlwqBAzYSk9Jn80sZmo8yK42T8OI23MGgctqtFpz76/TMgL
 AUlciUOG+SAHzRRZnOTTjM/ZAcdGkPe1yOBi2tKFZUsv998mgNVVUUG5jrkSZHEZK4fkQVtEwAa
 j07IgFNABZTzc3IixCFbxWGUG3BwOexdKkoNnDmsuiycZtTcOlJM34Mz52SaT6OA/+QxzP5FGfJ
 mjA12i12olkPrfgXnc4uDae/ET4zvqWK/5IRpd+TI5pMk/rizYIDFqFUFAwP/1F6jqxgobKc3nL
 V4424wWBf6icDxOUuf92zQdZoyHau32tdJFws+3Vp1n/NUYJjW2r2U0qHN06bPVpNoI4jvYP5QJ
 OMzRtaY34FDmnwF8pX18pwx0P1yMg==
X-Received: by 2002:a05:6122:3786:b0:5bd:fb77:842a with SMTP id
 71dfb90a1353d-5c3877e0246mr3243574e0c.7.1785761666192; 
 Mon, 03 Aug 2026 05:54:26 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c37edae208sm7935540e0c.13.2026.08.03.05.54.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:54:26 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5c276bd3692so2303658e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 05:54:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrD8cRfYG7vJKCbP3O6qjhARPmIEYLBP7wHI6qqzIGN/K2DuVxMPtgn0TUBaHvJP82JaPCqC13wMZs=@lists.freedesktop.org
X-Received: by 2002:a05:6102:6a83:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-75b2295c6d6mr7103654137.8.1785761305110; Mon, 03 Aug 2026
 05:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-10-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-10-5020b630668a@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2026 14:48:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUe0F06RE4ahWb9ERFq0_pnNy-qGZ5ewod+59x-RtU_FQ@mail.gmail.com>
X-Gm-Features: AUfX_mz7dUNKx_CkXmX2bBiqeRWfQJXaKympC5b4Q722_mZANMq2M_rTZsMnNYo
Message-ID: <CAMuHMdUe0F06RE4ahWb9ERFq0_pnNy-qGZ5ewod+59x-RtU_FQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] drm/renesas/shmobile: remove dependency on DRM
 simple helpers
To: Diogo Silva <diogompaissilva@gmail.com>
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
 Thomas Zimmermann <tzimmermann@suse.de>, Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>,
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

Hi Diogo,

On Mon, 20 Jul 2026 at 17:41, Diogo Silva <diogompaissilva@gmail.com> wrote:
> The simple KMS helpers are deprecated because they only add an
> intermediate layer between drivers and atomic modesetting.
>
> Open-code drm_simple_encoder_init() by calling drm_encoder_init()
> directly and providing driver-local drm_encoder_funcs.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c

> @@ -29,7 +30,6 @@
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>
>
>  #include <video/videomode.h>
> @@ -436,6 +436,10 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
>         .mode_fixup = shmob_drm_encoder_mode_fixup,
>  };
>
> +static const struct drm_encoder_funcs shmob_encoder_funcs = {

Nit: shmob_drm_encoder_funcs?

> +       .destroy = drm_encoder_cleanup,
> +};
> +
>  /* -----------------------------------------------------------------------------
>   * Encoder
>   */

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
