Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD36C5AC67
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 03:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B4010EE16;
	Wed, 12 Aug 2026 03:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jWrGKkom";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB2B10EE12
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:13:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DAB4600E2;
 Wed, 12 Aug 2026 03:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC591F00A3A;
 Wed, 12 Aug 2026 03:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786504396;
 bh=a3+VxNlwPBllAzrayaAf5dCv+h17tSY9fVaZoCdEnWs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jWrGKkompbBwlILusgfys+1fPn3J1E5diTRpQ1WvqVa9A1dIhCKn98NI330yNCGeG
 xIXdqH88p9RblapRHemNRn+nVZM4TJEPLjk0+E9VrzSFuHzgF/MahWrnXy4n1xXnuo
 yOKQkewBz/XERk4e78QoP/qDjzSmOHWGMihX7TPupTxhoNbYxYldd5SWkR2IyWjUJg
 Pbrkg1060/PC7EK33eNgtACPlGdBeTcq1wLOy2Nw4286AoK5Yt47zuE+jdsDaSpuyS
 2+kW531/NPEvd+bQFM5a7NydjJESmVo1ZP9R4lzq/H2vyERnZ+1Hk/XDAryvCUspci
 4w0JY+g4Kg7gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812030710.549621-1-zenghongling@kylinos.cn>
References: <20260812030710.549621-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 03:13:15 +0000
Message-Id: <20260812031316.1BC591F00A3A@smtp.kernel.org>
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
- [High] Resource leak of pixel clock on bus clock devm_clk_get() failure.
- [High] Improper error handling of LVDS clock retrieval breaks probe defer=
ral.
--

--- Patch [1]: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling ---
commit 9d3968fa3e6694cd51c4ea469a9ffb12dcc0dfc7
Author: Hongling Zeng <zenghongling@kylinos.cn>

drm/stm/ltdc: Fix clock cleanup error handling

This commit adds proper error handling to ensure prepared clocks are disabl=
ed
and unprepared when a subsequent clock preparation fails in ltdc_resume()
and ltdc_load().

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 8818dcf98da79..ac1c2f27563e3 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1958,12 +1967,12 @@ int ltdc_load(struct drm_device *ddev)
>  	if (of_device_is_compatible(np, "st,stm32mp251-ltdc") ||
>  	    of_device_is_compatible(np, "st,stm32mp255-ltdc")) {
>  		ldev->bus_clk =3D devm_clk_get(dev, "bus");
>  		if (IS_ERR(ldev->bus_clk))
>  			return dev_err_probe(dev, PTR_ERR(ldev->bus_clk),
>  					     "Unable to get bus clock\n");
                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does this early return leak a pixel clock
reference? If devm_clk_get(dev, "bus") fails and returns -EPROBE_DEFER, it
looks like the function returns directly without disabling the already
enabled ldev->pixel_clk.

> =20
>  		ret =3D clk_prepare_enable(ldev->bus_clk);
>  		if (ret) {
>  			drm_err(ddev, "Unable to prepare bus clock\n");
> -			return ret;
> +			goto err_pixel;
>  		}
>  	}

[ ... ]

> @@ -2004,3 +2013,3 @@ int ltdc_load(struct drm_device *ddev)
> =20
>  	ldev->lvds_clk =3D devm_clk_get(dev, "lvds");
>  	if (IS_ERR(ldev->lvds_clk))
>  		ldev->lvds_clk =3D NULL;
                ^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does this unconditionally mask all errors
from devm_clk_get(), including -EPROBE_DEFER? If the LVDS clock provider
is initialized after the STM DRM driver, it seems this would silently ignore
the error instead of correctly deferring the probe, which could leave the
LVDS interface broken.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812030710.5496=
21-1-zenghongling@kylinos.cn?part=3D1
