Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D242DC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C9E10E0DD;
	Thu, 30 Jul 2026 01:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hhzVkrxc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0843110E0DD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AA96600AA;
 Thu, 30 Jul 2026 01:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF021F000E9;
 Thu, 30 Jul 2026 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785375965;
 bh=IPXUJN7vg4rcfyPoPj49EGsOfnXI/L+Hz7907EAJKa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hhzVkrxcyS+YqELzmrYUT5da4FFHga2dIaytVUxIOBpwVxxHyST/zmwXSuBOBlG1S
 pL9dHuepF7ob6q5LfROzdS9CrLiBZ9+I2baFL0uBKgq8ajbPh1VcD3reQAS7U7S2NM
 OihUYUNzfiG7wctxTAUjuxXn4quUfY1mCk9p3vw21uVp1Ecx7JtZx2LNiZXT1sNJkF
 vCwy299KaOJs2bojVoGH32WJng56dYiKsivfOYX5U3A0ru1ZgkZQIO9d5EQUxmNbZt
 yPIUho6rPu4DfZm+ZdEVK7BFajMIkCcASnjZ3I2Em2NApCqGg21sm0U4sIibqJrc0i
 s5Ps5w6qrqg/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260730013349.51-6-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:46:05 +0000
Message-Id: <20260730014605.8DF021F000E9@smtp.kernel.org>
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
- [High] Valid extcon devices are incorrectly skipped during probe due to a=
 flawed pointer error check, breaking all existing platforms that use extco=
n.
- [High] Hotplug detect (HPD) is completely broken when extcon is not prese=
nt because no alternative notification mechanism is implemented.
- [High] Unchecked negative error code from `phy_get_bus_width` is implicit=
ly truncated to `u8` and used as a valid lane count, corrupting hardware co=
nfiguration.
--

--- Patch [5]: [PATCH v5 5/6] drm/rockchip: cdn-dp: Support handle lane inf=
o without extcon ---
commit 4ff0e4c27809cca886c5ca372b54b8d927541018
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This commit adds support for getting PHY lane information directly from the
PHY instead of relying on extcon when a Type-C controller is present. It
preserves extcon support for cases where the Type-C controller is absent.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 190cce9530c82..74e1f5422a6e2 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -157,6 +157,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *=
port)
>  	int dptx;
>  	u8 lanes;
> =20
> +	if (!edev)
> +		return phy_get_bus_width(port->phy);
> +

[Severity: High]
Can this return a negative error code (like -ENOSYS) that gets truncated?

In cdn_dp_enable_phy(), the return value is directly assigned to an 8-bit
unsigned integer:

	port->lanes =3D cdn_dp_get_port_lanes(port);

If phy_get_bus_width() returns a negative error, will this result in a
silently truncated out-of-bounds lane count being written to the hardware
registers?

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
Does skipping the notifier registration permanently orphan the driver's
hotplug detect state machine?

The driver's connection state machine is entirely driven by
cdn_dp_pd_event_work(), which is only ever scheduled by the extcon notifier
callback.=20

Without an alternative notification mechanism for non-extcon setups, will t=
he
display controller ever be notified of cable insertion?

[ ... ]

> @@ -1119,14 +1128,14 @@ static int cdn_dp_probe(struct platform_device *p=
dev)
>  		    PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> =20
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) !=3D -ENODEV)
>  			continue;

[Severity: High]
Will this condition evaluate to true for all valid extcon pointers,
skipping valid extcon devices entirely?

When a valid extcon device is found, PTR_ERR() will cast that pointer
address to a long. Since a valid pointer address will not equal -ENODEV,
this check seems to evaluate to true and skip the port setup for all existi=
ng
functional extcon setups.

Should this include an IS_ERR() guard, such as
IS_ERR(extcon) && PTR_ERR(extcon) !=3D -ENODEV?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013349.51-1=
-kernel@airkyi.com?part=3D5
