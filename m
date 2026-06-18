Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9167ACD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AD810F153;
	Thu, 18 Jun 2026 14:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R/ClUALd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDD910F153
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:26:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6A4544223;
 Thu, 18 Jun 2026 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBAC1F000E9;
 Thu, 18 Jun 2026 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781792816;
 bh=gunwCFOGhxMFsLOqvbTfC7s3idz9A4B+pYQ3O1ubRPs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R/ClUALdvAYitnEo58A5LJBRnwcUhNKC1c3cP+djsAYERCHAgW7dkEPBabBwCDSvX
 AirzntdhbYaPnYbRl8N3XQuQ08vySEmcIbeM/LzULZ+uxX/IPz6R1mr0zUUVOXyd8E
 cHq1Ek6bgP11BOtAiZm07ZAtF0l4E5gZqrmLO+vdWemvEv5I9V5aE6ptV+3Rgsg4aW
 HiQ2Zg23zIfohf6sh6InNhQPY+MJDyFUSHwaPgDCJqosw/rEc5eIDjgI+1Z6g/CssL
 gVXFQoYYqrTX69K8viJP2rTUU6F2EI4BxOq4/sgmyccJQKe3XNekguqmsDqBcik+3a
 2CBvrk3wG6HYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] drm/msm: fbdev: Use a DRM client buffer
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618141249.151338-6-tzimmermann@suse.de>
References: <20260618141249.151338-1-tzimmermann@suse.de>
 <20260618141249.151338-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:26:56 +0000
Message-Id: <20260618142656.7CBAC1F000E9@smtp.kernel.org>
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
- [Medium] Unbalanced `vmap_count` decrement and kernel warning on probe er=
ror path.
--

commit a68322c2e5e8736f3b039ddfe130065a05ddf719
Author: Thomas Zimmermann <tzimmermann@suse.de>
drm/msm: fbdev: Use a DRM client buffer

This commit replaces the internal DRM framebuffer with a DRM client buffer
in msm_fbdev. It unifies framebuffer allocation for DRM clients in user
space and the internal fbdev emulation, and simplifies the clean-up side.

> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fb=
dev.c
> index 5532c5779f17c..f14db46aa51e2 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c

[ ... ]

> @@ -162,19 +161,29 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_help=
er *helper,
>  	fbi->screen_buffer =3D msm_gem_get_vaddr(bo);
>  	if (IS_ERR(fbi->screen_buffer)) {
>  		ret =3D PTR_ERR(fbi->screen_buffer);
> -		goto err_drm_framebuffer_remove;
> +		goto err_msm_gem_put_vaddr;

[Severity: Medium]
If msm_gem_get_vaddr() fails and returns an error pointer, the vmap_count
is not incremented. Does jumping to err_msm_gem_put_vaddr here cause an
unbalanced msm_gem_put_vaddr() call that will underflow vmap_count and
trigger a GEM_WARN_ON() kernel warning?

It seems this should instead skip the put_vaddr step and jump straight to
err_drm_client_buffer_delete.

>  	}
>  	fbi->screen_size =3D bo->size;
>  	fbi->fix.smem_start =3D paddr;
>  	fbi->fix.smem_len =3D bo->size;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618141249.1513=
38-1-tzimmermann@suse.de?part=3D5
