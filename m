Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F75606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ5EK4/d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7BB10EB8D;
	Tue, 20 Oct 2026 08:36:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA6010EB9B
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:35:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F1A660DB0;
 Tue, 20 Oct 2026 08:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992151F000CC;
 Tue, 20 Oct 2026 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792485347;
 bh=crQcIFFBAX4Hpvb1vY/ep2aby/VU13YvjlGE1CBkL4I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YJ5EK4/d+RC+HFhf04s1RILOqB+fHmoq+VEcRZKAhcQaP+PWzCMXjG10rWZ5Lq/Mh
 Msp/wca+lPSHb006XfpNizr4pSQybPKf7DCvwS1yreyVZ4mCnaS3g0DS7+BYCxMAO+
 fxzj5MphIaO0sLMPPC63IlfmoxkffiXRSOKJ/U17eGFOyqA91XLlnwQgix9NFz1rEi
 sFrBUy2aisBzzfJe6AB41Q3lmexeTzRId/wZzbjewnouZjxuIoq7v3OnT3X5PsZBGW
 MFx9/A7nP+XGJlemrJAX2Fv4qJWGhWyBz3TZ2s4qwEEF0wXpSYMA0FRR1Zb+6sfpp7
 yJSYqqzfZ9Aag==
Message-ID: <sashiko-outbox-178573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261020072816.180-5-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
 <20261020072816.180-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:35:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: aux: missing of_node_get() in drm_aux_bridge_register_=
from_node()
- [High] drm/bridge: aux: improper OF node setup in drm_aux_bridge_register=
_from_node()
--

commit 36532c7bf6a02e3a0e3f70873a369995bccbc3c6
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()

This commit adds drm_aux_bridge_register_from_node() so callers can specify=
 an
explicit device_node for the auxiliary bridge instead of always using the
parent device's of_node.

> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge=
/aux-bridge.c
> index 90f76bb529cc2..f1adcdece7b95 100644
> --- a/drivers/gpu/drm/bridge/aux-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-bridge.c
> @@ -35,8 +35,9 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>  }
> =20
>  /**
> - * drm_aux_bridge_register - Create a simple bridge device to link the c=
hain
> + * drm_aux_bridge_register_from_node - Create a simple bridge device to =
link the chain
>   * @parent: device instance providing this bridge
> + * @np: device node pointer corresponding to this bridge instance
>   *
>   * Creates a simple DRM bridge that doesn't implement any drm_bridge
>   * operations. Such bridges merely fill a place in the bridge chain link=
ing
> @@ -44,7 +45,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>   *
>   * Return: zero on success, negative error code on failure
>   */
> -int drm_aux_bridge_register(struct device *parent)
> +int drm_aux_bridge_register_from_node(struct device *parent, struct devi=
ce_node *np)
>  {
>  	struct auxiliary_device *adev;
>  	int ret;
> @@ -64,7 +65,10 @@ int drm_aux_bridge_register(struct device *parent)
>  	adev->dev.parent =3D parent;
>  	adev->dev.release =3D drm_aux_bridge_release;
> =20
> -	device_set_of_node_from_dev(&adev->dev, parent);
> +	if (np)
> +		device_set_node(&adev->dev, of_fwnode_handle(np));
> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);

[Severity: High]
Does calling device_set_node() when np is non-NULL underflow the OF node
reference count on cleanup?

In drivers/base/core.c, device_set_of_node_from_dev() increments the refere=
nce
count via of_node_get() and marks the node as reused, whereas
device_set_node() only assigns the pointers:

drivers/base/core.c:
void device_set_of_node_from_dev(struct device *dev, const struct device *d=
ev2)
{
	of_node_put(dev->of_node);
	dev->of_node =3D of_node_get(dev2->of_node);
	dev_set_of_node_reused(dev);
}

void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
{
	dev->fwnode =3D fwnode;
	dev->of_node =3D to_of_node(fwnode);
}

However, both the auxiliary_device_init() failure path in
drm_aux_bridge_register_from_node() and the device release callback
drm_aux_bridge_release() (reached if auxiliary_device_add() fails via
auxiliary_device_uninit() -> put_device(), or when the parent unbinds via
drm_aux_bridge_unregister_adev()) unconditionally drop a reference on
dev->of_node:

drivers/gpu/drm/bridge/aux-bridge.c:drm_aux_bridge_release() {
	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);

	of_node_put(dev->of_node);
	ida_free(&drm_aux_bridge_ida, adev->id);

	kfree(adev);
}

When a caller such as rockchip_typec_phy_probe() passes a child node via
for_each_available_child_of_node(np, child_np) without taking an extra
reference for the bridge, won't this drop a reference that
drm_aux_bridge_register_from_node() never acquired?

[Severity: High]
Also, is device_set_node() appropriate here when np is shared with a parent=
 or
subnode device (such as the dp-port PHY subnode in phy-rockchip-typec)?

Unlike device_set_of_node_from_dev(), device_set_node() sets adev->dev.fwno=
de
and leaves DEV_FLAG_OF_NODE_REUSED unset on &adev->dev.

Because adev->dev.fwnode is set and the node is not marked reused:
1. device_add() assigns np->fwnode.dev =3D &adev->dev, so fw_devlink treats=
 the
   aux_bridge auxiliary device as the supplier for np. If np is a PHY subno=
de
   without an OF graph port (for example, tcphy0_dp / tcphy1_dp referenced =
via
   phys =3D <&tcphy0_dp>), drm_aux_bridge_probe() returns -ENODEV and leave=
s the
   auxiliary device unbound, which can cause consumers like cdn_dp to defer
   probe indefinitely with -EPROBE_DEFER.
2. really_probe() -> pinctrl_bind_pins() only skips pin binding when
   of_node_is_reused() is true, which can conflict if np carries pinctrl
   properties.

Should the non-NULL np path instead set adev->dev.of_node =3D of_node_get(n=
p)
and call dev_set_of_node_reused(&adev->dev) to match
device_set_of_node_from_dev()?

[ ... ]

>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020072816.180-=
1-kernel@airkyi.com?part=3D4
