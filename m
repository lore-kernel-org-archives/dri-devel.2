Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52AC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6F610F0F1;
	Wed, 12 Aug 2026 21:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lQIzQgey";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CC110F0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:54:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F57B42E74;
 Wed, 12 Aug 2026 21:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B8E1F00A3A;
 Wed, 12 Aug 2026 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786571664;
 bh=UQnJ9ceE1lU82i9ZZNmOt4XxSbcpocb1QXQ8j3oPO08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lQIzQgeyVtVDie2R6fFBgEwv9SkSspPnMLivqBgDCXX+733LkamgZ5dmx6qVy14wf
 xioY/BG9niIODYrtUTJA8cdglxBwcyO9G22pP3RtENJFqi0z5t7Gx6jq/uMrYF79qb
 PWlgt/5J3ZaxCxlEvD+4nLf6PlDcT5s8/87tZqIVCO7sw9UUH/HJTLJCMMJW+oAeij
 nisB9R2AYGBKFzN704f9/z3OKvWkMRvX1dGXJghiPR3xP0AhHCOG/oripv7WymACCR
 8jEzNOV7os4zI/c47L1g+oXLQ+ram4HJoCnLUjtVa2tAZzxFacAs1RviFXPMiEDFbV
 3Hw1IIIy7A9pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix unexpected wait when flushing
 notifier_wq
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812214403.817307-1-lizhi.hou@amd.com>
References: <20260812214403.817307-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 21:54:23 +0000
Message-Id: <20260812215423.E6B8E1F00A3A@smtp.kernel.org>
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
- [High] Replacing flush_workqueue() with cancel_work_sync() inside a list =
iteration creates a race condition leading to a Use-After-Free of the GEM o=
bject (`abo`) when a work item has already unlinked itself.
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Fix unexpected wait when flushing =
notifier_wq ---
commit 833f3279232d8856fda2a2788bbc7c5f9bd924f8
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix unexpected wait when flushing notifier_wq

This commit replaces flush_workqueue() in amdxdna_gem_obj_free() with a
new amdxdna_hmm_unregister_all() function. This avoids waiting for unrelated
work items on the global device workqueue by iterating through the BO's
umap_list and canceling the unregister works directly.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index b01f5d95fac83..a439e8c556465 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -301,33 +301,40 @@ static void amdxdna_hmm_unregister(struct amdxdna_g=
em_obj *abo,
[ ... ]
> +static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
> +{
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
> +	struct amdxdna_umap *mapp, *tmp;
> +	LIST_HEAD(dead);
> =20
> -	xdna =3D to_xdna_dev(to_gobj(mapp->abo)->dev);
>  	down_write(&xdna->notifier_lock);
> -	list_del(&mapp->node);
> -	if (list_empty(&abo->mem.umap_list))
> -		abo->mem.uva =3D AMDXDNA_INVALID_ADDR;
> +	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
> +		mapp->unmapped =3D true;
> +		mapp->cleanup =3D true;
> +		list_move(&mapp->node, &dead);
> +	}
>  	up_write(&xdna->notifier_lock);
> =20
> +	list_for_each_entry_safe(mapp, tmp, &dead, node) {
> +		cancel_work_sync(&mapp->hmm_unreg_work);
> +		amdxdna_umap_put(mapp);
> +	}
> +}
> +
[ ... ]
> @@ -341,6 +348,20 @@ static void amdxdna_hmm_unreg_work(struct work_struc=
t *work)
>  {
>  	struct amdxdna_umap *mapp =3D container_of(work, struct amdxdna_umap,
>  						 hmm_unreg_work);
> +	struct amdxdna_gem_obj *abo =3D mapp->abo;
> +	struct amdxdna_dev *xdna;
> +
> +	xdna =3D to_xdna_dev(to_gobj(mapp->abo)->dev);
> +	down_write(&xdna->notifier_lock);
> +	if (mapp->cleanup) {
> +		up_write(&xdna->notifier_lock);
> +		return;
> +	}
> +
> +	list_del(&mapp->node);
> +	if (list_empty(&abo->mem.umap_list))
> +		abo->mem.uva =3D AMDXDNA_INVALID_ADDR;
> +	up_write(&xdna->notifier_lock);
> =20
>  	amdxdna_umap_put(mapp);
>  }
[ ... ]
> @@ -643,8 +664,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_objec=
t *gobj)
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(gobj->dev);
>  	struct amdxdna_gem_obj *abo =3D to_xdna_obj(gobj);
> =20
> -	amdxdna_hmm_unregister(abo, NULL);
> -	flush_workqueue(xdna->notifier_wq);
> +	amdxdna_hmm_unregister_all(abo);

[Severity: High]
Does replacing flush_workqueue() with amdxdna_hmm_unregister_all() here ope=
n a
race condition leading to a use-after-free of the GEM object?

If the worker thread amdxdna_hmm_unreg_work() has already unlinked mapp from
abo->mem.umap_list via list_del(&mapp->node) and released the lock, but has=
n't
completed amdxdna_umap_put(mapp):

Worker thread:
amdxdna_hmm_unreg_work()
	list_del(&mapp->node);
	up_write(&xdna->notifier_lock);
    <-- preempted here before amdxdna_umap_put(mapp) finishes unregistering

Free path:
amdxdna_gem_obj_free()
	amdxdna_hmm_unregister_all(abo)

Because mapp is no longer in abo->mem.umap_list, amdxdna_hmm_unregister_all=
()
will not find it and won't call cancel_work_sync(&mapp->hmm_unreg_work).
The amdxdna_gem_obj_free() function will then proceed to free the GEM object
(abo) without waiting for the work item to finish.

If an MMU event such as munmap triggers the notifier before the worker
finishes unregistering it, could it dereference the freed abo?

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_hmm_invalidate() {
	struct amdxdna_umap *mapp =3D container_of(mni, struct amdxdna_umap, notif=
ier);
	struct amdxdna_gem_obj *abo =3D mapp->abo;
	...
	xdna =3D to_xdna_dev(to_gobj(abo)->dev);
}

Is there a way to safely ensure any detached but still running work items a=
re
fully completed before freeing the GEM object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812214403.8173=
07-1-lizhi.hou@amd.com?part=3D1
