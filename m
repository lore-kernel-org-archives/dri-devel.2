Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535EBCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC1F10E064;
	Fri,  9 Oct 2026 13:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SGeEVfmN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E74810E315
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:08:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 742DB43694;
 Fri,  9 Oct 2026 13:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3749A1F000FF;
 Fri,  9 Oct 2026 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551304;
 bh=qeyrCBMmTImAGtl7icwiJhmiAb3NAymCKLXsNlpPigY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SGeEVfmNuO7ODUaKmhx9NiffZFAbfMya+OU/++Qwj1syAUlE/uRqZ0TeB6fSFwNab
 GeldhXGUGisK959oCv/ZIKYPvcGmt1HCtEJQpQW8wSaVYeXNSHnOOBfgGTECy24v/L
 XjPZ7K0w7VTEGmjwnQzl6ZM+5epgQDAhHouyyqPxgTPQaSbKlu2zwk7ivvIe0/hEJx
 GKlpil9DboDEMY9Dx/TSw9pqXoDCLmSEk4QFJs6FQmW2Q0YSmiu9i8eis66MeSnPVp
 8TV8GuLQ1W4CBTuCQoH3T6mstVkulqhbWXlPxhVoZ95SIlbUfBm2kSvnixU6CkLi4U
 mxJAR/+eu03hw==
Message-ID: <sashiko-outbox-165596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-4-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-4-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:08:23 +0000
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
- [Medium] drm/panfrost: missing error check for dev_pm_opp_set_opp in resu=
me path
--

commit 551cc4e2301b0de24ff4541df0b0044dcc43f6d9
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Skip NULL checks for clock enable/disabling

This commit removes NULL checks before calling clk_enable() and
clk_disable() in the panfrost device suspend and resume paths. The clk_*
API can handle NULL clock objects safely.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 5bf528f41278d..b3a53504bd016 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -510,11 +510,9 @@ static int panfrost_device_resume(struct device *dev)
>  		if (ret)
>  			goto err_clk;
> =20

[Severity: Medium]
In panfrost_device_resume() just above this modified code,
dev_pm_opp_set_opp() is called without checking its return value:

	dev_pm_opp_set_opp(dev, opp);
	dev_pm_opp_put(opp);

Does this allow the resume sequence to proceed even if voltage
configuration fails?

If this configuration fails, the GPU may remain unpowered or improperly
powered. Proceeding to access GPU hardware in this state can lead to
imprecise external aborts and system lockups.

> -		if (pfdev->bus_clock) {
> -			ret =3D clk_enable(pfdev->bus_clock);
> -			if (ret)
> -				goto err_bus_clk;
> -		}
> +		ret =3D clk_enable(pfdev->bus_clock);
> +		if (ret)
> +			goto err_bus_clk;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D4
