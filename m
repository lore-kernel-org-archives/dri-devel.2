Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA110C54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF88610E9AD;
	Tue, 28 Jul 2026 18:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="afguqk1/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A9910E9AD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:20:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51A3360A88;
 Tue, 28 Jul 2026 18:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9151F000E9;
 Tue, 28 Jul 2026 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785262858;
 bh=jE7lh2aFKrZdG1Uj7ccPQY4WB7/NS6vEgjbz753yY5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=afguqk1/4/Ym56aUQc4oA5OeiK7l79ZZFcX3HuS2mZ3hMP86xpbRp3mPXL1lECWD8
 BlzTVkJo26E8gWeWq87T8RDvSU6r+3zwzPye1/fRPRAVRYf+GgI3To8oROS0MaI4ti
 4Yw6gkJUVpOYXVnL8YqeZC0Kb8BVo5bJRqv7kcn/kQrK0yHXvxIISzbaHarBjxzBuA
 YyEm16grH6Cb36XpksKHTdJMBpX23AKNTxsnkLvCx2BJA5NXxbb8doEJktR9o7TuKH
 1EC5njHcg5gHzZiEvae+C9pMaClSYbGvfmxIt8OtH1zSReMaAQV4rIwETHCVGIZFZk
 yzXeZ4SqvHqBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/18] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-3-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-3-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:20:57 +0000
Message-Id: <20260728182057.AD9151F000E9@smtp.kernel.org>
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
- [High] The DRM bridge is exposed to the system before its backing resourc=
es are fully initialized, leading to a reverse-order teardown Use-After-Fre=
e (UAF) vulnerability.
--

--- Patch [3]: [PATCH v7 03/18] drm/bridge: synopsys: dw-dp: Add missing mu=
tex cleanups on module removal ---
commit 374a35fd683724436ba90569775efd9aa551c376
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal
   =20
The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 8393f9c9b0f00..ca7ff544d243a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2028,10 +2028,13 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
>  	if (ret)
>  		return ERR_PTR(ret);
> =20

[Severity: High]
This is a pre-existing issue, but since this patch focuses on teardown
cleanups, could the early bridge registration cause a use-after-free
during driver unbind?

Because devres executes cleanup callbacks in reverse order of initializatio=
n,
the bridge remains registered globally while its backing resources, such
as dp->regmap, are freed.

If an administrator triggers a driver unbind, a concurrent DRM operation
(like a DRM_IOCTL_MODE_GETCONNECTOR ioctl) querying the connector state
could invoke bridge->funcs->detect(), leading to a dereference of the freed
regmap:

dw_dp_bridge_detect()
  dw_dp_hpd_detect(dp)
    regmap_read(dp->regmap, ...)

Should the bridge be registered later in the probe function, after all
hardware resources are allocated, to avoid this reverse-order teardown race?

> -	mutex_init(&dp->irq_lock);
>  	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
>  	init_completion(&dp->complete);
> =20
> +	ret =3D devm_mutex_init(dev, &dp->irq_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	res =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(res))
>  		return ERR_CAST(res);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D3
