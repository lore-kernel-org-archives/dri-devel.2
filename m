Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09341CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1233010E9C4;
	Wed, 14 Oct 2026 15:44:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EF710E9C4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:44:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0BC660229;
 Wed, 14 Oct 2026 15:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D251F000C5;
 Wed, 14 Oct 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791992649;
 bh=J0yrj6vqa/auUIb16YadWlvU9/dX5mNQAgrxvEyxZs0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bKAaE/QGTwedORBQRYqNZ8unpZHc/vaT5Iqu/5/reLOa7bZkQhPvurvo+mk0T+E40
 Zvk0gbfUb283ReWjLlCOnQ1sojH+ocEkXvlUyvGU993ZJf4KsI003O/B76M4GKWluz
 Y4zVF4CaDmS8lr8Jet+Bq4vFU8nkE/jGqFLYQRtkRb4XMFB9Q4PCtIsSxbglk56pVE
 xWwrtUc17WxhTHM1oossEWT8QqIhHq/LbuvuLKBsXPmAHbZrOA6JX/Ud+GsXGJP/TB
 JaiIjA6mjCgy/7TAPvxoGYGNKOzKfxGE3wUzVzPGcfiLfPamMvGPIsuwIdaQJlQXWi
 L20nLDbS63UxQ==
Message-ID: <sashiko-outbox-171485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: "Felix Kuehling" <felix.kuehling@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014153246.538155-1-felix.kuehling@amd.com>
References: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
 <20261014153246.538155-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:44:09 +0000
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
- [High] drm/amdkfd: Incomplete fix leaves lockless double-checked locking =
race
--

commit f4e452c37b6ce531530ab68a693284bf20a378b1
Author: Henry Martin <bsdhenrymartin@gmail.com>

drm/amdkfd: fix doorbell allocation race creating duplicate allocations

The patch introduces a per-process-device mutex to serialize the allocation
of doorbells in kfd_alloc_process_doorbells(). It removes the lockless check
in kfd_get_process_doorbells() so that all synchronization is handled inter=
nally
by the allocator.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index fdcf7f2d1b5b4..6af268a031f22 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -239,11 +239,9 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_pro=
cess_device *pdd)
>  	struct amdgpu_device *adev =3D pdd->dev->adev;
>  	uint32_t first_db_index;
> =20
> -	if (!pdd->qpd.proc_doorbells) {
> -		if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
> -			/* phys_addr_t 0 is error */
> -			return 0;
> -	}
> +	if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
> +		/* phys_addr_t 0 is error */
> +		return 0;

[Severity: High]
Are the lockless checks in kfd_ioctl_create_queue() and criu_restore_device=
s()
intentionally left in drivers/gpu/drm/amd/amdkfd/kfd_chardev.c?

While this lockless check was correctly removed here, identical lockless
checks (if (!pdd->qpd.proc_doorbells)) remain in the other two call sites
mentioned in the commit message.

Concurrently, a thread calling kfd_mmap() will allocate the doorbell struct=
ures
under doorbell_mutex. A racing thread in kfd_ioctl_create_queue() will read
proc_doorbells locklessly. Without memory barriers like smp_load_acquire(),
this thread can observe a non-NULL proc_doorbells pointer but fail to see t=
he
fully initialized qpd->doorbell_bitmap, or see the BO before it is fully pi=
nned
by amdgpu_bo_create().

Can this lead to a NULL pointer dereference in operations like
find_first_zero_bit() on doorbell_bitmap, or hardware access with an unpinn=
ed
BO?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014153246.5381=
55-1-felix.kuehling@amd.com?part=3D1
