Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45D2C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F62810E449;
	Tue, 18 Aug 2026 08:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="F9QdymzI";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA95C10E449
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:59:10 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47362928f65so4209696f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787043549; x=1787648349;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
 b=F9QdymzI8ce4EKOvk4r+8/fuo7MNSILmnVLyTR6k/Dqz0TnKsjHHH4vLbbmfX9rcw+
 MDbW0dKRWVl5ZuBEXpplzEWLDLFO9xP8pDAyCpW/gkzYr/xIYj2IpVWI2eVjttPa1l6k
 +IWBtPwDOaVrbW1cfP99yEA7406dzB2cCXlYgJNNx/VROwbviXHvQyXJ7RKjyIy1MHAq
 klEN4HGr83gbMUsYhrhp45iny3J/YfUOOuBa+G9ujIsJhAkGUaoXZtgHbS7Mfm3DfQeu
 azMdQzcVSj/vndJF+VQgofHpeDD+4BD1xG9f/WqUgjkfw07f2KVcihTaQcdk/j3N1BZU
 yIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787043549; x=1787648349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
 b=m1naPYDwzPORFF/awj81ECTlsxOoQ6JMJ5IrwHd1A6NsS0rBSX+IWr08X6nP+Qbubb
 18O51AV2F+6PQyTx4apY+dmtU8E7ZaVPVHJg/R/QzQHYIf8TQdhJkeUQ0QP0W5d2KR5+
 UtntZfxHiRYzw1aaOIPGzFvzEtLXAq/DDnlZXlb1WCSOObO8/guM8FSxZNylPwobi7wR
 5thwRiiPCIEJma6Y8juqHj/R8dCYSfJCHbPzxblo03yWtq2Rh4euyLHFeTJP5Lch/dB9
 5YKEsIkpSLqiU1MNfaVQK9Anf+HEUlvUAOW5PXpLyjnJ7aVxD3N6kMKcsdA1QMG9G+WD
 hikA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzzxHkGfa1j25WV1PRADHM1Y+AZnGwm7D0JZA6onlVIMcjy5TaoDpzoQaY1+xGjSRUh3IoXC4bsRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhScC6WHKG3D+RMGvRpykffVx/exGMQ4QdhV6mxmK7XkS1bKFi
 P3Fy8ESy1YD1UZrVIQ/okqMNvN3D7KgZp05YLzQoJCNGGkwripJfVgNv6iYcXhc6L+Y=
X-Gm-Gg: AR+sD10z37mhOS40J0ldhOlbleNHEB7VwmTObp186ruagjLXYOzJoK2kNwJdtlwRbWd
 /McG57Xkele60eNUEOnPePxQfdthuzyn7kPpV44fH1XnG7psaTrbn02NFixy0iEx03lwOYRycUJ
 YPkV7/TeQI1psk0mTVcmkeO/0Q1mAyQoTCfPRnfAaXqqe1SCIjFRsQw/gY/7JH0NhHznOOX1eON
 e+/1XuRqU5yC6Rg0mnCLjWraGm4ElRoe8GX4mcX8ubgYpWjYKpDFHrcUsYVlZyZq++DY+MDpmpc
 pIC3Aq0N12LCpZpuUZgsXkFCeK2Y/A+saeJnkiuG9VpcyNg2TJPidvl4nHRHh+e9722oIDEK39C
 B/hTEkRKPKrq9X/dqse5wtFN6CPlyxKwHxdJPh4En3+Y2DNBouPjOAsciFKicNKg42xQASgtuVg
 Or1S9d19R5BLETQT7QufwWAK3c7rS49HssOCtes2A3VPoklicBx7SqF7iD7If3lRAYZfuvv4lz5
 zRmV1Jr7yuoJ2usBBJ2zlnTpgjjPPOuSkRlQiDzTGMbrUgbm87D
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id
 5b1f17b1804b1-4999fb3f78bmr112284285e9.8.1787043548729; 
 Tue, 18 Aug 2026 01:59:08 -0700 (PDT)
Received: from localhost
 (p200300f65f01710416869d85a644e839.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:1686:9d85:a644:e839])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49987b278fbsm215087975e9.2.2026.08.18.01.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:59:07 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:59:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, 
 zhangqing@rock-chips.com, royalnet026@gmail.com, chaoyi.chen@rock-chips.com, 
 diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
Message-ID: <aoQdns-GHS3fg5BJ@monoceros>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-11-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uvayaecgmyelikx3"
Content-Disposition: inline
In-Reply-To: <20260817113603.1436067-11-gahing@gahingwoo.com>
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


--uvayaecgmyelikx3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
MIME-Version: 1.0

Hello,

On Mon, Aug 17, 2026 at 11:36:01PM +1200, Jiaxing Hu wrote:
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99..0096c4ab1 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -6,10 +6,12 @@
> =20
>  #include <drm/drm_mm.h>
>  #include <drm/gpu_scheduler.h>
> +#include <linux/mod_devicetable.h>

Please don't use <linux/mod_devicetable.h> but <linux/device-id/of.h>.

The former is a mixture of many subsystem specifics and thus a
dependency-hog.

Best regards
Uwe

--uvayaecgmyelikx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEHtYACgkQj4D7WH0S
/k4U9gf/aUhrYYFY54POvnsxnelsCZk9pbdIP6pqEh4NpwVQM+NfUIh1SYqcLXIf
NqdrFegte49P8wGlByYbp2BP8P+Vh/KdPn+VPTi15o5ivhF6/lS1s3Smp5hwDS1N
lDMzlLblQBoye2bS2VSkmaaJyzaZEARrJK3GOBpmc8PXGkMOFRFgF+ZgXiyEC91u
E3rOSqRX153lKJWaHX3SH4yO0RUjN22sW6htFUwQZTm4iLRG6IzaP2+BM2cpWnCe
I4RwXW6GaPue9NnC/Bf/659cN68fjK7fUU5JJn80cMtfO47GjXmA3ceX28vIB/rm
WKAMBlhKd47VGV36uZrPNREsoz3v8g==
=ee9u
-----END PGP SIGNATURE-----

--uvayaecgmyelikx3--
