Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F94606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQrN0jZP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FD510E4F5;
	Sat, 21 Nov 2026 08:15:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214DB10E4F5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:15:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9675413EA;
 Sat, 21 Nov 2026 08:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8798D1F000CA;
 Sat, 21 Nov 2026 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795248930;
 bh=nlevDYathA8urN/Gtunk9d4yNl3gmCiJ19oPUXpfdOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oQrN0jZPmWjIyUFt7TZDpI6+PUUY0HxAfS7HqwvAUjI9j8W1jaDZGjLifmQw6cfxN
 ezPjT5aUtQVPo/IdQhjNXaZeonQF7kSgtWuZzbnHU+XIdJ0HX/3sTcXcQcOu08Fu+L
 Ufr5S22t1QJ99grgIsC65IW2z1qvGSobHtcN0qNMnCnWvicXpgIVvxl++i7f0JsO5d
 LxrQC0iTjOJ3olrO4bmV/lm3T9djPLKIjoLxZMWo1jtBTo/0o+g2T9830fAL17FEpm
 p1kIZN21aeU0tagTUYv9eUx3XsWFrW+/nWkDMqpPTGIzJH8F89t6hJDsKgbLgV/f84
 HxQrtSjJj774g==
Message-ID: <sashiko-outbox-226823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: Give each RK3588 video port its own
 cluster
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261121-vop2-axi-primary-v1-1-8d5c74905207@gmail.com>
References: <20261121-vop2-axi-primary-v1-1-8d5c74905207@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 08:15:30 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/rockchip: vop2: default zpos inversion for overlays in
  vop2_create_crtcs()
- [Medium] drm/rockchip: vop2: overlay planes and VP0+VP1 still violate
  AXI separation
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/rockchip: vop2: port node leak and UAF on error in
  vop2_create_crtcs() [1]
--

commit 7cc91c6d385e03fd7bff780807113fe9561a15db
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/rockchip: vop2: Give each RK3588 video port its own cluster

This commit assigns Cluster N as the primary plane for video port N on
RK3588 so that VP0 and VP2 do not share AXI0 for their primary planes.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 76d151b8bc52b..303d9b987a7c5 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2583,6 +2583,12 @@ static bool vop2_is_mirror_win(struct vop2_win *wi=
n)
>  	}
>  }
> =20
> +/* RK3588 primary per video port; Cluster0/1 on AXI0, Cluster2/3 on AXI1=
. */
> +static const u8 rk3588_vp_primary[] =3D {
> +	ROCKCHIP_VOP2_CLUSTER0, ROCKCHIP_VOP2_CLUSTER1,
> +	ROCKCHIP_VOP2_CLUSTER2, ROCKCHIP_VOP2_CLUSTER3,
> +};
> +
>  static int vop2_create_crtcs(struct vop2 *vop2)
>  {
>  	const struct vop2_data *vop2_data =3D vop2->data;
> @@ -2655,6 +2661,10 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			if (!(win->data->possible_vp_mask & BIT(vp->id)))
>  				continue;
> =20
> +			if (vop2->version =3D=3D VOP_VERSION_RK3588 &&
> +			    win->data->phys_id !=3D rk3588_vp_primary[vp->id])
> +				continue;
> +
>  			if (vop2_is_mirror_win(win))
>  				continue;

[Severity: Medium]
When an earlier video port is unused (such as VP0 + VP2 without VP1), does
skipping Cluster1-win0 here give the first overlay plane a lower default
zpos than VP2's primary plane?

vop2_win_init() assigns win->win_id sequentially (Cluster0..3 get 0..3),
and vop2_plane_init() sets each plane's initial zpos to win->win_id:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_plane_init() {
	...
	drm_plane_create_zpos_property(&win->base, win->win_id, 0,
				       vop2->registered_num_wins - 1);
	...
}

When VP1 is disabled, VP2 claims Cluster2-win0 (default zpos 2) as its
primary plane, while the unclaimed Cluster1-win0 (default zpos 1) is
registered as the first DRM_PLANE_TYPE_OVERLAY plane in the loop below. If
userspace enables that overlay plane on VP2 or VP3 without explicitly
setting zpos, drm_atomic_normalize_zpos() places the overlay underneath the
primary plane.

[Severity: Medium]
Does filtering only the primary plane loop actually keep a video port's
layers on one AXI bus, or avoid AXI0 sharing on VP0 + VP1 boards?

In the overlay loop right below, possible_crtcs is still computed solely
from win->data->possible_vp_mask (BIT(0) | BIT(1) | BIT(2) | BIT(3) for all
eight windows in rk3588_vop_win_data[]), and neither possible_crtcs nor
atomic_check restricts a video port's planes to one axi_bus_id. On a board
with VP0 and VP2 active and VP1 disabled, the skipped Cluster1-win0
(axi_bus_id 0) becomes the first overlay plane and can be attached directly
to VP2 alongside its Cluster2-win0 (axi_bus_id 1) primary plane, as can
Esmart0/1.

In addition, because rk3588_vp_primary[] maps VP0 to Cluster0 and VP1 to
Cluster1, dual-display RK3588 boards wired to VP0 and VP1 (such as Rock 5B,
Orange Pi 5 Plus/Max, and NanoPC-T6) still put both 4K primary planes on
AXI0.

[Severity: High]
This problem wasn't introduced by this patch, but if vop2_create_crtcs()
fails after acquiring port nodes or initializing planes or CRTCs [1],
does the early return leak vp->crtc.port references and leave freed planes
and CRTCs linked in drm->mode_config?

In the first loop, of_graph_get_port_by_id() stores a device_node reference
in vp->crtc.port, and the following loops link embedded win->base and
vp->crtc objects into drm->mode_config.plane_list and crtc_list. Returning
an error without calling vop2_destroy_crtcs() leaks the port nodes and
lets component_bind() free the devm-allocated struct vop2 while its planes
and CRTCs remain on drm_device, causing a use-after-free when
rockchip_drm_bind() unwinds through drm_mode_config_cleanup().

[1] https://sashiko.dev/#/bug/linux-81b4737a-b947-4652-ad38-8f28fe971257

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-vop2-axi-p=
rimary-v1-1-8d5c74905207@gmail.com?part=3D1
