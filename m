Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96243C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65CB10E1A8;
	Fri, 10 Jul 2026 12:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDNHFPbt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E103610E1A8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:20:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3746760051;
 Fri, 10 Jul 2026 12:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93C31F000E9;
 Fri, 10 Jul 2026 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783686032;
 bh=Diq8N1x9E5Ckry+AwHFSmVFZbWbF1LnAqVzVOL8Dn2Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aDNHFPbtNdpJYtAPHBg0zk7204yIzUlPjJmOvdQqHyWbBEG5LmJb1obuS/CScit44
 ivs1vBYn2Ok4KcKRmx/RMvivFhEflLZOJBKsJ8+XXAt3drtUM8AWDUceQgWUIQvv1B
 W0OLFJIXdJ9PK/H/d2IBJBKAHab+VyYKMM/ZYie4AX25/AWJU4IYN8mmkv/+KCDe5q
 PpLwEFNmm+cxRygO5lRJfurMA/r32+HTYP3aEF+Vf6yAEud3RSeIBquo0XhB24a/fV
 YxrUaarNwv7wuR1zvVdI4g+iCLgTDBIeF3dMyGlxh0CkN6dP0Zoo/s7kZDRk3d1jq1
 xIMLcGsLnLzWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-etnaviv-reset-notification-v3-1-7a145c8a1d01@igalia.com>
References: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
 <20260710-etnaviv-reset-notification-v3-1-7a145c8a1d01@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 12:20:31 +0000
Message-Id: <20260710122031.E93C31F000E9@smtp.kernel.org>
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
- [High] The return value of `drm_sched_entity_init()` is ignored in `etnav=
iv_open()`, leading to a NULL pointer dereference in `etnaviv_postclose()` =
if initialization fails.
--

--- Patch [1]: [PATCH v3 1/2] drm/etnaviv: Reference count struct etnaviv_f=
ile_private ---
commit 15b05c3fcbf409d69374c7e633d70b33641f9909
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Reference count struct etnaviv_file_private

This commit introduces reference counting for the etnaviv context to
prevent a use-after-free when a context is closed while still needed
by the GPU reset path.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1a..a27ed014fb4e7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
[ ... ]
> @@ -70,6 +83,8 @@ static int etnaviv_open(struct drm_device *dev, struct =
drm_file *file)
>  	if (!ctx)
>  		return -ENOMEM;
> =20
> +	kref_init(&ctx->refcount);
> +
>  	ret =3D xa_alloc_cyclic(&priv->active_contexts, &ctx->id, ctx,
>  			      xa_limit_32b, &priv->next_context_id, GFP_KERNEL);
>  	if (ret < 0)

[Severity: High]
This is a pre-existing issue, but I noticed the return value of
drm_sched_entity_init() is ignored during etnaviv_open().

If drm_sched_entity_init() fails (for example, if memory allocation fails i=
nside
drm_sched_entity_stats_new()), it leaves the entity partially initialized w=
ith a
NULL stats pointer.

When the file descriptor is later closed, etnaviv_postclose() unconditional=
ly
calls drm_sched_entity_destroy(). Would this sequence result in a crash?

etnaviv_open()
    drm_sched_entity_init(&ctx->sched_entity[i], ...);
    // Error is ignored
            =20
etnaviv_postclose()
    drm_sched_entity_destroy(&ctx->sched_entity[i]);
    // Leads to drm_sched_entity_stats_put(entity->stats)
       =20
Does this lead to a NULL pointer dereference when kref_put() operates on the
NULL stats pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-etnaviv-re=
set-notification-v3-0-7a145c8a1d01@igalia.com?part=3D1
