Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AC8C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E426310E311;
	Mon, 31 Aug 2026 13:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JTYU4b0w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DB510E2AC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:59:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69C6F6013A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E61F00A3D;
 Mon, 31 Aug 2026 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788184759;
 bh=FaapfVs4E2XAhUx6bkrWyQuO3g4+L6QUXJH1Seo3gmg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTYU4b0wBk0+vN6wZwyHWI6gpCNA4NsInoSWr+/yGudOBDkbQtm81xq3WXZ3S8Boq
 aUoxuGHBISFzKdueAnSF7J36cc82eyqgX4NObIInZNg4ocIG4NRKp69EDPghr+mERF
 8n5d0i5bhKKg9FAesyAODlwEMIRA84ek21wGTTqzFLee0IJg4I3u3EZr9wJaK7ObFG
 oKXLgbjUAkejWpzxiOXKOemnxtDNB1zS22R0mEe8xnn63u4exeynZy8NLKRZ/nEE/J
 856kIxjPzPgO424EWsprnQkGKJecfdt79pdzZo/vldvQbX4M5gJJ/a5JVu1UjM1ttY
 kld8vYPLYrhbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/arm/komeda: fix error handling
 for clk_prepare_enable() and callers
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-34-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-34-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:59:18 +0000
Message-Id: <20260831135919.002E61F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Skipping drm_mode_config_helper_resume() on hardware resume failur=
e leaks the DRM atomic suspend state and breaks future suspends.
- [High] Unbalanced hardware state causes a bus hang on the next system sus=
pend if komeda_dev_resume() fails.

Pre-existing issues:
- [High] Ignored failure of connect_iommu() in komeda_dev_resume() leads to=
 false-success and invalid DMA.
--

commit f5ccdd439f7c420a2895a7d27b82a5ce2f112b7d
Author: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>

drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

This commit adds error checking to clk_prepare_enable() in
komeda_dev_resume() and propagates the error to callers in the probe
and system PM resume paths.

Link: https://patch.msgid.link/20260609130828.1066038-1-kaneko.dev@pm.me

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 5ba62e637a616..9aad1d1d28ec0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -313,7 +313,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> =20
>  int komeda_dev_resume(struct komeda_dev *mdev)
>  {
> -	clk_prepare_enable(mdev->aclk);
> +	int err;
> +
> +	err =3D clk_prepare_enable(mdev->aclk);
> +	if (err)
> +		return err;
> =20
>  	mdev->funcs->enable_irq(mdev);

[Severity: High]
This is a pre-existing issue, but does ignoring the failure of connect_iomm=
u()
further down in komeda_dev_resume() lead to a false-success?

If mdev->funcs->connect_iommu(mdev) fails, the function logs an error
but still returns 0. The DRM core would then proceed with display
initialization on an unattached IOMMU, which could result in unintended DMA
behavior and IOMMU fault storms.

[ ... ]
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index 358c1512b0879..fc1816c634087 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
[ ... ]
> @@ -139,11 +142,12 @@ static int __maybe_unused komeda_pm_suspend(struct =
device *dev)
>  static int __maybe_unused komeda_pm_resume(struct device *dev)
>  {
>  	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
> +	int err =3D 0;
> =20
>  	if (!pm_runtime_status_suspended(dev))
> -		komeda_dev_resume(mdrv->mdev);
> +		err =3D komeda_dev_resume(mdrv->mdev);
> =20
> -	return drm_mode_config_helper_resume(&mdrv->kms->base);
> +	return err ? err : drm_mode_config_helper_resume(&mdrv->kms->base);

[Severity: High]
If komeda_dev_resume() fails, this early return bypasses
drm_mode_config_helper_resume(), which is required to free and clear
dev->mode_config.suspend_state. Could this leak the DRM atomic suspend state
memory and permanently break subsequent suspends with -EBUSY?

[Severity: High]
Additionally, if komeda_pm_resume() returns an error early, the PM core
still marks the device as active.

On the next system suspend, komeda_pm_suspend() would call
komeda_dev_suspend(), which unconditionally writes to MMIO via disable_irq(=
).

Could this unbalanced hardware state cause a bus hang or crash on the
next suspend cycle due to unclocked MMIO access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-34-sashal@kernel.org?part=3D1
