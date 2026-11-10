Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD333606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtNm8Yu0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59C10E041;
	Tue, 10 Nov 2026 15:57:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 936A410E041
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:57:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA0041944;
 Tue, 10 Nov 2026 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D0F1F008A1;
 Tue, 10 Nov 2026 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326253;
 bh=y4liM3rZqK2hzewUSyJ+aSsol2hUV/6sP+DKWvHJyFc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OtNm8Yu0E9BPQOZ1H0fz8JCqAzP8QeIiZpC5mAguhNxl1Z1K/WFNPuOuZkOJSKYYJ
 iWV58cKohBRE/zA+c7oCADZTEFQ7HcUpv4o447e7QAfArbGUJy0cVWUsdQRy4TVGu+
 6IC55zZX0StGp/4XVoHMSSPzE6/2hfuNpkDcG4ZXWxTvQyzvevZaIffIPl8dLVene+
 fhq4R8HtB99973CzW1KOMtjGlFj48jnb0i/I1FS7o7bDh75ylFxX50J1qcC/vD/L9m
 a/xmCA9HJCsOWmqUV5ITZrVzfbWqsiuuoJjqr/lOpU1jTNViUPjQbU/9LD9PHBeP75
 0VgOFXkVXrWDA==
Message-ID: <sashiko-outbox-207309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/28] drm/panthor: Add AM_SYSTEM platform driver
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-13-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-13-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:57:32 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panthor: undocumented gpu-supply in
  panthor_system_regulator_init()
--

commit 7d8058a58397fcb291163cb1ac726e2a1ba1d037
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_SYSTEM platform driver

This commit adds the AM_SYSTEM platform driver for Arm Mali 5th Gen AM GPUs
to manage shared clock and regulator resources and perform the initial GPU
reset sequence during probe.

> diff --git a/drivers/gpu/drm/panthor/system/panthor_system_drv.c b/driver=
s/gpu/drm/panthor/system/panthor_system_drv.c
> new file mode 100644
> index 0000000000000..e70dba4058f38
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
> @@ -0,0 +1,344 @@
[ ... ]
> +static int panthor_system_regulator_init(struct panthor_system *sdev)
> +{
> +	struct regulator *regulator =3D NULL;
> +	int ret;
> +
> +	regulator =3D devm_regulator_get_optional(sdev->dev, "gpu");
> +	if (IS_ERR(regulator)) {
> +		ret =3D PTR_ERR(regulator);
> +
> +		/* Regulator not found. Exit */
> +		if (ret =3D=3D -ENODEV)
> +			return 0;
> +
> +		return dev_err_probe(sdev->dev, ret, "Failed to get gpu-supply");
> +	}

[Severity: Low]
Should gpu-supply be documented in
Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml?  That
schema sets additionalProperties: false without listing gpu-supply, so any
arm,mali-gen5-am-system device tree node providing the regulator expected
here will fail dtbs_check validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D12
