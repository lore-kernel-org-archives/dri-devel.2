Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC33CC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5FD10F2C5;
	Thu, 13 Aug 2026 11:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4Kcoc5z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C2310F2C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:18:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C6D143444;
 Thu, 13 Aug 2026 11:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073D1F000E9;
 Thu, 13 Aug 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786619932;
 bh=MQxeTbiP8ZOOqFG7aI6tdnaRgFCAyg6MCaFY/kFqwq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L4Kcoc5z9U8hhp2iIQ/OKmpWbyN1k9XqgCxSmBpcKxulUn/Sgs1rzYC1q5cmlt6DE
 YH9tK7c1ypePKnaPbsffthh7kGw1p7bKBD3bMNRf42YGMA2baBUXgcxNge1cBWUOfS
 sQX6JtJ8rY4v3g8J3ojXInKYWs57ARLX0XG6ZA31uPlgEFZxa7bn2wWSrjIh4i7Qu2
 Th9A2LsmgsJg8zhaz+pm2ehJdanhx+4Vo7WzZcSDurHC5QN6muQVwXvBnP1PhyNlow
 1MIPp7bV0iYd549zWeMr1izzsWNeai4vkwnByd8qK75rq7QLVYV8X2t7TNSHeQaxoL
 mK56QwrROt4UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/17] drm/panthor: Track user owned VMs
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-13-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-13-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:18:51 +0000
Message-Id: <20260813111851.F073D1F000E9@smtp.kernel.org>
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
- [Low] The kernel-doc comment for the new `user_owned` list incorrectly re=
ferences `@vm.list` instead of `@vm.user_owned` and contains inaccurate beh=
avioral claims.
--

--- Patch [13]: [PATCH v3 13/17] drm/panthor: Track user owned VMs ---
commit ac0f4e912e13271ec8810a284d5bae2a86d22478
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Track user owned VMs

This commit introduces tracking for user-owned VMs in the panthor driver by
adding a new user_owned list to the panthor_mmu structure. This will be
needed to fix unplug logic and prevent panthor_vm objects from being left
behind.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 5f4aab5813d52..4c01b0e4288be 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -107,12 +107,15 @@ struct panthor_mmu {
> =20
>  	/** @vm: VMs management fields */
>  	struct {
> -		/** @vm.lock: Lock protecting access to list. */
> +		/** @vm.lock: Lock protecting access to list and user_owned. */
>  		struct mutex lock;
> =20
>  		/** @vm.list: List containing all VMs. */
>  		struct list_head list;
> =20
> +		/** @vm.list: List containing VMs with a valid handle. */
> +		struct list_head user_owned;

[Severity: Low]
This isn't a bug, but is this kernel-doc comment accurate? It references
@vm.list instead of @vm.user_owned due to what looks like a copy-paste
error.

Also, the comment mentions it contains "VMs with a valid handle", but
looking at panthor_vm_pool_create_vm(), the VM is added to this list
before xa_alloc() assigns a handle:

	scoped_guard(mutex, &ptdev->mmu->vm.lock)
		list_add_tail(&vm->user_node, &ptdev->mmu->vm.user_owned);

	ret =3D xa_alloc(&pool->xa, &id, vm, ...

Should the description be updated to reflect that it might briefly contain
VMs that have not yet been assigned a handle?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D13
