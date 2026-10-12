Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EECDCA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A3210F1E8;
	Mon, 12 Oct 2026 15:26:37 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E3310F1E2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:26:30 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c34bff61551so173941866b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791818789; x=1792423589;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RvHQEIGxpaUf21Ijq4HTy/LleTd6G7LJ99iq4zk8rXk=;
 b=oVymD6YLXmopnBbJ+bswyk4JOoacxLdh+o+98tAGuswJaMN2NEX4qCv4X29M5YU3TX
 2LSMr7DIMFH9MUBgpkXetc1g5r4tOzkTDu/ecBxCwZFqUytvQULrPDb0mPqloKKQB7Y8
 2chQAhd0tHuwOGLphf4z0coK7O6wM488NS/MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818789; x=1792423589;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvHQEIGxpaUf21Ijq4HTy/LleTd6G7LJ99iq4zk8rXk=;
 b=zMNNZ3Q2zJ3JyJQW2IwuNG0Pp8b8aDaxqVkOJbIMdDk6hrsmiuCmgnLqCFAjhSVkyi
 VszHTAWtQQL0ECXFv9Zw6RS2LY3XbCK9NbYyvLcAENsd/yzJI5rxqAV9km6Qca+uPDmd
 XEc9Lm09MkIPCP/rnBZkmAdo0SYQgAaIAK7x3PM/l52uyekW+UsbZ1YvaCvQvK5obb0e
 px93zi9ohTfmupxa9tKvULfYXtmWNkqzwRsagZmiwaArX8uDVLvDAb7DRJACkCNso2EJ
 0BPorlBJxIcQVILgzF5M7TqZVC5M7FLaRrwqvncqarcKWXkEKUM7ovX27HBAeLLdSTkM
 VuCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx87eAUlyX2MkwysoWXOXwlXq82pkkfHOQ2clFz6BfQ3fljhFMeOtevTsUe7DSPpca+Zc40D1yLpVY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZh93WvklqJktsKAkdo8aD6eQb0Glvs91mgNzlpXsgmDH/1qX7
 CBZpQbSJA5Y8ztdve+UYI2Nxdj+bGeS22fdBxSi1/suuKq6f9e9+t3koO+89GORWR8kyp/qz880
 blYqMDA==
X-Gm-Gg: AYBFou2PlITKfA5JPH3exXF+E4n6OpvAWGKxSA0STpJakk8KXIWuipHPADluSZCcLoU
 J8qf+zQINFvhq9XQluYyCknwtekO7RdIB6WVTFpvPCOUlorZFUauBgzMeHT7r+lQXJSIQehROSD
 Fflp2tCFuIYFTlRfXWT5CMs9eVv4D8HB/5gKTcm9LMfN3XzJ3YfVuunz39Fph+sA7ksr5gPuIC3
 OXHgTT09VTKEtsxbArZ4ueUDGGjYq+L7/LN66PV4ivd28TzUgzyX00M+S+T2FnO8kG4XLwQhKa+
 3Qx50uC1BoEDZDuvpLfWCfWZtLhO9gIEoi80Yb0MiIHmEEC9a7n+HUER/M6zhNhUqCpMxpg6Na8
 sBNCGAPNUieRQtSDZ9gS6PZMbrLJ8ylUD4P8Jkex2EpDvkhwHqiGf7braehu30X3TA4T0Oxd1zN
 ycaJ+sSiURI/aEQpt0UDSznqlWEIILzGoNDcEOn2JpVmf/R0DmePTIYM9kN7h70zYrM0qLsx1Bd
 JWLyWmA9epe6GwdQz8Ykdt+HcJUt/3xqL1dklE=
X-Received: by 2002:a17:907:a713:b0:c2e:3f49:df04 with SMTP id
 a640c23a62f3a-c31a9a3404emr1003947666b.1.1791818789108; 
 Mon, 12 Oct 2026 08:26:29 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a38044sm470672566b.14.2026.10.12.08.26.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:26:28 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso13839015e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:26:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz8MOmsG3hZKHdEh1QwMjDlTcfX87523ZY6anfNRl4pY2cz2BrF9ParzVOGXwGjxBZxglwy0W4Bvxs=@lists.freedesktop.org
X-Received: by 2002:a05:600c:3b08:b0:4a0:da23:e06d with SMTP id
 5b1f17b1804b1-4a18e4a380bmr192954375e9.10.1791818785340; Mon, 12 Oct 2026
 08:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261011164417.151770-1-jerrysteve1101@gmail.com>
In-Reply-To: <20261011164417.151770-1-jerrysteve1101@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Oct 2026 08:26:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZs9bZciynpey2O6Yy5DQJqeq9Rgz_Ks6dgsBhVUkenA@mail.gmail.com>
X-Gm-Features: AclHuK9bI6P913aL5-rnPTBteKvsbpWcqqRccf9MDbM65_2lAJpzo-yFPxnN8ew
Message-ID: <CAD=FV=VZs9bZciynpey2O6Yy5DQJqeq9Rgz_Ks6dgsBhVUkenA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NV140FHD-N43 panel
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Oct 11, 2026 at 9:44=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
wrote:
>
> Add the BOE NV140FHD-N43 14.0" 1920x1080 eDP panel found in the
> Sunniwell Z96A.
>
> raw EDID:
>
> 00 ff ff ff ff ff ff 00 09 e5 f4 03 00 00 00 00
> 13 1c 01 04 a5 1f 11 78 02 3f 62 94 5e 56 94 28
> 21 4f 58 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 c8 36 80 cc 70 38 14 40 30 20
> 36 00 35 ae 10 00 00 1a 86 24 80 cc 70 38 14 40
> 64 64 44 05 35 ad 10 00 00 1a 00 00 00 fe 00 53
> 54 41 52 52 59 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 56 31 34 30 46 48 44 2d 4e 34 33 0a 00 97
>
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index ac815729aa83..ba981581f3b4 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1972,6 +1972,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120X=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140X=
TN07.7"),
>
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x03f4, &delay_200_500_e50, "NV140=
FHD-N43"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unkn=
own"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116=
WHM-N11"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200=
, "NT116WHM-N21 V4.1"),

Things look pretty reasonable, but before landing I'd love a little
more background about this panel and where your timings come from. Do
you actually have a datasheet here, or are the timings a guess based
on nearby panels? This panel is also curious in a few other ways:

1. ID (0x03f4) is much lower than other panels.

2. The EDID contains the string "STARRY", which is weird for a BOE panel.

None of that is necessarily blocking, but I wanted to get a little
more info. Thanks!

-Doug
