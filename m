Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1290CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6A010EC78;
	Thu, 18 Jun 2026 05:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNIdeYWT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3F610EC78
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:11:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 207D860008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715B41F000E9;
 Thu, 18 Jun 2026 05:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759471;
 bh=EcafC8p6Ak4Dofze3k3WQ4urTBYybz+2V7C98WnSf4U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mNIdeYWThLmchIyYp4x6zVBW/NNcQRd/MsyoRXaVL7aYnma+jfy6A44ckIyiTATde
 82VgJjBcEObVw4qNeTINX2ooTZotP22pUT8jP7MXFeMTCSTlUqK3KSxNjY9Uz+m7t5
 qZ0ncTZzsLw2Aw8ddj8mbKs9G1oVqBacMVpLz3uVx8Vq36nBnFR2w/Z1B45Aj0OKqn
 mp+PLzYlrVLeW6rxhhFsVq/51FC3JAJKZUj9R1y2uHQUFv+ngUrZFYTjZwcWllQyqi
 Ra4jW8VyINNq7aZtq4f7z6QSYy8H/r6NxBDrbxFHnz/gIz9/BB6levoQD4MCNH7K+K
 yYu1u7QsbAvzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] drm/mcde: Use power domain for display power
To: "Linus Walleij" <linusw@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
 robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-7-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-7-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:11:11 +0000
Message-Id: <20260618051111.715B41F000E9@smtp.kernel.org>
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
- [High] Incorrect return value check for pm_runtime_put_sync_suspend(), tr=
eating success as an error.
- [High] Resource leak of the main clock (mcde_clk) on the probe error path.
--

commit 1e2436e1c266a49af52c126fb77756c71e5e0e91
Author: Linus Walleij <linusw@kernel.org>

drm/mcde: Use power domain for display power
   =20
Replace explicit EPOD regulator handling with runtime PM.
Use the MCDE power domain and drop the regulator dependency.

> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/m=
cde_display.c
> index 257a6e84dd583..52f071bb347c4 100644
> --- a/drivers/gpu/drm/mcde/mcde_display.c
> +++ b/drivers/gpu/drm/mcde/mcde_display.c

[ ... ]

> @@ -1327,9 +1326,9 @@ static void mcde_display_disable(struct drm_simple_=
display_pipe *pipe)
>  		spin_unlock_irq(&crtc->dev->event_lock);
>  	}
> =20
> -	ret =3D regulator_disable(mcde->epod);
> +	ret =3D pm_runtime_put_sync_suspend(mcde->dev);
>  	if (ret)
> -		dev_err(drm->dev, "can't disable EPOD regulator\n");
> +		dev_err(drm->dev, "can't disable MCDE power domain\n");

[Severity: High]
According to the Runtime PM API contract, pm_runtime_put_sync_suspend()
returns 1 when the device is already in the RPM_SUSPENDED state. Is it
intentional to treat a positive return value as an error here? If the device
is already suspended, this will log a false-positive error.

>  	/* Make sure we are powered down (before we may power up again) */
>  	usleep_range(50000, 70000);
> =20
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_=
drv.c
> index 5f2c462bad7e1..3f966cccda5a3 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c

[ ... ]

> @@ -412,14 +392,15 @@ static int mcde_probe(struct platform_device *pdev)
> =20
>  	/*
>  	 * Perform an invasive reset of the MCDE and all blocks by
> -	 * cutting the power to the subsystem, then bring it back up
> +	 * powering down the subsystem, then bring it back up
>  	 * later when we enable the display as a result of
>  	 * component_master_add_with_match().
>  	 */
> -	ret =3D regulator_disable(mcde->epod);
> +	ret =3D pm_runtime_put_sync_suspend(dev);
>  	if (ret) {
> -		dev_err(dev, "can't disable EPOD regulator\n");
> -		return ret;
> +		dev_err(dev, "can't disable MCDE power domain\n");
> +		pm_runtime_get_noresume(dev);
> +		goto clk_disable;
>  	}

[Severity: High]
Does this incorrectly abort the probe sequence if the device is already
suspended?=20

pm_runtime_put_sync_suspend() returns 1 if the device was already in the
RPM_SUSPENDED state, which is a success condition, but the if (ret) check
here treats it as a failure.

>  	/* Wait 50 ms so we are sure we cut the power */
>  	usleep_range(50000, 70000);

[ ... ]

> @@ -428,25 +409,18 @@ static int mcde_probe(struct platform_device *pdev)
>  					      match);
>  	if (ret) {
>  		dev_err(dev, "failed to add component master\n");
> -		/*
> -		 * The EPOD regulator is already disabled at this point so some
> -		 * special errorpath code is needed
> -		 */
> -		clk_disable_unprepare(mcde->mcde_clk);
> -		regulator_disable(mcde->vana);
> -		return ret;
> +		goto clk_disable_pm_disabled;
>  	}
> =20
>  	return 0;
> =20
>  clk_disable:
>  	clk_disable_unprepare(mcde->mcde_clk);
> -regulator_off:
> -	regulator_disable(mcde->vana);
> -regulator_epod_off:
> -	regulator_disable(mcde->epod);
> +pm_runtime_put:
> +	pm_runtime_put_sync_suspend(dev);
> +clk_disable_pm_disabled:
> +	pm_runtime_disable(dev);
>  	return ret;
> -
>  }

[Severity: High]
Does this code leak the main clock when component_master_add_with_match()
fails?=20

The goto clk_disable_pm_disabled jump skips over the clk_disable label, so
clk_disable_unprepare(mcde->mcde_clk) is never called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D7
