Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D4C56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BAD10F269;
	Thu,  6 Aug 2026 17:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ONNh7bYg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FB310F269
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E03E360AB0;
 Thu,  6 Aug 2026 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489941F000E9;
 Thu,  6 Aug 2026 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786037424;
 bh=cNlEiKeg0qAhamMntmJBK5UZpClTlc0sM4jXKWxngJc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ONNh7bYg6XGsEZ9Ex6aAAR2yzZu08AKCfpJ8dvY8qEt1MR35kE/4e2ntOUuY/lBNH
 5k0zt0ui0i/01yv2YCL22+W90esLPU8upF3HRDd4g7TH9AAAhPWapCyxPLSQJymyCQ
 1W/vIOo7nRE1WK8pcmqIeAKwnA/7mgv35pAo5XJ5jC53xBchs0nliba9RE+ZXHgIQq
 984hsvusx5qSSqJ3yvQmncQbQdoboUasL04Qt1SKnu3fkxe7yGKY8i14YhF9FHWbVg
 WBgmOLJaFzYwvkRi83wJtsHyRs/AsTEtnRpY6zfmF4ElChZPvZyk9/1KT0Sdtkks4Y
 SHbGrmnEPT51Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/21] drm/bridge: synopsys: dw-dp: Add missing
 mutex cleanups on module removal
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-5-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-5-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:30:23 +0000
Message-Id: <20260806173024.489941F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The bridge's atomic enable and disable callbacks execute sleeping =
functions, violating atomic context rules for display drivers.
- [High] Missing devm-based cancellation of `hpd_work` and unregistration o=
f `dp->aux` leads to a Use-After-Free of devres-managed resources on physic=
al device unbind.
- [High] Out-of-bounds reads and writes in link training arrays due to unbo=
unded lane count derived from untrusted DPCD.
- [High] Missing `reinit_completion()` in DP AUX transfer causes premature =
completion and data corruption.
--

--- Patch [5]: [PATCH v11 05/21] drm/bridge: synopsys: dw-dp: Add missing m=
utex cleanups on module removal ---
commit 1e2ea3ee5b8e223fa29b59cba2907fd3cca590e6
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 52e3b37259a69..b1856418f4419 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2040,10 +2040,13 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
>  	dp->pixel_mode =3D plat_data->pixel_mode;
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> =20
> -	mutex_init(&dp->irq_lock);
>  	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);

[Severity: High]
This is a pre-existing issue, but by making the irq_lock managed by devres,
does this workqueue now trigger a use-after-free on device unbind?

If the physical device is unbound (e.g., via sysfs) while the DRM master is
still active, devres will destroy dp->irq_lock and free the dp structure.
However, hpd_work is only cancelled in dw_dp_bridge_detach(), which is tied
to the DRM master's lifecycle.=20

If the worker executes:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_hpd_work() {
    ...
    mutex_lock(&dp->irq_lock);
    ...
}

Will it attempt to lock the destroyed mutex and access the freed dp structu=
re?
Should we use devm_add_action_or_reset() to ensure the work is cancelled
during physical device unbind?

>  	init_completion(&dp->complete);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for DP AUX
transfers to prematurely complete due to a missing reinit_completion()?

If dw_dp_aux_transfer() times out, but the hardware eventually signals the
interrupt later, dw_dp_irq() calls complete(&dp->complete).=20

Because dw_dp_aux_transfer() fails to call reinit_completion() before start=
ing
the next transfer, will the subsequent call to wait_for_completion_timeout()
return immediately and incorrectly read the status registers?

> =20
> +	ret =3D devm_mutex_init(dev, &dp->irq_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	res =3D devm_platform_ioremap_resource(pdev, 0);

[Severity: High]
This is a pre-existing issue, but do the atomic enable and disable callbacks
execute sleeping functions?

The DRM bridge's atomic disable callback (dw_dp_bridge_atomic_disable) is
reached from the atomic commit tail, but it invokes dw_dp_reset(), which
uses blocking functions:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_reset() {
    ...
    disable_irq(dp->irq);
    ...
    usleep_range(10, 20);
    ...
    regmap_read_poll_timeout(...);
    ...
}

Similarly, dw_dp_bridge_atomic_enable() reaches dw_dp_link_train_fast()
which calls usleep_range().  Since functions reached from
drm_atomic_helper_commit_tail() run in atomic context, will this cause
scheduling-while-atomic bugs or kernel warnings?

[Severity: High]
This is a pre-existing issue, but is there a risk of out-of-bounds reads and
writes during link training due to an unbounded lane count?

In dw_dp_link_parse(), link->lanes is determined by reading the capability
from the DP sink:

    link->lanes =3D min_t(u8, phy_get_bus_width(dp->phy),
                        drm_dp_max_lane_count(link->dpcd));

If the PHY driver returns a bus width greater than 4, and the untrusted DPCD
reports more than 4 lanes, link->lanes will exceed 4. =20

The link training functions then iterate up to link->lanes:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_link_train_update_vs_emph() {
    ...
    for (i =3D 0; i < lanes; i++) {
        phy_cfg.dp.voltage[i] =3D vs[i];
        phy_cfg.dp.pre[i] =3D pe[i];
    }
    ...
}

Will this cause out-of-bounds writes to arrays like phy_cfg.dp.voltage and
phy_cfg.dp.pre (which are sized for 4 elements) when a non-compliant or
malicious DP sink is connected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D5
