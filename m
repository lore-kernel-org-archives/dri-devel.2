Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91953C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC93910E2E7;
	Tue, 28 Jul 2026 18:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Efb/FWbq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B499E10E2E7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:09:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59274416A0;
 Tue, 28 Jul 2026 18:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70B71F000E9;
 Tue, 28 Jul 2026 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785262173;
 bh=HVdR4ZKA7Zta2IZhjN6ktehlmIKQgutcv6DUrYZeOfs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Efb/FWbqQZ0J36nqejgeuMTSatXOwaWlF3ucrIRgQ46TUWHVmJ5hW9a04TAMNKRfi
 kcKMWID6iuyM6dJF+Ubl/9a4FuHMnOus7YR6ISd2/CGEqsSeiZtZn/Yqdbnt04E8X1
 PZec+B3uQgyPirtWdHIArS6pJt+y/5AFEzqPmxqpbGlCCd9GdNOGbdLOgQu+QoljuT
 5NpmEM5kHgqfwMm+/N99GZ0MBvsTbfYff8SbB4yYlD4ogDL93rW+QRidtHydMYikwu
 0wSbKuKs0QYnhPLx8WXv1nep0mXohGxY84Tn8+c5qL0dk5je1S4PFGdu2vnuiXXbw/
 QbeD7+EOdmpOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/18] drm/bridge: synopsys: dw-dp: Cancel pending
 HPD work on unbind
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-2-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-2-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:09:32 +0000
Message-Id: <20260728180932.E70B71F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing reinit_completion() in dw_dp_aux_transfer causes immediate=
 return on subsequent transfers if a previous one timed out.
- [High] The driver requests a hardware reset control but never deasserts i=
t, potentially leaving the hardware in a reset state.
- [Medium] The DP AUX I2C adapter is exposed to userspace before the hardwa=
re is initialized, and unregistered after the hardware is powered down.
--

--- Patch [2]: [PATCH v7 02/18] drm/bridge: synopsys: dw-dp: Cancel pending=
 HPD work on unbind ---
commit 9df51b0b37728e172be280b5d55126b4cd203eb4
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Cancel pending HPD work on unbind
   =20
This commit fixes a race condition during device unbind by canceling any
pending HPD work after disabling the interrupt, preventing the worker thread
from accessing invalid resources.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 67d9cd0bf5fd4..8393f9c9b0f00 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1996,6 +1996,7 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
>  	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
>  	phy_exit(dp->phy);
>  	drm_dp_aux_unregister(&dp->aux);

[Severity: Medium]
This is a pre-existing issue, but the AUX adapter is unregistered after the
PHY is shut down via phy_exit().

Can this allow in-flight transactions to access unpowered hardware? A
userspace process could initiate an I2C transaction during device unbind af=
ter
phy_exit() is called but before drm_dp_aux_unregister(), causing I2C
transfers to timeout or fail.

Similarly, is the AUX adapter registered before hardware initialization in
dw_dp_bind()? It appears drm_dp_aux_register() is called before
dw_dp_init_hw() and phy_init() complete, exposing uninitialized hardware to
potential userspace access.

>  }


While reviewing this file, I also noticed a couple of other pre-existing
issues outside of this patch's scope:

[Severity: High]
This isn't a bug introduced by this patch, but does dw_dp_aux_transfer() fa=
il
to reinitialize the completion before waiting?

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
    ...
    status =3D wait_for_completion_timeout(&dp->complete, timeout);
    ...
}

If an AUX reply interrupt fires after wait_for_completion_timeout() has tim=
ed
out, the completion structure's done count is incremented.

On the next transfer, will wait_for_completion_timeout() return immediately
without waiting for the new hardware reply? Consecutive I2C/AUX transfers
could fail prematurely, potentially breaking display detection.


[Severity: High]
This is also a pre-existing issue, but the driver requests a hardware reset
control without ever deasserting it:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_probe() {
    ...
    dp->rstc =3D devm_reset_control_get(dev, NULL);
    ...
}

Can this leave the DisplayPort hardware in a reset state? There are no
corresponding calls to reset_control_deassert() anywhere in the driver.

If the bootloader has asserted the reset line, the driver might fail to
communicate with the hardware and potentially cause bus hangs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D2
