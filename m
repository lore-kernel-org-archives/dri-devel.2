Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E396CCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0960F10E0C4;
	Wed, 24 Jun 2026 17:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HefBdyHQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368C210E0C4
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAB9B43A63;
 Wed, 24 Jun 2026 17:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686111F000E9;
 Wed, 24 Jun 2026 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782322296;
 bh=ialLlhmDOplGZ28xq/iQiNYrY4G01OSAOz8Wa25h/Ck=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HefBdyHQBsX8oqj5SyMT86DVy4cc/pzIFOmuwMksqe4Z0CckqJtgVYQh8qAqfu+ii
 ct58w3PoLZx8bb84PH8sJrqgjcXSxCZexQRDTpl/mdt4TWExAZnz61sEYZI6U6jF6Y
 4KzgRexa8M/z1JsezEMAqbDpeLlPnxwUlanT1v27xYycv2+vRe0ToNBQT0eAugZ6W8
 ri5ekaV+TQYExFWZWGtcsrEtC89CAn0zfudDfaI0H9HhYv5cTlx6SHy5MW7fN23hXk
 1Ab1oj+MWdIJ36novZN0A5d8Yk/04MV6oipgoz3/ZocTSprr5v+yGBE7AqxgWWVmQY
 8dOt/29pzsVfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624172029.2508-1-alhouseenyousef@gmail.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:31:35 +0000
Message-Id: <20260624173136.686111F000E9@smtp.kernel.org>
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

New issues:
- [Low] Duplicate `if (!bo_va)` check introduces redundant logic.

Pre-existing issues:
- [High] Deadlock risk due to GFP_KERNEL allocation with dma_resv locks hel=
d.
- [High] Denial of Service risk via unverified large kernel memory allocati=
on.
--

commit 3feae89c84a776461a942a018d277330e825a587
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

drm/amdgpu: reject mapping info for unmapped BOs

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
iterates the valid and invalid mapping lists unconditionally. A GEM BO can
be queried before it has been mapped into the file VM, in which case
amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.

Return -ENOENT for an unmapped BO, matching the VA operation path that
already rejects missing BO-VA state before touching the mapping lists.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 28f89ae8ca745..4ef08737390a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>  		struct drm_amdgpu_gem_vm_entry *vm_entries;
>  		struct amdgpu_bo_va_mapping *mapping;
>  		int num_mappings =3D 0;
> +
> +		if (!bo_va) {
> +			r =3D -ENOENT;
> +			goto out_exec;
> +		}
> +

[Severity: Low]
Does this introduce a redundant check? There appears to be an identical che=
ck
immediately following the comment block in amdgpu_gem_op_ioctl():

		/*
		 * num_entries is set as an input to the size of the user-allocated array=
 of
		 * drm_amdgpu_gem_vm_entry stored at args->value.
		 * num_entries is sent back as output as the number of mappings the bo ha=
s.
		 * If that number is larger than the size of the array, the ioctl must
		 * be retried.
		 */
		if (!bo_va) {
			r =3D -ENOENT;
			goto out_exec;
		}

>  		/*
>  		 * num_entries is set as an input to the size of the user-allocated ar=
ray of
>  		 * drm_amdgpu_gem_vm_entry stored at args->value.

[Severity: High]
This is a pre-existing issue, but does this allocation risk a deadlock when
memory pressure occurs?

amdgpu_gem_op_ioctl() {
	...
	vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL=
);
	...
}

Using GFP_KERNEL here allows direct memory reclaim, which can invoke the DRM
shrinker. If the shrinker attempts to acquire dma_resv locks to evict buffer
objects, it could cause a circular locking dependency (ABBA deadlock) since
gobj's dma_resv is already locked earlier in this path via drm_exec_lock_ob=
j().

[Severity: High]
This is another pre-existing issue, but does this same allocation allow for=
 an
unbounded memory allocation that could lead to a denial of service?

amdgpu_gem_op_ioctl() {
	...
	if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
		r =3D -EINVAL;
		goto out_exec;
	}

	vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL=
);
	...
}

An unprivileged user could request an allocation size up to INT_MAX (~2GB)
because the kernel does not verify the actual number of mappings before
allocating the vm_entries array based solely on the user-supplied
args->num_entries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624172029.2508=
-1-alhouseenyousef@gmail.com?part=3D1
