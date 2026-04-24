Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3F0FB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF3410F38A;
	Fri, 24 Apr 2026 07:50:26 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B784610F38A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:50:25 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56d9ed609d2so2251087e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777017025; x=1777621825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+k21mzy1Q8IyL290m/XCuURamP2UyoHvl1hWQE5Pk/w=;
 b=AbqFs6dr6oRyZW5cwOHGuSYq9a+pM5+fjBAUCj0EA/rN/EhbZG77mDeR+cQ+/CBLrB
 6fg3hcerHAUkbLFxsZQxGsfxxbKWwuXUUp1tjLQDEf4mMzl7Mey6oBfY5RvUkWcJJ1/F
 r9k1NPf0RVz73yzy5ZIwiUhOroIr1c8uwpY3JfFwW2cM6lmJFRDcRjipuUeUJGlU+hSf
 zHQ4xRXm/lBSXOsVKYvxE/lZCarURgU8kO76Vw8G/1v0mcBEo4eJmUSIPG+glcS5bXzy
 WH7AERnp1dmKCUjxLuZDfYe9+oZVDJVHckh11RH3pGGUljp5JPrP1YCV7StygNoALF3Q
 wi/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ86HT8cUTWsmCTHzjspKG8LAzOhJHeB1ncBSQvtPcDbqlAGjpED0kbt1VcFo56ffChDCvEnAjs3fhY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhgvET53aZITyOcpuKB1MNA/0SIx1TSpB3t9Em1nzQuFtWSjQ4
 4DQ2ygLY5BcQGF5Djpuw06KIa9bV3j97+GHXw57SLik+9l7FWe5WwUnEodGXGyyL2TE=
X-Gm-Gg: AeBDiesb1M/tF8AiBfJWA3iGajp1Vkg05+5L3XIcwdgPmp0J8yQoZXKw8/GJrJ5fDIF
 fD8svetjqIowg2ttJBQrPkdRQpxuXjdZojac7YEoxGGqUJ8Wktrh5wlsVgu3WG0CGwKqefgOA83
 DY2Dm7l5ZIx3e036Y1aGlrf5hcUVxwKeWpwAI035DKAJS8zDYkr+xlOC+nWlY1NYk7aVlW4o8tO
 5aXaNO2JcfmGIMQjkO3awK/2g0vmPo7scxCIuenLX1QnaV+dk/ooY1kK1qjPTcy0Lbu5jMqrrFr
 swYeNpmIeiCQaRyomE1SXy16cK1NLyKKbEZP6e2EkUYCPtnVcSmhWGjCOjrH0KDsvkfZr7PRvJS
 IGQuzs9Fpz0IwEBqqBIfIDEXcW+uZSto70wxsMizEsOen/zwSel4EjbHwG6W9QXuU4V+H215FdW
 UlBDRz8GCqEf1ag8wIFPT6q7EZj3PjEvZlunztq0SpCH9VAJ065p7DzlbtVDapm1TWsB+5ZLJ6e
 efAckTYcg==
X-Received: by 2002:a05:6122:e233:b0:56e:f876:5626 with SMTP id
 71dfb90a1353d-56fa5848332mr14070755e0c.5.1777017024503; 
 Fri, 24 Apr 2026 00:50:24 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa9351ca8sm12670654e0c.18.2026.04.24.00.50.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:50:23 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-6221c7251d1so294307137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Pft3bjfNHCHB8LUjW6RGFflPwiKEtgnj7LiX16U7UUVZCeTB84K+f/swRCCidGGb24EEPCJ8zvgo=@lists.freedesktop.org
X-Received: by 2002:a05:6102:38cb:b0:5e8:1d93:921a with SMTP id
 ada2fe7eead31-616f772e968mr14645934137.15.1777017023068; Fri, 24 Apr 2026
 00:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423115550.444930-7-luca.ceresoli@bootlin.com>
In-Reply-To: <20260423115550.444930-7-luca.ceresoli@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 09:50:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbEV0b+MwCjqyc9Q0EjasD2hoN0rqWtjfmPPotZ19Lrw@mail.gmail.com>
X-Gm-Features: AQROBzASdrVB_Aky8lNaIViGqa4fIOoRKTkBEjNLF-nFJbKyYgy5oQezNNnYjKM
Message-ID: <CAMuHMdVbEV0b+MwCjqyc9Q0EjasD2hoN0rqWtjfmPPotZ19Lrw@mail.gmail.com>
Subject: Re: [PATCH v2 41/41] drm: renesas: shmobile: remove now-redundant
 call to drm_connector_attach_encoder()
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
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Liu Ying <victor.liu@nxp.com>, Douglas Anderson <dianders@chromium.org>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jingoo Han <jingoohan1@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Jyri Sarha <jyri.sarha@iki.fi>,
 Michal Simek <michal.simek@amd.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

Hi Luca,

On Thu, 23 Apr 2026 at 13:59, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> shmob_drm_connector_create() can init the connector in two ways, based on
> the 'if (sdev->pdata)':
>
>  1. manually in shmob_drm_connector_create(), or
>  2. delegating to drm_bridge_connector_init()
>
> Whichever branch is taken, drm_connector_attach_encoder() is called
> immediately after to attach the connector to the encoder.
>
> Now drm_bridge_connector_init() calls drm_connector_attach_encoder() on the
> connector so it is not needed anymore in case 2 and should be removed, but
> it is still needed in case 1. Move drm_connector_attach_encoder() from the
> common path to inside shmob_drm_connector_create() in order to get back to
> a single drm_connector_attach_encoder() in both cases.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

For case 2:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

As none of the old SH platform have been converted from
sh_mobile_lcdc_fb to shmob-drm yet, case 1 cannot be tested.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
