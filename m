Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C352606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz3R5F2N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E44710EE1B;
	Sat, 14 Nov 2026 05:34:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C7110EE1B
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:34:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95F3743426;
 Sat, 14 Nov 2026 05:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF01F000C5;
 Sat, 14 Nov 2026 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794634465;
 bh=oNIEiaTmTfdp3lH+tYaJG9S1dzUHt9teqTh8ueV86Yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vz3R5F2NSRBG06RvQWiYMFQ2RnkLcR02dXwq8pQAczNgzPFdNemeoiL65RQNf7nQv
 KLz1Ce2+YyzbnAWH8+DBqMapuQcOva41HbweBQUUYn78Q2HELe2xt53XqkOj0FcATJ
 y7cI4sBrjNNEHkIN6aGhRfXfhS9XlCNCVauRxrxkaQZZXXv1r4qeJGFACtksVBpc+l
 PkEsHQgGBZXOQwX/f1CCMCu7eloohAC5W2wrbRHy8kVzA7na76LBlaR/S+/56jwqau
 5gtEsw46qVOh+ofkjMMZ7HV3rt79fGG1CAh2mPChWQxwDa8MFwmrU4ji8AiqKITGCc
 Ad5YL6tz97Zew==
Message-ID: <sashiko-outbox-214182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/23] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-10-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-10-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:34:24 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/bridge: dw-dp: permanent probe deferral in dw_dp_probe() on
  RK3588 boards
--

commit 75b0f7632b89aacf0c388d31b5dbe1c16aadde94
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add follow-up bridge support

This commit acquires the downstream DRM bridge connected to port 1 endpoint=
 0
during dw_dp_probe() and attaches it in dw_dp_bridge_attach() to support US=
B-C
DP altmode bridge chains.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 5db9063ee97e0..74ba1306caee6 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -2156,6 +2179,16 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> +	dp->next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
> +	if (IS_ERR(dp->next_bridge)) {
> +		dev_err_probe(dev, PTR_ERR(dp->next_bridge), "failed to get follow-up =
bridge\n");
> +		return ERR_CAST(dp->next_bridge);
> +	}

[Severity: High]
Does requiring dp->next_bridge cause dw_dp_probe() to defer forever on RK35=
88
boards where usbdp_phy0 uses a single port node?

In rk3588-lubancat-5io.dts and rk3588s-indiedroid-nova.dts, dp0_out_con
connects to usbdp_phy0_dp_in (endpoint@2) under a single port subnode on
usbdp_phy0 rather than a multi-port graph with port@3.  However,
rk_udphy_probe() only registers the auxiliary DRM bridge when port 3
endpoint 0 is present:

drivers/phy/rockchip/phy-rockchip-usbdp.c:rk_udphy_probe() {
    ...
	dp_aux_ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 3, 0, 0);
	if (dp_aux_ep) {
		ret =3D drm_aux_bridge_register(dev);
    ...
}

On those boards, of_drm_get_bridge_by_endpoint() resolves the remote node to
usbdp_phy0, finds no registered drm_bridge, and returns -EPROBE_DEFER
indefinitely.  Because rockchip_drm_match_add() adds every enabled dw-dp
device as a required component, this prevents the entire rockchip-drm displ=
ay
subsystem from binding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D10
