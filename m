Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE4ACD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 01:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BA710E02E;
	Tue,  9 Jun 2026 01:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AwqV6ANq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBAA10E02E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 01:27:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15778601E6;
 Tue,  9 Jun 2026 01:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0681F00893;
 Tue,  9 Jun 2026 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780968443;
 bh=kq49xDvqxP/K49Lm2YM+lgHb54hAqsSIUUBHssZTOYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AwqV6ANqGYCx7kaPx/6GTbYO2k86Zw280B7S+z4lBurXf6oowQgaVoDq1qYSVe5m3
 tSxlLjMRIlEU6Ub9+UDtP2BTGKpmAbft/hhtp6cutP3FCQ5nfcR26FfO4N4H+yBZM7
 ZfJtuH9eXygeyVYN/+AUt2GyMSZQTXkqQvegVDZzwDNbijJyyGTidfg67pkW6JA9fJ
 QeRZt07SDmUHTdSS5yovS6/n2fGy/jk7ScZVXF390w/RTtJ1LefMHYYW6Ub2Gh0P0p
 Tg8AYqrGsaw2bqxECweE5ypEYfFjZh/IGg5wloHKQSolHLVisiPw23ixngD8a6IC9k
 FyoAHjNkPg7bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] accel/amdxdna: Fix VMA access race
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609011242.2833740-1-lizhi.hou@amd.com>
References: <20260609011242.2833740-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:27:23 +0000
Message-Id: <20260609012723.AD0681F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Partial unmap or mremap of a buffer drops the MMU interval notifie=
r for the entire mapping, leading to a silent Use-After-Free of physical pa=
ges if the remaining mapped pages are later evicted.
- [High] aie2_populate_range() permanently leaks a reference to the process=
's mm_struct on every successful iteration or retry.
- [High] amdxdna_umap_release() makes a blocking call before removing the o=
bject from umap_list, causing a race condition where aie2_populate_range() =
can acquire a use-after-free reference.
--

commit 71483c5a347d768c335b0ee0b6039363e243ad92
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix VMA access race

aie2_populate_range() and amdxdna_umap_release() access a saved VMA
pointer that may have already been freed, leading to a potential
use-after-free.

Remove the VMA accesses from these functions to avoid the race.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index da89b3701f5b6..3e21e2dabe820 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1023,8 +1023,6 @@ static int aie2_populate_range(struct amdxdna_gem_o=
bj *abo)
>  	kref_get(&mapp->refcnt);
>  	up_write(&xdna->notifier_lock);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can this sequence lead to a
use-after-free or double-free?

In amdxdna_umap_release(), the blocking mmu_interval_notifier_remove() is
called before the object is removed from the abo->mem.umap_list. If
aie2_populate_range() runs concurrently, could it find the dying object in
the list and blindly call kref_get(&mapp->refcnt) here after the refcount h=
as
already dropped to zero?

> -	XDNA_DBG(xdna, "populate memory range %lx %lx",
> -		 mapp->vma->vm_start, mapp->vma->vm_end);
>  	mm =3D mapp->notifier.mm;
>  	if (!mmget_not_zero(mm)) {
>  		amdxdna_umap_put(mapp);

[Severity: High]
This isn't a bug introduced by this patch, but does this code permanently
leak a reference to the mm_struct?

It looks like mmget_not_zero(mm) is called here, but on the successful path
and retry paths later in the function:

    if (ret =3D=3D -EBUSY) {
        amdxdna_umap_put(mapp);
        goto again;
    }

and:

    mapp->invalid =3D false;
    up_write(&xdna->notifier_lock);
    amdxdna_umap_put(mapp);
    goto again;

It appears mmput(mm) is missing before jumping back to the again label.

[ ... ]

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 63976c3bcbe0f..20ce304b19ef2 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interva=
l_notifier *mni,
> =20
>  	xdna =3D to_xdna_dev(to_gobj(abo)->dev);
>  	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
> -		 mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
> +		 mapp->range.start, mapp->range.end, abo->type);
> =20
>  	if (!mmu_notifier_range_blockable(range))
>  		return false;

[Severity: High]
This isn't a bug introduced by this patch, but does this invalidate logic
safely handle partial unmaps?

When user space partially unmaps a VMA, mmu_notifier_invalidate_range_start=
()
notifies the driver with MMU_NOTIFY_UNMAP. However, further down in this
function, hmm_unreg_work is queued unconditionally:

    if (range->event =3D=3D MMU_NOTIFY_UNMAP) {
        down_write(&xdna->notifier_lock);
        if (!mapp->unmapped) {
            queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
            mapp->unmapped =3D true;
        }

Since this destroys the notifier for the entire mapping without verifying
if the entire range is being unmapped, could the remainder of the VMA
stay mapped in user space without an interval notifier, leading to device
hardware performing DMA to stale, freed physical pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609011242.2833=
740-1-lizhi.hou@amd.com?part=3D1
