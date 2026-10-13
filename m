Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48ECC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CFE10E96C;
	Tue, 13 Oct 2026 15:35:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31D710E96C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1484360A56;
 Tue, 13 Oct 2026 15:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939031F00893;
 Tue, 13 Oct 2026 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791905732;
 bh=dGd5Gch1nVmAvkJWGgrkzeaMclYoGL/rEiMkZMWvh4s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ms1zlcCqrUSRBeCcxLGb8YmEbaMHUJb6xXRuL7CtqMkMgq1JtaASvAqqJSFtw/LF9
 uyMsQTxhv+Vv35gPXi11A2ml5eUciRPLZ6YY5xy5Hq6UDxntTPnHLypIYhDc62HFpL
 e+amU9l//qdrswPigKyNybfVY8lG5iUbLKapFfmxV4bJPj3AR4KNqL59mTwtTl4ikx
 kbWFvYNdvLrMRtPj8JqTg+3L7O8oRI2w0vGKcTsC6hqL0E0tCRrcmWVgdeCZ/frTIw
 7JmM2cf5MoBUEfij8q1rEYtXH4MJBwWeUs/uTwHzLccg0MW9Ek4fFmXkxVBs8UDK1J
 xp/e2rvikyxGQ==
Message-ID: <sashiko-outbox-170020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-drm-fix-of_get_bridge-build-regression-v3-2-0b4c0b65be82@bootlin.com>
References: <20261013-drm-fix-of_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com>
 <20261013-drm-fix-of_get_bridge-build-regression-v3-2-0b4c0b65be82@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:35:32 +0000
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
- [Medium] drm/vc4: reference leak of next_bridge on component unbind/rebind
--

commit 01a94378aeae8cb42a9f68ed6384a34ccaa162a0
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()

drmm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure it is put by using bridge.next_bridge.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 0148f2befed14..675bd0fc13913 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
[ ... ]
> @@ -1775,9 +1774,13 @@ static int vc4_dsi_bind(struct device *dev, struct=
 device *master, void *data)
>  	if (ret)
>  		return ret;
> =20
> +	dsi->bridge.next_bridge =3D drm_bridge_get(next_bridge);
> +

[Severity: Medium]
Does this code introduce a regression that leaks the bridge reference across
component unbind/rebind cycles?

During component unbind, vc4_dsi_release_action() only drops the reference
to dsi->bridge acquired during bind:

static void vc4_dsi_release_action(struct drm_device *drm, void *ptr)
{
	struct vc4_dsi *dsi =3D ptr;

	drm_bridge_put(&dsi->bridge);
}

Because dsi->bridge outlives the component unbind, __drm_bridge_free() is
not executed, and the reference to next_bridge is not automatically release=
d.

When the component is subsequently rebound, vc4_dsi_bind() overwrites
dsi->bridge.next_bridge here without freeing the previous pointer,
permanently leaking the bridge reference. Does next_bridge need to be
explicitly cleared in the teardown path?

>  	ret =3D drm_bridge_attach(encoder, &dsi->bridge, NULL, 0);
> -	if (ret)
> +	if (ret) {
> +		drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
>  		return ret;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-drm-fix-of=
_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com?part=3D2
