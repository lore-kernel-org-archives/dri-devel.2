Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D83CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B73710EB07;
	Fri,  9 Oct 2026 18:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j5IhKus+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3381710EB07
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:43:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE39B43FDC;
 Fri,  9 Oct 2026 18:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688491F00898;
 Fri,  9 Oct 2026 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571428;
 bh=bIFOJHKin+xwJymQQvSLKRsvhJgChfGIiEITtgqc+2Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j5IhKus+LccL6B9cA7wprNlfEFgCVVN9caVURj18qJxnl03lXOCcYQrWQz1AyOiLp
 xAqR0tXFwNCnpEU9nAUmRtJeFuzEWvhsAQ10gDLFEPoVu8cfiQ+45ZxH7814aDfaOJ
 3i6kF01tmLjJR+T4pMLhZesWleJrEKaJS8hJ5VLEqzTgpHxDrKoXIYQDhqTz3NDSA+
 yYgnAKFV9Zv6bMyjvyLrLIGGHewjtS+SXf1GokYC6wBqXa61WgQHWD0ZlYl0TQsHiX
 uKelIaQYZ46COxZSsEDPNcoOOWnsp5MKxThFm5O/1gFwgyGqO95altoOclpuL8yxyj
 cDhGJczFxuGNQ==
Message-ID: <sashiko-outbox-165964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 28/38] mm: drop some redundant checks around hugetlb
 VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kvm@vger.kernel.org, bpf@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, selinux@vger.kernel.org, linux-usb@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-28-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-28-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:43:46 +0000
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

> Adjust code which inadvertently perform redundant checks on hugetlb VMAs
> and clean them up:
>=20
> * hugetlb VMAs have VMA_DONTEXPAND_BIT set so a VMA_SPECIAL_FLAGS check
>   suffices. (migrate_vma_setup() regains an explicit hugetlb test later in
>   the series, once VMA_SPECIAL_FLAGS is removed.)
>=20
> * hugetlb VMAs unconditionally set vma->vm_ops, so they are never
>   anonymous.
>=20
> * hugetlb VMAs do not set VMA_PFNMAP_BIT so checking for this is redundan=
t.
>=20
> While we're here also drop a VM_BUG_ON() which the simplified check above
> makes unreachable, and use the new VMA flag API.
>=20
> No functional change intended.
>=20
> Acked-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D28

