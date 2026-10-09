Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C10CA9EC1
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848BA10EB11;
	Fri,  9 Oct 2026 18:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HLqJTBNT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07E310EB11
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:47:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FD2360267;
 Fri,  9 Oct 2026 18:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C861F000FF;
 Fri,  9 Oct 2026 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571658;
 bh=mLlOFaw/IlJZnvJ/4xxpVCtKs3elyFr6/EuYxK+WsAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HLqJTBNTQI+DMSuFOj7AqNFJPmjCsLNI/umMw+QNgwVgaLZlsBcDqiHahrE2PcNv1
 kqZkhRrN/kDmCtQnsXSSaaT8ga6dT9tFJAwfV+9f9oMuHy1If9uuX5es7diAu3W8sS
 +dX1b9JMhQMPVlCpbrM9xmL0xp21DKimVpTg3G5OhakXTY1xmjiJLKfJN1P1Gpv6gA
 fcJ5Kd61r/ENOVuDCagyA/i/laFHRXNNqUrsrrK66WagciziwnY8mjSrpZ0kIkaWLz
 j/rSdVYAxJ2/0Z+IB0s22fCLlfKRymRSVJ+4l2ouCDQYA97/B+pGwrUdIwcFFRY2qd
 WWZ6k9ekmOWkA==
Message-ID: <sashiko-outbox-165972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 32/38] mm/madvise: use predicates for madvise(...,
 MADV_DOFORK)
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-usb@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev,
 selinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-32-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-32-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:47:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D32

