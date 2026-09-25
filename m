Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D2C98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEA710FB28;
	Fri, 25 Sep 2026 14:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="baLf5kpg";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B7F10FB28
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 14:43:51 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so6492555e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790347430; x=1790952230;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtEfZGf6pOZoZKp7BZybV8NV7US5hG1rb4KkghHs3uw=;
 b=baLf5kpgaKtCf7v6hsUxdpTPF4OTA9uhhEflnDpRLypwxXiAIVSq/3UbWX1ARlFb43
 F03pQo5oaQRm6XzUpOTU6oEJQ1j++FRM5LKKS87cX3BcvyYVimuBIg4/1HjXAcjeEu5k
 AL837AuQbtgMv9N+i7nenmEfwYLnac0KR4orF8+awg28t2OBaCOfXTua+OSaa/bfp9cr
 rwNRKdIqbgJT05Avk4pOekdYT+rDNrITJj3Ji3CohvKy9YABEL7bdkg4FgKaRVuuDEL/
 M9EYnzqdUavFnQOqWJqc5i+2jP2eJeXw8+9v+CL/uTvlxIYA7k044xcwALf2YsdCfR27
 GWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790347430; x=1790952230;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DtEfZGf6pOZoZKp7BZybV8NV7US5hG1rb4KkghHs3uw=;
 b=KPe/45uSxVuDrCQy/a4VQUuuY7oZDLqLlVz75OYpvNunEMHL+LanuGG9ob4ycJZSYi
 mfuFMKsDl1gddYMwWbgZkkPA/7rN86cNJ4Tqf+BAGe03aChmy5NsMxF2XQhA2XewIe/T
 +hiOwuI5vm9VvcNxMDaPXsauuF2q8q23rBFyeOsLykS9sXEYVv9vGIm8aj15PHODT5yu
 yf5mUsznTFi/X3dYGgqy4Ndcivc7cjppnrwzTz80QO8n+ci3vHGAk4DEZw09PqxIii22
 tAVjo6KpomvmyrPobn1e6+K2Sonp4fGkyFr1dk1iTUuIBm0mzu3MojUV1kCEhO7irp5z
 hIdw==
X-Gm-Message-State: AFuF++m6/eJzfS6KtIN68cOnwOD0eSa1egz6QY7Y5/bg3Ps5Stq0SiGt
 Gg6qGbZ3HvFGf1PiI4XFmoJF35ZuDvk3FEbLLsrP/cdXTLtrBF6b5hOIoFl/z8AOBEU=
X-Gm-Gg: AYBFou1xHrNqo7gGL4+53CAC8TbnvypuQYf1eLJ98vaVmMFF6jl684AHZjLdLMkmLJe
 kJoyU0umr7gFH6DqVIzFG9Wv/V1y1Frgq4I5mxB1UYBMS9Vn4+LEfS1gfXA5Vvf+aBqINjASYPg
 k+lKIh9miccnfjCXxruQlwEtbzxgPKk7A8GwsdJBdE5bYSRRLt06RlczLv4aK6CCfhv9qOea40r
 MgSdby27HKSn2HQ+cshOHXr0ozyT+mxDQkofsNsxQCgJJuPP4QL4GlcAvj0DGrefB4IyOK8ykR/
 4Qr8U5BLZG6ag6mkLK+s3slPjQhmOmdCtFT89hYVOlVQn2ipY+E0sJix75N8PssXvIClS+vxULK
 jd1ls9GhKxclHd0YYejXkPM1el+CokIBD2chCc71FtEx0IFrqz0lX4s8nuY896CxkmuZA46lF2n
 MR6h/x/CE5DFzL1F7IAX2F7NhjB/kIXIR+AsVboZQWKQYgzDc5FFoB+d02TTvBvsqJMgKQSSTug
 rcjSPHRKmj/IANf1Q==
X-Received: by 2002:a05:600c:c8f:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49fe66bdf3bmr105928135e9.3.1790347430286; 
 Fri, 25 Sep 2026 07:43:50 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35607bsm7104435f8f.16.2026.09.25.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:43:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Cody Kang <codykang.hk@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu
 <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
Subject: Re: [PATCH v2 06/17] clk: spacemit: k3: parent eDP/DP pixel clock
 to the PHY PLL
In-Reply-To: <20260809-k3-display-v2-6-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-6-327d7910bf71@gmail.com>
Date: Fri, 25 Sep 2026 16:43:46 +0200
Message-ID: <1jwls975nh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On dim. 09 ao=C3=BBt 2026 at 21:14, Cody Kang <codykang.hk@gmail.com> wrote:

> The APMU eDP/DP pixel-clock muxes were parented to a placeholder, because
> their real parents (the DP PHY PLLs) did not exist as clocks yet. They do
> now, so point each mux at its PLL and let the pixel clock reach the
> controller through the clock framework.
>
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>
> ---
> v2:
> - no change
> ---
>  drivers/clk/spacemit/ccu-k3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
> index cb0c4277f72a8..afbbbd797826d 100644
> --- a/drivers/clk/spacemit/ccu-k3.c
> +++ b/drivers/clk/spacemit/ccu-k3.c
> @@ -937,13 +937,13 @@ CCU_MUX_DIV_GATE_FC_DEFINE(ufs_aclk, ufs_aclk_paren=
ts, APMU_UFS_CLK_RES_CTRL, 5,
>=20=20
>  static const struct clk_parent_data edp0_pclk_parents[] =3D {
>  	CCU_PARENT_HW(lcd_pxclk),
> -	CCU_PARENT_NAME(external_clk),
> +	CCU_PARENT_NAME(edp0_pll_pxclk),

hidden behind this macro is a .fw_name. Basically these are your DT
input names. You can't change them at will like that because your
bindings are supposed to be stable.

You should not use placeholder name, ever. No need to make the
name too specific either, from the beginning it should have been
something like "pixel_pll" or whatever your doc refer it with.

"external_clk" is not declared in your bindings AFAICT, so at least it
should be fine to remove it.

There need to be a dt-binding patch documenting the new name you need
and then you can start using it in the driver.

In the future, please try to document all the inputs of your controller
in the bindings. Even if you do not use them yet, they exist.

>  };
>  CCU_MUX_GATE_DEFINE(edp0_pxclk, edp0_pclk_parents, APMU_LCD_EDP_CTRL, 2,=
 1, BIT(1), 0);
>=20=20
>  static const struct clk_parent_data edp1_pclk_parents[] =3D {
>  	CCU_PARENT_HW(dsi4ln2_lcd_pxclk),
> -	CCU_PARENT_NAME(external_clk),
> +	CCU_PARENT_NAME(edp1_pll_pxclk),
>  };
>  CCU_MUX_GATE_DEFINE(edp1_pxclk, edp1_pclk_parents, APMU_LCD_EDP_CTRL, 18=
, 1, BIT(17), 0);
>=20=20
>
> --=20
> 2.43.0
>

--=20
Jerome
