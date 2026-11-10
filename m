Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71F606CF54
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avDh0Ofj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9B210EE75;
	Tue, 10 Nov 2026 07:59:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE50110EE7D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:58:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEAD9637A0;
 Tue, 10 Nov 2026 07:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C71F008A7;
 Tue, 10 Nov 2026 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794297537;
 bh=zzl3qN3jrfIkaTF6gZFYkVfpQftBFSdaR3BrqSMTGDw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=avDh0OfjwdY5zh+JT5IMeSY270sx3k1YXQtowb2PEG3mtQgBLMYlTpaL+eT6mSPW5
 KfTNZHUcRVddl9l7EcQ+c1XC/t4nGx8MsGyM0blItTVpWUZeKrYY4khrFl/JvU/k3y
 oEGcuNp5UbAfpRFMwB5ZAHKy+vuJIjrovuXD2AZ6GoDgnF6RiHk9lcuh4oUy/vKeB/
 bgyMTJxWBTLaR//CnFoA3pMsKnYj9O9WOdyGNXrL/9ljLc8JKT3mlYLjYMWnzv0ZzJ
 /ISIaM0e5StQtSgphNIuNZudMILG5Fk9r0pKW3QqT9zmetPRNyoZjzyLZgddFwsfEk
 Dj/P0lGe95xtg==
Message-ID: <sashiko-outbox-206550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] drm/rockchip: vop2: Balance window fetches across
 both AXI ports on RK3588
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vop2-fixes-v1-4-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-4-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:58:56 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/rockchip: vop2: plane commit order skews
  vop2_win_get_axi_bus()
- [Medium] drm/rockchip: vop2: vop2_plane_atomic_update() omits UV plane
  AXI load
- [Medium] drm/rockchip: vop2: premature AXI bus release in
  vop2_win_put_axi_bus()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/rockchip: vop2: wrong GEM object for UV plane in
  vop2_plane_atomic_update() [1]
--

commit d091a328bc345e54d430e0882d6dfc1be033a2f5
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/rockchip: vop2: Balance window fetches across both AXI ports on RK3588

