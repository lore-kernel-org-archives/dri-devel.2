Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63506CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB9410E9A0;
	Sat,  3 Oct 2026 17:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z3z7KAFP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E974A10E99F
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D26D041B0A;
 Sat,  3 Oct 2026 17:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED111F00A02;
 Sat,  3 Oct 2026 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050229;
 bh=jXVmItd1jWo+YkfeJqvwLb+xsPg3KsljVnNywlc+IwU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z3z7KAFPb8/z8a9VPJfRi6+FbdhEXpiV3rJ+g2GgKAWW8ifjBmoJV/Vcxvu32Bj4O
 3VCCpfv1mQwLTFffuWGmwhXkoOuqk/k8VwF+LkxnugaRncQcVTDNoVST7qIgqXmqDd
 1eyV47+rE21j6F4fe9b31IIyCcAal+3VtQP8nv384qhpHa2BbJvy9A7xDSShdcX+hD
 e7GLz9DYCLWAQfJH9RZ398BujKwK3Y8sVfW56Hqwa/TUaWZTJ5BSN5QPivFAWRqJKN
 He0IgOuYPglg8ttw710Y8v3Ypy7m15x8mhO8PYFgAUSuZdL0x1yWe538gIw/beNMzo
 CVjkaCvkBv2EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 29/38] mm/madvise: update is_valid_guard_vma() to use
 vma_can_merge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-29-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-29-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:08 +0000
Message-Id: <20261003175708.DED111F00A02@smtp.kernel.org>
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

> We currently disallow the installation of lightweight guard regions in VM=
As
> whose flags intersect VMA_SPECIAL_FLAGS or VMA_HUGETLB_BIT, or
> VMA_LOCKED_BIT unless allow_locked is set.
>=20
> hugetlb VMAs set VMA_DONTEXPAND_BIT so this was already redundant,
> VMA_SPECIAL_FLAGS already sufficed.
>=20
> However, now that VMA_IO_BIT is only set if VMA_PFNMAP or VMA_MIXEDMAP_BIT
> is set, this check collapses to being the equivalent of
> !vma_can_merge().
>=20
> Update is_valid_guard_vma() to reflect this.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D29

