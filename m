Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A2606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0gBlAOP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6132110E22A;
	Tue, 20 Oct 2026 08:52:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35AB10E596
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:52:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0147760142;
 Tue, 20 Oct 2026 08:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C66F1F000C4;
 Tue, 20 Oct 2026 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792486331;
 bh=ZH1z6KDVx90CY10u+4FjiY0FSByMO+4UfjWl2FRvU9M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T0gBlAOPczycR1ibIInPoOYRYf96wkiPpCFkeNWkCT/3n5C/3THP2ZDql7ZCXA6s0
 M4KTWYKJ0L5xXXqwJ2yhyLSRJr536ubI7AQfZxIa6eq9HBTz4ouaOpkE/coKJA2Zwp
 MlZox7KQUjto/5aVEIdqDGDVZ2UpEqOCOuZe4dAMOldsrV5FRhu1npTDXj7QeWDS0r
 mJnDwC0VCCs0nvsPgooyJHPuobEi6y8JBMzoVj6wGqGkjoj3yKsVIN6hnhGSTSJIRp
 MTV8K+rALS7+VErh4aj6uWwjoXS0UAjpZserSlU1GiZq6WBP6oGyPR8CVI11lmluHY
 784gHtSpx0cAg==
Message-ID: <sashiko-outbox-178640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261020072816.180-7-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
 <20261020072816.180-7-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:52:10 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/rockchip: cdn-dp: unguarded PTR_ERR() in cdn_dp_probe() breaks=
 extcon
--

commit 1cf3e3cfbcc79fdbf3996fd0993b72d987bbcf59
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This patch updates the Rockchip cdn-dp driver to allow operating without an
extcon device by retrieving lane count information directly from the PHY
while preserving existing extcon support.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 68aa66915e8ac..1c1c1116b5ebe 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c

[ ... ]

> @@ -1122,14 +1131,14 @@ static int cdn_dp_probe(struct platform_device *p=
dev)
>  		    PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> =20
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) !=3D -ENODEV)
>  			continue;
> =20
>  		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
> =20
> -		port->extcon =3D extcon;
> +		port->extcon =3D IS_ERR(extcon) ? NULL : extcon;
>  		port->phy =3D phy;
>  		port->dp =3D dp;
>  		port->id =3D i;

[Severity: High]
When an extcon phandle is present in Device Tree and resolved,
extcon_get_edev_by_phandle() returns a valid struct extcon_dev pointer
rather than an error pointer.

Because PTR_ERR(extcon) !=3D -ENODEV is evaluated in cdn_dp_probe() without
first checking IS_ERR(extcon), any valid extcon pointer will satisfy
PTR_ERR(extcon) !=3D -ENODEV and hit the continue statement.

Doesn't this skip every port that has a valid extcon device, making the
non-NULL branch of IS_ERR(extcon) ? NULL : extcon unreachable and causing
cdn_dp_probe() to fail with -EINVAL on boards that use extcon? Should the
check in cdn_dp_probe() be:

	if (IS_ERR(phy) || (IS_ERR(extcon) && PTR_ERR(extcon) !=3D -ENODEV))
		continue;

instead?

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020072816.180-=
1-kernel@airkyi.com?part=3D6
