Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3DDCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBDF1128FE;
	Thu,  4 Jun 2026 17:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oh6Z5KRX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2837D1128FE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780595856;
 bh=6QJ4WzyVXysFN2vNMNj8xY6pSIAcO+GVV5Cc91oxCE4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oh6Z5KRXTYf/740kQz5Nz4Nt3LB/24wC91m4KnBQz/80Ke6F3g2jG3V4aiXGqZ8zx
 PAJmdGofxwQj0KBHg3nduPoX3p4G3W2ti3oAG7rW056OJFFRqVHS+jNd6e6MHRsNYw
 8PIlsUH3AAFZiEBf9KPCjesk60F+uJnlFp9LAag8fanPhdzP5zBtgWfYfArDXqxshc
 DYiHh71B7boeJrtq3VUd8dKIc8SW6x8qo3fpYFWMLRzKjkU8wX1ZWIffdubVfyf0b6
 Um16dBHcbCrtwey34fnDhk3/CS6AOfuiG9cuYkkQEStS4l1eE0CASKaqYG9OXjC2H1
 XeMAobotAhuWA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 21A9E17E0475;
 Thu,  4 Jun 2026 19:57:36 +0200 (CEST)
Date: Thu, 4 Jun 2026 19:57:30 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v2 1/7] drm/panfrost: Check another bo field for cache
 option query
Message-ID: <20260604195730.264b1be1@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-1-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-1-57c6bd4c1655@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 04 Jun 2026 18:35:20 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When querying the properties of a BO, whether it was created in
> Writeback caching mode for userspace mappings, is recorded in a Panfrost
> BO's wb_mmap field.
>=20
> Reported-by: Claude <noreply@anthropic.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back=
 Cacheable")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 3d0bdba2a474..cb8e5015847f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -659,7 +659,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_de=
vice *dev, void *data,
>  		if (bo->is_heap)
>  			args->create_flags |=3D PANFROST_BO_HEAP;
> =20
> -		if (!bo->base.map_wc)
> +		if (bo->wb_mmap)
>  			args->create_flags |=3D PANFROST_BO_WB_MMAP;
>  	}
> =20
>=20

