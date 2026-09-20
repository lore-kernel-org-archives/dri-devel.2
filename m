Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC9C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422AD10E2F7;
	Sun, 20 Sep 2026 22:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JEc3hvyU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6025210E2C4
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:58:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 232C240374
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797301F000FF;
 Sun, 20 Sep 2026 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789945109;
 bh=vqdXNa7PU0vKrWanHtgF1CuycbEPu3rT6cLqRY4ULwY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JEc3hvyUKmQNOT1JOU9rEaqfpOQ7SIwHD6BdjxafWKLoEEbwA8v0gmZwJxDE3PNfv
 84+zL5R8XKy6+snaw6vfxtbJOVhITqpmfEUzc8DdCAeudJcii0pEwwYtcFa4RwgnLc
 lTUsrWYUGSr5S3BVKObjXRZb6mXCK7t0n9ZvQCmpwY5sCPGHpApROf4fYm4j9MNXsY
 6n/UeF9xP4vRF+jl4RGXDjYw2vOIT0mlFFdFz5d3LvsJOg7TN93VFlNv6lB19M8J0W
 ZoXQKA8gofL9j8Zvm5pOQWDZltk7lDZEodlnQ3Y79EJjIOr7RvCuWBhDaO8zg50I3Y
 pBbCQLiksNM/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/18] drm/mcde: Use power domain for display power
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 vkoul@kernel.org
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-13-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-13-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 22:58:29 +0000
Message-Id: <20260920225829.797301F000FF@smtp.kernel.org>
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
- [Low] pm: incorrect success check for pm_runtime_put_sync_suspend()
--

commit 1421b098d2f7f0ffecc255355537663b64ad9955
Author: Linus Walleij <linusw@kernel.org>

    drm/mcde: Use power domain for display power

This commit replaces explicit EPOD regulator handling with runtime PM.
It uses the MCDE power domain and drops the regulator dependency.

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

[Severity: Low]
Does this incorrectly treat a successful return value as an error?

When mcde_display_disable() calls pm_runtime_put_sync_suspend(), the PM core
returns 1 if the device is already suspended. Because this code checks
if (ret) rather than if (ret < 0), the success value of 1 will trigger the
error path.

This will cause a spurious "can't disable MCDE power domain" message to be
printed to the kernel log even when the operation succeeds.

>  	/* Make sure we are powered down (before we may power up again) */
>  	usleep_range(50000, 70000);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-ux500-powe=
r-domains-v7-1-v3-0-9352be6b86b1@kernel.org?part=3D13
