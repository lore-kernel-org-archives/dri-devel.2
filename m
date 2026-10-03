Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF86ECA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C7910E98B;
	Sat,  3 Oct 2026 17:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JGKwLDL1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67A710E98B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A02C60DA1;
 Sat,  3 Oct 2026 17:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8171F0089C;
 Sat,  3 Oct 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050220;
 bh=MQxJazrbjhgm0gRarbkFujbF+zlkwv7DxlNa3s+HWj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JGKwLDL1gw9CF1kbvunBYS9hoASwUwjP/uAAfYAwjXRMKLQODllvvSushKdkFJxSo
 tk78ZPjNFXNxl49d/ciKHFV/vajcGNQl2vVWSQ+Wqw9+keCnqGfkv5VnD2mAphJWdL
 D66dq19ybXiijdCVz7ucr8z/d89AiYq9YBF7nfpui3Yy+5uqDdIxiQd6y37hPpTjHw
 jsVlqh2dgKynbd+5+KJaXB+pdYG43GVHSruDMp2MFoQ9OKAdFL0cnDFrz/b6sUcWgz
 M+9WkqF9s+C2NrpPe+l8DWI5gvb2QD0dmMV5d1kBNauG5iWa50FVN36vPQNKXvz7FC
 PHq8xPgEiCIxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/38] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-rdma@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-scsi@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-23-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-23-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:58 +0000
Message-Id: <20261003175659.4C8171F0089C@smtp.kernel.org>
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

> When performing mlock() or munlock() otherwise normal VMAs have VMA_IO_BIT
> solely to fix a race with migration which might otherwise double-count
> mlock VMAs.
>=20
> This is unnecessary - at the point of applying folio mlock state, whether
> setting or clearing PG_mlocked, we know whether or not we are locking.
>=20
> Solve this in two ways - thread a boolean through the page table walk
> indicating whether a lock or unlock is being performed, and run a locking
> walk with VMA_LOCKONFAULT_BIT set and VMA_LOCKED_BIT cleared.
>=20
> This state never occurs otherwise, as VMA_LOCKONFAULT_BIT always implies
> VMA_LOCKED_BIT. These are also always cleared together.
>=20
> Then, update folio_add_lru_vma() and mlock_folio() to check only for
> [ ... ]
>=20
> While here, also replace some deprecated VMA flag predicates.
>=20
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D23

