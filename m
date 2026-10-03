Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35490CA5FF0
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABE610E9AD;
	Sat,  3 Oct 2026 17:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G7R5W+5o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEA110E9AD
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 358EB4080B;
 Sat,  3 Oct 2026 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804691F008A3;
 Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050239;
 bh=DBaEZLeORgCi7ZNKkb2bttUus6/jcwyebZupu2FrDxE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G7R5W+5oTk5xv0YsoKXnGPkj0s7JOOQJhOd9Ux7YUXcVkp7Qxtts9bngS/2sEJBG7
 dAXAfk4hLIZB+PiddKg6PDehXM1BENa2k1BItqZ2/3TDQYbKisf3BMRPMKYccwi8YH
 C2+yw5oP8+yR8EQ6/iOR8LmsoTTyoAepyWcP/XmnlQkdA9vcg5MDpAsR7GcpiK7UGF
 jDmrBmJJFa7yrmU4EoKCuBsOhNkfRZfgwkM3A2mE9DGTBLf0IPDcyzveEEgMEfNFgK
 QKpa/oLV9ScRR2skG2vX7PHhCOkFUyA36uVkj+BlKMKEs9zR+h1fbpRYDNNzY3RRXO
 LlD6ppcZ9h42g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 35/38] mm: avoid use of VMA_SPECIAL_FLAGS in
 migrate_vma_setup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-scsi@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>,
 linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev, selinux@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-35-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-35-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:18 +0000
Message-Id: <20261003175718.804691F008A3@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D35

