Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DBC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BD810F39F;
	Thu,  9 Jul 2026 06:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O8LEqQTg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4015010F39F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:37:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8B0D413F6;
 Thu,  9 Jul 2026 06:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8091F000E9;
 Thu,  9 Jul 2026 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783579059;
 bh=94hMHJ7O5P7ONPhvYQVIKRqZqN34yTx4fdFHZsr+2ek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O8LEqQTgw/FSRUFMfqqaVF3n4Kf1Ng4oOqkzfVz5hig8cE7SgHJLX7Pffzi9DQtvh
 SFest1vRoSctCW/3kcuT01a1PpCCbm6zuJouQHr85dMWL92AqoT/BlWuq/azhYduRs
 KILielYTGwhT6UUQQadxI+AZHyqyV0HJl/bES40pYjcipDKSBHvwo7fzKbxLl/0i7j
 HWvtOW38q1MeZU0cJcJxqa0Uc+X6XNLtuhovibmlMYrux+wieEpIHaVvO3VrH97Lyb
 yu6ske7Zb3NhmE9BUG4rRPmaP/dKzkEj9RUJiqoh4+exaIhJdV4Em3cbuDb97TI5nT
 3dtHHqwZF9tpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/gsp: Preserve BAR2 flush mapping on kmap
 failure
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709062318.4169329-1-ruoyuw560@gmail.com>
References: <20260709062318.4169329-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:37:39 +0000
Message-Id: <20260709063739.9E8091F000E9@smtp.kernel.org>
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
- [Medium] Unbalanced acquire/release refcount leak when nvkm_kmap() return=
s NULL
--

--- Patch [1]: [PATCH] drm/nouveau/gsp: Preserve BAR2 flush mapping on kmap=
 failure ---
commit 31b13bcd1196c2d2aeb9a843ab22642741567833
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/nouveau/gsp: Preserve BAR2 flush mapping on kmap failure

This patch prevents a NULL pointer dereference in r535_bar_bar2_init() by
checking the return value of nvkm_kmap() before assignment. It also preserv=
es
the physical-mode flush mapping unless the BAR2 flush mapping was successfu=
lly
acquired.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> index 9cd68f8622d36..b7b44baf836cb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
[ ... ]
> @@ -71,8 +71,9 @@ r535_bar_bar2_fini(struct nvkm_bar *bar)
>  	struct nvkm_vmm *vmm =3D gf100_bar(bar)->bar[0].vmm;
>  	struct nvkm_gsp *gsp =3D bar->subdev.device->gsp;
> =20
> +	if (bar->flushFBZero && bar->flushBAR2 !=3D bar->flushBAR2PhysMode)
> +		nvkm_done(bar->flushFBZero);
>  	bar->flushBAR2 =3D bar->flushBAR2PhysMode;

[Severity: Medium]
Will this skip the necessary cleanup if nvkm_kmap() failed?

Because the failure path in r535_bar_bar2_init() below doesn't call
nvkm_done(), and this condition now skips nvkm_done() if the flush pointer
wasn't updated, this appears to cement a reference leak of the mapping.

> -	nvkm_done(bar->flushFBZero);
> =20
>  	WARN_ON(r535_bar_bar2_update_pde(gsp, vmm->func->page[0].shift, 0));
>  }
[ ... ]
> @@ -106,12 +108,16 @@ r535_bar_bar2_init(struct nvkm_bar *bar)
>  			ret =3D nvkm_memory_kmap(fbZero, &bar->flushFBZero);
>  			nvkm_memory_unref(&fbZero);
>  		}
> -		WARN_ON(ret);
> +		if (WARN_ON(ret))
> +			return;
>  	}
> =20
> +	flush =3D nvkm_kmap(bar->flushFBZero);
> +	if (WARN_ON(!flush))
> +		return;

[Severity: Medium]
Does this early return cause a refcount leak?

In the Nouveau driver, nvkm_kmap(o) expands to (o)->func->acquire(o). The=20
acquire implementation always increments the mapping reference count and re=
moves=20
the object from the LRU list, even if it returns a NULL mapping.

If nvkm_kmap() fails to map and returns NULL, shouldn't nvkm_done() still b=
e=20
called to decrement the refcount and unpin the object before returning?

> +
> +	bar->flushBAR2 =3D flush;
>  	bar->bar2 =3D true;
> -	bar->flushBAR2 =3D nvkm_kmap(bar->flushFBZero);
> -	WARN_ON(!bar->flushBAR2);
>  }
> =20
>  static void

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062318.4169=
329-1-ruoyuw560@gmail.com?part=3D1
