Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB7410F681;
	Fri, 26 Jun 2026 14:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JOXdEBG1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C0910F681
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:53:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68CDB600C8;
 Fri, 26 Jun 2026 14:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D021F000E9;
 Fri, 26 Jun 2026 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485590;
 bh=e0kYfM8oqDzzMpJd6By3xmlEH96RtP/nsFhH+nGuOrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JOXdEBG1r0j7hNF6V1REyMpucMlQaI/bh8JakN/Puwa6ofG2lX1AHxK2RRNXDa2vu
 akNkpivMq7E/kxSQStgIfTeapFbgMqfZ0ikwMSWSTNI8SZ6GR9Mqcdt2Cd7kw1WvWh
 eo9BHEqo9gyEe/wRaTqnNuwmtn14EajKuPj5TNmo2vv1XhEmXFQVL7/+VaYAsF1LsM
 1jPajZB+VDDYeYKXpWrQzkcYknCblU2zesZdIodj0OGq9bn6Aqa3y1ooysLGFbaQRp
 kwEo2n6vn67F7x/7V8pryXN2R6P+H1hEETPR341jtYff4wWtBfFCVHabAqi1bT5tqy
 j19/sN7OxT7ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/nouveau: nvkm_chan_new_: multiple error paths
 return without   releasing acquired references
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626143953.48952-1-vulab@iscas.ac.cn>
References: <20260626143953.48952-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:09 +0000
Message-Id: <20260626145309.E1D021F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Silent failure converting error paths to success, leading to i=
mmediate NULL pointer dereference.
- [High] Setting `*pchan =3D NULL` on error bypasses framework destructors,=
 causing severe memory and GPU resource leaks.
--

commit 36c8694a5768a3efc7f331411db88cf737b0facf
Author: WenTao Liang <vulab@iscas.ac.cn>
fix: drm/nouveau: nvkm_chan_new_: multiple error paths return without relea=
sing acquired references

This commit aims to fix resource leaks in error paths by routing them throu=
gh
a single cleanup block.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/chan.c
> index 418a8918bcb8f..1bf595bafa9ac 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> @@ -410,18 +410,18 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, s=
truct nvkm_runl *runl, int ru
>  			      &chan->inst);
>  	if (ret) {
>  		RUNL_DEBUG(runl, "inst %d", ret);
> -		return ret;
> +		goto done;
>  	}
> =20
>  	/* Initialise virtual address-space. */
>  	if (func->inst->vmm) {
>  		if (WARN_ON(vmm->mmu !=3D device->mmu))
> -			return -EINVAL;
> +			goto done;

[Severity: Critical]
Does this leave the local variable ret set to 0 from the earlier successful
nvkm_gpuobj_new() call?

If so, the function returns success while setting *pchan =3D NULL. When the
caller receives a successful return code, it might proceed to dereference t=
he
channel, leading to a null pointer dereference:

nvkm_uchan_new() {
    ...
    chan =3D uchan->chan;
    if (chan->func->doorbell_handle) {
    ...
}

Could we set ret =3D -EINVAL before jumping to the done label?

[ ... ]

> @@ -443,13 +443,13 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, s=
truct nvkm_runl *runl, int ru
>  			if (ouserd + chan->func->userd->size >=3D
>  				nvkm_memory_size(userd)) {
>  				RUNL_DEBUG(runl, "ouserd %llx", ouserd);
> -				return -EINVAL;
> +				goto done;
>  			}

[Severity: Critical]
Is there a similar missing error code assignment here? It looks like this p=
ath
would also return success without initializing the channel.

[ ... ]

> @@ -461,7 +461,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, str=
uct nvkm_runl *runl, int ru
> =20
>  	if (chan->id < 0) {
>  		RUNL_ERROR(runl, "!chids");
> -		return -ENOSPC;
> +		goto done;
>  	}

[Severity: Critical]
Does this path also need ret =3D -ENOSPC before jumping to the cleanup bloc=
k?

[ ... ]

> +done:
> +	if (chan->id >=3D 0)
> +		nvkm_chid_put(runl->chid, chan->id, &chan->cgrp->lock);
> +	nvkm_memory_unref(&chan->userd.mem);
> +	nvkm_vmm_unref(&chan->vmm);
> +	nvkm_cgrp_unref(&chan->cgrp);
> +	*pchan =3D NULL;
> +	return ret;
>  }

[Severity: High]
Does setting *pchan =3D NULL hide the partially allocated object from the
caller's framework destructor?

When an error occurs, the native destructors like nvkm_object_del() and
nvkm_chan_del() are usually invoked by the framework to clean up. Since the
done block misses freeing the channel struct and initialized GPU objects li=
ke
chan->inst, clearing the pointer here seems to prevent the framework from
finishing the cleanup, resulting in a resource leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626143953.4895=
2-1-vulab@iscas.ac.cn?part=3D1
