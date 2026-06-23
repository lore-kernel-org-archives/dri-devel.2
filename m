Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D5CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5BA10EC6D;
	Tue, 23 Jun 2026 19:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nf8r1Zyz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F6210EC6D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D14B060018;
 Tue, 23 Jun 2026 19:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BD1F000E9;
 Tue, 23 Jun 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782244162;
 bh=Ja5q2fZKG3v7RFMZdWsvuqRkGzU83kSeBhA8tTduTvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nf8r1ZyzR8a96W1ECLiC8OFvtA9C7n/wi23dyb5/qB2gz3uyuXhxGIMZLzVdJdtr1
 nrNYR4+bKSLunMKzAEFu9Lqr7BjVpDCAu7ggkvZrJizqkriF6fHY/ZR9r/D2cQ2qtj
 GlhcxG5CFsJV8Met+N8YaUlNkizhq0nZqCzvJOxcwOTqbF/PRsh+0w3PPKI6RSkMza
 /TJ2N2oxytZbYye5EhBuRixKCEMhVRuc8xDJje0YZMAi/eRM7UBqfjxoF3v5g7t9Ut
 9H76mBekept6+w18fE12+t1i/SeXCKvMwbvIfnFom+Z6Xr3dqZnU1TIoek3RuakAEv
 38zHPFtwtFOFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-3-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-3-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:49:21 +0000
Message-Id: <20260623194922.4F4BD1F000E9@smtp.kernel.org>
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

New issues:
- [High] Memory leak of the follow-up bridge reference count.
- [High] Unconditional probe failure causing DT backward compatibility brea=
kage.

Pre-existing issues:
- [High] Missing completion reinitialization causes race conditions with st=
ale completion states during AUX transfers.
- [High] Premature registration and exposure of the DP AUX channel to users=
pace before hardware and IRQ initialization.
--

commit ceef3e5c9dcfb09773dad5a727e1e2147c87f8e5
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add follow-up bridge support

Add support to use USB-C connectors with the DP altmode helper code on
devicetree based platforms. To get this working there must be a DRM bridge
chain from the DisplayPort controller to the USB-C connector.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index ac7779e42bb24..98cff435dfb87 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1970,7 +1970,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct=
 drm_encoder *encoder,
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct dw_dp *dp;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *bridge, *next_bridge;
>  	void __iomem *res;
>  	int ret;
> =20
> @@ -2064,6 +2064,20 @@ struct dw_dp *dw_dp_bind(struct device *dev, struc=
t drm_encoder *encoder,
>  		goto unregister_aux;
>  	}
> =20
> +	next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
> +	if (IS_ERR(next_bridge)) {

[Severity: High]
Can this unconditional check break device tree backward compatibility?

By making the absence of a follow-up bridge a fatal error instead of an
optional configuration, this appears to cause the display driver to
completely fail to probe on existing platforms that do not define a downstr=
eam
bridge endpoint in their device tree.

> +		ret =3D PTR_ERR(next_bridge);
> +		dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
> +		goto unregister_aux;
> +	}
> +
> +	ret =3D drm_bridge_attach(encoder, next_bridge, bridge,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

[Severity: High]
Does this code leak the next_bridge reference?

Calling of_drm_get_bridge_by_endpoint() increments the reference count of t=
he
returned bridge, but there doesn't seem to be a corresponding drm_bridge_pu=
t()
on either the success or error paths to release it.

> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to attach next bridge\n");
> +		goto unregister_aux;
> +	}
> +
>  	dw_dp_init_hw(dp);
> =20

[Severity: High]
This is a pre-existing issue, but does registering the AUX channel early
expose uninitialized hardware to userspace?

Looking earlier in dw_dp_bind():

	ret =3D drm_dp_aux_register(&dp->aux);
	if (ret) {
		dev_err_probe(dev, ret, "Aux register failed\n");
		return ERR_PTR(ret);
	}

And then later:

	dw_dp_init_hw(dp);

	ret =3D phy_init(dp->phy);

If a userspace process opens the AUX character device and initiates a
transaction before dw_dp_init_hw() and the IRQ setup are called, the hardwa=
re
may enter an invalid state and miss completion interrupts.

>  	ret =3D phy_init(dp->phy);

[Severity: High]
This is a pre-existing issue, but can the lack of completion reinitializati=
on
cause race conditions?

Looking at dw_dp_aux_transfer() in the same file:

	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

	status =3D wait_for_completion_timeout(&dp->complete, timeout);

If a previous AUX transfer timed out but the hardware eventually triggered a
late interrupt, the completion object will remain in a done state. The next
AUX transfer will see this stale state, causing wait_for_completion_timeout=
()
to return immediately before the new transfer has actually completed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D3
