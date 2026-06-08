Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C7CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE52810F9B2;
	Mon,  8 Jun 2026 20:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DwW5IAxo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B1610F9B2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:35:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A7D76001D;
 Mon,  8 Jun 2026 20:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956141F00893;
 Mon,  8 Jun 2026 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780950925;
 bh=55vQvXp8tqCUe6KVd5KgtTVlOsgthM8g4L9p/vkgFuc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DwW5IAxobTECgnv7PwZu7Bg6Es9bL7VWgk0MZYhFO8TwOza/lVC7/eI+6b/oEX56G
 KO5bAiXKpO56Vu4MZlzDgfEzda/vJYl/BSgwsQnhtTUlloq3jU3AaQNqAoZqkcWCf0
 +ZGkNpK0QsYNRsB6odDAxj1kYTDLEWT2HPO+WE3lQLKKO+RL0ZUkXPzHdFKj2f+9RR
 t05UAie+Jf3J0rpLtcaqn0KD20qm5y6pg4dNOcQsNBQh6O9EzGi3gMFnj3JM1QgrQ+
 43jNecZspidcqoqhIZCWdv+rLcS25D0BqY0tVojI642j/ZXajTNPU2yA9+zNoKkg2h
 mwArBR59KQBGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Fix VMA access race
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608202828.2771524-1-lizhi.hou@amd.com>
References: <20260608202828.2771524-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:35:25 +0000
Message-Id: <20260608203525.956141F00893@smtp.kernel.org>
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
- [Critical] Using `list_last_entry()` for error-path cleanup in `amdxdna_h=
mm_unregister()` introduces severe race conditions and out-of-bounds memory=
 accesses.
--

commit c58a67e26be2ca21d6b5952f0fd92febb2fa73f8
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix VMA access race

This commit removes VMA accesses from aie2_populate_range() and
amdxdna_umap_release() to fix a potential use-after-free where a saved VMA
pointer may have already been freed. It also updates amdxdna_hmm_unregister=
()
to unregister mappings based on a boolean flag instead of a VMA pointer.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -284,21 +284,26 @@ static const struct mmu_interval_notifier_ops amdxd=
na_hmm_ops =3D {
>  	.invalidate =3D amdxdna_hmm_invalidate,
>  };
> =20
> -static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
> -				   struct vm_area_struct *vma)
> +static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo, bool unr=
eg_all)
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
>  	struct amdxdna_umap *mapp;
> =20
> +	if (!unreg_all) {
> +		down_read(&xdna->notifier_lock);
> +		mapp =3D list_last_entry(&abo->mem.umap_list, struct amdxdna_umap, nod=
e);

[Severity: Critical]
Can this cause an out-of-bounds access if the list is empty?

Looking at amdxdna_hmm_register(), it can return 0 without adding an entry
to umap_list:

amdxdna_hmm_register() {
	if (!amdxdna_pasid_on(abo->client)) {
		abo->mem.uva =3D addr;
		return 0;
	}
	...
}

If amdxdna_insert_pages() subsequently fails in amdxdna_gem_obj_mmap(), the
error path calls amdxdna_hmm_unregister(abo, false). Since the list is empt=
y,
would list_last_entry() evaluate to an invalid pointer offset, leading to
memory corruption when setting mapp->unmapped =3D true below?

Additionally, is there a race condition here with concurrent mappings?
If multiple processes mmap the same GEM object concurrently, and one
thread's amdxdna_insert_pages() fails, could it incorrectly retrieve and
unregister the other thread's mapping from the end of the list?

> +		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
> +		mapp->unmapped =3D true;
> +		up_read(&xdna->notifier_lock);
> +
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608202828.2771=
524-1-lizhi.hou@amd.com?part=3D1
