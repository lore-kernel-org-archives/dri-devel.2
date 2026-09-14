Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051FBC88E77
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3564010E16F;
	Mon, 14 Sep 2026 22:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TgzPu8za";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDFE10E16F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:21:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B45A60252;
 Mon, 14 Sep 2026 22:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2121F000FF;
 Mon, 14 Sep 2026 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424499;
 bh=TxyqE9qSzKfbftv9np+eWXMq+Nx+z+yADqVfykR+bRw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TgzPu8zaFGNsdkBIdojqJ+pflk0NNEtGGpSgGWwxLKoPpSgf7VgjapuUFxxwMipRo
 O4XJmmZieKI5h8G2jU5imAoCXXCJ5cef3fIBU9uw0qI/Km2lcOrmP7D3zL2QlNY/T8
 Y2E2kd6urK7GHO4edzfVdlLNkM3R6075jjBP5N83k9iE26UeeN0OR0on5xD/Dyd9W2
 dnSFlDlnL9db2mMYWsu+ppYpDgoicvhaCMAfqJGPctUtWpI7IJmrnT7J34b219t7jX
 EcVU1T7q4bvOeDO8FvASbgzbL8TLTBTwD2jzEyh7YdTpNmt8Joak3G1of9v/oh3hDJ
 /CpPVKaz/yzuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/40] mm: eliminate VMA_SPECIAL_FLAGS usage when
 hugetlb explicitly tested
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, bpf@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, selinux@vger.kernel.org,
 linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Marc Zyngier" <maz@kernel.org>, linux-scsi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-34-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-34-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:21:38 +0000
Message-Id: <20260914222138.EC2121F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D34

