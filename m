Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAFACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6119E10E553;
	Mon, 12 Oct 2026 11:18:33 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B768110E553
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:18:26 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so15163225e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791803905; x=1792408705;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ojX3hkGfX4or6LXO9A1AxAUN8SUQm9XePAgC0Ad/Cog=;
 b=HoqOkiF0b3Nti6GZGH0BSBgZ+OBSnGKe20V2IiY0QYIEMx+WU5zKSAnanqHw60TXK8
 Ngnzp3ofsGePMuSoyQ/kOB46392qC7GMclbSz0KuHJULvVbBkl9xABTjcUDZ9vh0jn+t
 LwbBwrptZzVrxYWpVkORjrCi87vkTWRq14dDlPY590jqE900KIRN3eiXlEvF7vZZfxDv
 pa5bwDIZyeUoEoGcjxSfws0wFE5/d89nYz9dBLHE5HNixm0QbIn2ph5QyhRB0vcwvOl+
 4dRn9YckhJxF5K/V/HoyY0ByDeLTzkqj0fNiG140jx00qLCUebp1QsyAak9vuanHglGz
 iFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791803905; x=1792408705;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ojX3hkGfX4or6LXO9A1AxAUN8SUQm9XePAgC0Ad/Cog=;
 b=F0rS9hkDT7SaliyQ/twrNZ86TXnnLXwjbh6QasJnqDjAuGuLQ+Mi90le7uW3yo308d
 KIXbUogICX8AFjYoeVj6KEiTx4K/RLbZAJoIHgXighxVKuVU3+UbK+PiiUOxr2T/ghte
 4VdWBxELB9tGq7rjNwfQRLr0eMg969/QbQ+S5v+u4ryzuIf+mSc7iBfHNExXveojY3r4
 lu5kD3UQ8wCY0uV5u2y3diFuuIGyvFEBKJ4UAjZbOH77Phcn896xLSc7aO6qh0af8PnU
 WVYC3nZx608Y/KtwUoanR/K1F2omnGIPhQaP3pjtZ59YXewUJZqh/l0wabfR06JyiHxl
 7+fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVvlDtCXFSjzVtRVGRjW9nXM5SIqMShgdBp4maPVKh6mluxxaJpghTZzZRtXOy7wKKwAJWqy5edTk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFHpDQcclNVWkSo5pTzOicXDOAd3WjrxN672PU2aCCaXs4Ob3m
 FVcGf6F7o7HedCcZC0NkzL66HRzqSDFgTU7t+mO5RCKkwFoUejtGolxjcYvdfI/ivjY=
X-Gm-Gg: AYBFou2f2gBQGFOGFmmb1cfGBcWvwPLyAZjxxok5lkU9h2NZVVCvgo76ghO09QYvkkH
 r39msM+/rCzHcPUyHnoRY+Adg9fDxcWtZB54MjkY2fjOzbVdLiXVRp9rX9EjDUy4VuCpdKyR2ql
 j6qHM8PYWAesJEgEVKEC/kzYlGVYaw6TIRwR3N2/cMrIls7loXtHo0SURLFTt5T/RuowmSGB2Hx
 GOMiC3+x1WW8alJIw+ANCbMVF+OTyFOgmzazW/7DitBSM366kt2KKdFLTQKorvR76mzbYadMhcZ
 kic71N156FLs5hXguwbRsaZthzCi63kPPDNUs7mshaTamZ2DEjebH7ezdEuQpWgMVQVss2TzKM1
 4nRugIl/HaFDcT/2GM+YqiHZTmazBv1mGHYFTVHdNafm73rv3Gu1UI/sf3D8qfdQWtN2UEjSCsz
 Q98w//gs8LbDlRMuz5rI4ZcNKjReynl7Sn09aXSNiwLiVMcKnYa1j7kYGu6rQ5RnRWoOiThW2Fg
 gfb0E+fD0v/KMbQVXpyENwutXUH702MKLtirgheriFRixGqkEA+L+0E+pqOHw==
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr159157835e9.26.1791803904585; 
 Mon, 12 Oct 2026 04:18:24 -0700 (PDT)
Received: from localhost
 (p200300f65f19a904ade4f69ba751c34c.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:ade4:f69b:a751:c34c])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a18bb68abfsm311754435e9.0.2026.10.12.04.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:18:21 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:18:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 5/9] drm/imx: Add support for i.MX94 DCIF
Message-ID: <aszBIkBXoFIkkeiL@monoceros>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-5-bcfb28de0aae@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cdga4qrbhoxcfsbx"
Content-Disposition: inline
In-Reply-To: <20261006-dcif-upstreaming-v10-5-bcfb28de0aae@oss.nxp.com>
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


--cdga4qrbhoxcfsbx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v10 5/9] drm/imx: Add support for i.MX94 DCIF
MIME-Version: 1.0

On Tue, Oct 06, 2026 at 12:22:00PM +0000, Laurentiu Palcu wrote:
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

Please rely on linux/platform_device.h to provide of_device_id and drop
linux/mod_devicetable.h.

> +static const struct of_device_id dcif_dt_ids[] = {
> +	{ .compatible = "nxp,imx94-dcif", },

No , before } please.

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dcif_dt_ids);
> +
> +static struct platform_driver dcif_platform_driver = {
> +	.probe	= dcif_probe,
> +	.remove	= dcif_remove,
> +	.shutdown = dcif_shutdown,
> +	.driver	= {
> +		.name		= "imx-dcif-drm",
> +		.of_match_table	= dcif_dt_ids,
> +		.pm		= pm_ptr(&dcif_pm_ops),
> +	},

I generally don't like the effort to keep the = aligned in such
structures and don't recommend to even try it. Still more if it's
inconsitent from the start. Just use a single space before the =.

Best regards
Uwe

--cdga4qrbhoxcfsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMwfoACgkQj4D7WH0S
/k616wgAm56cItlrtTGYJGQMifXXyKIZEbNaNh8obfuoDdC9KTfL6OrQDbETA8n/
83AtYbd6RkC4JP7NX3SK5DlSDS/oLGmxynxAfceKMBWsUcqR4oEpGee8ZRkIFMYn
BL355LaaGTv56+1iWN/tYDLNYYgKV+jwUYXmDJferAy0J0I1aTlYgEYMNoCJGGxb
ciaSMXRD1FzuAb3vpJpUvWltH2+boMSdeaKoj6ZblcP2sHWtw4UWN3b1YEcrSVcl
zMXusjBfMNf3S6BQ3GHOW5axtmRXjnPsqxXPCouSaEqqAahemWk+g7rA/4XF+Xax
302ZWP3FujxCr3/FFyysMyUncNGZnw==
=Kiiw
-----END PGP SIGNATURE-----

--cdga4qrbhoxcfsbx--
