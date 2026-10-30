Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7A606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6eGCPHe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A975910E87E;
	Fri, 30 Oct 2026 10:08:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DBC10E87E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:07:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8404601EE;
 Fri, 30 Oct 2026 10:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDB81F000C1;
 Fri, 30 Oct 2026 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354876;
 bh=RRGG+nMF/kpQZTAaIuH7K29ONaEy1fhm7c9ASdHRyMg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k6eGCPHeYHUCC1GhjR6+/Skkub2YCoSEnGxiJEqCZAcHOctyckOPrDjBriTfVDwog
 zN9rtOsWiATwu0l5KvrEgcoZYyPwJlPE36k1656y/ON3H3i+xYeTZZNEcSx0JRsna2
 Pl2gN0X9CT5XclBIYOwDtJL2LotSIOQpQ20ybhLQ4kbO9JE1yxde2AyOpYDIzBmTPr
 km4a3ks2/J7ztnvedEfP+V/ZIkKVUdQi2LaNT4DEHKnbpmobEwty1oSrRLTHAkJTEP
 xJivHwhXm4yV2zmYHCcAgkJInvYaWcJkoRfLgag4n4a7R02IsJrY1MAqcq0YZjgstD
 jT0rJIz/k30qQ==
Message-ID: <sashiko-outbox-190808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] drm/imx: dc: Flag CRTC status in
 GERNERALPURPOSE register
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030-imx8-dc-prefetch-v8-5-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-5-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:07:55 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm/imx: dc: missing max_register_is_0 in dc_gp_regmap_config
- [Low] drm/imx: dc: commit message uses stale helper names and register ty=
po
--

commit 376ae6ee1d9ffb7f4790013466f30007db36afe6
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Flag CRTC status in GERNERALPURPOSE register

This commit maps the Display Controller's GENERALPURPOSE register via an MM=
IO
regmap and adds helpers to set, clear, and query the CRTC enablement status=
 in
its 2 LSB bits.

>     drm/imx: dc: Flag CRTC status in GERNERALPURPOSE register
>    =20
>     Map Display Controller's register GERNERALPURPOSE at offset 0x100 and
>     create an MMIO regmap to access the register.  Create helpers
>     dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the regist=
er
>     to flag the CRTC enablement/disablement status.  Also, create a helper
>     dc_drv_crtc_was_enabled() so that the CRTC driver can use it to check
>     if the CRTC was enabled by a previous boot or not.  This is a prepara=
tion
>     for an upcoming patch to disable display controller at boot if the CR=
TC
>     was enabled by the driver during a previous boot instead of a bootloa=
der.
>    =20
>     Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>     Signed-off-by: Liu Ying <victor.liu@nxp.com>

[Severity: Low]
This isn't a bug in the code, but should the commit message be updated to
match the current symbol names?

In drivers/gpu/drm/imx/dc/dc-drv.c and drivers/gpu/drm/imx/dc/dc-drv.h, the
helpers are named dc_drv_set_crtc_enable(), dc_drv_set_crtc_disable(), and
dc_drv_crtc_is_enabled(), rather than dc_drv_flag_crtc_{enable,disable}() a=
nd
dc_drv_crtc_was_enabled().

Also, the commit subject and body spell the register name as GERNERALPURPOS=
E,
whereas the macro in drivers/gpu/drm/imx/dc/dc-drv.c is defined as
GENERALPURPOSE.

> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-=
drv.c
> index 13795a2ad7350..9629beaed43c1 100644
> --- a/drivers/gpu/drm/imx/dc/dc-drv.c
> +++ b/drivers/gpu/drm/imx/dc/dc-drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> =20
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -28,9 +29,21 @@
>  #include "dc-drv.h"
>  #include "dc-pe.h"
> =20
> +/* General Purpose register offset used to flag driver usage. */
> +#define GENERALPURPOSE		0x100
> +#define  CRTC_ENABLED(x)	BIT(x)
> +
>  struct dc_priv {
>  	struct drm_device *drm;
>  	struct clk *clk_cfg;
> +	struct regmap *gp_regmap;
> +};
> +
> +static const struct regmap_config dc_gp_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.max_register =3D 0,
> +};

[Severity: Low]
Should dc_gp_regmap_config also set .max_register_is_0 =3D true here?

In dc_probe(), only a 4-byte MMIO region at r->start + GENERALPURPOSE is
mapped and passed to devm_regmap_init_mmio() for priv->gp_regmap, so offset=
 0
is the only valid register.

In __regmap_init(), map->max_register_is_set is initialized as:

    map->max_register_is_set =3D map->max_register ?: config->max_register_=
is_0;

Without .max_register_is_0 =3D true, regmap treats a zero .max_register as
unspecified and leaves map->max_register_is_set false, so regmap_writeable()
and regmap_readable() do not enforce the offset 0 bound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-imx8-dc-pr=
efetch-v8-0-c4f81afd4533@nxp.com?part=3D5
