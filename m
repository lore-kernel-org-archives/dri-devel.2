Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1EBCD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10CF410EAEA;
	Wed, 17 Jun 2026 18:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TMaFGtRX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DAB10EAEA
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781722236;
 bh=cGhpOTVUfhYSkugL3gF933KZI26XchlLEAh6KkAfLVA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TMaFGtRX0tJMg+AQrQryIY3rJx1mlKQT+nxlUUAZkZoF7ILX37r33mMwnzS8Iqh+9
 zd5/mU+OYrkrRRjLsF7ga853WFllXam4/rJczf6Hh/aX8MihDOaCBUfHoG77Qpf85y
 jW+kldFbZ3gLhkrs2aBPZOhaj+WW0wlGpUDVUo/tn8sQ0tA4WRR6S12YyLrAwI7WDe
 m3kJy3YLgpWgfi8esTdG6PlisStgLG91wxdy6cXVUtTUMKwp7rz45pLzDxDG+06tcf
 BDoz6nAPVeOFvkjiEH0ZdG6mqwpJbKiBthEkceDNBTftkmJF6pBXrFdCyBsegslZRP
 lKvxsPo9sx3pg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E77417E045E;
 Wed, 17 Jun 2026 20:50:36 +0200 (CEST)
Date: Wed, 17 Jun 2026 20:50:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
Message-ID: <20260617205032.27ddec5f@fedora-2.home>
In-Reply-To: <20260616-vm_bind_checks-v1-2-956198602ae3@collabora.com>
References: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
 <20260616-vm_bind_checks-v1-2-956198602ae3@collabora.com>
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

On Tue, 16 Jun 2026 15:46:44 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> The mismatch would pop up when building the kernel with W=3D1.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 5625f3d34031..ab7a1698c327 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -315,7 +315,7 @@ struct panthor_vm {
>  		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel =
BOs. */
>  		u64 start;
> =20
> -		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BO=
s. */
> +		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs.=
 */
>  		u64 end;
>  	} kernel_auto_va;
> =20
>=20

