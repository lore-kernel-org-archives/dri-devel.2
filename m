Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FEEC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C8810F7A2;
	Fri,  3 Jul 2026 11:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LM3BmMC7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCC810F7A2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16EC26001A;
 Fri,  3 Jul 2026 11:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96BA1F000E9;
 Fri,  3 Jul 2026 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783076955;
 bh=tuWJc8imFqb5FUwYOIHT8S1/CiCKvV///7YUxzwmiDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LM3BmMC7MgYSpIzMfpzB+fFYNAhMe9wIo1o0OJLC1Kel2K2ZP/+VYxOAC9ivUroRz
 e4JPeoPiFFfqZ1qhYtgHkZfsdaJh8zcFkZV/66zPWGhUzxzaFzlF4vJpkPovVJSOtI
 lwj3dqu+64Kj8tRzc145Qxd72W41qMMdgRzcTAa273NCEWWlyJtiJvPgXzbS3Dgy7H
 MoZ72HwHtFSy9sa/vMxx7hgMY28svlczu2j7TqHWvEhRlnhjNiIsYAZQu4yNqsXE4d
 nuCScM8ZI10umNXmDNle0KarbBqoXiOd0UIayfbNh22N3Bes3fi6oQgXyA+zQkFa33
 pLJ/aYI5MisIg==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wfblh-00000000jBK-1vKA;
 Fri, 03 Jul 2026 13:09:13 +0200
Date: Fri, 3 Jul 2026 13:09:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
Message-ID: <akeYWRF-wIlrHTF5@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-10-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-10-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:26AM +0300, Svyatoslav Ryhel wrote:
> Add support for 2.7V-5.5V VIN power supply.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
 
> -static void lm3533_enable(struct lm3533 *lm3533)
> +static int lm3533_enable(struct lm3533 *lm3533)
>  {
> +	int ret;
> +
> +	ret = regulator_enable(lm3533->vin_supply);
> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to enable vin power supply\n");
> +		return ret;
> +	}
> +

No delay needed?

>  	gpiod_set_value(lm3533->hwen, 1);
> +
> +	return 0;
>  }

Johan
