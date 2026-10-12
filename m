Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F7CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365D310F1C6;
	Mon, 12 Oct 2026 15:20:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4250210E323;
 Mon, 12 Oct 2026 15:20:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77AE560233;
 Mon, 12 Oct 2026 15:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24CF1F0089B;
 Mon, 12 Oct 2026 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818444;
 bh=+jKo+edBr0ZCx9dqghVy/8u7UGh3G0k/EfZb3lqwgeg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aq9Acq6djEIMz811v7U2qBrRbOAEealKsIGqrFEbDRuRL+WYjmuGUilB6esK41o5z
 miqPJXncDkmb02KvKekw59nIjf/D7xnM1t1Z3KuCN9n+z0qdMrky3RmoAOnMPZ2zN2
 TpdrA2u1XW+7gkrXBi68nrZmEGNYid+3wjMD5NPNtdFRuk1cZ6nXCaBlwqWcdNRoWA
 GMFSfxwETwrS6dwnF/shI5cG/Yz+MZcfdyLbDleT5Jx17j2xthCeSoZVboOCUSKNRm
 ME0/IAiEb+kJBq81TMBcIX2+irWfpbCd3VOTqHqZtFEglcQ83spbVj2eP1owWfG8jb
 S/BPleKS0YuMw==
Message-ID: <sashiko-outbox-168325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 6/8] drm/bridge: Expose link training state via
 new DRM_BRIDGE_OP_DP flag
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-6-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-6-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:20:43 +0000
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
- [High] drm: Probe failure for DP pipelines ending in non-DP connectors
--

commit 1f392a73217bd39ddc3ecb68c1400cefdd77a913
Author: Kory Maincent <kory.maincent@bootlin.com>
Subject: drm/bridge: Expose link training state via new DRM_BRIDGE_OP_DP fl=
ag

This commit introduces DRM_BRIDGE_OP_DP, a new bridge operation flag for
bridges that provide DisplayPort connector operations with link training
support. Bridges advertising this flag must fill the dp_link_caps field
with their link capabilities.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
[ ... ]
> @@ -1079,6 +1097,17 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  					       connector_type, ddc);
>  		if (ret)
>  			return ERR_PTR(ret);
> +	} else if (bridge_connector->bridge_dp) {
> +		ret =3D drmm_connector_init(drm, connector,
> +					  &drm_bridge_connector_funcs,
> +					  connector_type, ddc);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		ret =3D drm_dp_source_set_caps(connector,
> +					     bridge_connector->bridge_dp->dp_link_caps);
> +		if (ret)
> +			return ERR_PTR(ret);

[Severity: High]
Does this cause a probe failure for DisplayPort pipelines that end in a non=
-DP
connector?

Earlier in drm_bridge_connector_init(), the final connector_type is determi=
ned
by the last bridge in the chain. If a display pipeline ends with an active=
=20
converter (like a DP-to-VGA or DP-to-LVDS bridge), the resulting connector=
=20
type will be non-DP (e.g., DRM_MODE_CONNECTOR_VGA).

However, this block unconditionally calls drm_dp_source_set_caps() as long =
as=20
any upstream bridge advertises DRM_BRIDGE_OP_DP and there is no HDMI bridge.

Looking at drm_dp_source_set_caps() in drm_dp_helper.c, it has a strict che=
ck
for the connector type:

	if (!(connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
	      connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP))
		return -EINVAL;

If the pipeline ends in a VGA or LVDS connector, this will return -EINVAL,
which is then propagated up by drm_bridge_connector_init(), causing the ent=
ire
display pipeline initialization to fail for otherwise valid bridge chains.

Could we add a check here to ensure the connector type is actually DP or eD=
P=20
before calling drm_dp_source_set_caps()?

>  	} else {
>  		ret =3D drmm_connector_init(drm, connector,
>  					  &drm_bridge_connector_funcs,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D6
