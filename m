Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A96CA9EC5
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 00:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C986B10E081;
	Sun, 11 Oct 2026 00:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g+hUdQgs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB98F10E081
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:56:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C71C660018;
 Sun, 11 Oct 2026 00:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A84B1F000FF;
 Sun, 11 Oct 2026 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791680204;
 bh=EJaRq5VLVpexPsCNG6md8X8pDtNa7WirTlBJ7J4XteE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g+hUdQgsOJcF16/eSoEzD3CjXCK3KXr6cA1qWWIlo/z5e7DxWalqzL6qRwxeJUkm2
 1E3mBZRqmk5bLunDX1z7p2YrXgQjNuORNXj0ix4CCwpTiAgviTMeVLRLL50h3Ap242
 pPIRkvjcjOvoRzJRWdpKADNKVtOfypSc2F1BkgIV7Fdsg1tpfBdELJBRRcTBe/VrbJ
 ZUITqB7W4BomUfPjmm94/JcaHoKWGGuYG3sdm7eKbQmTIY7e1qiiANeRiNeUjyCCaf
 ZxVf8yiUH89788EfZYnBk8e02t81yF6jT3T2EQdAGyAC5bjitX4GeoPjwah5mNj2Ef
 DkQUeqgUAs4Qg==
Message-ID: <sashiko-outbox-166953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/mediatek: mtk_crtc: Pick the connector route on
 every CRTC enable
To: zoan37 <agentzoan@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011004248.1117649-4-agentzoan@gmail.com>
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-4-agentzoan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 00:56:43 +0000
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
- [Medium] drm/mediatek: data race on ddp_comp array in mtk_crtc_mode_valid
--

commit 932f98864769c15d84bbf97b7de7de8b563c5923
Author: zoan37 <agentzoan@gmail.com>

drm/mediatek: mtk_crtc: Pick the connector route on every CRTC enable

mtk_crtc_update_output() only picks the output component of a CRTC
with connector routes when connectors_changed is set in the commit that
enables the CRTC. But connectors_changed only says that the connectors
changed in that commit, not since the CRTC was last enabled. A connector
can be attached to (or moved to) the CRTC while it is inactive, and the
later commit that only sets ACTIVE then has active_changed but not
connectors_changed:

- If the CRTC had never been enabled, the route slot is still NULL and
  mtk_crtc_ddp_hw_init() dereferences it (mtk_ddp_comp_clk_enable()
  and so on).
- If the CRTC was driven through another route before, e.g. a CRTC
  shared by an HDMI bridge on DSI and a DisplayPort output that is
  switched off (DPMS) while the monitor moves from one to the other,
  the pipeline is set up for the old output.

update_output() only runs from atomic_enable and the lookup is a short
loop over the routes, so do it on every enable.

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 704931b369b6f..0bfd17f682826 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -695,9 +695,6 @@ static void mtk_crtc_update_output(struct drm_crtc *c=
rtc,
>  	struct mtk_drm_private *priv;
>  	unsigned int encoder_mask =3D crtc_state->encoder_mask;
> =20
> -	if (!crtc_state->connectors_changed)
> -		return;
> -

[Severity: Medium]
Does removing this guard expose a data race on the ddp_comp array in
mtk_crtc_mode_valid()?

A non-blocking atomic commit executes mtk_crtc_atomic_enable() asynchronous=
ly
via the commit_tail worker, which does not hold dev->mode_config.mutex.

This calls mtk_crtc_update_output(), which modifies the array using plain
non-atomic assignment:

mtk_crtc_update_output()
	mtk_crtc->ddp_comp[mtk_crtc->ddp_comp_nr - 1] =3D comp;

Concurrently, unprivileged userspace can issue DRM_IOCTL_MODE_GETCONNECTOR,
which acquires mode_config.mutex and invokes
drm_helper_probe_single_connector_modes().

This iterates over all possible CRTCs and calls mtk_crtc_mode_valid(), which
reads the entire ddp_comp array without READ_ONCE():

mtk_crtc_mode_valid()
	for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
		status =3D mtk_ddp_comp_mode_valid(mtk_crtc->ddp_comp[i], mode);

Could this lead to undefined behavior, KCSAN splats, or a crash if compiler
optimization splits the pointer read in the inlined mtk_ddp_comp_mode_valid=
()
function?

>  	if (!mtk_crtc->num_conn_routes)
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011004248.1117=
649-1-agentzoan@gmail.com?part=3D3
