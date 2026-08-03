Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D4FC55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E1510E764;
	Mon,  3 Aug 2026 18:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D0vrXOcW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBBA10E764
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B911B60AB4;
 Mon,  3 Aug 2026 18:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A11F00A3A;
 Mon,  3 Aug 2026 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785781641;
 bh=cagmjcCnugkZqel+yCa4eKiX2O2nCPdhL7kDhUmszqc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D0vrXOcWiHlCUOKsutcHnX1dhfaAWF/Fa+m4BWB76M+CAQ77lEyZFua+DnsYW70+e
 j1CxW+WpbMQZ66L72VW08RW4ZRNlL50jxmdwIS2tgNwNUYRrKKR9Fp0JNy/v6Vqoql
 ekcF8wk4qWB8Jm3O7qxu/8vega4Mz91A/mJ/xedi6Rdes74vSrgC+/F38taDLISQtL
 2jsqkrLUNw9kStheO69K22g67UMErPKoQeH9xHwkYf1RzXOtBIMbHP/JfWyZWq2sev
 95GnxhGqi1bowVl+NflCOhNvhLX+RL9qGtVjcKFQkRxsZ+jjjGGWikJ+CIck+iqYBa
 27sR2eBjU21aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/22] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-2-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-2-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:27:20 +0000
Message-Id: <20260803182721.284A11F00A3A@smtp.kernel.org>
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
- [High] Missing `cancel_work_sync(&dp->hpd_work)` causes a use-after-free =
of `dp` on driver removal.
- [High] Lockless TOCTOU check of `dp->bridge.dev` in `dw_dp_hpd_work` caus=
es Use-After-Free or NULL pointer dereference on unbind.
- [High] Unhandled interrupt sources in `dw_dp_irq()` can lead to an interr=
upt storm.
- [High] Sleeping functions are called from an atomic context path (`atomic=
_disable`).
--

--- Patch [2]: [PATCH v9 02/22] drm/bridge: synopsys: dw-dp: Fix incorrect =
resource lifetimes in bind callback ---
commit 639a2b7137e1fc5209a35b30731a14a632ba6684
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in b=
ind callback
   =20
Currently the Synopsys DesignWare DP controller driver's bind function
requests lots of resources using device managed functions. These are
free'd on driver removal instead of at unbind time. Fix this discrepancy
by introducing a new probe helper function and moving over the whole
bind function. This results in a fully functional DRM bridge once probe
succeeded.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 112a499113095..06997208945ed 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1895,6 +1895,9 @@ static void dw_dp_hpd_work(struct work_struct *work)
>  	long_hpd =3D dp->hotplug.long_hpd;
>  	mutex_unlock(&dp->irq_lock);
> =20
> +	if (!dp->bridge.dev)
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but does this lockless check create a race
condition?

If drm_bridge_detach() executes concurrently and clears bridge->dev, can
this work function still proceed and pass a NULL or freed drm_device pointer
to drm_helper_hpd_irq_event()?

>  	dev_dbg(dp->dev, "[drm] Get hpd irq - %s\n", long_hpd ? "long" : "short=
");
> =20
>  	if (!long_hpd) {

[ ... ]

> @@ -2005,9 +2027,8 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct=
 drm_encoder *encoder,
> =20
>  	dp->dev =3D dev;
>  	dp->pixel_mode =3D plat_data->pixel_mode;
> -
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> -	bridge =3D &dp->bridge;
> +
>  	mutex_init(&dp->irq_lock);
>  	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);

[Severity: High]
This is a pre-existing issue, but does this workqueue lack a cleanup step?

Since dp->hpd_work is initialized here but doesn't have a corresponding
devm action to cancel it on teardown, could a pending work item execute
after the dp structure is freed during driver unbind, resulting in a
use-after-free?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can unhandled interrupt sources cause an
interrupt storm?

Looking at dw_dp_irq():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_irq() {
    ...
    if (value & HPD_EVENT)
        dw_dp_handle_hpd_event(dp);

    if (value & AUX_REPLY_EVENT) {
        regmap_write(dp->regmap, DW_DP_GENERAL_INTERRUPT, AUX_REPLY_EVENT);
        complete(&dp->complete);
    }

    return IRQ_HANDLED;
}

If an interrupt source other than HPD_EVENT or AUX_REPLY_EVENT fires (such
as HDCP_EVENT), the handler returns IRQ_HANDLED without clearing the event
in DW_DP_GENERAL_INTERRUPT. Will this keep the IRQ line asserted and
continuously re-enter the handler?

[Severity: High]
This is a pre-existing issue, but are sleeping functions being called from
atomic context?

The DRM documentation indicates that atomic disable callbacks run in atomic
context during non-blocking commits.

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_disable() {
    ...
    dw_dp_reset(dp);
}

And dw_dp_reset() unconditionally calls sleeping functions:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_reset() {
    ...
    disable_irq(dp->irq);
    ...
    usleep_range(10, 20);
    ...
    regmap_read_poll_timeout(...);
}

Could this lead to kernel warnings or system instability when non-blocking
atomic commits occur?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D2
