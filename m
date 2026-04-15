Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C162CF419A5
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CAD10E238;
	Wed, 15 Apr 2026 13:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pbhaTxHa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE3310E238
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776260508;
 bh=+AfMJx1Lwq5Nlm+uLenMAgEa7kXrbxQjFNp3/nKGA2g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pbhaTxHaA9tNOX7OryptcDIFnPkeL8/SgYyxiwZaVIr5qyTxa/Q6ePHo/ajtxerwW
 Thr7zfm6SNntDKk+kihHxx7tqNdJcIyEUwCLSRIn3d3aR2eHFFmuYbJMlxkTKc3r2+
 x6ZbVnVJ13gflTV+dxnXDnHbrKM6BZ6aFn/y3pv5BJCIXZYJyb4D5XJGxdmKLBcAH4
 KBStM0bKwBGg4EFMQOxseakZPirgugqk8JoB8XACzF9RKAudFBjgu1aabAz1vdWest
 zrk7XoIU6h8kJ37UqRcFjaiQVjmF6g6Q5NXjaiLR5AmhenS9kST7/Jvn5aOI2nFgOr
 +tWDELJblW5rg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BF1D817E1276;
 Wed, 15 Apr 2026 15:41:47 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:41:43 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 4/6] drm/panthor: Remove unused operation context field
Message-ID: <20260415154143.3a4d39e8@fedora>
In-Reply-To: <20260415112900.681834-5-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-5-adrian.larumbe@collabora.com>
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

On Wed, 15 Apr 2026 12:28:48 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> A Panthor BO's sgtable is now retrieved from its dmap field.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index d9e2f8afb8fb..cea78e5f0591 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -195,14 +195,6 @@ struct panthor_vm_op_ctx {
>  		/** @map.bo_offset: Offset in the buffer object. */
>  		u64 bo_offset;
> =20
> -		/**
> -		 * @map.sgt: sg-table pointing to pages backing the GEM object.
> -		 *
> -		 * This is gathered at job creation time, such that we don't have
> -		 * to allocate in ::run_job().
> -		 */
> -		struct sg_table *sgt;
> -
>  		/** @map.bo: the BO being mapped. */
>  		struct panthor_gem_object *bo;
>  	} map;

