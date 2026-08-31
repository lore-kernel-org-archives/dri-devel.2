Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B349C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2A810E913;
	Mon, 31 Aug 2026 14:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZS7/594q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CBD10E913
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:33:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DEE06013A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DDF1F000E9;
 Mon, 31 Aug 2026 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186819;
 bh=MFtKHsncj1QEZ3NhaQOPB0YkU0McOneGQFPmQZ0wFj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZS7/594qFe63gYZNgLVhGfjN66LekBQ6+rdVZltw+/BpLpEuI6AxKv2nTdIYQRWOn
 w1WL3o9nbvHGJjOL8MC1fAcllBnBrhzebBidS96od5/LKDASIGWsYYPf6hXM0nu/9N
 N1wrJEXBZbCSVPaZUdhc8u9g35YjH++um0ubqpE08zkKGuzLtDiZtJb6cGd4IJt6Pt
 H0fK1zViE2jlv28uoi/+R9IFhh9a2NDlivaehIZEs5fekUaQiw+IbZRHNW+z/wNY1y
 3QcKRXafNWLpkD0yurmxSMH1B9nd4W6gXJTe6hK14NSQYSz5H1v0yw7DV3AfewIIhL
 D1vILtPhki7IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/arm/malidp: use clk_bulk API in
 runtime PM resume and suspend
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-108-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-108-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:33:38 +0000
Message-Id: <20260831143339.07DDF1F000E9@smtp.kernel.org>
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
- [Low] Final Result: The clock framework logs '(null)' during enablement f=
ailures because the .id fields in the clk_bulk_data array are not initializ=
ed.

Pre-existing issues:
- [High] Final Result: Hardware accesses on explicitly disabled clocks trig=
ger synchronous external aborts. Ignored return values from pm_runtime_get_=
sync() and malidp_runtime_pm_resume() combine with the new clock rollback t=
o guarantee an APB bus hang.
- [High] Final Result: Missing synchronize_irq() in the runtime suspend pat=
h allows active shared IRQ handlers to crash the system by accessing powere=
d-down hardware.
--

commit 049d634e1eb44e14ba4f4fc2612f50ff9b67236e
Author: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>

drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend

This commit converts the Mali DP driver's runtime PM resume and suspend
paths to use the clk_bulk API. It ensures that clk_bulk_prepare_enable()
return values are checked during resume, rolling back any successfully
enabled clocks if a failure occurs.

Link: https://patch.msgid.link/20260609130812.1065699-1-kaneko.dev@pm.me

> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malid=
p_drv.c
> index bc5f5e9798c32..2bf4a647e4b28 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -669,6 +669,11 @@ static int malidp_runtime_pm_suspend(struct device *=
dev)
>  	struct drm_device *drm =3D dev_get_drvdata(dev);
>  	struct malidp_drm *malidp =3D drm_to_malidp(drm);
>  	struct malidp_hw_device *hwdev =3D malidp->dev;
> +	struct clk_bulk_data clks[] =3D {
> +		{ .clk =3D hwdev->pclk },
> +		{ .clk =3D hwdev->aclk },
> +		{ .clk =3D hwdev->mclk },
> +	};
> =20
>  	/* we can only suspend if the hardware is in config mode */
>  	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
> @@ -676,9 +681,7 @@ static int malidp_runtime_pm_suspend(struct device *d=
ev)
>  	malidp_se_irq_fini(hwdev);
>  	malidp_de_irq_fini(hwdev);
>  	hwdev->pm_suspended =3D true;
> -	clk_disable_unprepare(hwdev->mclk);
> -	clk_disable_unprepare(hwdev->aclk);
> -	clk_disable_unprepare(hwdev->pclk);
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);

[Severity: High]
This is a pre-existing issue, but is there a risk of a shared interrupt
firing exactly as the device enters runtime suspend?

The omission of synchronize_irq() before clk_bulk_disable_unprepare() allows
concurrently executing handlers to read unclocked registers. For example, in
drivers/gpu/drm/arm/malidp_hw.c:

malidp_de_irq() {
    if (hwdev->pm_suspended)
        return IRQ_NONE;
    ...
}

Could we add a call to synchronize_irq() before disabling the clocks so
active shared IRQ handlers do not crash the system by accessing powered-down
hardware?

> =20
>  	return 0;
>  }
> @@ -688,10 +691,17 @@ static int malidp_runtime_pm_resume(struct device *=
dev)
>  	struct drm_device *drm =3D dev_get_drvdata(dev);
>  	struct malidp_drm *malidp =3D drm_to_malidp(drm);
>  	struct malidp_hw_device *hwdev =3D malidp->dev;
> +	struct clk_bulk_data clks[] =3D {
> +		{ .clk =3D hwdev->pclk },
> +		{ .clk =3D hwdev->aclk },
> +		{ .clk =3D hwdev->mclk },
> +	};

[Severity: Low]
Does this array initialization cause the clock framework to log (null)
during enablement failures?

If a clock fails to enable during PM resume, the uninitialized .id fields
in the local clk_bulk_data array are used by pr_err(), which results in
useless error logging instead of the clock name.

Should we add the corresponding .id string values to this array?

> +	int err;
> +
> +	err =3D clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but can the new clock rollback here cause an
APB bus hang on failure?

If a clock enablement fails during malidp_runtime_pm_resume(), the newly
introduced clk_bulk_prepare_enable() rolls back and disables all clocks on
partial failure.

However, callers blindly proceed and ignore the return values from
pm_runtime_get_sync() and malidp_runtime_pm_resume(), meaning they will
read and write unclocked MMIO registers. For example, in
drivers/gpu/drm/arm/malidp_drv.c:

malidp_atomic_commit_tail() {
    pm_runtime_get_sync(drm->dev);
    ...
    atomic_set(&malidp->config_valid, MALIDP_CONFIG_START);
    malidp->dev->hw->set_config_valid(malidp->dev, 0);
}

Are we able to check the return value of pm_runtime_get_sync() in these
callers to prevent a synchronous external abort when the resume path fails?

> =20
> -	clk_prepare_enable(hwdev->pclk);
> -	clk_prepare_enable(hwdev->aclk);
> -	clk_prepare_enable(hwdev->mclk);
>  	hwdev->pm_suspended =3D false;
>  	malidp_de_irq_hw_init(hwdev);
>  	malidp_se_irq_hw_init(hwdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-108-sashal@kernel.org?part=3D1
