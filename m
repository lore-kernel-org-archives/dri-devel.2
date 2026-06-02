Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2EDCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EE3113A1E;
	Tue,  2 Jun 2026 14:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IyNC9PbB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999D1113A1E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:05:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71EE04437F;
 Tue,  2 Jun 2026 14:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA5E1F00893;
 Tue,  2 Jun 2026 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780409131;
 bh=RwmM6VRZg5l+0GvbV/xOvwKkYl5MibkLoOqq8L//Tag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IyNC9PbBLUb7m07qNRltiOyeQtRvHibdxXDofusCnxdqOqIt4C/b08lD6V+mwRPqe
 BgL28PJeGQuqV/eJbVS20qes2l1HBYm/COYkyP2Y07yswps9weXUxe1EGr1P+R21eM
 7KJ7WLfgFMTl7FIIB9ToK604upmNy55XdOpmLKiz15HDL9tjaI6F8nEPm0qWavjQ3a
 BBxu4CUkOhJkeq2yijdjb9G/EgfZSBXAri7+70ZuMiu2QHi7V7LZ6+bPdT+g8afoKh
 wAJL1DKVpSU8RJ3mTi+we4xWC+3DvtcHPQ44jeTJ1oxJzmcrtqh+WlyuhGdvlH5Jzw
 A49aM5OXdfG3g==
Date: Tue, 2 Jun 2026 15:05:25 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 09/11] video: backlight: lm3533_bl: Set initial
 mapping mode from DT
Message-ID: <ah7jJbAKI6cAJbS0@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-10-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-10-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:29PM +0300, Svyatoslav Ryhel wrote:
> Add support to obtain the initial mapping mode from DT instead of leaving
> it unconfigured.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/backlight/lm3533_bl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index 36e6f027613a..f0d88b7bc229 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -34,6 +34,7 @@ struct lm3533_bl {
>
>  	u32 max_current;
>  	u32 pwm;
> +	bool linear;
>  };
>
>
> @@ -247,8 +248,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
>
>  static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
> +	int id = lm3533_bl_get_ctrlbank_id(bl);
>  	int ret;
>
> +	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> +				 CTRLBANK_AB_BCONF_MODE(id),
> +				 bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);

I guess this is another candidate for regmap_assign_bits() but with that
change:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
