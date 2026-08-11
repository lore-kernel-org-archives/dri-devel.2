Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0777C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAD410E32C;
	Tue, 11 Aug 2026 14:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="N4NeBAmW";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB2F10E32C
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:28:35 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso786482f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786458514; x=1787063314;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=15/Bnl2VxSh6SuH4L0zNteMsMCshNZVm/S5m2oTyH2U=;
 b=N4NeBAmWF30zqrB1gb1bRiY4fpYUMZo3teJNx/MqaOyg2lgwrE1XAr5sgZLF5+x/ko
 fOeO3hTtRlUOtQ5V7V5CMOB1jiCnRjtp8I3UC39xTYh+h4vA6sI3+9vaJMLNQ4z4Tmkq
 C8GSTxVCaXBS7lUOYnYQatPeqhXV6ZgZ9bdGxgkSllYvtXI9iL0Z2x9KdFZMIown6Ax9
 fX7gxTjkDl2mA8wQSEu5JmoYJu4yjbhXvhcZGvsiBt0kHxHscYuvEXRz6sUZPE9ZYkQ8
 VkTviBe1p6cgRmlzqlNLYdvjseilpXguE+7HHmenglU+weCnwzHXov89P3emE1L61gzL
 IzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458514; x=1787063314;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15/Bnl2VxSh6SuH4L0zNteMsMCshNZVm/S5m2oTyH2U=;
 b=J24o84Dl+hKsJi72VSFxA8EE3XYYeCuMsZfzWMhVX2x7WTgSjmX5lhvgCowY+OrL5r
 8SdM5PsYZWs39LOymKC5QEHdh3YWP3uafmhb2aqSLJSwcDrMz/t8YOFMiXQcxSPGLbEF
 xe1O/ZQS6qafX1JQjpmZCEMWUycT9Uy79yHhtJ1wLV7AdrV0aVaw5yZtGUnZdS5wKpoL
 Oehhk2oWvyw02+7+KsonCSHbA9PiBPv3tmfyPtEpOzpE+Qe8q0DRz5a+dvTwT0kkJbNm
 Sudh5dCSKvXD8xLYK+p4Cz6Bd6q9ueBGbq/0ji+lSxUuO/lkf3nFn8XnQOxAqQqCSyPv
 rvgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU9HYA6nS5Am6MX1SFnNbf4e/7HAu/Yt508jXffB+pE6CGdTkya2Do6WmMj/uWq5FeAIlszpq+hso=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJGtSCi2UcTMMlIS8jqvGLeVGYEYybjVnQHvCJbZjkm36gGg86
 zdHIA6g6Sqydmnnpifgo/ciwJgj9hcC1rvi6grSwpHNZ1EkIPKwDABhFGL0EOPdP7uc=
X-Gm-Gg: AR+sD11XFwOMPp7+rpUZM2kERh498BQa/7bftd6flKeQCWHsj8hHo2W3nCFEzJFxbwj
 Us46v0KeKZvThT2diw0AH+1E5GufzAmV0Qos5Vht5LTzbietpG2usp47AfZRH5Lwo59AuENn1lJ
 KjA1HEIAGv8vd5RlUJMGmQ6T/FG5deQ2O/BPPKCqGPkOTNpDuHkZRdaU9nko04zeKdO26JP9Xm+
 UhbTPtIUa+jTCOCPSFRSbJC3gvfxUtQMC3SZSbZLb8DqNlxMCUuIe9NXlcWEPB+zttjhtHBmSs+
 p5XK4os7QzAh09tMMi3A8fLWNAOaCzQHSBLjlGdELMzAsCcuwLilDzrIN4MaSKoL2E1+q/bEw92
 W7AkuMAvL8IWpdBh2U3sHcqMQfhsADroYJWBMi0IxZ7F13zBF2YLwHPMENz/wAwh3e8oKqF+B4d
 4xP44PZa/aYyW1RT1eQ6VL8XxgfXDldd48pP69PyJ0Wshixp/1JbdNIPaWOh6qyww2GY3GJwmGy
 ztB6c5UMyGdhenrhYQH7w92bo54ulcJABSX9hI8V6ZSrnrR86FI
X-Received: by 2002:a05:6000:46cb:b0:47f:e7f7:370f with SMTP id
 ffacd0b85a97d-4814ff0bd3bmr471948f8f.10.1786458513493; 
 Tue, 11 Aug 2026 07:28:33 -0700 (PDT)
Received: from localhost
 (p200300f65f017104853c3975fdcddd6f.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:853c:3975:fdcd:dd6f])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4814a5be2aasm4934080f8f.13.2026.08.11.07.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:28:32 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:28:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Esteban Urrutia <esteuwu@proton.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Novatek NT37703 based panels
Message-ID: <answxKBHSJNR-bua@monoceros>
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-2-34ad42b064a3@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mdziawi5h7yhrhrs"
Content-Disposition: inline
In-Reply-To: <20260811-nt37703-bup-v1-2-34ad42b064a3@proton.me>
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


--mdziawi5h7yhrhrs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Novatek NT37703 based
 panels
MIME-Version: 1.0

Hello,

On Tue, Aug 11, 2026 at 01:52:34AM -0400, Esteban Urrutia wrote:
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37703.c b/drivers/gpu/drm/panel/panel-novatek-nt37703.c
> new file mode 100644
> index 000000000000..5858bf12a310
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37703.c
> @@ -0,0 +1,467 @@
> [...]
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>

Please rely on <drm/drm_mipi_dsi.h> to provide the definition of
of_device_id and drop explicit inclusion of <linux/mod_devicetable.h> as
this will go away soon.

> [...]
> +static const struct of_device_id nt37703_of_match[] = {
> +	{
> +		.compatible = "motorola,bronco-tianma-v2-nt37703",
> +		.data = &bronco_tianma_v2_desc,
> +	},
> +	{ /* sentinel */ },

No trailing comma after the list terminator please.

> +};
> +MODULE_DEVICE_TABLE(of, nt37703_of_match);

Best regards
Uwe

--mdziawi5h7yhrhrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp7MYsACgkQj4D7WH0S
/k4ptQgAioC+Rr2A/Y5d45JoMyxiVG0O3RuWg9gDYCChFxXDJuKOWL12djmbG2Mm
+06Qy0mRg7Mf2XwORLM24txg92KtS9FWg454A4qeINt7TvZ1/FupspVlrxBKWwgr
jUs5ua3a1C3VIeM0safbs7w3tNhy7oo4o1xS/ACn4e4U70YZNxqooS2dpdcrx5qr
ObEH/mpbsEseluUZtEF8I5R+SbniO+25spM9TZXM30YGcoFiMKhHAoYzPQEbwKPE
RYsXTMMReO+5alsUjkAUfkQWzErZe05Sl7YdX3uMaxOAP9gSYa1sgToQU4nijg/c
RYsE/7R7AZASm+U0u+KySpmqyhqXMA==
=HQGs
-----END PGP SIGNATURE-----

--mdziawi5h7yhrhrs--
