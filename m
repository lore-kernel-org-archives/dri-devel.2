Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E59FCA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7242E10EB1E;
	Fri,  9 Oct 2026 18:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g6Ohof9q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B300E10EB1E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:50:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92F3441859;
 Fri,  9 Oct 2026 18:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6434E1F000FF;
 Fri,  9 Oct 2026 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571804;
 bh=Enmdzzj0sP8U+nehEBpABhud7J5njQLUQed3l3DuJ2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g6Ohof9qHl8tFsb7i5dHYSMyT9/Dj/MD6eMWnehlErSA2yf5Bn93DKoTT502HVOsc
 1gJEHcbFYg4+JpO4MOzXLOBapnopIBQUXeiUcQh37J33r+YQoFh9VPBYw7r5KPDFfK
 K9Q2H6ulqq1EQHnXj3vaG+jJuikPRaSYtFpQjLk9/ZEJp+DgvdjZvm/bcVTfOtKJbW
 BgcZwoIgTu/4HnZKXglDyUB2RzWGTHr36mKLVqH28XNcZw5/B/C2mGNlqUgem6FNNZ
 nZjs56FOSB525VRVUCeL2De5HoxIb+Bge4x4hfctEjNWmMxMjKt5MtFvbvywPWQq2P
 dMV2p6aMTcBhQ==
Message-ID: <sashiko-outbox-165982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 35/38] mm: avoid use of VMA_SPECIAL_FLAGS in
 migrate_vma_setup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-usb@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, selinux@vger.kernel.org, linux-s390@vger.kernel.org,
 kvmarm@lists.linux.dev, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-35-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-35-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:50:02 +0000
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

> Now we have the expressive vma_is_mm_managed() and vma_is_fixed_mapping()
> predicates, use them to determine whether to proceed with migration. This
> drops the VMA_IO_BIT test, which is safe as mm-managed mappings may not s=
et
> it.
>=20
> hugetlb mappings remain excluded, as they are fixed mappings.
>=20
> No functional change intended.
>=20
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D35

