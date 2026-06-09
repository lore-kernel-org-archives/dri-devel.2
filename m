Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EB3CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D936110E33B;
	Tue,  9 Jun 2026 15:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UlqvQPXD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C926810E33B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:20:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D646C600C3;
 Tue,  9 Jun 2026 15:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684451F00893;
 Tue,  9 Jun 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781018407;
 bh=A9nig6VAiivKLkaaxytOdZW9wjXUyqOd2m1txdkJgCQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UlqvQPXDr/YDBvHGeJZhGNW2KSmK2yBSl783IHIjdaWUvijzJjI4Vebajg+HnYlkf
 85xyD5Upf4IbFr94FrBKzDGVOBaNpnpZLMq1tKnoFjzfDmC4ZafjG2D8PCkec2Pf15
 iaO14KOV98s29DIKCFuHgNB6pb6L2oOy3GMeXyDxbKEpAtTh2pCAlYIKBB/u18eZ1a
 RxMqmDx0EFGPxJBNiFZYC+x5Uq7Ou/1fz7Ajvn76cjtlNFcR7hSwGmXil6WpbUC6sh
 16vPxY7aSj7YRPusSvhhT4T/El3hke1vRPJ1x+k0w9NGF6W+j+O4qTMUe07470yu3/
 eL1/Fwj0wks1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/arm/komeda: fix error handling for
 clk_prepare_enable() and callers
To: =?utf-8?b?R3VzdGF2byBLZW5qaSBNZW5kb27Dp2EgS2FuZWtv?= <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609130828.1066038-1-kaneko.dev@pm.me>
References: <20260609130828.1066038-1-kaneko.dev@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:20:06 +0000
Message-Id: <20260609152007.684451F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Skipping drm_mode_config_helper_resume() upon error leaks the atom=
ic suspend state and breaks future system suspends.

Pre-existing issues:
- [High] `clk_prepare_enable()` return value is ignored in `komeda_dev_crea=
te()` and `komeda_dev_destroy()`, leading to hardware access without clocks.
- [High] `pm_runtime_get_sync()` return value is ignored in `komeda_crtc_at=
omic_enable()`, leading to unclocked hardware access.
- [High] Ignoring IOMMU connection failure in `komeda_dev_resume()` allows =
IOMMU bypass.
- [High] `komeda_crtc_prepare()` inadvertently ignores `clk_prepare_enable(=
)` failures due to variable overwrite.
--

commit c3f7a8cea64f30e941bea95c0ba39f80812bdd7f
Author: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>

drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

komeda_dev_resume() calls clk_prepare_enable() without checking the
return value. If the clock fails to enable, the function returns 0
(success) while IRQs are enabled and IOMMU is connected on potentially
unclocked hardware, causing undefined behavior on resume.

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
> =20

[Severity: High]
This is a pre-existing issue, but does ignoring the connect_iommu() failure
later in komeda_dev_resume() allow the display controller to bypass the
IOMMU?

If mdev->funcs->connect_iommu(mdev) fails, the function prints an error
but still returns 0 (success). The PM framework considers the resume
successful, and the display controller pipelines are programmed with
IOVAs.

Because the IOMMU translation buffer unit failed to connect, it might
bypass translation and treat the programmed IOVAs as raw physical
addresses, potentially allowing unintended memory access.

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index 4bb5f250e95ef..67fffab018ae8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
[ ... ]
> @@ -140,11 +143,12 @@ static int __maybe_unused komeda_pm_suspend(struct =
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
>  }

[Severity: High]
If komeda_dev_resume() fails, will skipping drm_mode_config_helper_resume()
leak the atomic suspend state?

By returning early, dev->mode_config.suspend_state is left allocated and
non-NULL. When the system attempts to suspend again,
drm_mode_config_helper_suspend() hits a WARN_ON for the suspend_state
check and returns -EINVAL, which permanently prevents the system from
entering a suspended state again. The error path should explicitly drop
the reference to the atomic state to prevent a memory leak and state
corruption.

[Severity: High]
This isn't a bug introduced by this patch, but does komeda_dev_destroy()
ignore the clock enable failure?

drivers/gpu/drm/arm/display/komeda/komeda_dev.c:komeda_dev_destroy() {
        ...
        if (mdev->aclk)
            clk_prepare_enable(mdev->aclk);
        ...
}

Similarly in komeda_dev_create(), clk_prepare_enable() is called without
checking the return value. If it fails, the subsequent call to
komeda_identify() accesses unclocked hardware registers, which can lead
to a synchronous external abort.

In komeda_dev_destroy(), the unconditional call to clk_disable_unprepare()
on a failed clock could underflow the clock's reference count.

[Severity: High]
This isn't a bug introduced by this patch, but does komeda_crtc_prepare()
inadvertently ignore clk_prepare_enable() failures?

drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:komeda_crtc_prepare() {
        err =3D clk_prepare_enable(mdev->aclk);
        if (err)
            drm_err(drm, "failed to enable aclk.\n");
       =20
        err =3D clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
        ...
}

The return value of clk_prepare_enable() is stored in err, but err is
immediately overwritten by clk_set_rate(). If the pixel clock
operations succeed, the function returns 0 even though the main engine
clock failed to enable, allowing the display pipeline to proceed and
access unclocked hardware.

[Severity: High]
This is a pre-existing issue, but does komeda_crtc_atomic_enable() ignore
the pm_runtime_get_sync() return value?

drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:
komeda_crtc_atomic_enable() {
        ...
        pm_runtime_get_sync(crtc->dev->dev);
        komeda_crtc_prepare(to_kcrtc(crtc));
        ...
}

If the device fails to resume, the driver still proceeds to call
komeda_crtc_prepare() and komeda_crtc_do_flush(), which access hardware
registers. Accessing registers while the device is suspended or
unclocked can cause a bus fault. Ignoring the error also leaves the
runtime PM usage counter unbalanced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609130828.1066=
038-1-kaneko.dev@pm.me?part=3D1
