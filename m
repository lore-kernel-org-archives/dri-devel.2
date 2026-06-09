Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95BECD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D93D10E577;
	Tue,  9 Jun 2026 17:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AbV7imMY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193E710E577
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B51A5403A9;
 Tue,  9 Jun 2026 17:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1DD1F00893;
 Tue,  9 Jun 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781026262;
 bh=LT/BBQjk3NyZ2igTJL+bXVXkPUhFiGNgT3tAZgfrmc0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AbV7imMYBD99mzIqHFPip6lxVJvh+pzWx256IziUQ9fH3Tb4XyK5jf+cnPfJJfbVA
 i0ElvfYNSufhXQflcttapGMfwZzY02HuncmJYUgLIvBGRLrTrtzzwCzX3T7jHVGDHG
 Wtg+4mgqSds6Mlquqfau2nzTJ0MtVo3VyjJ1kyje0Y8DpKKlzoFCTcfZK+le8DXoxS
 fBg7WpFOQacVuBKv/yirR1G6jQ4afoWTEuP4tu2YuKU5MYTT3f9GUf8x6InmeLcUJj
 nK0hky6cVekS93ZCCH8hNBDObI89LJ1OeY15BUUXbuxkCEcJrMhuTg4CRlrED+dXXC
 DOG3e6e0ZslOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] drm/colorop: Reduce scope of colorop helpers
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609171941.169104-2-John.Harrison@Igalia.com>
References: <20260609171941.169104-2-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:31:02 +0000
Message-Id: <20260609173102.7B1DD1F00893@smtp.kernel.org>
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
- [Low] The prototype for `drm_atomic_set_colorop_for_plane` was not remove=
d from the header file when the function was renamed and made static.
--

commit db8489fc6303b4a6973676321220c79b3ad4273f
Author: John Harrison <John.Harrison@Igalia.com>

drm/colorop: Reduce scope of colorop helpers

This commit reduces the scope of drm_colorop_find and
drm_atomic_set_colorop_for_plane by making them static local helpers within
the drm_atomic_uapi.c file.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 6441b55cc2740..530576850239f 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c

[ ... ]

> @@ -259,16 +259,16 @@ drm_atomic_set_fb_for_plane(struct drm_plane_state =
*plane_state,
>  EXPORT_SYMBOL(drm_atomic_set_fb_for_plane);
> =20
>  /**
> - * drm_atomic_set_colorop_for_plane - set colorop for plane
> + * set_colorop_for_plane - set colorop for plane
>   * @plane_state: atomic state object for the plane
>   * @colorop: colorop to use for the plane
>   *
>   * Helper function to select the color pipeline on a plane by setting
>   * it to the first drm_colorop element of the pipeline.
>   */
> -void
> -drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
> -				 struct drm_colorop *colorop)
> +static void
> +set_colorop_for_plane(struct drm_plane_state *plane_state,
> +		      struct drm_colorop *colorop)

[Severity: Low]
Since the exported function drm_atomic_set_colorop_for_plane is being renam=
ed
and made static here, should its corresponding declaration in
include/drm/drm_atomic_uapi.h also be removed? The prototype remains in that
header file without an implementation, leaving a dangling declaration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609171941.1691=
04-1-John.Harrison@Igalia.com?part=3D1