This commit dynamically assigns newly enabled VOP2 windows on RK3588 to the
least loaded of the two AXI read ports while avoiding AXI read ID collisions
with other active windows.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 629ea7f112502..9aeb90c6aa4b1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1231,6 +1231,98 @@ static int vop2_plane_atomic_check(struct drm_plan=
e *plane,

[ ... ]

> +static u8 vop2_win_get_axi_bus(struct vop2_win *win, u64 load)
> +{
> +	struct vop2 *vop2 =3D win->vop2;
> +	u64 bus_load[VOP2_SYS_AXI_BUS_NUM] =3D { };
> +	bool clash[VOP2_SYS_AXI_BUS_NUM] =3D { };
> +	u8 def =3D win->data->axi_bus_id;
> +	unsigned long flags;
> +	u8 bus =3D def;
> +	int i;
> +
> +	if (!(vop2->data->feature & VOP2_FEATURE_AXI_BALANCE))
> +		return def;
> +
> +	spin_lock_irqsave(&vop2->axi_lock, flags);
> +
> +	if (win->axi_active) {
> +		win->axi_load =3D load;
> +		bus =3D win->axi_bus;
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < vop2->registered_num_wins; i++) {
> +		struct vop2_win *w =3D &vop2->win[i];
> +
> +		if (w =3D=3D win || !w->axi_active)
> +			continue;
> +
> +		bus_load[w->axi_bus] +=3D w->axi_load;
> +		if (vop2_win_axi_ids_clash(win, w))
> +			clash[w->axi_bus] =3D true;
> +	}
> +
> +	if (!clash[def ^ 1] &&
> +	    (clash[def] || max(bus_load[def ^ 1] + load, bus_load[def]) <
> +			   max(bus_load[def] + load, bus_load[def ^ 1])))
> +		bus =3D def ^ 1;
> +
> +	WARN_ON_ONCE(clash[bus]);
> +
> +	win->axi_bus =3D bus;
> +	win->axi_load =3D load;
> +	win->axi_active =3D true;
> +out:
> +	spin_unlock_irqrestore(&vop2->axi_lock, flags);
> +
> +	return bus;
> +}

[Severity: Medium]
Does vop2_win_get_axi_bus() see stale axi_active and axi_load state for
higher-indexed planes changed in the same atomic commit?

drm_atomic_helper_commit_planes() runs a single loop in ascending plane
index order, calling atomic_disable() or atomic_update() on each plane.
In rk3588_vop_win_data, all windows that default to AXI0 (Cluster0/1,
Esmart0/1) have lower indices than their AXI1 mirrors (Cluster2/3,
Esmart2/3).  When a commit enables Esmart0 while disabling Esmart2 (or
another higher-indexed plane on AXI1), vop2_win_get_axi_bus() runs for
Esmart0 before vop2_plane_atomic_disable() clears Esmart2's axi_active.
It therefore sees Esmart2's old load and read-ID clash on AXI1 and pins
Esmart0 to AXI0 alongside Cluster0 for as long as Esmart0 remains enabled,
causing the POST_BUF_EMPTY underflows this patch aims to avoid.

> +
> +static void vop2_win_put_axi_bus(struct vop2_win *win)
> +{
> +	struct vop2 *vop2 =3D win->vop2;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vop2->axi_lock, flags);
> +	win->axi_active =3D false;
> +	win->axi_load =3D 0;
> +	spin_unlock_irqrestore(&vop2->axi_lock, flags);
> +}
> +
>  static void vop2_plane_atomic_disable(struct drm_plane *plane,
>  				      struct drm_atomic_commit *state)
>  {
> @@ -1241,6 +1333,8 @@ static void vop2_plane_atomic_disable(struct drm_pl=
ane *plane,
> =20
>  	drm_dbg(vop2->drm, "%s disable\n", win->data->name);
> =20
> +	vop2_win_put_axi_bus(win);
> +
>  	if (state)
>  		old_pstate =3D drm_atomic_get_old_plane_state(state, plane);

[Severity: Medium]
Can clearing win->axi_active in vop2_plane_atomic_disable() cause an AXI
read ID collision before the disable is latched at VSYNC?

VOP2_WIN_ENABLE is a shadow register latched at the video port's next
VSYNC, so the disabled window keeps fetching over win->axi_bus until then.
If Esmart0 is on AXI1 on VP0 and is disabled while its mirror Esmart2
(which shares read IDs 0x0a and 0x0b) is enabled on VP1,
vop2_win_get_axi_bus() sees Esmart0->axi_active =3D=3D false and assigns
Esmart2 to AXI1.  If VP1's VSYNC fires before VP0's VSYNC, both windows
fetch on AXI1 with identical read IDs until VP0 latches the disable.

> @@ -1416,7 +1510,9 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
>  		afbc_en ? "AFBC" : "", &yrgb_mst);
> =20
>  	if (vop2->version > VOP_VERSION_RK3568) {
> -		vop2_win_write(win, VOP2_WIN_AXI_BUS_ID, win->data->axi_bus_id);
> +		u64 load =3D (u64)src_w * src_h * bpp / 8 * drm_mode_vrefresh(adjusted=
_mode);
> +
> +		vop2_win_write(win, VOP2_WIN_AXI_BUS_ID, vop2_win_get_axi_bus(win, loa=
d));
>  		vop2_win_write(win, VOP2_WIN_AXI_YRGB_R_ID, win->data->axi_yrgb_r_id);
>  		vop2_win_write(win, VOP2_WIN_AXI_UV_R_ID, win->data->axi_uv_r_id);
>  	}

[Severity: Medium]
Does computing load from bpp omit the UV plane bandwidth for multi-planar
YUV formats?

bpp comes from vop2_get_bpp(fb->format), which falls back to
drm_format_info_bpp(format, 0) and returns only plane 0's bits per pixel:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_get_bpp() {
	switch (format->format) {
	case DRM_FORMAT_YUV420_8BIT:
		return 12;
	case DRM_FORMAT_YUV420_10BIT:
		return 15;
	case DRM_FORMAT_VUY101010:
		return 30;
	default:
		return drm_format_info_bpp(format, 0);
	}
}

For semi-planar formats such as NV12, NV16 or NV24, plane 1 is fetched
through the same AXI port via VOP2_WIN_AXI_UV_R_ID, but bpp only counts
the Y plane (8 or 10 bpp instead of 12 to 30 bpp), underestimating
win->axi_load by 33% to 67%.

[Severity: High]
This problem wasn't introduced by this patch, but earlier in
vop2_plane_atomic_update() the UV plane DMA address is computed from
fb->obj[0] instead of fb->obj[1] [1]:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_plane_atomic_update() {
	...
	rk_obj =3D to_rockchip_obj(fb->obj[0]);

	yrgb_mst =3D rk_obj->dma_addr + offset + fb->offsets[0];
	if (fb->format->is_yuv) {
		...
		rk_obj =3D to_rockchip_obj(fb->obj[0]);
		uv_mst =3D rk_obj->dma_addr + offset + fb->offsets[1];
	}
}

When a multi-planar YUV framebuffer has separate GEM objects for the Y and
UV planes, VOP2_WIN_UV_MST is programmed with plane 0's DMA base address
plus plane 1's offset, causing corrupted scanout or out-of-bounds DMA
reads past fb->obj[0].

[1] https://sashiko.dev/#/bug/linux-46433ab8-0e41-4994-af45-5dfb41ba7894

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vop2-fixes=
-v1-0-d336e9dd90d3@gmail.com?part=3D4
