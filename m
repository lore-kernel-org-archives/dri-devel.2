Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3C606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFnAcIDH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC7A112306;
	Thu, 26 Nov 2026 11:21:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B320112306
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 312E045E65;
 Thu, 26 Nov 2026 11:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775581F000C6;
 Thu, 26 Nov 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795692081;
 bh=4k4SeiXqeNsIoGLeydYWgKzq0JIDSlv38JHd98lll3Q=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HFnAcIDHGkD4QhRiT237leF4KF0RLkD6lDw+07hR49EA/9gPIY1MZWtr56o2mmdrh
 u9Tn1K2lBRPcnoox2dIU/iwpjXxKO2Zq00uxmWOldRrs7xhP27sOYjkng+b74DD/0S
 4ok9eKAwkp1kgZM56tdVskyevA+rgDerU9/4GKGce21AchFdQ3A0aA5atKbIBf80G+
 /tK2E1/9l5feAoJkwSGgBqggOEKWSttat/BIUHDzVtLy6Q7uc+yZjGEp+JiLvp7dM9
 ud0NjSTxuX0IZrSZCX5B97zHMiWkv2LRMRGftbK4C+ftSxnWxnaKjCKV0Eedfbe2m9
 bJqdhrHIBPjJg==
Message-ID: <sashiko-outbox-235367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_timeline_signal_ioctl chains
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261126111117.67342-6-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:21:21 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/syncobj: mixed goto and __free() in
  drm_syncobj_timeline_signal_ioctl()
--

commit 97e96ebc6a98c85d2c6da0c4d034fb53f985a940
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/syncobj: Use scoped cleanup for drm_syncobj_timeline_signal_ioctl chains

This commit introduces a syncobj_chains helper struct with DEFINE_FREE()
to manage the dma_fence_chain array in drm_syncobj_timeline_signal_ioctl()
using __free(syncobj_chains).

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index e05051c3895fe..da90ae11382e3 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1566,15 +1566,33 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, =
void *data,
>  	return ret;
>  }
> =20
> +struct syncobj_chains {
> +	struct dma_fence_chain **chains;
> +	unsigned int count;
> +};
> +
> +static void syncobj_chains_free(struct syncobj_chains *c)
> +{
> +	if (!c->chains)
> +		return;
> +
> +	for (unsigned int i =3D 0; i < c->count; i++)
> +		dma_fence_chain_free(c->chains[i]);
> +
> +	kvfree(c->chains);
> +}
> +
> +DEFINE_FREE(syncobj_chains, struct syncobj_chains, syncobj_chains_free(&=
_T))
> +
>  int
>  drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *file_private)
>  {
>  	struct drm_syncobj_timeline_array *args =3D data;
> +	struct syncobj_chains chains __free(syncobj_chains) =3D {};
>  	u64 *points __free(kvfree) =3D NULL;
>  	struct drm_syncobj **syncobjs;
> -	struct dma_fence_chain **chains;
> -	uint32_t i, j;
> +	unsigned int i;
>  	int ret;
> =20
>  	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
> @@ -1606,30 +1624,29 @@ drm_syncobj_timeline_signal_ioctl(struct drm_devi=
ce *dev, void *data,
>  		goto out;
>  	}
> =20
> -	chains =3D kvmalloc_objs(*chains, args->count_handles);
> -	if (!chains) {
> +	chains.chains =3D kvmalloc_objs(*chains.chains, args->count_handles);
> +	if (!chains.chains) {
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
>  	for (i =3D 0; i < args->count_handles; i++) {
> -		chains[i] =3D dma_fence_chain_alloc();
> -		if (!chains[i]) {
> -			for (j =3D 0; j < i; j++)
> -				dma_fence_chain_free(chains[j]);
> +		chains.chains[i] =3D dma_fence_chain_alloc();
> +		if (!chains.chains[i]) {
>  			ret =3D -ENOMEM;
> -			goto err_chains;
> +			goto out;
>  		}
> +		chains.count++;
>  	}
> =20
>  	for (i =3D 0; i < args->count_handles; i++) {
>  		struct dma_fence *fence =3D dma_fence_get_stub();
> =20
> -		drm_syncobj_add_point(syncobjs[i], chains[i],
> +		drm_syncobj_add_point(syncobjs[i], chains.chains[i],
>  				      fence, points[i]);
> +		chains.chains[i] =3D NULL; /* Ownership transferred to syncobj */
>  		dma_fence_put(fence);
>  	}
> -err_chains:
> -	kvfree(chains);
> +
>  out:
>  	drm_syncobj_array_free(syncobjs, args->count_handles);

[Severity: Low]
This isn't a bug, but drm_syncobj_timeline_signal_ioctl() mixes __free()
cleanup with goto out unwinding for syncobjs, and declares chains empty
at the top of the function (before points) instead of defining and
initializing it where the array is allocated.  Follow-up commit
"drm/syncobj: Use scoped cleanup in drm_syncobj_array_find and callers"
removes the goto label, though both it and commit "drm/syncobj: Add
temporary array allocation fast paths" still declare chains at the top of
the function before points, which reverses the LIFO cleanup order
relative to the allocation order.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126111117.6734=
2-1-tvrtko.ursulin@igalia.com?part=3D5
