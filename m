Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05225CA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B3710E9B2;
	Sat,  3 Oct 2026 17:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iPAg4ffC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4826410E9AD
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 316CE4486D;
 Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465DD1F008BD;
 Sat,  3 Oct 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050238;
 bh=0mxsnUa9XVZw7tAYkGSJyqCMKbxZYuDBVrOKZUgJJK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iPAg4ffCGQa76+RxgZDCA2VwMkgafBfFsECijlMW9IyK6gyRRCWwDOD5GlUklSiLo
 9hUNjVT6IHAJe5udZ8RBy4NHuoPGXXEVxoRgS+3KIbCG00hy9pRe07RUzyoXStkTiN
 y/+V84A2JgN16tPY2y2GzOFAScwEOd9QswNgs1IRyfoXgmk9bS7lvXSOzVetfvThUy
 UJxgh5TEhzSBgCHA0pbYh3cNHanZ0YA4gw48kkqFbYMkKTYg7IwmTIbWfqCijwr2zy
 nXpIc5SILHJ8Pv9/YpB2fqiyeQ7256HEEFg/1CuWW96hmoIrizXwHjsdC5y0wv5slB
 U7y9glXpF7nmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 38/38] mm/huge_memory: remove vma_is_special_huge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-38-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-38-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:16 +0000
Message-Id: <20261003175717.465DD1F008BD@smtp.kernel.org>
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

> vma_is_special_huge() tests whether either the VMA_PFNMAP_BIT or
> VMA_MIXEDMAP_BIT is set (i.e. whether the VMA is not mm-managed),
> but with a DAX carve-out.
>=20
> DAX however no longer sets VMA_MIXEDMAP_BIT, so this carve-out is no long=
er
> required.
>=20
> Therefore test for !vma_is_mm_managed() instead and also drop the
> VMA_IO_BIT check, as it is now redundant since it is enforced that
> mm-managed mappings may not set VMA_IO_BIT.
>=20
> This also eliminates another overloaded use of 'special' within mm.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D38

