Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C5606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hCEh1ae5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C757B10E0C8;
	Fri, 13 Nov 2026 06:23:47 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FC010E0C8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 06:23:41 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so3377315e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794551020; x=1795155820;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=scTX0bumEv05AQNebNSsHg/mOW7TqFZSq25FZEyaOcI=;
 b=hCEh1ae50zOzReniHkNLmGWpEzqWKpADG89FakNUXgDOriehOTBS7sSp2OfWsMZItJ
 VxDh8fxQ9mlQdZWTFRrFLd48MPk8yDNuO8w3XW+L/yeXqISLmIFzLCcuZuFVpRa/Hp0A
 U+otRSHVHuPoPqMsZWIjvnuKX7W5jIjxnzV7DP9wKhNbLZAidEV98GFqbs8blMhSpZLc
 amYT0P5jg1/8PH8LkWoxctBOq3WMc/HRAan6MDtZV5qraUKIogcQmlO2ZPS40HzVN+xO
 JvT+eYQhP8KWJ1o/wewkfb5rqqGyYliXyBYF4U7buOoKciRNUfiZ8l3mBM9YlU96Ro54
 vqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794551020; x=1795155820;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=scTX0bumEv05AQNebNSsHg/mOW7TqFZSq25FZEyaOcI=;
 b=DE6NZMmvZfWrjSSLQUGFzgs6QMN+pXMuh2bFJ75SFUx0itLAIStumTcFPJof2Q5VuS
 XvfK2O1Awd1NEgTQhzy2BklnUfgIS4rAsTddyOWSFmRSNe1aJTDsYGjVpCsSuGHzQQlm
 bk82YUuK8j3xcHxd9dOSvmQezGehNRm2DeSVxjUCNfP2gsRHzx1u8uU8Fef2VZH2+d30
 BEHThFJmDaKWhmn4Yv8lYB62YpOOzmv974D6zQGN7vNW1nlowLuMqWfSBps3txHfaO6s
 8VOaXVhLQQC8/w4fn8vHsiwUeRrVJp0JSrf0rZmzp9HxpRxoXSSf89QqcWeKzHncvXTm
 T1jA==
X-Gm-Message-State: APuU4Z9HvlSRBKY79NFPw9FHfitChJj/vTQEXHUdldJI0RtySa8pJHGu
 Vi/oD/eXC+ywToEFaVM2ec5/DzwGfnJb7X4VVlWWycFUIc3xsIQX99mylIANnfKVUMo=
X-Gm-Gg: AYBFou1z7vonX1NpHBPHY0KVUdVNZx8f++COK+Io/hKVtQFURH7Yu7ekc3IIc+DTPBA
 O+Ub4+bl6BWnJD/NwkZk6Pl5ELjAvw8hXPRFRKpHpYEcIrUwlGOpRZJimChE3eNhc5zHlIVEQjM
 8hOTTs20iPJwsAiV8wVjf4lJiOrwaORUbs2Dku5EaJn0eEew1Twky7PVnXX5oKYVaNvAgjVpnJ8
 3NuzUjagLDYFky4loKD16WtL5zJrX1vuVHCTgKPhUGNJxpUE8VhjaBKVYZmR7JWjkD9Fa+Cino0
 VI0A9ozC3vR89QHVqEa4p83KiYQe0K7ohkeqPUCd0/VQCpDMKm72y2zdX4Lcv8O9sPK6gkBOaM9
 MT5R3VUyUH2Gr9xGGoIFHVr1uwnDTzEEHrWJFjAMLrqoGzz5zZrsS8bPMAU4O5M8VwJyCmJ1jjt
 KxHO7MU4wmLlrurH3qblmlOBbEKuuiaLuz6xGPVS8asScfnUGCfgMwm+4QcF89yKherCm5CVhLg
 2RpXeWgO1lUS4KX4YwCgsCEttl4YMzOxNs7k+Ky5c91kYjL+M/+x+leBOVyx4BVazQJTHSlpqVE
 WUHRN20hCWq158kTSfFcHofeTISHttRlbbvvusnujEJnI5uwxcdLFlfnALKFS9mLAUd43tKUnKb
 PJj8myogWSIyjvM+8R7k=
X-Received: by 2002:a05:600c:1daa:b0:4ba:2bfc:c8ab with SMTP id
 5b1f17b1804b1-4bb55a4801bmr29639465e9.15.1794551019876; 
 Thu, 12 Nov 2026 22:23:39 -0800 (PST)
Received: from localhost (ip-091-089-005-024.um28.pools.vodafone-ip.de.
 [91.89.5.24]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb56f8d054sm16744035e9.3.2026.11.12.22.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 22:23:37 -0800 (PST)
Date: Fri, 13 Nov 2026 07:23:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Joseph Telaak <joseph@telaak.dev>
Cc: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>,
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 12/13] drm/powervr_sgx: Add the DRM driver, power
 management and debugging
Message-ID: <avajebb1alBnAm8U@monoceros>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-12-c69b84bac011@telaak.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q3fovxmny7pd3sxx"
Content-Disposition: inline
In-Reply-To: <20261112-powervr-sgx-v1-12-c69b84bac011@telaak.dev>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--q3fovxmny7pd3sxx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 12/13] drm/powervr_sgx: Add the DRM driver, power
 management and debugging
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 05:59:02PM -0500, Joseph Telaak wrote:
> +static const struct pci_device_id pvrsgx_pci_ids[] =3D {
> +	{ PCI_VDEVICE(INTEL, 0x089b), 545 },	/* CE5300 family: SGX545 */

Please make this

	{ PCI_VDEVICE(INTEL, 0x089b), .driver_data =3D 545 },	/* CE5300 family: SG=
X545 */

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, pvrsgx_pci_ids);
> [...]
> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_of.c b/drivers/gpu/drm/po=
wervr_sgx/pvrsgx_of.c
> new file mode 100644
> index 000000000..e347a3699
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_of.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright =A9 2026 Joseph Telaak */
> +
> +/*
> + * An SGX on a device tree SoC (Documentation/devicetree/bindings/gpu/
> + * img,powervr-sgx.yaml). On TI parts the GPU node has no clocks or power
> + * domain of its own: its ti-sysc parent module enables both, and applie=
s the
> + * SGX interrupt quirk, when the GPU device is runtime-resumed. Every re=
gister
> + * access happens with the parent held awake.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>

Don't include <linux/mod_devicetable.h>. of_device_id is already
provided by <linux/of.h> and also by <linux/platform_device.h> without
the useless dependencies that <linux/mod_devicetable.h> introduces.

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>

Best regards
Uwe

--q3fovxmny7pd3sxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2rOQACgkQj4D7WH0S
/k653gf/auhko2qaNS4BWJKPTZ0U6dpwzMZplMcZygr/SRNkqB4rtNEr7cniJb/w
6HZVwgsx6EXyuiQ3Fznzch9R+5VAoHbqY1QrjaycWAttOem37Sm+3FGHqoG0zW8R
XSea37dwrl441qCF8WonzOU9YK8dbo2CV5Bi6SGvtf/fnaj1F3smvAws5CmtB5yq
KEPdVWFNnVGqV95nEDkgb09I3EgkCZRkYmBn3bEN+VrJRvYJOfNdGX8AkBDjog3e
D6eh7mRm1yDdkHd8zrpKf9tAAaS784qhDz6YzqobHn/DSybseU7VEV+6gsajSEWE
tJ7bUnZyLTpFf7SLsE8ghAOQ8KSLmQ==
=uMBo
-----END PGP SIGNATURE-----

--q3fovxmny7pd3sxx--
