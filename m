Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AD2CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126EC10EEF2;
	Wed, 24 Jun 2026 12:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dsppSV9V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8586310EEF2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:31:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA6E9601FC;
 Wed, 24 Jun 2026 12:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2161F000E9;
 Wed, 24 Jun 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782304298;
 bh=MCthOd3Um/cxAv6THxFutEBI/SJXQ365jPYZDTkO0EU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dsppSV9VdbQYXNnXqlgW5YIs3bmT0pzhVpJMDrmi49N1vzSTqLpCCCU/9k6A5s8Dt
 jNqwaQihoo3WYRoRD2GFe0opmWeoOVh5jtjLgMkFGGoMPN9SCOJ1LAoCxRB2KZtL9b
 gAef5ZXWjC8RrEElOPlWquk2UBgGLIYxBqfazhRZpOKoSAiiNcE6NBjK1Co27kYNor
 NR8d7uoP8Oh85NKbCvUuS8ChmIxCF/5nB/84HN6I35MOky/gNlc6ZwZxRb7kCZCfEM
 bbBpH16vK86/rgpFZk256rkMIiYb+/GKo90mXq3Q9b0H20qubtK1P57ILDGqqFOlA6
 Cz6DFNmKWyC2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/bridge: tc358767: register DP aux bus even in
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
References: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 12:31:37 +0000
Message-Id: <20260624123138.7D2161F000E9@smtp.kernel.org>
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
- [High] The bridge detach function `tc_edp_bridge_detach` does not call `d=
rm_connector_cleanup()` for the connector initialized in `tc_edp_bridge_att=
ach()`, leading to a use-after-free when the module unloads.
--

commit 29555064108dbff74cdded5aeba9baee8adfd8a7
Author: Alexander Stein <alexander.stein@ew.tq-group.com>

drm/bridge: tc358767: register DP aux bus even in DRM_BRIDGE_ATTACH_NO_CONN=
ECTOR case

This commit changes the bridge attach sequence to always register the DP aux
bus. It achieves this by moving the check for the no-connector flag to after
the aux registration is complete.

> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index 7188935fdb826..a1663cc6c2236 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1833,14 +1833,14 @@ static int tc_edp_bridge_attach(struct drm_bridge=
 *bridge,
>  			return ret;
>  	}
> =20
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> -		return 0;
> -
>  	tc->aux.drm_dev =3D drm;
>  	ret =3D drm_dp_aux_register(&tc->aux);
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> +		return 0;
> +
>  	/* Create DP/eDP connector */
>  	drm_connector_helper_add(&tc->connector, &tc_connector_helper_funcs);
>  	ret =3D drm_connector_init(drm, &tc->connector, &tc_connector_funcs, tc=
->bridge.type);

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing issue. Does
tc_edp_bridge_detach() properly clean up the connector initialized here?

Looking at the detach function in drivers/gpu/drm/bridge/tc358767.c:

static void tc_edp_bridge_detach(struct drm_bridge *bridge)
{
	drm_dp_aux_unregister(&bridge_to_tc(bridge)->aux);
}

It seems drm_connector_cleanup() is never called for tc->connector.

Since tc_data (which embeds the connector) is allocated via devm_kzalloc,
could the freed connector remain linked in the active drm_device connector
list when the driver is unbound?

Would this cause a use-after-free if the DRM core accesses the connector li=
st
after the module is unloaded or unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624121515.2301=
219-1-alexander.stein@ew.tq-group.com?part=3D1
