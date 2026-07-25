Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFDFC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7293510F50C;
	Sat, 25 Jul 2026 05:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C0Bv2Ld4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678BD10F50C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:17:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 508CB40430;
 Sat, 25 Jul 2026 05:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E61F000E9;
 Sat, 25 Jul 2026 05:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956634;
 bh=Utnein2fnJxWftuwWQeGdjOhiB9dMIZV1q9PqnQrr98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C0Bv2Ld40wQ6+8vikGOaoSPlyWlzyzUAZvzV0WPqrzN784v6ooPSmkEpqV6WFnNAh
 3x0H/uGa83P6nqOEW0A4k9+BZgsT9bfY/yes+XT13U0yHijA0M5prTtCjg/6Y2Tt/F
 eAbG8eEDTRmNZ5ugwQvjwBQX6eYq3xhz2G/w9paOr9G39DtJYn2T0xjHHtuMneJlR6
 YJt9TlPxwnSXtyKIqXpFs98c5sMknkdDQrRheydjraXz6K/74RA75D4uyisCudat6j
 h2AgvMXb1POCuR0bTqB2nU2XoX0EuSlpP50SxZEM9twWjsgsCvAW5z48xPKWLbmIy5
 mdfjA8XQo8Ccg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] drm/spacemit: add Saturn DPU DRM device driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724-k3-display-v1-11-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-11-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:17:13 +0000
Message-Id: <20260725051713.B60E61F000E9@smtp.kernel.org>
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
- [High] Missing IS_ERR() check for 'match' causes an ERR_PTR dereference i=
nside component_master_add_with_match().
- [Medium] The atomic commit tail stalls the commit pipeline by waiting for=
 flip completion before signaling hardware done.
--

--- Patch [11]: [PATCH 11/17] drm/spacemit: add Saturn DPU DRM device drive=
r ---
commit e12174b9614adeccb5a06f03b5944837004e96f4
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU DRM device driver

This commit adds the DRM device for the SpacemiT K3 Saturn display processi=
ng
unit. The SoC has two DPU instances, each driving one CRTC that scans out a
single primary plane in linear RGB, feeding a downstream DP/eDP controller
over an OF-graph endpoint.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c b/drivers/gpu/drm/sp=
acemit/spacemit_drm.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */

[ ... ]

> +static void spacemit_drm_atomic_commit_tail(struct drm_atomic_commit *ol=
d_state)
> +{
> +	struct drm_device *dev =3D old_state->dev;
> +
> +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> +
> +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> +
> +	drm_atomic_helper_commit_planes(dev, old_state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> +
> +	drm_atomic_helper_wait_for_flip_done(dev, old_state);
> +
> +	drm_atomic_helper_commit_hw_done(old_state);

[Severity: Medium]
Does calling drm_atomic_helper_wait_for_flip_done() before
drm_atomic_helper_commit_hw_done() stall the commit pipeline?

By waiting for the flip completion before signaling hardware done, the CPU =
work
for the next frame (such as state preparation and buffer pinning) is blocked
until the hardware flip completes.

Should commit_hw_done() be called before wait_for_flip_done() to avoid
degrading atomic commit performance?

> +
> +	drm_atomic_helper_cleanup_planes(dev, old_state);
> +}

[ ... ]

> +int spacemit_drm_of_component_probe(struct device *dev)
> +{
> +	struct device_node *ports, *port, *ep;
> +	struct device_node *remote;
> +	struct component_match *match =3D NULL;

[ ... ]

> +	for_each_child_of_node(ports, port) {
> +		if (!of_node_name_eq(port, "port"))
> +			continue;
> +		for_each_child_of_node(port, ep) {
> +			if (!of_node_name_eq(ep, "endpoint"))
> +				continue;
> +			remote =3D of_graph_get_remote_port_parent(ep);
> +			if (!remote)
> +				continue;
> +			if (of_device_is_available(remote))
> +				drm_of_component_match_add(dev, &match,
> +							   compare_of, remote);
> +			of_node_put(remote);
> +		}
> +	}
> +	of_node_put(ports);
> +
> +	if (!match) {
> +		dev_err(dev, "no downstream component available\n");
> +		return -ENODEV;
> +	}
> +
> +	return component_master_add_with_match(dev, &spacemit_drm_master_ops,
> +					       match);

[Severity: High]
Can match be an ERR_PTR here instead of just NULL?

If memory allocation fails inside drm_of_component_match_add(), it can set
the match pointer to an ERR_PTR. Since the code only checks if (!match), an
error pointer would bypass this check and be passed directly to
component_master_add_with_match().

Looking at component_master_add_with_match(), it immediately accesses the
pointer:

drivers/base/component.c:component_master_add_with_match() {
    ...
	/* Reallocate the match array for its true size */
	ret =3D component_match_realloc(match, match->num);
    ...
}

Should this code check IS_ERR(match) to prevent a potential kernel panic
under memory pressure?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D11
