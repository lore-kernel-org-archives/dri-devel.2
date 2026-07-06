Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5172C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0580410E277;
	Mon,  6 Jul 2026 13:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cEknt/wx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E062710E277
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:55:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10D7560098;
 Mon,  6 Jul 2026 13:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD41F000E9;
 Mon,  6 Jul 2026 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783346113;
 bh=q7zlp4wnd6FwHx0pQkEWcDS5OW9sgYHEkUPlwvbCfVw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cEknt/wx+P55pWXrCbhbCwELLXhDPgotUR4cDdpIK0d1QfG+ASdqO65FuERJf3sgj
 xhc/s7BNJgBplL6zHYeD3wHfaHY8uDn9Hj1TD+qXq2QUJwgr8OWlivU92L8GC/j7ml
 RpMzem2BONCSZIwq+ldUB6c0oJ44nArbUdcA4BkkHN//pStQYdcbxnV3yqxrPd0iG1
 fVP68wrfpfR7A3ptU7adQwIxb4jcl9broBupvatlXh0BJI84+X5PcZ4RiMIF7A3GRe
 34grJvW97XsWUWoJ2k9esL0sm3RNsFIYy2Ss85JrXr7HZeK245lViiPbAD2K5AEEms
 p1FvjfhCbwbWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] gpu/drm: Remove unused *dev parameter from
 drm_mode_destroy function
To: "Jan Niedziolka" <j.niedziolka@samsung.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706134515.3369960-2-j.niedziolka@samsung.com>
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968@eucas1p2.samsung.com>
 <20260706134515.3369960-2-j.niedziolka@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:55:13 +0000
Message-Id: <20260706135513.8FFD41F000E9@smtp.kernel.org>
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
- [Low] Unused local variables `dev` and `vbox_connector` due to the remova=
l of the `dev` parameter from `drm_mode_destroy()`.
--

commit 9caafe56634afb7bf9e65d116788497811b64f48
Author: Jan Niedziolka <j.niedziolka@samsung.com>

gpu/drm: Remove unused *dev parameter from drm_mode_destroy function

This commit removes the unused dev parameter from the drm_mode_destroy
function prototype and updates all callers across the tree to match.

[ ... ]

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vbox=
video/vbox_mode.c
> index 8e4e5fc9d3c5a..fbe5c2382983e 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -782,7 +782,7 @@ static int vbox_fill_modes(struct drm_connector *conn=
ector, u32 max_x,
>  	dev =3D vbox_connector->base.dev;
>  	list_for_each_entry_safe(mode, iterator, &connector->modes, head) {
>  		list_del(&mode->head);
> -		drm_mode_destroy(dev, mode);
> +		drm_mode_destroy(mode);

[Severity: Low]
Since the dev parameter was removed from drm_mode_destroy(), are the dev and
vbox_connector variables now completely unused in vbox_fill_modes()?

Looking at the full function context:

static int vbox_fill_modes(struct drm_connector *connector, u32 max_x, u32 =
max_y)
{
        struct vbox_connector *vbox_connector;
        struct drm_device *dev;
        struct drm_display_mode *mode, *iterator;

        vbox_connector =3D to_vbox_connector(connector);
        dev =3D vbox_connector->base.dev;
        list_for_each_entry_safe(mode, iterator, &connector->modes, head) {
                list_del(&mode->head);
                drm_mode_destroy(mode);
        }

        return drm_helper_probe_single_connector_modes(connector, max_x, ma=
x_y);
}

Could leaving these assignments here trigger unused-but-set-variable compil=
er
warnings, potentially breaking builds with -Werror enabled?

>  	}
> =20
>  	return drm_helper_probe_single_connector_modes(connector, max_x, max_y);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706134515.3369=
960-1-j.niedziolka@samsung.com?part=3D1
