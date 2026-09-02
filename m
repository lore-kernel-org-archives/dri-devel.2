Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD48C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6CB10E4B2;
	Wed,  2 Sep 2026 13:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n1L9BG5V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87E710E4B2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:16:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E813D600D9;
 Wed,  2 Sep 2026 13:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C321F000E9;
 Wed,  2 Sep 2026 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788354972;
 bh=MjoS3S3Yqa4GriPOf8U3JvKvhm7zP5NNgOAI6B25mK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n1L9BG5VSE7J81rA+DWJbg3TOkmwAjMxzLGF94FexGREM6Ec5YWt2TkHnQz4xVZfp
 iuECxhz4T8KYhs9rA+MRasmLpWbuR8NOJ3vaV61Bg9vRIKJ36xmTkwrUg1tO5o++xB
 GI6eVRy4PZ9UFvZM3ak7iD27s2L8jzZfzczebPucAHAP1eB7blTgfQSHL+WhM22SwZ
 c/IV/r9sF8R33Rd3cOfF/fMP3/i3JmyvjD641i7BJbHjNPGIIoILsTBaTQjIy+/Ptx
 wLWusJJuGtwgdsUdJ10j97BhKJdN56NRLflkiYWyX7payyvDMUgm96KAdLOcTSV6AM
 dW/tlg5khod2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense
 when detecting hotplug
To: "Ian Ray" <ian.ray@gehealthcare.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902130117.2731-2-ian.ray@gehealthcare.com>
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
 <20260902130117.2731-2-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:16:12 +0000
Message-Id: <20260902131612.74C321F000E9@smtp.kernel.org>
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
- [Medium] The `ignore_rxsense` flag is applied too late in the IRQ handler=
, breaking CEC physical address invalidation and PHY power-down on hotplug =
disconnect.
- [Low] The commit introduces a new device tree property `ignore-rxsense` w=
ithout providing the corresponding YAML binding update.
--

commit daf606cf171e0645fecfea5f019e9fab9dd7eb6f
Author: Ian Ray <ian.ray@gehealthcare.com>

drm/bridge: dw-hdmi: optionally ignore rxsense when detecting hotplug

This commit introduces a new optional device tree property 'ignore-rxsense'
to bypass the rxsense state during hotplug detection. It is designed to
handle boards where rxsense is always active, such as when an HDMI to DP
converter is used.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
> index 17d5caedb32e0..5e8f56fba8e96 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c

[ ... ]

> @@ -3156,6 +3157,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_i=
d)
>  		if (phy_stat & HDMI_PHY_HPD)
>  			status =3D connector_status_connected;
> =20
> +		if (hdmi->ignore_rxsense)
> +			phy_stat &=3D ~HDMI_PHY_RX_SENSE;
> +

[Severity: Medium]
Is this modification applied too late in the interrupt handler?

Earlier in dw_hdmi_irq(), the raw phy_stat is passed to
dw_hdmi_setup_rx_sense():

		dw_hdmi_setup_rx_sense(hdmi,
				       phy_stat & HDMI_PHY_HPD,
				       phy_stat & HDMI_PHY_RX_SENSE);

When the cable is disconnected on a board where RX_SENSE is stuck high,
feeding the unmodified phy_stat into dw_hdmi_setup_rx_sense() prevents
it from clearing hdmi->rxsense, leaving the PHY incorrectly powered on.

Additionally, the raw phy_stat prevents the CEC invalidation block from
executing on disconnect:

		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) =3D=3D 0) {
			mutex_lock(&hdmi->cec_notifier_mutex);
			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);

Could the mask be applied to phy_stat earlier in the function, before
it is used by the PHY power management and CEC invalidation logic?

>  		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
>  			status =3D connector_status_disconnected;
>  	}

[ ... ]

> @@ -3362,6 +3366,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_devic=
e *pdev,
>  	mutex_init(&hdmi->cec_notifier_mutex);
>  	spin_lock_init(&hdmi->audio_lock);
> =20
> +	hdmi->ignore_rxsense =3D of_property_read_bool(np, "ignore-rxsense");
> +

[Severity: Low]
Is there a corresponding yaml binding update for this new property?

This introduces 'ignore-rxsense' as a new device tree property, but the
commit does not seem to include documentation for it. Missing
documentation makes it difficult for other board developers to know the
property exists and how to use it properly.

>  	ddc_node =3D of_parse_phandle(np, "ddc-i2c-bus", 0);
>  	if (ddc_node) {
>  		hdmi->ddc =3D of_get_i2c_adapter_by_node(ddc_node);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902130117.2731=
-1-ian.ray@gehealthcare.com?part=3D2
