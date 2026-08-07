Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D9C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD4310E33A;
	Fri,  7 Aug 2026 06:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="MzPAHb+z";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC53310E33A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 06:46:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2066816f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786085169; x=1786689969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fuxZgv9NDap5lx/vLVQf2iAz+mvVDGMWBjZuHXXwkDc=;
 b=MzPAHb+zmUmuW+PNQWe2n2jCduRYEFDZ62KJlRBEzYY+rOfHPGGAiUYnuza/G/GhkA
 ppo72E0yi247Gb7Bys5dYlWZYG/QFt43cQRR09XKCeYPPI1Nn03G4Jr3bszhOUt63r4m
 Z23fAUYkreBWzn7H3UmM4UnQf3lGlhCb7scK4FuLyRSQzTUmPfYWf6JsepLpUZR8Oy/8
 g6Z01fyCHz9mVRdlRCiaYtw2p6xl+4zoUXy1oehwdmorAKlWezNIS9GIb7BVXyq2W6qC
 ckTXe2sA4NjidzqZVL5oeVnEf3GGEV8yda/h615LcFjtt0Q/YG3Q1UsrvNBIxYJ2T35v
 etjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786085169; x=1786689969;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fuxZgv9NDap5lx/vLVQf2iAz+mvVDGMWBjZuHXXwkDc=;
 b=Inweuij2X3NMlHAIVMDJYDz8mvIO+yF0jcgJAb1OL0rlnotj8FFDVPHuKCKNZFe3iT
 UOlgmw5C6rvnj4zEuDuZvCPIu30ZxnYeiDqpPNYiqCfv2sKAlxbegcAZpEQwg5Y9QgFu
 nz71m7UlPy3vTVfPVzFS/fbIrMDgDKnvujgVa5p6A3E37XeSfMRQ+YEySNlqIdFht7nV
 VSbiqewcnmug2adQ1Ar+VemjXP69KxrXl1tCHvnocwArsbkD6TyLPGuWS1yfV+7PeD1k
 R5ZS+Xn+/SyiKBcVFvwc+iOQWiFCMWm9FPcskj+983nIt+O2xeFyLXxuHpu70bGsbocW
 Nn+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAByy2UZaRBPCcUg3ni1QrSzn1HGWsK4hRrsuo9ST61FjYhE5xi44jB+FIP9wxJfAseBMCdITU6cg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzP8Z2NP4uQnIBHq4tDEQnlzT8D2bG5Q9T/VyGIWuWDeTwYgoMN
 h9r8VFIcLvpv+8U86VSz4ytzkGD6MLY+m7p7H5G9v2vaDfJNZKj1u1CjmDfT4m+9UIE=
X-Gm-Gg: AR+sD13+WB78xW/tuZk/E9/AJa5buqhNM04Ug5G9rf2pS0W7nNgjg77d0l690fVDRYL
 UKvU4P7U55YZDnD+Ft/9fKjvQI7T/gT5US0oyIR6tu6xw+/MOWsqr9UDxRybAck7MbOFBoEJis7
 oRyuB3wxrhzBfEiciwj0HuKE643/y3Zf6nDesSs/YA+eXTWkiVWCQ3nKW4IFGBTNRVHWOg+TFyf
 DXy0ZUSAtQy8h9XzoNs1+n+zrJfN4d6pkFJuPDOTQbZ7TH5XbJqTKjJ2XrPzU0u9NeXyOd5MyW3
 HTezrzoeN7kDeYQX9aGwkfwRfyRQD+0CF0iZbB/SPfHiWCrsJ1l7yXnX46gqAsMFD2efTRH7pJj
 VfFwfewKd8Kr31jTmhmCaXWvU/d/9HiCUKaMg13e4q/B4Prtka5ky8qQfuwNFlV2qJiECEKLzm3
 e5z6FpdOmDl73Tw3ESr+L9eP31oUaEZmxGHYKNdkFYS60P88EP5lJHFyskrsjQcCZBHCwWHxExh
 aO3SjpavMldBM9ft73Pr33T4pEUFnVjxo2SPwcK2gAhwo4/Ad7T
