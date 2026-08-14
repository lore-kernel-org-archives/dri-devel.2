Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAAFC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA68510E155;
	Fri, 14 Aug 2026 14:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4kR/HPS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD18D10E155
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:17:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9B14600C3;
 Fri, 14 Aug 2026 14:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713AA1F000E9;
 Fri, 14 Aug 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717076;
 bh=bAPwymv6ED1t0mMXNwIJQfp0DOubnIdUXaLe+eJCTrg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L4kR/HPSK/75MPCYPtdGtJ0rJUAAx1hAX8KiK2EejGlvf0sKexgCyEA/V0rIee0Gt
 /brNxW3GWwAylRI752tqPExS2Venc7QOGomSoyziVUGmQ+N3WF6jWbNNmw2bQbXM5S
 5rdgMO9SDSJ/28hlrOEiB09eHOd5enE6UPm7hYTcGd2/0IkjBdDMFEed2vaL7aDuEy
 iKQpAHPqyHKYnz46O9X0KNgaClGxsznqq1pJKAviztqXbANXO0DOCfqk4MkC76UawO
 vgyDE4FeLuZ2BKA62BcOt4C6qgNYBLAcm4st1LqBz/2fRBhLhn/hVmaTqrLUnEy2Z4
 tLoKFpowVWKJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] drm/bridge: tc358767: don't create a panel_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-6-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-6-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:17:55 +0000
Message-Id: <20260814141756.713AA1F000E9@smtp.kernel.org>
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
- [Critical] Refcount underflow and use-after-free for bridges acquired in =
DPI mode.
- [High] Resource leak of the bridge reference on probe error paths.

Pre-existing issues:
- [High] Undefined behavior due to a negative bitshift when evaluating `tc-=
>hpd_pin`.
--

--- Patch [6]: [PATCH 06/11] drm/bridge: tc358767: don't create a panel_bri=
dge ---
commit ae8aef2f483ffa927af25a2f1ac42b0420349ca8
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: tc358767: don't create a panel_bridge

This commit prevents creating a second panel_bridge by retrieving the
already-existing one using of_drm_get_bridge_by_endpoint() for eDP
endpoints. It updates tc_remove() to release the reference.

> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index e3a57f8228dae..2fef5d9fa361d 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2347,24 +2347,15 @@ static int tc_probe_dpi_bridge_endpoint(struct tc=
_data *tc)
>  static int tc_probe_edp_bridge_endpoint(struct tc_data *tc)
>  {
>  	struct device *dev =3D tc->dev;
> -	struct drm_panel *panel;
> -	int ret;
> +	struct drm_bridge *bridge;
> =20
>  	/* port@2 is the output port */
> -	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, NULL);
> -	if (ret && ret !=3D -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "Could not find DSI panel or bridge\n");
> +	bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 2, 0);
> +	if (IS_ERR(bridge) && PTR_ERR(bridge) !=3D -ENODEV)
> +		return dev_err_probe(dev, PTR_ERR(bridge), "Could not find DSI bridge\=
n");
> =20
> -	if (panel) {
> -		struct drm_bridge *panel_bridge;
> -
> -		panel_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> -		drm_panel_put(panel);
> -		if (IS_ERR(panel_bridge))
> -			return PTR_ERR(panel_bridge);
> -
> -		tc->panel_bridge =3D panel_bridge;
> +	if (!IS_ERR(bridge)) {
> +		tc->panel_bridge =3D bridge;
>  		tc->bridge.type =3D DRM_MODE_CONNECTOR_eDP;
>  	} else {
>  		tc->bridge.type =3D DRM_MODE_CONNECTOR_DisplayPort;
>  	}

[Severity: High]
If of_drm_get_bridge_by_endpoint() successfully returns a refcounted bridge
pointer, it is stored in tc->panel_bridge. If any subsequent initialization
step in tc_probe() fails, it appears to return directly without cleaning up
the bridge reference:

tc_probe() {
    ...
    tc_probe_edp_bridge_endpoint(tc);
    ...
    tc->refclk =3D devm_clk_get_enabled(dev, "ref");
    if (IS_ERR(tc->refclk))
        return dev_err_probe(dev, PTR_ERR(tc->refclk),
                             "Failed to get and enable the ref clk\n");
    ...
}

Could this cause a resource leak on probe error paths?

[Severity: High]
This is a pre-existing issue, but does evaluating tc->hpd_pin here lead to a
negative bitshift later?

Due to initialization order, tc_data is zero-allocated, meaning tc->hpd_pin
is 0 when checked in tc_probe_edp_bridge_endpoint():

    if (tc->hpd_pin >=3D 0)
        tc->bridge.ops |=3D DRM_BRIDGE_OP_DETECT;

Later in tc_probe(), if the DT property is absent, tc->hpd_pin is assigned
-ENODEV (-19).

When the DRM core periodically polls the connector, it calls
tc_bridge_detect(), which executes:

    conn =3D val & BIT(tc->hpd_pin);

Does this lead to undefined behavior by evaluating BIT(-19)?

[ ... ]

> @@ -2609,6 +2600,7 @@ static void tc_remove(struct i2c_client *client)
>  {
>  	struct tc_data *tc =3D i2c_get_clientdata(client);
> =20
> +	drm_bridge_put(tc->panel_bridge);
>  	drm_bridge_remove(&tc->bridge);
>  }

[Severity: Critical]
Does this unconditional drm_bridge_put() cause a double-free for bridges
acquired in DPI mode?

When operating in DPI mode, tc_probe_dpi_bridge_endpoint() is called instea=
d,
which assigns tc->panel_bridge to a devm-managed bridge:

tc_probe_dpi_bridge_endpoint() {
    ...
    bridge =3D devm_drm_panel_bridge_add(dev, panel);
    ...
    tc->panel_bridge =3D bridge;
}

When the device unbinds, tc_remove() drops a reference it does not own. For
the devm-managed bridge, this prematurely drops its refcount to 0, freeing
the bridge immediately. Later, the devres framework will attempt to clean up
the same bridge, causing a double-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D6
