Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5CFE9D832
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8005A10E294;
	Tue,  7 Apr 2026 06:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mbzHPU8u";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3A310E2CF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 06:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775544906;
 bh=wv4SpAP9/lZ9RiTs9+vHkbr11/NMu9+BR6QLXTTqrZM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mbzHPU8uM01gP5A+xj9RxV9L6w1OFQVj0ILAme0WPgH57Z9oWg7Zf69AVKDXmFlwF
 jTAFz+SsNgzAiEoB9dZGsJECZFLHAdMjx+l3Z8AOlKdVWIRdiNN5d17Zbl6j8ZvSea
 SC36BDqcZFiaTgdir0n07db6Aj+qp+b+52MxuYBs5kyNuPEpb73R2M2ukme4zUJT4V
 oiN8epPbT7H3+k+THkArwSLDJmRAn4prLrRz93VtkvoOmI9ffZqTmj5iSpJ+6Sbo5m
 VY5O03jlUK8Ovt6TlvVNqWkQ+mkEk650mj4w5Zi6MmfjDfLfWg3X35xPsyOL/z0aEY
 9Vf8QXMQAsr+w==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A992417E107E;
 Tue,  7 Apr 2026 08:55:05 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:55:01 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/panthor: Fix outdated function documentation
Message-ID: <20260407085501.4f5c80a3@fedora>
In-Reply-To: <20260403172116.3424075-2-adrian.larumbe@collabora.com>
References: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
 <20260403172116.3424075-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Fri,  3 Apr 2026 18:21:12 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> 'vm' is no longer allowed to be NULL.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 69cef05b6ef7..13295d7a593d 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1264,7 +1264,7 @@ void panthor_kernel_bo_destroy(struct panthor_kerne=
l_bo *bo)
>  /**
>   * panthor_kernel_bo_create() - Create and map a GEM object to a VM
>   * @ptdev: Device.
> - * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapp=
ed.
> + * @vm: VM to map the GEM to.
>   * @size: Size of the buffer object.
>   * @bo_flags: Combination of drm_panthor_bo_flags flags.
>   * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those

