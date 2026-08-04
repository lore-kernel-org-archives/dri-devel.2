Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3737C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA6410E89D;
	Tue,  4 Aug 2026 07:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SQYBSKz0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA9610E89D
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:35:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DA3160A77;
 Tue,  4 Aug 2026 07:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560F71F000E9;
 Tue,  4 Aug 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785828917;
 bh=e7qRs4IqtYJoIg5+mk7KbBb3QrwL3cGkLcEJyc3Ym5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SQYBSKz0BOB9mAdZEF0rl81gs4JjTKmV9foVwORdAF2ANieWFUF/wz0h5gaTgsq46
 YQjrbKqY95Llny6IPE+hn1lfsxQoeLbmkK7qXEpApHtdWforOpkov4CMR/3V7wQlP4
 CU/0yisln0CTF9wxigxE0be7lwwzyZZMxhBnRnwEO6RRB0QW+VOYHv+dsJxf36BeIf
 oLUKCKznUu4h8l9Kx0/wtnKBP48aIpBZKFhy9gRNBrrxd0kCv5c+lFKG2zA+XSDDPi
 TzdmKFOZq6++mDhCD6AciWB7np43zquiP2c92qm4Z/HoV/4MngdPInmIu2IhBP3dG+
 O13nKDY1s1qjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org, vkoul@kernel.org
In-Reply-To: <20260804070730.68-7-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-7-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:35:15 +0000
Message-Id: <20260804073516.560F71F000E9@smtp.kernel.org>
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
- [Critical] Logic error in pointer error checking breaks probe for all exi=
sting boards using extcon.
- [High] Missing hotplug detection (HPD) mechanism when extcon is absent.
--

--- Patch [6]: [PATCH v6 6/7] drm/rockchip: cdn-dp: Support handle lane inf=
o without extcon ---
commit 2ec5f110f1557ebaec82cbe6b39d4e2ab7f4a88f
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This patch add support for get PHY lane info without help of extcon.

There is no extcon needed if the Type-C controller is present. In this
case, the lane info can be get from PHY instead of extcon.

The extcon device should still be supported if Type-C controller is
not present.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 190cce9530c82..74e1f5422a6e2 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c

[ ... ]

> @@ -1027,6 +1033,9 @@ static int cdn_dp_bind(struct device *dev, struct d=
evice *master, void *data)
>  	for (i =3D 0; i < dp->ports; i++) {
>  		port =3D dp->port[i];
> =20
> +		if (!port->extcon)
> +			continue;
> +

[Severity: High]
Does skipping the notifier registration when extcon is absent break hotplug=
=20
detection?=20

The driver relies on cdn_dp_pd_event_work() to transition dp->connected to=
=20
true, load firmware, and train the link. Without the extcon notifier,=20
event_work is never scheduled on hotplug.=20

Since cdn_dp_bridge_detect() simply returns the static dp->connected state:

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_dp_bridge_detect() {
    mutex_lock(&dp->lock);
    if (dp->connected)
        status =3D connector_status_connected;
    mutex_unlock(&dp->lock);
    ...
}

Could KMS polling always see the port as disconnected when hardware is=20
configured without an extcon device?

>  		port->event_nb.notifier_call =3D cdn_dp_pd_event;
>  		ret =3D devm_extcon_register_notifier(dp->dev, port->extcon,
>  						    EXTCON_DISP_DP,

[ ... ]

> @@ -1119,14 +1128,14 @@ static int cdn_dp_probe(struct platform_device *p=
dev)
>  		    PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> =20
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) !=3D -ENODEV)
>  			continue;
> =20

[Severity: Critical]
Will this condition accidentally skip port initialization for all valid ext=
con
pointers?

If extcon is a valid pointer, PTR_ERR(extcon) evaluates to its memory addre=
ss,
which will never equal -ENODEV. This causes the condition to evaluate to tr=
ue,
triggering the continue statement and bypassing port setup completely for a=
ny
hardware that has an extcon device.

>  		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
> =20
> -		port->extcon =3D extcon;
> +		port->extcon =3D IS_ERR(extcon) ? NULL : extcon;
>  		port->phy =3D phy;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D6
