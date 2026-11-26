Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AB606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIUMq1HY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EA010E97A;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3BD10E97A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:47:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABFD6439F7;
 Thu, 26 Nov 2026 11:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3451F000C4;
 Thu, 26 Nov 2026 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693666;
 bh=/IuU2RbLnTfHjvDJt5vubfcTTRydUn5VtyQNhV9yHwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iIUMq1HYFh7Ug+mB4SJbihaa468j1yKHlqow/OXuId2iW3hUoQ2wS83jcwCECrfMw
 aVsKkwOcboYfRqoeZR7t4qibEbQhD6PhDjo1i2ANpiL9ue3xFu4jGuVPlVHtht464s
 HviepUDvEoPYIvURjU3c1+56+9baH91+auYwn4QgztxPsXgEC+shL5TcygPFbznh3u
 lqCadeeNN9heBa0goOw/UyHKbmT3gs5XbIryL1sYJyTNGSXUBf9tVqBIvYpw+tTabL
 KjJtNGVgNLjqBQMiV7dTNXNPjezHpVzX5rcpxFqmY+GyzVOojmTzxAadPnxrPK01JC
 Tl5ohrORWvSBQ==
Date: Thu, 26 Nov 2026 11:47:28 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 4/4] mfd: aat2870: Add support for VIN and IN-LDO
 power supplies
Message-ID: <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
References: <20261115085826.89641-1-clamor95@gmail.com>
 <20261115085826.89641-5-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115085826.89641-5-clamor95@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:

> The AAT2870 supports a dedicated main power supply input alongside parent
> power supply for its internal regulators.
> 
> Add support for retrieving and managing these supply regulators
> (vin-supply and in-ldo-supply) using the regulator framework to ensure
> proper power supply dependencies and power-up sequencing.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/mfd/aat2870-core.c            | 5 +++++
>  drivers/regulator/aat2870-regulator.c | 1 +

Is this a build dep?

Would something that was working before, break?

>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index f5409dd91efb3..9017960ee73b1 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/aat2870.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -307,6 +308,10 @@ static int aat2870_i2c_probe(struct i2c_client *client)
>  
>  	aat2870->reg_cache = aat2870_regs;
>  
> +	ret = devm_regulator_get_enable(&client->dev, "vin");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");
> +
>  	aat2870->en_pin = devm_gpiod_get_optional(&client->dev, "enable",
>  						  GPIOD_OUT_HIGH);
>  	if (IS_ERR(aat2870->en_pin))
> diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
> index 73b6d06858cff..896f39e345379 100644
> --- a/drivers/regulator/aat2870-regulator.c
> +++ b/drivers/regulator/aat2870-regulator.c
> @@ -105,6 +105,7 @@ static const unsigned int aat2870_ldo_voltages[] = {
>  #define AAT2870_LDO(ids, match, vsel, vmask) {		\
>  	.name = #ids,					\
>  	.of_match = (match),				\
> +	.supply_name = "in-ldo",			\
>  	.id = AAT2870_ID_##ids,				\
>  	.n_voltages = ARRAY_SIZE(aat2870_ldo_voltages),	\
>  	.volt_table = aat2870_ldo_voltages,		\
> -- 
> 2.53.0
> 

-- 
Lee Jones
