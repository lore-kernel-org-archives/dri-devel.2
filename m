Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D89EF4EC9
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDDE10E284;
	Tue,  7 Apr 2026 06:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="S86zVSCP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418A410E284
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 06:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775544872;
 bh=EsmCJyDsmm+Rjnz6B0Osuziqt5xz1oUh1j+zEEv/eX0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S86zVSCPsxujoEfRrgEEPR0eZZ18k88kAOOJAftVE5uSy/5kKdO5CbtJvaOCsKlyk
 CUeXC7IUBNpjZxi4lSuha3tGsX9hWZA/OIh1G6lS8TEPPDouyYlxmgS2Ht1YRbYIvO
 OX6Bz6jJGTv373OfS9DDqOrucuttRI+/TjdavTfkKJSeZRppH/PAK4j2lCtRktZ/6r
 o3tW+ztgjcwKahtfu/UlSLb6ibcr4wnpIBjwu544gTWivfkwR7DQAamZ1I8Y1VhM1I
 Q/zgx8AsdR+iUjNkB2OVRt7GSs6GbcHbTXtQLRSml9AYnx8Vayf/gXXzoyciqvAEbP
 47oCYhX4Z/zWg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BB84017E1078;
 Tue,  7 Apr 2026 08:54:31 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:54:26 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/panthor: Extend VM locked region for remap case
 to be a superset
Message-ID: <20260407085426.26fa3a1e@fedora>
In-Reply-To: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
References: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
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

On Fri,  3 Apr 2026 18:21:11 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> In the event of an sm_step_remap() that leads to a partial unmap of a
> transparent huge page, the new locked region required by an extended unmap
> might not be a superset of the original one. Then, if it leaves a portion
> of the initially requested one out, the ensuing map will trigger a warnin=
g.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

One suggestion below.

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index fa8b31df85c9..2b96359d3b94 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1709,6 +1709,19 @@ static int panthor_vm_lock_region(struct panthor_v=
m *vm, u64 start, u64 size)
>  	    start + size <=3D vm->locked_region.start + vm->locked_region.size)
>  		return 0;
> =20
> +	/* sm_step_remap() may need a locked region that isn't a strict superset
> +	 * of the original one because of having to extend unmap boundaries bey=
ond
> +	 * it to deal with partial unmaps of transparent huge pages. What we wa=
nt
> +	 * in those cases is to lock the union of both regions.
> +	 */
> +	if (vm->locked_region.size) {
> +		u64 end =3D start + size;
> +
> +		start =3D min(start, vm->locked_region.start);
> +		size =3D max(vm->locked_region.start +
> +			   vm->locked_region.size, end) - start;

I'd probably go:

		u64 end =3D max(vm->locked_region.start + vm->locked_region.size,
			      start + size);

		start =3D min(start, vm->locked_region.start);
		size =3D end - start;

> +	}
> +
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >=3D 0 && size) {
>  		/* Lock the region that needs to be updated */
>=20
> base-commit: fb42964e2a76f68a5fb581d382b5d2be2d5bda9b

