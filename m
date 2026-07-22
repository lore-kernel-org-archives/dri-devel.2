Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973A9C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEB310E3CF;
	Wed, 22 Jul 2026 01:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrzEEtp8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220B610E3CF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:25:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 507DE601EC;
 Wed, 22 Jul 2026 01:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A61F000E9;
 Wed, 22 Jul 2026 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784683527;
 bh=9JQDuIPMRGm1AZBtkGOnYehCcEprY2pwmL3Pl10VzPg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KrzEEtp8KLGRhZLa23sHMQkSZkQARgkrTuXfo7+bgykg941ep7a1dOer7hfDEdtgX
 i3a7qXPBxL70T8S1za8y3xhbo3oAhcysl8b3q/x+Hp1jqDCjELLOg8U6K6FyB1Y41e
 Si+HkdkALZdVWmLFnlhQlE5sQWHaecnD6xkgqYCXoL3zD54CMBfhxBMAlH2fVzyapP
 Wh4BbK9ygcdDC8Urom+mkq52dTiPfcv+bo2jD3/93YuLKhlgklT42L5YqtrFTin4hd
 +F8v/E0zhYxbeerwwElAK8OfuC45YCoj82cly3pJTTdOTTf4SoJs+C7D1feQiPJLGQ
 +zFV2rq62/DyA==
Date: Wed, 22 Jul 2026 02:25:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Message-ID: <20260722022519.3b1e4fd3@jic23-huawei>
In-Reply-To: <20260617080031.99156-7-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Jun 2026 11:00:23 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> only in lm3533_device_setup(), which in turn is only called by
> lm3533_device_init(). Incorporate their code directly into
> lm3533_device_init() to simplify driver readability.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

>  static int lm3533_device_init(struct lm3533 *lm3533)
>  {
>  	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> @@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
>  
>  	lm3533_enable(lm3533);
>  
> -	ret = lm3533_device_setup(lm3533, pdata);
> -	if (ret)
> +	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> +				 LM3533_BOOST_FREQ_MASK,
> +				 pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);

As you are touching this maybe get rid of the shifts and have one source
of info on where the field lies in the register.

				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));

> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to set boost frequency\n");
>  		goto err_disable;
> +	}
> +
> +	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> +				 LM3533_BOOST_OVP_MASK,
> +				 pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to set boost ovp\n");
> +		goto err_disable;
> +	}
>  
>  	lm3533_device_als_init(lm3533);
>  	lm3533_device_bl_init(lm3533);

