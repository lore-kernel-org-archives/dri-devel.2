Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23053C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E5910E06E;
	Fri, 24 Jul 2026 18:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YOry3xgL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDCB10E06E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E796143DB2;
 Fri, 24 Jul 2026 18:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ACB1F000E9;
 Fri, 24 Jul 2026 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784916931;
 bh=NXnHCQH4oSBjr3avjn5kMlYCpkzlYjsyEk44BV35/O4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YOry3xgLFSPNnfdd/Q4JkNoB77y2Nimb9Xu9vql5AKUKRNMBa2algbQeD+AFMDywc
 9px9sBzFYv4629cVIH7t3PDdntT53LHvh8GvI2wJt9QVXPw8BXa00kHsUgagUdsLI+
 ZvLidWoQaTPE6kykZOh/W1/95KJs6fHrCFkFo3XpRzGD13v4GwYHozUsvjgXtUaIRa
 LAOU+lEByvJqZ8R/WyCJH3Gsf3MWOzNksCTyLB1RAoUzYH5PUWXK2S95efYtZmlT9a
 SKINC7uy1awNNookNiXZYWhQf2mQuNrduehDZo9sSege9Mmt+/dz2jCeUQZrAsadkA
 nIO+h8btgOfIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/16] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-3-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v6-3-041d99a19c4e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:15:31 +0000
Message-Id: <20260724181531.85ACB1F000E9@smtp.kernel.org>
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
- [High] Missing reinit_completion() before AUX transfer causes subsequent =
transfers to falsely succeed if a timeout previously occurred or stray inte=
rrupts arrived.
- [High] Short HPD and Long HPD events share a single boolean state variabl=
e, causing critical hot plug events to be lost if interrupts arrive in quic=
k succession.
- [High] Hardware is powered down and interrupts are disabled before the DP=
 AUX interface is unregistered, allowing userspace to crash the system or h=
ang by accessing powered-down hardware.
--

--- Patch [3]: [PATCH v6 03/16] drm/bridge: synopsys: dw-dp: Add missing mu=
tex cleanups on module removal ---
commit 4a4bd90d7d64ae717e418a4501d8f02733f02d38
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support =
library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 21bd08571dcfe..b28040d69fabf 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
dw_dp_aux_transfer():

	value |=3D FIELD_PREP(AUX_ADDR, msg->address);
	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

	status =3D wait_for_completion_timeout(&dp->complete, timeout);
	if (!status) {

[Severity: High]
Does this completion need to be reinitialized before the transfer?
If a previous transfer timed out and the hardware later replies,=20
could a subsequent transfer falsely succeed immediately because the
completion counter was left > 0?

[ ... ]

This isn't a bug introduced by this patch, but there is a potential
event loss in the HPD handler.

If a physical hotplug triggers an interrupt:

dw_dp_handle_hpd_event()
	if (value & HPD_HOT_PLUG) {
		dp->hotplug.long_hpd =3D true;
	}

Could a subsequent short HPD interrupt (e.g., from a link status change)
overwrite this state before dw_dp_hpd_work() evaluates it?

dw_dp_handle_hpd_event()
	if (value & HPD_IRQ) {
		dp->hotplug.long_hpd =3D false;

[Severity: High]
If dw_dp_hpd_work() runs after this short pulse, will it read long_hpd as
false and perform a link retrain instead of notifying userspace of the
hotplug?

[ ... ]

This is also a pre-existing issue, but I noticed a potential hardware hang
in the unbind sequence just above the probe function:

void dw_dp_unbind(struct dw_dp *dp)
{
	disable_irq(dp->irq);
	cancel_work_sync(&dp->hpd_work);
	phy_exit(dp->phy);
	drm_dp_aux_unregister(&dp->aux);

[Severity: High]
Does this order allow userspace to access unpowered hardware?
Since phy_exit() powers down the PHY before the AUX interface is
unregistered, could a concurrent read/write to the /dev/drm_dp_auxN
character device cause a synchronous external abort or hardware hang?

> @@ -2031,10 +2031,13 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
>  	dp->pixel_mode =3D plat_data->pixel_mode;
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> =20
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v6-0-041d99a19c4e@collabora.com?part=3D3
