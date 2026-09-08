Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3EDC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761E810ED88;
	Tue,  8 Sep 2026 20:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gzG4DFce";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE4910ED87
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FD44601DE;
 Tue,  8 Sep 2026 20:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA91F00A3A;
 Tue,  8 Sep 2026 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900176;
 bh=HPnuUPLge9NsP89LHUM1W/NUU4VwcdvDMeWDBqRiaoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gzG4DFce0xQy5gOuNRxwgGMb97lIHOSIz0AuOpPXY6kkJzVRDVdI7eUegWWVd6SMf
 j/hstwi8mv97hIKxlxjfO+SKolfBZtqS8z2OaEj3EicCft1e2ML9akPvsBqDoHpkeF
 raCA1Zwyc1dIXNvdy+pWhh+8yOIR5rC+5Y/HESivYyOJBGIKm1C+XY09+eRhyj144C
 7w3t6hoIPB1mmtYFlpir3E+9IfGboPr7OGCaIhvECuBHGYY+TPq0SrfHlIbPBZCsOV
 x+ZuutBiAa1F0t3F2k7xQcCR8SaqjRiWDuRm1anjkIUDTGYllV7v5oGUCGZUTleIIi
 shpQ5CXK9Bpkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 33/39] mm: eliminate VMA_SPECIAL_FLAGS usage when
 hugetlb explicitly tested
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, kvm@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-perf-users@vger.kernel.org,
 kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-33-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-33-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:42:54 +0000
Message-Id: <20260908204255.5AEA91F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D33

