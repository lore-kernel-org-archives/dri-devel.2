Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C209CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE56310ED5A;
	Thu, 17 Sep 2026 17:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FDxiI0WY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6BA10EC68
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:45:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DEE9600D4;
 Thu, 17 Sep 2026 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320DF1F00898;
 Thu, 17 Sep 2026 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789667125;
 bh=O5H1hZshSBJhIdHc0JA75duWW0fV+utc0ymv/zcPeG4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FDxiI0WYmPE+oVgUqhtaheFOAWoC1aqIFOC2otsBZmnP/i9esxnpXeU9vwojN6bTO
 Qha23w5ktUfKIX7sLWtEN01QMYTSdhScryve/O5xXGgoNDgc8PSArdNBaGp6Cux1OX
 uMxsbCetIg4fqFjXqBUzFFChH8stVNOQqrQE68cKAEAFS7Qkoh5MmNQ3FehqtoanSa
 lGJKNeHXBPASZ4VtHRu71cHXxpPUPJOmUNoNDXI/ye9PqTf+JS+z05lEOfyMDs1dJs
 tasrjzN4CkUzwhCxybqUD8eTXVENeS38ol4pqdEbSPTCy7doGx5k2YpFZkBbVC3umv
 +PnUcy8bkc1Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 34/40] mm: eliminate VMA_SPECIAL_FLAGS usage when
 hugetlb explicitly tested
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Marc Zyngier" <maz@kernel.org>, selinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org,
 "Oliver
 Upton" <oupton@kernel.org>, bpf@vger.kernel.org, kvm@vger.kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-34-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-34-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:45:23 +0000
Message-Id: <20260917174524.320DF1F00898@smtp.kernel.org>
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

> It is now an invariant that VMA_IO_BIT is not set except by kernel-owned
> mappings, so each existing VMA_SPECIAL_FLAGS test need only test for
> VMA_DONTEXPAND_BIT, VMA_PFNMAP_BIT and VMA_MIXEDMAP_BIT.
>=20
> This is precisely a test for a kernel-owned or fixed mapping.
>=20
> Update a number of callsites which already explicitly handle hugetlb
> mappings.
>=20
> vma_supports_mlock() and ksm_compatible() also explicitly bail on droppab=
le
> mappings - detecting kernel-owned, fixed or droppable mappings is handled
> by vma_is_persistent(), so in these cases use this predicate.
>=20
> should_skip_vma() tests for locked, kernel-owned or fixed memory (having
> already excluded hugetlb mappings) so simply test for those there.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D34

