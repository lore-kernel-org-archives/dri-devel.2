Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95773C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6710E6B1;
	Mon,  3 Aug 2026 15:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nuRCh46U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6891010E6B1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:04:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFD1E40797;
 Mon,  3 Aug 2026 15:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF11F1F000E9;
 Mon,  3 Aug 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785769452;
 bh=gM4FCMik/iz+q0x/G4qwU3gAFqWT2vo73/mhnzO0TOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nuRCh46UbOP1ZsLuj06TJi0JT2dukpRgVFoG0TikuvihaDg93qg0K16f5p69EzREY
 bS0+uieyGpWZluZMQPYxsq6B/Lw5/CBq1hprN2XhcYrp1cDCImjrmhR6kBvl2L19fW
 Zk1ZuBKDDLTZmV3RSGSezsnHGyzQKKhyf9F9YgdSBrnnuVwP2vVrsADiUuulcU79ny
 9Z5fMDsVsrrxy9QJwoU4UpwNdhxN/VwHiZfKRH8+zrg6jlDq/oukFU7imuy9FT1UUW
 h6dDGcbjn/oZm1i8Fsc7IhNfoFeLUSLoplmmRO4nuLDq1WKe9tUz5/ew0oX/m0zP+S
 z8oRgf/463F1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:04:12 +0000
Message-Id: <20260803150412.BF11F1F000E9@smtp.kernel.org>
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
- [High] Leaking an SRCU read lock on the error path in `sn65dsi83_reset_wo=
rk()` due to an early return without calling `drm_bridge_exit()`.
--

--- Patch [1]: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in =
sn65dsi83_reset_pipe() ---
commit d19637cc30dea31a13c6747fe2aa3733116ec5e5
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe()
   =20
Propagate the error code from drm_bridge_helper_reset_crtc(), so that
callers has a chance to handle the failure.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..476f255bd34dd 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn6=
5dsi83)
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
> =20
> -	return 0;
> +	return err;
>  }
> =20
>  static void sn65dsi83_reset_work(struct work_struct *ws)

[Severity: High]
Does propagating the error here cause an SRCU read lock leak?

By propagating the error from sn65dsi83_reset_pipe(), it is now possible
to hit the early return path in sn65dsi83_reset_work():

	if (!drm_bridge_enter(&ctx->bridge, &idx))
		return;

	/* Reset the pipe */
	ret =3D sn65dsi83_reset_pipe(ctx);
	if (ret) {
		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
		return;
	}

Because this early return skips the call to drm_bridge_exit(idx) at the
end of the function, wouldn't this leak the lock and cause a system hang
during drm_bridge_unplug() when synchronize_srcu() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-ti-sn65dsi=
83-fixes-v3-0-9b403a405ccd@geanix.com?part=3D1
