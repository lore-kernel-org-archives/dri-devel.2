Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5790DC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D8810E6E3;
	Mon,  3 Aug 2026 15:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k/8Es9DA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B667F10E6E3
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:28:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AADE760A7D;
 Mon,  3 Aug 2026 15:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C061F000E9;
 Mon,  3 Aug 2026 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785770907;
 bh=+sRe82nG65BNEK3JUG/9vekdHzbeJdLGMoJeX0EyzLI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k/8Es9DAPlV7OqtKuKxj+HqurD+jLrkDpGNcXh9haqfss0SmN2m6AzaQJWVuZMPd5
 HFJoSHOLfBVb4er4iVrVM6XHLvkz9bLVfSPQLF5V+t/uXWsBKsuVxuQLGHple0+JmO
 aSyO5+kWPybyIWZ1YZz54RtUFuOGd1ulWtdLJ2EMf+yaAovlfuVNy0fvvTR3D7f+xx
 TNuBvJIUGJG7qP8wXlWDfv+h20Q4Z5pX2M1HlsUolk4af0MXewe+ps5HUyvY9taURy
 lqvO5TE3GAX981dPhE/gLD2I+TfTaDBIUmDlyzVz5JpzpeyeuE9U6DouXrqmqC1pQw
 tSGQjhiPwuziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:28:26 +0000
Message-Id: <20260803152827.37C061F000E9@smtp.kernel.org>
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
- [Medium] Handling `nwl_dsi_mode_set()` error by jumping to `runtime_put` =
causes a `pm_runtime` usage counter underflow.
--

--- Patch [4]: [PATCH v2 4/4] drm/bridge: nwl-dsi: Add error handling of nw=
l_dsi_mode_set() ---
commit 7d9af739876057a4f21f4e98151a3fe153456a02
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Add error handling of nwl_dsi_mode_set()

This commit introduces error handling for nwl_dsi_mode_set() in
nwl_dsi_bridge_mode_set(). If the function fails, it jumps to the
runtime_put label to release the PM runtime reference.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 226036d22e3f8..08e87d166b17a 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -942,7 +942,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	}
> =20
>  	/* Step 2 from DSI reset-out instructions */
> -	nwl_dsi_mode_set(dsi);
> +	ret =3D nwl_dsi_mode_set(dsi);
> +	if (ret < 0)
> +		goto runtime_put;

[Severity: Medium]
Since nwl_dsi_bridge_mode_set() returns void, does the DRM core know that t=
his
setup failed?

If the DRM core continues treating the bridge as active, it will unconditio=
nally
call nwl_dsi_bridge_atomic_disable() during teardown, which also drops the
reference:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_bridge_atomic_disable() {
	...
	pm_runtime_put(dsi->dev);
	...
}

Could this double-put cause a pm_runtime usage counter underflow, since we=
=20
already dropped the reference in this new error path?

> =20
>  	/* Step 3 from DSI reset-out instructions */
>  	ret =3D reset_control_deassert(dsi->rst_esc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-nwl-dsi-fi=
xes-v2-0-1809a0ac453f@geanix.com?part=3D4
