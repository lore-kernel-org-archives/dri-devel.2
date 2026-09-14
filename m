Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431CAC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D92910F49A;
	Mon, 14 Sep 2026 22:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ee54wVnf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74D610F49A
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:09:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BFEA60252;
 Mon, 14 Sep 2026 22:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C61F000FF;
 Mon, 14 Sep 2026 22:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789423766;
 bh=URsiDikOU1m9AQWG4RNqOvLBN3qofHCzrj/OVx8GoD4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ee54wVnf97zCc5J3PcrklBVpZWo8uOlZlvdl31yWq2lmRKiHNb2rQtO84bnctkc9Q
 swUvPHKi3ua5swzvT6MBIyATVbcFblQZqWnjG6uVRVWPfy55NO/5McO4way+HnyQtf
 r/8fgJCQW1XzLxymA5uthEl9D3EPWEMo/HDr/H2btcwl4jTy+L1NWcah1R66tq7z1D
 eFM+QmjJ/EVytopbqDuZihYwHS8C4vOljXFrELxZdtd8aCx2uqF+TfL0vp/i0yUCuV
 KkqbNdGZzfrOVYgKzTEHzg2s4xZkO7RrK0ioH7ueq/BZMoUiUnRVlM00SeQEJyTpoh
 H3OC6nVaAJghA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/40] mm: remove VMA_IO_BIT check in
 vma[_flags]_is_kernel_owned()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-rdma@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev,
 "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, bpf@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 selinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-26-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-26-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:09:24 +0000
Message-Id: <20260914220925.400C61F000FF@smtp.kernel.org>
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

> We have now made it such that every driver which sets VMA_IO_BIT marks it
> as kernel-owned.
>=20
> However, vma_flags_is_kernel_owned() currently checks for VMA_IO_BIT. This
> was a product of drivers previously marking a range as kernel-owned by
> setting VMA_IO_BIT alone.
>=20
> Fix this by removing the VMA_IO_BIT check in vma_flags_is_kernel_owned(),
> and update mmap_validate_vma_flags() to use vma_flags_is_kernel_owned()
> rather than open-coding the VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT check.
>=20
> This change means that vma[_flags]_can_merge() doesn't check VMA_IO_BIT a=
ny
> longer (which is now redundant) as it calls vma_flags_is_kernel_owned().
>=20
> Now that the predicate means precisely VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT,
> [ ... ]
> Finally, update the VMA userland merge 'special' flag tests to no longer
> assert that VMA_IO_BIT prevents merge as VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT
> now suffices.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D26

