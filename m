Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6A1C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EC610E68E;
	Thu, 17 Sep 2026 08:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQZXFoeS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698F110E68E
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:17:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 459C5600D4;
 Thu, 17 Sep 2026 08:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C749E1F00893;
 Thu, 17 Sep 2026 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789633032;
 bh=NWvyGveb+McTgJMo8EjKDgd0rD3pwid9BPHqVHpsiy4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZQZXFoeSQM7bmt3ZBymXP2VQWeTvswfsfM0lly+krlaMAZnw06qpR+FAbBGvNuUYM
 SRw1Yq00M5Y4j3reVLI+Fr2PMnxAESSEQDtvbxTga5KWXCEPv+jeMBfaeuZbtoyQHU
 6QbGx56Nn3fGG6BrL4p/Ur12GpUIutGdYfasDh8bWhxyM97KoGTDRa5i1jsHfYE7dP
 aodXbiE64s5E6M8v6h7O1huG71KHRIk9TMbSxgDlRHYJ1wcYCzdqCWmLfauoSD5ow6
 XgfOurRE59D242z/U54y8PWqtPQUGn3JXhPcTzBK6F1m4Vf1+mOOHEqfDyeZaJqu8B
 y4gHdMNH7SafQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917080126.1729898-1-xiaolu.xie@intel.com>
References: <20260917080126.1729898-1-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 08:17:11 +0000
Message-Id: <20260917081711.C749E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/dp/mst: missing connector creation breaks hotplug for empty do=
wnstream ports
--

commit b7642d2c459f1deba3af19a444979a2c15cbf1e0
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp/mst: skip connector creation for unplugged downstream ports

This patch modifies the MST link enumeration path to skip creating DRM
connectors for downstream ports that do not have a device connected.
It aims to reduce error log noise and spurious sideband messages from
DPCD reads on empty ports.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2448,7 +2448,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
> =20
>  	if (port->connector)
>  		drm_modeset_unlock(&mgr->base.lock);
> -	else if (!port->input)
> +	else if (!port->input && port->ddps)
>  		drm_dp_mst_port_add_connector(mstb, port);

[Severity: High]
If we skip connector creation here for empty ports, will the hotplug path
actually create the connector when a monitor is plugged in?

Looking at drm_dp_mst_handle_conn_stat(), create_connector is only set to
true when transitioning from an input port to an output port:

    } else if (port->input && !conn_stat->input_port) {
        create_connector =3D true;

For standard downstream ports, port->input is 0, so create_connector
remains false during a hotplug event.

Later in drm_dp_mst_handle_conn_stat(), it checks:

    else if (create_connector)
        drm_dp_mst_port_add_connector(mstb, port);

Since create_connector evaluated to false, the dynamic connector creation
is bypassed.

Also, drm_dp_port_set_pdt() returns 0 for regular SST monitors:

        if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
            /* add i2c over sideband */
            ret =3D drm_dp_mst_register_i2c_bus(port);

This prevents the caller from setting dowork =3D true and triggering a
fallback link address reprobe.

Does this mean a display plugged into an MST hub port that was empty at
boot will remain permanently dark because its DRM connector is never
created?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917080126.1729=
898-1-xiaolu.xie@intel.com?part=3D1
