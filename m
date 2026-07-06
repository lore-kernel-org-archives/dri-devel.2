Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF1C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1BE10EAA0;
	Mon,  6 Jul 2026 19:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fGrVFPzW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BB210EAA0
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:49:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6656F600FC;
 Mon,  6 Jul 2026 19:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7601F000E9;
 Mon,  6 Jul 2026 19:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783367376;
 bh=VFcz+EfeTy4YSqnWqIN2EiXpeUhDbo6WJM77ir482ds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fGrVFPzWrjHZDvv71Rts8a3le6dwZpjLrPz4fDorhE8uDGxnB2m+KCY8oufLYJWH0
 A464OoBbHjDG2/ScwpVN6/IRaLTp/B3/0xeJBKSbydlaF0kt+YWSs7ejC17IftD5tQ
 XfwXf2KH9gvKD12g0dYMaoKZlI+ev26FggfyxigUh3LrIbaIwT3Fxph4CQd8eGB0TN
 xwbxL9SSDAWL1gJ2g7x2IOxu70RPfLrJ+xwCrvBmWVdNyBqwWsjG+87cHJX0qsppon
 I3yHV6HOEmamuxXSKyMv1YGrLqGZ8AtHi/TrSY/uJc8rqvrnDIZpynmXORZskqQ36f
 TzhkaM8+6E+wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] drm/rockchip: vop2: Balance state on
 atomic_enable error paths
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706-dw-hdmi-qp-yuv-v2-3-b91beb33dedf@collabora.com>
References: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
 <20260706-dw-hdmi-qp-yuv-v2-3-b91beb33dedf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 19:49:35 +0000
Message-Id: <20260706194935.AC7601F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Powering down VOP2 hardware on `atomic_enable` error causes a =
kernel panic when DRM core unconditionally proceeds to `atomic_update` and =
`atomic_flush`.

Pre-existing issues:
- [High] VBLANK events are leaked if `atomic_enable` fails, permanently han=
ging userspace waiting for a page flip completion.
--

commit 635b59397bdbb9526ef2f8c21f8fd4904f6e98d9
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Balance state on atomic_enable error paths

vop2_crtc_atomic_enable() prepares vp->dclk and calls vop2_enable(),
incrementing the shared vop2->enable_count before programming registers.
This commit attempts to fix a resource leak by reverting the setup on
failure, and tracking the per-VP bring-up state so atomic_disable() skips
teardown when atomic_enable() fails.

Link: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1033,6 +1033,9 @@ static void vop2_crtc_atomic_disable(struct drm_crt=
c *crtc,
> =20
>  	vop2_lock(vop2);
> =20
> +	if (!vp->enabled)
> +		goto out_unlock;
> +

[Severity: High]
This is a pre-existing issue, but does this early return cause VBLANK
events to be leaked if atomic_enable() fails?

If atomic_enable() fails, drm_crtc_vblank_on() is skipped. The DRM core
still continues to atomic_flush(), which consumes the event and stores it:

vop2_crtc_atomic_flush() {
    ...
    if (crtc->state->event) {
        WARN_ON(drm_crtc_vblank_get(crtc));
        vp->event =3D crtc->state->event;
        crtc->state->event =3D NULL;
    }
    ...
}

Because the VBLANK interrupt wasn't enabled, it never fires to process
vp->event. When the CRTC is eventually disabled, this new early return
bypasses the teardown and ignores the trapped vp->event. Could this cause
the userspace process waiting for the page flip completion to hang
indefinitely?

[ ... ]

> @@ -1965,6 +1971,18 @@ static void vop2_crtc_atomic_enable(struct drm_crt=
c *crtc,
> =20
>  	drm_crtc_vblank_on(crtc);
> =20
> +	vp->enabled =3D true;
> +
> +	vop2_unlock(vop2);
> +
> +	return;
> +
> +err_put_enable_count:
> +	if (!--vop2->enable_count)
> +		vop2_disable(vop2);
> +

[Severity: Critical]
Does powering down the VOP2 hardware on an atomic_enable() error cause a
synchronous external abort (bus hang)?

Since atomic_enable() returns void, the DRM core will unconditionally
proceed to call the atomic_update() and atomic_flush() callbacks even if
setup fails here. If vop2_disable() gates the core clocks, subsequent
unconditional MMIO accesses like this one in vop2_plane_atomic_update()
will access unclocked memory:

vop2_plane_atomic_update() {
    ...
    vop2_win_write(win, VOP2_WIN_AXI_BUS_ID, win->data->axi_bus_id);
    ...
}

Similar unconditional accesses happen in vop2_crtc_atomic_flush() when it
calls vop2_post_config(). Can this result in an immediate kernel panic on
transient clock setup failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-dw-hdmi-qp=
-yuv-v2-0-b91beb33dedf@collabora.com?part=3D3
