Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0164C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E98F10F48B;
	Fri, 17 Jul 2026 07:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZtSNv0vi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF6D10F48B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:56:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 422454146F;
 Fri, 17 Jul 2026 07:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC24E1F000E9;
 Fri, 17 Jul 2026 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784274993;
 bh=ut8qNtIyxsOvnRwMY68Ryxwa0RJgWxJXx89jScypmjg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZtSNv0vis1P+5aMe6+4Noj1S2n0/QxR3UtTptmV34AANC9Gm+lerRsbQdArYFxdmg
 PcTv4Ezx9Za9psU2OAiwZJ9j4UZB6J8Jon1wA2oDWUGfUUH35IedJs/2LGvvEobxE6
 Yzbu5W5o9Paqzf/N93lh0p6ZBBDuoq+M9Z820Y5IKa2Ogej7sndWc+BnOKIqbWNgmA
 Go7/NJpalI3R0hEEQiovRyuKfKCiVKRsIfxcaWdfzgljoFd/suKwDKEpKk4NV8TUrG
 FYR/92Sh6DPnfkWLnoPTDOz6hehJCz4dbnRwlA09V493ip2Cbj0Og86fq81qzJhJT6
 /f+o5//9HyeTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org
In-Reply-To: <20260717072323.96-5-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:56:32 +0000
Message-Id: <20260717075632.BC24E1F000E9@smtp.kernel.org>
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
- [High] Incorrect error checking logic in `cdn_dp_probe` skips port initia=
lization for valid extcon devices, breaking DisplayPort for legacy boards.
- [High] Removing the `extcon` notifier without providing an alternative me=
chanism completely breaks hotplug detection for Type-C connections without =
an extcon device.
--

--- Patch [4]: [PATCH v3 4/5] drm/rockchip: cdn-dp: Support handle lane inf=
o without extcon ---
commit 2789d7ccb0bb45f82d439538cf9aeaac1da9c5e9
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This patch adds support for getting PHY lane info without the help of extco=
n.
There is no extcon needed if the Type-C controller is present. The extcon
device should still be supported if the Type-C controller is not present.

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
Does skipping the notifier registration when extcon is absent leave the dri=
ver
without any hotplug detection mechanism?

The driver relies on the cdn_dp_pd_event notifier (registered via extcon) to
schedule dp->event_work, which probes the hardware, updates the connection
state, and calls drm_bridge_hpd_notify().

Without an alternative HPD mechanism when extcon is absent, won't hotplug
events be silently ignored, causing displays to only be detected if plugged=
 in
during boot or resume?

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

[Severity: High]
Does evaluating PTR_ERR(extcon) !=3D -ENODEV without first checking if extc=
on
is an error pointer break initialization for valid extcon devices?

When a valid extcon device is successfully found, extcon is a valid kernel
pointer. Casting this pointer to long via PTR_ERR() yields a memory address
that is not equal to -ENODEV.

Since the condition incorrectly evaluates to true, won't the loop continue
and skip port allocation for all valid extcon devices, breaking DisplayPort
on existing platforms that use extcon?

> =20
>  		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
> =20
> -		port->extcon =3D extcon;
> +		port->extcon =3D IS_ERR(extcon) ? NULL : extcon;
>  		port->phy =3D phy;
>  		port->dp =3D dp;
>  		port->id =3D i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717072323.96-1=
-kernel@airkyi.com?part=3D4
