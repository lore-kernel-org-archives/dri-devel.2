Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79945C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A7D10E6EE;
	Mon,  7 Sep 2026 08:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ozqNurEt";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DB810E6E5
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:35:17 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d0b98d6d0so13290445e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788770116; x=1789374916;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zNMtCRsUQspr7I5Yp/4mxHgCjGnZu22lUWt/I66qtMo=;
 b=ozqNurEtqR+V1H+GvmQm0S0gOG4wreVpSqObxNoeJiPWkPqoNy1doOSiS0Ajhg2MQA
 hbhNzW1Tey1/vd+kfMASTMq9hRIM88qpSd91l78TwLrnLVrKcqgFsjKGEn7dAqQETsR4
 j76NhSuK2IrHpol0gYdBYs+Gl8dOJkJYs0DaeSJ8x06tptiB2MyAr0waP2Q86Z/EYLAF
 2pI/aahXjOr+vIMjTBVczb+kVjpLAHK6+Bm0ieIrZnT3MHaE7AGr0KQv+2xk+XmX9UfO
 x4A0Q5/fupH8Zbp5wxNPnH9J2YL2MQyHemxkAZZl1mb7FlzaXJBQNmeM/eGqGGDmHQJp
 evgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788770116; x=1789374916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zNMtCRsUQspr7I5Yp/4mxHgCjGnZu22lUWt/I66qtMo=;
 b=ZSLqN8D9TTnJ5Fd/kljEHWZL7y1tHb1TCxR0tOCpDeSPcQhCUoo4Jwm5eI01s3TSQt
 EHyNGeJblpvIE+OkQ2cQ32BM2yTjfq5+rBf5Rs0rcBv888edpSVRO+Q1mc6iOYWaw0FJ
 hHc9bFiRuqRAx3HAcBmdwwUq5VcWFhrOKee24Sl6UApxs4/qcicZXQQIOU76tzsi2+KS
 r1YKAS2UrVYiSQOOGy6e9izKrjLdXhhSMqb6HuCGE47exzHQS0PR0BJxlv/Tpi6C5rCa
 YO1ZC8g4gxPat+VaephsMFgWT1ovydbfsR5fVgAEvVnUDRmTt18gKvs3ACHNMOIgohwp
 gYHA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEp7YszM9KjY6GZh5/mQ9w7DI/gvAo9cGa3KVpICtkgqxY1LZDRRQtdbhkMVZGeQyMNf73J2u3Q7o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1rwEWPvkU0YgqnNGJIJEjv2QFFCWA4vib+kKluUIKutZ3vaMc
 WbDSvdoLAjQNUFS5fw8nmjroYiLEyj3KtB2wX2IvMM5cG/uzpRRwf3dXKJKwoB1EnE4=
X-Gm-Gg: AYBFou2ty8LhCVqn5hDuXTC6IFUxP/m9QOqgGjde4A+7NwgpRgbydUdrXUjV/s3PJO4
 BwoItc9hCPEDNYywZfdJ/S11zNSWS19AldigjY8pqDa1s5Qaz1/PuEq81jAD2sM/4aBcvKiTYZj
 9bJLW/zbLYxrumO5kL02pbxczXSu3Wdkw4HCjjmlvZvsR4pCfqj1yEmDF2apFQscKYUITNT7q6b
 yYrxc3WeTLMiwVbImPAZbmWV69N2P9F1C6QIaaWon7N34nrfN/jrZR1FB7EbsCWLbfBdI3ERQWE
 pS/3qxNbmL2tfDyYsaI83EJgYAgH/zBdGaH65iG747c3Wxn8Vqzml/dtvjWowNokx51Y6jKjSJQ
 bGU+YC1eQx4jHRpMQ8QrNZ7SS1dbNFx5IJFH7wcTvgAOdySvhmSK9iipMPlgTMYwQKqCP1b2iG7
 z6NFA8sE+KiAn8rPWaNNi84WQv6fkNk9FJ6I+tkTiWZJHOBmfISWB7Ah4Md+VrDsiIRjVoRSNsI
 kh60bnNWlMIoYaVd4mhTm7ZFqTE9pq8lQUpLSM5XnPhKS/mB6M=
X-Received: by 2002:a05:600c:3b9b:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49cf8286e30mr197654635e9.15.1788770115721; 
 Mon, 07 Sep 2026 01:35:15 -0700 (PDT)
Received: from localhost
 (p200300f65f19a9047ae53bb37ada872a.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:7ae5:3bb3:7ada:872a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49ce4761dd1sm274503085e9.0.2026.09.07.01.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 01:35:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:35:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: Re: [PATCH RFC 2/2] drivers: gpu: drm: panel: Add BOE NT51021 driver
Message-ID: <ap52w_LsxykYh6T1@monoceros>
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-2-cc1ca61bd261@mainlining.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f7m35ekvx6ajsize"
Content-Disposition: inline
In-Reply-To: <20260829-qcom-novatek-nt51021-panels-v1-2-cc1ca61bd261@mainlining.org>
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


--f7m35ekvx6ajsize
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/2] drivers: gpu: drm: panel: Add BOE NT51021 driver
MIME-Version: 1.0

Hello,

On Sat, Aug 29, 2026 at 11:09:14PM +0300, Nickolay Goppen wrote:
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>

Please rely on <linux/of.h> to provide of_device_id and don't include
<linux/mod_devicetable.h>. If you want to stick to IWYU, include
<linux/device-id/of.h> instead.

Liebe Gr=FC=DFe
Uwe

--f7m35ekvx6ajsize
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqedz4ACgkQj4D7WH0S
/k6mCwf8DB+wWG1X5R1Barm6eVJNkn6T9iEtu6q952Rb44GVXBmsgNzH/8kPoPvx
MgqVTBvCjN5jnomwxeU4EPk1eRtFXqf4jwGytePENeFWAqwNGvBZHuYaowSbPCzb
r6NXPx7I9i9qrBNTAufIz8/sLutrkzoc5so8Z33c3eovQgHbRZXbNpsBSW7Et7d3
DEBJbSFNF4lYRM6ozD7Xk2CHDgfhaf1sznfIlFIXe1jA1/tAIyI21LSclKz58Dkt
JuDlvdCCSC+hoWswZFYnITu60LPBwbgo8JeIVPx07ZuHJr2v6yknqw1yefvB1TKC
r+3sOCPIgjR9hMDIjXlfEVZwDo/T+A==
=6K8E
-----END PGP SIGNATURE-----

--f7m35ekvx6ajsize--