X-Received: by 2002:a05:600c:4fcb:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4995e084875mr16033505e9.7.1786085169192; 
 Thu, 06 Aug 2026 23:46:09 -0700 (PDT)
Received: from localhost
 (p200300f65f017104bf0aa590e17c3201.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:bf0a:a590:e17c:3201])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4995ea2e038sm9844665e9.14.2026.08.06.23.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 23:46:08 -0700 (PDT)
Date: Fri, 7 Aug 2026 08:46:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <anV9EBIaZvoTz-lp@monoceros>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iwu3m4uskszqhttb"
Content-Disposition: inline
In-Reply-To: <20260806201541.101304-3-wf@dewith.io>
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


--iwu3m4uskszqhttb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
MIME-Version: 1.0

On Thu, Aug 06, 2026 at 10:15:41PM +0200, Wim de With wrote:
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

Please don't use <linux/mod_devicetable.h> in new code.
<linux/platform_device.h> already provides struct of_device_id, so you
should be able to just drop the include for <linux/mod_devicetable.h>.

> [...]
> +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> +{
> +	unsigned long flags;
> +
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +	udelay(OCP8178_1W_T_START_US);
> +
> +	local_irq_save(flags);
> +
> +	for (int i = 7; i >= 0; i--) {
> +		if ((value >> i) & 1) {
> +			gpiod_set_value(ocp8178->gpiod, 0);
> +			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> +		} else {
> +			gpiod_set_value(ocp8178->gpiod, 0);
> +			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
> +		}
> +	}
> +
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +
> +	local_irq_restore(flags);
> +
> +	udelay(OCP8178_1W_T_EOS_US);
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +}

Is this function open-coding stuff that already exists in drivers/w1?
(Just asking because you call that onewire).

> [...]
> +static int ocp8178_bl_probe(struct platform_device *pdev)
> +{
> +	[...]
> +
> +	dev_info(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);

IMHO this is just noise once the code hits mainline. The amount of log
lines like these during boot is just annoying and makes it hard to
identify the relevant lines. So if you're confident that your driver
works, users are probably not interested in that line and you can drop
it (or degrade to dev_dbg).

> +static const struct of_device_id ocp8178_bl_of_match[] = {
> +	{ .compatible = "ocs,ocp8178" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocp8178_bl_of_match);
> +
> +static struct platform_driver ocp8178_bl_driver = {
> +	.driver		= {
> +		.name		= "ocp8178-bl",
> +		.of_match_table	= ocp8178_bl_of_match,
> +	},
> +	.probe		= ocp8178_bl_probe,

I'm not a fan of aligning the = chars. But opinions differ.

> +};
> +module_platform_driver(ocp8178_bl_driver);
> +
> +MODULE_AUTHOR("Wim de With <wf@dewith.io>");
> +MODULE_DESCRIPTION("Orient Chip OCP8178 Backlight Driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--iwu3m4uskszqhttb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp1fywACgkQj4D7WH0S
/k6jeQgAoLN+VXXOB+z1f0HbZb9ikcQC2mevDd4JHgtRG5bJK1LekQ92vTBtDHGL
5hOxcoN7X7DorPQZt5zDoq3PNK5UsyLgdqJ/CqlIOrMccsctk//nNFo56WWOkxfz
h5TJ6Czia5t0ELTDvtse7QaRDg9cGvpecxIhAuUFd4g2DCwROUEdO4y6m7gmsAUt
deIIMXTb7K5CKQIQ3zju+QKd/bNxNnEcxcZiCDxRJGpGjzTmWihSCayXP7vPTtQN
Tm1Mi/MBwcbB9Mqz03LSGsp6UNLZCUcgPYWZrix7v/MtfmfA/T/IZzjTZNX5jLVY
nWDYA61X1eCKGjX1tgCngtThRezv5Q==
=aE0N
-----END PGP SIGNATURE-----

--iwu3m4uskszqhttb--
