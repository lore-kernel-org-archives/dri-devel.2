Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948E1CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC1810F2CB;
	Thu, 25 Jun 2026 14:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MNI1pI5+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0918410F2CB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CDE660018;
 Thu, 25 Jun 2026 14:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63CB1F00A3A;
 Thu, 25 Jun 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782396238;
 bh=uHWTL7LJEM6fU/6LiGYusl4aDKnB2Rmm27qS5l8djlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MNI1pI5+2XnCW9Za8k138PJ2TVbwwd3ev5pyoiZG+30e1QAgvD4JM2m2ZcTFwEvDq
 ifnk0X4UEDsPEukH32RWKx9+nv94/mVHJbtQis+j7FoX6mqbg9WTNRjTd4aUcKFPeS
 YT69vhRo2nUwba8sVH2xeo+g44nV4WErtbLBskm0ssNkkgYp2Td1j0Nz16/7i16gMq
 UCJ8JtdhT1dfYPx+ZiY0PA7OC1h0qvEvISrDcdA3sT2HIPIK1iu87ZzNhw1CvDQAs0
 Dvtfjv6Aesl5hGdIx0dPE5oCLVgDgDNkFYu+pJyiMkP0oY2G16gYAb92Z5BXfWQTl4
 BGkBim00WNyBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625135341.1159-1-alhouseenyousef@gmail.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <20260625135341.1159-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:03:58 +0000
Message-Id: <20260625140358.B63CB1F00A3A@smtp.kernel.org>
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

New issues:
- [Medium] Duplicate check for `!bo_va` introduces dead code and changes th=
e returned error code without justification, while the commit message incor=
rectly claims the list was walked unconditionally.

Pre-existing issues:
- [High] Memory allocation using `GFP_KERNEL` while holding `dma_resv` lock=
s, risking AB-BA deadlock with memory reclaim.
--

commit 6e50ec4c3e751796a8ad26f809bc3ef0737b1ddc
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

drm/amdgpu: reject mapping info when BO VA is gone

The commit adds a check to return -EINVAL if the BO-VA mapping is missing
during AMDGPU_GEM_OP_GET_MAPPING_INFO. It claims this prevents unconditiona=
lly
walking the lists after a racing close.

> If a racing close drops the last handle reference in that window,
> amdgpu_gem_object_close() can remove the BO-VA before
> amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
> unconditionally.

Is it accurate that the ioctl walks the BO-VA mapping lists unconditionally?

Looking at amdgpu_gem_op_ioctl(), there is already a pre-existing check for
!bo_va that returns -ENOENT before any lists are walked.

[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 28f89ae8ca745..f048bbc4c672e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>  		struct drm_amdgpu_gem_vm_entry *vm_entries;
>  		struct amdgpu_bo_va_mapping *mapping;
>  		int num_mappings =3D 0;
> +
> +		if (!bo_va) {
> +			r =3D -EINVAL;
> +			goto out_exec;
> +		}
> +

[Severity: Medium]
Does adding this check introduce unreachable dead code just below it?

A few lines further down in amdgpu_gem_op_ioctl(), there is another !bo_va
check:

		if (!bo_va) {
			r =3D -ENOENT;
			goto out_exec;
		}

With the newly added check returning -EINVAL, the pre-existing -ENOENT
check becomes unreachable. Is there a specific reason to change the error
code from -ENOENT to -EINVAL?

[Severity: High]
This is a pre-existing issue, but can this function trigger an AB-BA deadlo=
ck
during memory reclaim?

Further down in amdgpu_gem_op_ioctl() for this same op:

		vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNE=
L);

This memory allocation occurs while holding the dma_resv locks after
drm_exec_until_all_locked() has successfully acquired them.

Allocating with GFP_KERNEL under a dma_resv lock allows direct memory
reclaim, which can invoke the graphics shrinkers. Shrinkers often attempt
to acquire dma_resv locks to evict buffers, causing a deadlock if the
thread already holds them.

>  		/*
>  		 * num_entries is set as an input to the size of the user-allocated ar=
ray of
>  		 * drm_amdgpu_gem_vm_entry stored at args->value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625135341.1159=
-1-alhouseenyousef@gmail.com?part=3D1
