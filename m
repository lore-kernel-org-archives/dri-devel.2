Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E01CA5FED
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A007A10E9A7;
	Sat,  3 Oct 2026 17:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yl+B+hZR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FB710E9A0
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 795ED41A18;
 Sat,  3 Oct 2026 17:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CADC1F00A02;
 Sat,  3 Oct 2026 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050233;
 bh=QOQ+cwBU9GT41cprgA0JdPora2bEFAvJcCZV0BYlW7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yl+B+hZRLnwuVSdDrCpD6WunqOte3h2sHjmBF3eQv2dhSPB7OZCqfkPhcAZNDnWs0
 RBoPIdGDrugtmRBiA4MxaEHbqb2U3kLCYmjJnm3tfCaT3Td62NS/xAxri6Dbi3Wia2
 WbQEMJUYbraAXYiuZii+kUgWSbsJpoUU9k7/Md3QpeT8RQB9bniUyLNxClKJzGKya7
 2MN1SLmuyyiEa3Z19MKU+ocb6ZQ1d8v1Aj5Tr4VD9jJicQAKlD4LKrs6t9xUnyKzIe
 V0w2wTyfkkdRE97ZH24ALE90k5fZ6GKbkELgo2j43opST2j4wN6G2n4gcgM3Qzuhy5
 xO2Xqyvkql/FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 32/38] mm/madvise: use predicates for madvise(...,
 MADV_DOFORK)
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org, kvm@vger.kernel.org,
 "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, linux-rdma@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-32-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-32-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:12 +0000
Message-Id: <20261003175712.8CADC1F00A02@smtp.kernel.org>
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

> Make it clear what we're blocking in MADV_DOFORK. Previously we simply
> disallowed VM_SPECIAL i.e. mappings not managed by core mm, fixed mappings
> and
> VMA_IO_BIT.
>=20
> Now the invariant is established that mm-managed mappings may not set
> VMA_IO_BIT, the VMA_IO_BIT check is redundant.
>=20
> The rest is equivalent to testing for a fixed or non-mm-managed mapping,
> i.e. exactly the same check as whether the VMA is permitted to be merged.
>=20
> This was established by commit 0b2758f48f22 ("Require (reasonably) normal
> mappings for MADV_DOFORK") containing my hands-down favourite call out of
> all time.
>=20
> Express the same thing differently - if we wouldn't be allowed to merge i=
t,
> then we aren't allowed to manipulate CoW behaviour on fork.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D32

