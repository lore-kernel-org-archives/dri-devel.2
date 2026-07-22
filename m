Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC3C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C9710ECBC;
	Wed, 22 Jul 2026 08:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="baQ4zn+T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C07910ECBC
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:08:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C40DF60A64;
 Wed, 22 Jul 2026 08:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5906B1F000E9;
 Wed, 22 Jul 2026 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784707698;
 bh=n7hF20DS9KZZZzG/0Eyd8KG4qZxGKGHfY1gmhzQDIHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=baQ4zn+T8dSmYjxiqGVsir2WEf/0qCXqLE4visma4Xoc44LhwChu7LQipUghhmvE/
 rNjTMWFgRIixbAFjg5ZtSV5VW+3HrQHn6Eb5CKPMbXOxYBcUJbP5jVNxazp/S/qggq
 ODTuFRSZRgxq8I6WHZyQeAT3XVNA96kqBmrNgjn817Kdv2jwX/otibNfoOhwL702uI
 rFTqCOi2rHu4yMu0qjZUeVE8G7w9CDLpB18xsGAwOMQvekewZUToKaY00xH0zLer1D
 ypaeXTNxF+0Tq/aCsUjMzK5DoKGQ8GRWpp2muZ1OVlkQ1SCdVkChXrI1u3qweXib2I
 aPJAsl0XeYD8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] fbdev: omapfb/dsi-cm: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-3-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:08:17 +0000
Message-Id: <20260722080818.5906B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error paths in `dsicm_probe()` fail to unregister the DSS devi=
ce, leaving it linked in the global `panel_list` while its memory is freed,=
 leading to a critical Use-After-Free.
--

--- Patch [2]: [PATCH 2/7] fbdev: omapfb/dsi-cm: Remove redundant dev_err()=
 ---
commit 02fb3b045764b81b12936790330528bf51db067e
Author: Pan Chuang <panchuang@vivo.com>

fbdev: omapfb/dsi-cm: Remove redundant dev_err()

This commit removes a redundant dev_err() call after devm_request_irq()
since the devm API automatically logs detailed error messages on failure.

> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/d=
rivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> index 5e7963b4aa93c..7c3463ee02ef1 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
[ ... ]
> @@ -1185,10 +1185,8 @@ static int dsicm_probe(struct platform_device *pde=
v)
>  				IRQF_TRIGGER_RISING,
>  				"taal vsync", ddata);
> =20
> -		if (r) {
> -			dev_err(dev, "IRQ request failed\n");
> +		if (r)
>  			return r;

[Severity: High]
This is a pre-existing issue, but does returning directly here leave a
dangling pointer in the global panel_list?

Earlier in dsicm_probe(), the display is registered and added to the
global list:

	r =3D omapdss_register_display(dssdev);
	if (r) {
		dev_err(dev, "Failed to register panel\n");
		goto err_reg;
	}

If devm_request_irq() fails here, the function returns directly without
calling omapdss_unregister_display().

Since ddata was allocated using devm_kzalloc(), it will be automatically
freed on probe failure. Could this cause memory corruption or a
use-after-free when other functions like omap_dss_get_next_device() iterate
over the panel_list?

> -		}
> =20
>  		INIT_DEFERRABLE_WORK(&ddata->te_timeout_work,
>  					dsicm_te_timeout_work_callback);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D2
