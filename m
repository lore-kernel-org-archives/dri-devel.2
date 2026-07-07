Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBFC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2E210ECFB;
	Tue,  7 Jul 2026 13:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ian6Kg+T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57AA10ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F866618B3;
 Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7371F00A3D;
 Tue,  7 Jul 2026 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430699;
 bh=9J/5kdUzNZ4A1zvWuu+ZIn5vyFjeG5mMP6m9LXXbf/I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ian6Kg+T8E9rhyk0z8vcxmm3rnQUFwc35apDM5FVYpdlp8ppMxaGfYzPgIDJe9Kg7
 UZSj5hu2X7TsVh4pOOfzwXohO8A7nlwCTADd193u3lWOwRooM/t13uMEyodkm9MNO3
 /wCtJfL3U8JJwFeFhIs0mveSGyeDiw/yFVBTzUR7wyztE+xzhaej5IQpFYzGb1rxOG
 tvhUFxUAKtu4hx86lB4J+mOlS5EYaKvjCL7xrNicq3ypSjGWJLLqRyaAhk+MrUq9nS
 xJVdC1jqhHztxM9Ko81X20dTzTYKCWApoa55VgK3YSBK4IPao77GIX0gKLCEVGKnal
 gRPW3MyfpBhNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/20] pmdomain: imx: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, lee@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, imx@lists.linux.dev,
 mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:58 +0000
Message-Id: <20260707132458.9E7371F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Child platform devices dynamically added during probe are not unre=
gistered on probe error paths or during driver removal.
- [High] The i.MX GPC power domain driver initializes domains as powered on=
 but does not set GENPD_FLAG_NO_STAY_ON or provide a sync_state callback, c=
ausing domains to stay on indefinitely.
--

commit 183445e8048cfd412f98719fae14416614f14176
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

pmdomain: imx: use platform_device_set_of_node()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 42e50c9b4fb9f..abca5f449a226 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			domain->ipg_rate_mhz =3D ipg_rate_mhz;
> =20
>  			pd_pdev->dev.parent =3D &pdev->dev;
> -			pd_pdev->dev.of_node =3D of_node_get(np);
> -			pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
> +			platform_device_set_of_node(pd_pdev, np);
> =20
>  			ret =3D platform_device_add(pd_pdev);
>  			if (ret) {

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that child platform
devices added in previous loop iterations are not unregistered on this error
path.

If platform_device_add() fails, or if platform_device_alloc() fails earlier
in the loop, imx_gpc_probe() returns immediately. Any successfully added
"imx-pgc-power-domain" devices from previous iterations are left orphaned.

Because these orphaned child devices hold references to the parent's
devm-managed regmap, does this create a use-after-free when the parent's
devres cleanup runs?

The same unregistering step appears to be missing in imx_gpc_remove(), which
skips the cleanup of these dynamically added platform devices entirely when
pgc_node is present.

[Severity: High]
This is also a pre-existing issue, but I noticed a potential problem with h=
ow
these domains are initialized.

In imx_pgc_power_domain_probe(), the domains are initialized as powered on
via pm_genpd_init(&domain->base, NULL, false). For OF-based genpd providers,
this sets genpd->stay_on =3D true.

However, neither imx_gpc_driver nor imx_pgc_power_domain_driver registers a
.sync_state callback, and the domains do not have GENPD_FLAG_NO_STAY_ON set.

Since the stay_on flag is never cleared, will this cause the domains to
remain powered on indefinitely? If regulator_late_cleanup() later disables
the underlying regulators while the domains are still active, could this
lead to hardware malfunctions?

>  				platform_device_put(pd_pdev);
>  				return ret;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D11
