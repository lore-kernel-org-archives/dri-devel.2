Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE60C44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAE410E211;
	Wed, 22 Jul 2026 08:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NVk0aiVb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BA110E211
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:15:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F50960A65;
 Wed, 22 Jul 2026 08:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD751F000E9;
 Wed, 22 Jul 2026 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784708154;
 bh=3dyaCh43laRhQqPfVS8K3G9GYOfeJQ8PhbKCLAZJECo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NVk0aiVbdZ5nYXteemx/5Vbofrl+kOqCpbegEpqX2RznAFeuaD9QmJUt9QAac0g6y
 XsrBSD6/bcPCBhc3/vHZQM/gEO7+gBTQQEJLHNBDbtHXiM/1Ii8+nvBwZ8JyjSVb3Y
 9WfqAj+jjm4Qufn+k8Mk31sHdQfXpoXzeUT1QbDQfNpRIDFQke+7q/+PzO+9Lf8GRW
 mM37y3sEMCTUOegq35goElhe6xCYvNsNFnvlOUS5sdq/QMi6qJjkGlj6U9kn1YEz43
 Hn6pT/BIzLrY0Jqt5v6bhyoMxAeiEq3EEcU/SSzq6+Aq2XATCWbGQtx4rE3G1EfOaP
 ZYJK2ug/hgHSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] fbdev: sa1100fb: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-8-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-8-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:15:53 +0000
Message-Id: <20260722081554.2AD751F000E9@smtp.kernel.org>
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
- [High] Missing `.suppress_bind_attrs =3D true` leads to catastrophic use-=
after-free on sysfs unbind.
--

--- Patch [7]: [PATCH 7/7] fbdev: sa1100fb: Remove redundant dev_err() ---
commit 811a165c0a2521029ab935181ae6d9d247a19898
Author: Pan Chuang <panchuang@vivo.com>

fbdev: sa1100fb: Remove redundant dev_err()

This commit simplifies the probe function by removing a redundant error
message after devm_request_irq(). The devm variant already logs detailed
error messages internally on failure.

> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100f=
b.c
> index 0d362d2bf0e38..fea0172c45b5b 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1167,10 +1167,8 @@ static int sa1100fb_probe(struct platform_device *=
pdev)
> =20
>  	ret =3D devm_request_irq(&pdev->dev, irq, sa1100fb_handle_irq, 0,
>  			       "LCD", fbi);
> -	if (ret) {
> -		dev_err(&pdev->dev, "request_irq failed: %d\n", ret);
> +	if (ret)
>  		return ret;
> -	}

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying
sa1100fb_probe(), should we also address a potential use-after-free during
driver unbind?

Looking at the driver definition, it registers resources that require expli=
cit
unregistration, but does not provide a remove callback and does not suppress
sysfs unbind:

drivers/video/fbdev/sa1100fb.c:sa1100fb_driver {
	.probe		=3D sa1100fb_probe,
	.suspend	=3D sa1100fb_suspend,
	.resume		=3D sa1100fb_resume,
	.driver		=3D {
		.name	=3D "sa11x0-fb",
	},
};

If a user unbinds the driver via sysfs, the driver core will call
devres_release_all() and free the devm allocated fbi structure.

However, because register_framebuffer() and cpufreq_register_notifier()
are called during probe without ever being unregistered, the fbdev and cpuf=
req
subsystems will hold dangling pointers to the freed fbi structure.

Any subsequent access to the framebuffer or CPU frequency transitions
could dereference this freed memory.

Would it make sense to set suppress_bind_attrs =3D true in the driver struct
to prevent sysfs unbind from succeeding, or alternatively implement a proper
remove callback to unregister these resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D7
