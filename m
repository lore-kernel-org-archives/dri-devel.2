Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAEBC4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7063910EBFA;
	Wed, 22 Jul 2026 01:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i6zkORiS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29F110EBFA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:05:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84E0443861;
 Wed, 22 Jul 2026 01:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3148A1F000E9;
 Wed, 22 Jul 2026 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682348;
 bh=YcvShhdVpnd96kUvNTzPjhDuigAY3MNORRUYT7t8FIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i6zkORiSF3Egazd2Ydkr7eDvC1PFgOAu3+YuqWmsSxV4WeaWHn8zurRYQyQfPi26e
 bIg2VPkmh9oYzEfl/h1zMDg/eGj5Bb0xjpVfkGGLHe38tIPNZgslM7ppGjTNBkbcka
 +0idr4yDxdLxUbedVBlah3K1Pq5rbz667p6dCEk9JRanOaF1urxOjtyJyzptTs68HY
 DqtMl9UsNN5s8Lhz7bva0H2oEaYzmNtI8wdRmYs4I7JrcH7o2/NT+TB1xkmMsA+poh
 7/fCdgZzw+aD6eAo4eMCkzH/ViV2Vj/1ntMkCKJVOg42tJUMqSBt717QUIF+bnAK+p
 FcNRDMHvnnJ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] drm/tyr: add resources to RegistrationData
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-fw-boot-b4-v8-1-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-1-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:05:47 +0000
Message-Id: <20260722010548.3148A1F000E9@smtp.kernel.org>
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
- [High] Clocks are enabled before power domains (regulators) are powered o=
n.
- [Medium] Clock enable state is leaked on early probe failure paths.
--

--- Patch [1]: [PATCH v8 1/7] drm/tyr: add resources to RegistrationData ---
commit ebb25c59afc71f766bee84e4619205c5e8db839b
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add resources to RegistrationData

This commit moves Tyr's device-private resources and GPU information
from drm::Driver::Data to drm::Driver::RegistrationData. This ensures
safe access to the data during the platform device binding lifetime and
while registered with userspace.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 8348c6cd39295..46ce5c41e310c 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs

[ ... ]

> @@ -134,10 +137,10 @@ fn probe<'bound>(
>          // other threads of execution.
>          unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits=
)?)? };
> =20
> -        let platform: ARef<platform::Device> =3D pdev.into();
> +        let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(p=
dev, Ok(()))?;
> =20
> -        let data =3D try_pin_init!(TyrDrmDeviceData {
> -                pdev: platform.clone(),
> +        let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
> +                pdev,
>                  clks <- new_mutex!(Clocks {

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential resource leak in=20
probe().=20

Earlier in this function, core_clk, stacks_clk, and coregroup_clk are=20
enabled:

drivers/gpu/drm/tyr/driver.rs:probe() {
    ...
    core_clk.prepare_enable()?;
    stacks_clk.prepare_enable()?;
    coregroup_clk.prepare_enable()?;

    let mali_regulator =3D Regulator::<regulator::Enabled>::get(pdev.as_ref=
(), c"mali")?;
    ...
}

If getting a regulator or another step fails and returns early via ?, does=
=20
the clock enable state leak? Because the Clocks struct isn't created until=
=20
this point in the diff, it seems the enable count might remain incremented=
=20
on those early error paths.

[Severity: High]
This is also a pre-existing issue, but looking at that same snippet in=20
probe(), the hardware clocks are enabled before the mali and sram regulator=
s=20
are fetched and enabled.=20

Could this sequencing cause problems? Toggling clocks for unpowered IP=20
domains can sometimes lead to bus lockups or undefined hardware behavior=20
during initialization.

>                      core: core_clk,
>                      stacks: stacks_clk,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D1
