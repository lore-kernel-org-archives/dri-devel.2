Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA8606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZJVwFq+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDF710FF13;
	Wed, 18 Nov 2026 18:11:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A1D10FF13
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:11:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B93B422B1;
 Wed, 18 Nov 2026 18:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF91F000CA;
 Wed, 18 Nov 2026 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795025468;
 bh=ZPGYOniFEW8UWdeOVV1k4a5IAhEXjVEKYaRzLZIIGOw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YZJVwFq+Jso0iKdhRMRKPvSweAKKWjJJSre0uleo5PI4oBagQvO9/rzGk7VCYbsVv
 cuZxocUqseHlETftA0czhDmD6gcxkfvJ1tB8/4Bg7BrI9m2aLb1rT6FzO15Kb+SvUy
 /vv1lQ2ND/Fzi5/i0qr4WGfDPiQ0uNvxLV5bi0vTRRa793u5yz2+fdD7o3m+PR4qp6
 omyBdWVHjI2F6y5ZKsIkdF3lojrrJw4C+S0YWW1qp8HOuEYXMHSMv9er/FJzTk5DB2
 MEJPHKh1F23Jh+pxHL4Cp37JtSsJ2X3mW+wAYSWwjgmrCr3J0mZcbf612wY+8Wunk4
 13RpZ8LztRffg==
Message-ID: <sashiko-outbox-221729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] drm/panthor: Skip devfreq when no OPP table is
 present
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261118175332.519657-11-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-11-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:11:07 +0000
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
- [Medium] drm/panthor: premature -ENODEV check in
  panthor_devfreq_init() skips DT OPP table
--

commit ab9f7c849faad8dd2154fb00865ae2985875a9a7
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Skip devfreq when no OPP table is present

This commit skips panthor devfreq initialization on Mali v15 AM systems
when no OPP table is present, guards the devfreq helpers against a NULL
devfreq pointer, and omits drm-maxfreq-panthor from fdinfo when fast_rate
is zero.

> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 2249b41ca4afe..d1814b5197221 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -12,6 +12,7 @@
> =20
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
> +#include "panthor_hw.h"
> =20
>  /**
>   * struct panthor_devfreq - Device frequency management
> @@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptde=
v)
>  	 */
>  	table =3D dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR_OR_NULL(table)) {
> +		/*
> +		 * On v15 GPUs, frequency scaling is handled outside of panthor
> +		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
> +		 * an OPP table. In such cases, do not initialize devfreq for
> +		 * panthor.
> +		 */
> +		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
> +		    PTR_ERR(table) =3D=3D -ENODEV) {
> +			drmm_kfree(&ptdev->base, pdevfreq);
> +			ptdev->devfreq =3D NULL;
> +			return 0;
> +		}
> +
>  		ret =3D devm_pm_opp_set_regulators(dev, reg_names);
>  		if (ret && ret !=3D -ENODEV) {
>  			if (ret !=3D -EPROBE_DEFER)

[Severity: Medium]
Does checking PTR_ERR(table) =3D=3D -ENODEV right after
dev_pm_opp_get_opp_table(dev) skip devfreq even when the GPU DT node
provides an OPP table?

dev_pm_opp_get_opp_table() only searches the in-memory opp_tables list for
a table already registered (for example by a power domain) and returns
ERR_PTR(-ENODEV) before devm_pm_opp_of_add_table(dev) has parsed the
Device Tree.  As a result, on arm,mali-gen5-am systems without a
pre-registered power-domain OPP table, panthor_devfreq_init() returns
early before devm_pm_opp_of_add_table(dev) is called, ignoring any OPP
table in the GPU DT node.  Should the -ENODEV check for
panthor_hw_is_gen5_am() happen on the return value of
devm_pm_opp_of_add_table(dev) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118175332.5196=
57-1-karunika.choo@arm.com?part=3D10
