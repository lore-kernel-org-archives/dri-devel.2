Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4EDC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C0D10E55A;
	Fri, 14 Aug 2026 14:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b+K5aN0g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAB210E55A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:19:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33531413E4;
 Fri, 14 Aug 2026 14:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15731F000E9;
 Fri, 14 Aug 2026 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717188;
 bh=Up/IOsReKPp3Giw1py9EY7LHtH2Ipk1OQw3TzNcgnZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b+K5aN0gAs9p+iv79VATFuvg0gazifV1eZPQOduJOUwABqdS//ZYvwINQrxVdi65p
 lrQU14loSk6TA9/bZhTNVYT9EUNjW/hQ+7delRzkSxZAPAYdxFiRqlsW36AYuEgo9R
 +E4DxqvFrZpY6RYam7ITXs5mlsQJhRDAvlFa0tU0ZfON/o+BewiCC6jX4BseiFPVCF
 MpIoiCM8c4Cx8xRxSEXGSGRsfPZxLLXR75mWbpnlYsJniGxBR0MSXMb+5gUq5y59ll
 8xR3i8jG6ODQaL1xj3p06yJua1sv8Jv0sYdVV9/VAVad+o3DYfcpNnZlq79+FDfvZf
 7b9MXUBtDgLiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] drm/mcde: dsi: simplify device_node management
 using scoped for_each variant
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:19:47 +0000
Message-Id: <20260814141947.E15731F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `drm_bridge_remove()` for `d->bridge` during unbind causes=
 a memory leak and use-after-free risk.
- [High] Deferred probing for panels is broken by mapping `-EPROBE_DEFER` t=
o `-EINVAL`.
--

--- Patch [8]: [PATCH 08/11] drm/mcde: dsi: simplify device_node management=
 using scoped for_each variant ---
commit 6cf52153aa2a545f24c563456ea7265e0b307010
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mcde: dsi: simplify device_node management using scoped for_each variant

Before further modifying this function, simpify the struct device_node
management using the scoped variat of for_each_available_child_of_node().

> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_=
dsi.c
> index 6943725818407..ce078aa3910f2 100644
> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c

[ ... ]

> @@ -1104,7 +1103,7 @@ static int mcde_dsi_bind(struct device *dev, struct=
 device *master,
>  	}
> =20
>  	/* Look for a panel as a child to this node */
> -	for_each_available_child_of_node(dev->of_node, child) {
> +	for_each_available_child_of_node_scoped(dev->of_node, child) {
>  		panel =3D of_drm_find_panel(child);
>  		if (IS_ERR(panel)) {
>  			dev_err(dev, "failed to find panel try bridge (%ld)\n",
> @@ -1114,15 +1113,12 @@ static int mcde_dsi_bind(struct device *dev, stru=
ct device *master,
>  			bridge =3D of_drm_find_and_get_bridge(child);
>  			if (!bridge) {
>  				dev_err(dev, "failed to find bridge\n");
> -				of_node_put(child);
>  				return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does returning -EINVAL here break
deferred probing?

If the panel driver is not yet probed, of_drm_find_panel() returns
ERR_PTR(-EPROBE_DEFER). This error path intercepts that by checking
IS_ERR(panel), setting panel =3D NULL, and falling back to
of_drm_find_and_get_bridge(). Since the panel's bridge is also not
registered yet, this returns NULL.

Finding no bridge, the driver then unconditionally returns -EINVAL instead
of propagating the -EPROBE_DEFER error. This causes the component bind to
fail permanently rather than deferring, which can lead to a loss of
display output if the MCDE driver probes before the panel driver.

>  			}
>  		}
> =20
> -		if (panel || bridge) {
> -			of_node_put(child);
> +		if (panel || bridge)
>  			break;
> -		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing
drm_bridge_remove() in mcde_dsi_unbind() for the bridge registered in
mcde_dsi_bind()?

The driver registers d->bridge using drm_bridge_add() further down in
mcde_dsi_bind(), which acquires a reference and links it into the global
bridge_list.

However, in mcde_dsi_unbind(), the driver fails to call
drm_bridge_remove(), meaning the bridge is never unlinked and its reference
count never drops to zero.

Because d->bridge remains in the global bridge_list even after the device
is unbound and its devres-managed resources are freed, subsequent
iterations of the bridge_list by other drivers could dereference a stale
pointer. Can this cause a use-after-free and potential kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D8
