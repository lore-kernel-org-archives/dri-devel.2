Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72973C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B93010E88F;
	Mon, 31 Aug 2026 13:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c9mEH3Oq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F6D10E88F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:42:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BF506025F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76891F00A3F;
 Mon, 31 Aug 2026 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183753;
 bh=eRKcdDoTh5TPownunc5u8277SnhJWHOIovsr1ngI8RQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c9mEH3OqTKmVBoAeaXUPfpUaEdblNaQsiEclomKM1q2aX8yopBoWEsh356+Nx0p4i
 X5rwDksJBaK598WuvKXnolCdp1J+DkOGAPWbsHBt+HMbUnE+5Xqd+ov2/q/aepfbQa
 mR8o9OPspFg5qqmxzSYRhVhV+VGljVfdFOuTKI0EUH7FgxeIIwHXDja/Z1qgH2fTJU
 CgQUeUw7AmShQ0AhaeQ4Rbm3ePsNXfHvThoMzmoIPYB//6EDoyvf2kR2D4vd8FZSF2
 tg+HlvClYRlyYbLuLhPCjv14Q2MiTWGRDbu18ri62qKdWLCPd8eLhyYIBfjoqkwty1
 AmawLLwQXeUkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/panel/tdo-tl070wsh30: Use refcounted
 allocation in place of devm_kzalloc()
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-24-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-24-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:42:32 +0000
Message-Id: <20260831134232.E76891F00A3F@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `drm_panel_remove()` in the error path of `mipi_dsi_attach=
()` causes list corruption and use-after-free.
--

commit 31f5775c1776d598f0568c50d1a4cecc265d2e88
Author: Albert Esteve <aesteve@redhat.com>
drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of devm_kzallo=
c()

This patch migrates the driver to use the devm_drm_panel_alloc API instead
of devm_kzalloc. This adds refcounted allocation to the panel to prevent
use-after-free bugs during unbind operations.

Link: https://patch.msgid.link/20260508-drm_panel_init_rm-v2-6-0bd4ac429971=
@redhat.com

> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/d=
rm/panel/panel-tdo-tl070wsh30.c
> index 227f97f9b136f..13cfe252a838d 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
[ ... ]
> @@ -183,10 +180,13 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_d=
si_device *dsi)
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
>  	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | M=
IPI_DSI_MODE_LPM;
> =20
> -	tdo_tl070wsh30 =3D devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
> -				    GFP_KERNEL);
> -	if (!tdo_tl070wsh30)
> -		return -ENOMEM;
> +	tdo_tl070wsh30 =3D devm_drm_panel_alloc(&dsi->dev,
> +					      __typeof(*tdo_tl070wsh30), base,
> +					      &tdo_tl070wsh30_panel_funcs,
> +					      DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(tdo_tl070wsh30))
> +		return PTR_ERR(tdo_tl070wsh30);
> =20
>  	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
>  	tdo_tl070wsh30->link =3D dsi;
>=20
> 	err =3D tdo_tl070wsh30_panel_add(tdo_tl070wsh30);
> 	if (err < 0)
> 		return err;
>=20
> 	return mipi_dsi_attach(dsi);
> }

[Severity: High]
This is a pre-existing issue, but does this error path lead to a use-after-=
free
if mipi_dsi_attach fails?

During tdo_tl070wsh30_panel_probe, the panel is added to the global list in=
side
tdo_tl070wsh30_panel_add via drm_panel_add.

If mipi_dsi_attach fails (which can happen due to probe deferral when the D=
SI
host is not yet ready), the error is returned directly. The driver core will
then unwind the devm resources, and the action registered by
devm_drm_panel_alloc drops the kref and frees the panel memory.

However, since drm_panel_remove is never called on this error path, the fre=
ed
panel memory remains linked in the global panel_list. The next time the lis=
t is
traversed, the kernel could dereference the freed memory, causing a crash.

Should there be a call to drm_panel_remove to safely remove the panel from =
the
list before returning the error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-24-sashal@kernel.org?part=3D1
