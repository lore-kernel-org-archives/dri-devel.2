Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24840C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB4810F305;
	Fri, 28 Aug 2026 09:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TFiiHYdl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FF810F305
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:07:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2A25601FD;
 Fri, 28 Aug 2026 09:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACBF1F000E9;
 Fri, 28 Aug 2026 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787908062;
 bh=W3psK8NkSI21J56PPDr+tj0rYZnIIb3KCy84Jc8T6LQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TFiiHYdljkAWWrJ9EQq9wGSOF56IrD4jU5XCcmBAhLmHMhfrmS1HM7BLLW6QBPiJq
 /aPfw5imvqvjc79altANckn+WX0oKbJ5DaQjW2XbhUkxYtsf4/bRBMVdxHyUiwMbgO
 dUSMsn4KrHkex8eO+fnEfr7TIxMkr0q6HF1KewOl1ex8eesQzd6Q7MyEAS8Manm/S4
 dm+NBJyDq2Um88Z8/QFMboyV2/l9PDEplgoTQkYMRWyk+L+/bBBddUV65AC/flpEAK
 vh6pdR8WvhF5VT/sKdDtZIkdaYqSxSKqvNac7GYOi9ffAcPU88XQ29NWseWVlL+en/
 0op4hK18LQWrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260828084737.565-7-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-7-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:07:41 +0000
Message-Id: <20260828090742.5ACBF1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] The condition `PTR_ERR(extcon) !=3D -ENODEV` incorrectly skips=
 valid extcon pointers during probe, breaking backward compatibility for al=
l existing devices with an extcon.

Pre-existing issues:
- [High] Extcon notifier registered using devres in component bind is not u=
nregistered in component unbind, leading to Use-After-Free of released firm=
ware.
- [High] Using devm_drm_bridge_add in component bind causes duplicate bridg=
e registrations and devres corruption upon re-bind.
--

commit 30782eee380f850a10d083003cae3953c1e3c8d7
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This commit adds support for retrieving PHY lane information without
relying on extcon. This is useful for setups where a Type-C controller
is present and lane info can be acquired directly from the PHY.

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
>  		port->event_nb.notifier_call =3D cdn_dp_pd_event;
>  		ret =3D devm_extcon_register_notifier(dp->dev, port->extcon,
>  						    EXTCON_DISP_DP,

[Severity: High]
This is a pre-existing issue, but does using devres for the notifier here
cause a use-after-free upon component unbind?

Because devm_extcon_register_notifier() is tied to the platform device's
remove lifecycle rather than component unbind, the notifier remains active
after cdn_dp_unbind() completes. Since cdn_dp_unbind() frees the firmware
via release_firmware(), a subsequent extcon state change could trigger the
still-active notifier callback.

Could this lead to cdn_dp_pd_event_work() calling cdn_dp_firmware_init(),
which then dereferences the freed firmware data?

[ ... ]

> @@ -1119,14 +1128,14 @@ static int cdn_dp_probe(struct platform_device *p=
dev)
>  		    PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> =20
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) !=3D -ENODEV)
>  			continue;

[Severity: Critical]
Does this condition inadvertently skip valid extcon pointers during probe?

When extcon_get_edev_by_phandle() returns a valid kernel pointer,
PTR_ERR(extcon) casts that valid address to a long. Since a valid pointer
will never equal -ENODEV, the condition PTR_ERR(extcon) !=3D -ENODEV will
evaluate to true.

Will this completely disable port allocation for existing setups with a
valid extcon, resulting in a loss of display output?

[ ... ]

This is a pre-existing issue, but I also noticed a potential problem in
cdn_bridge_add():

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_bridge_add() {
        ...
        ret =3D devm_drm_bridge_add(dev, bridge);
        if (ret)
                return ret;
        ...
}

[Severity: High]
Does using devm_drm_bridge_add() in a component bind hook cause duplicate
bridge registrations?

Because devres actions only execute on full driver remove, unbinding and
rebinding the DRM component via sysfs appears to queue duplicate devres
cleanup actions. This adds the exact same bridge structure to the global
bridge_list repeatedly.=20

Could this corrupt the bridge list and lead to a double-free on removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D6
