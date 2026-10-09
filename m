Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC255CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BF210EB17;
	Fri,  9 Oct 2026 18:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U3upDNCB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F1410EB17
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:48:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FFF240C51;
 Fri,  9 Oct 2026 18:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405131F000FF;
 Fri,  9 Oct 2026 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571717;
 bh=myCsleBd7rDtLyXwSi2Jz8qATuSPeR2suTnZ07+6mr8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U3upDNCBaIB4EBHmX5GK6OxqFfelMjvRAapWzOFV3MpjMj26j8PFMOz3vjgZ0RYFp
 7eqIVT88/1NoQpO1en1J8p1apa/fnae6nRVOHVlqytTS7x1H31QOkCo4ImdG4x5w65
 BgxHg64v9rb77suVsDW/X4CKDMzOfiPtRWn6vFOjz2bEDgpXEsNAkduNeqnF2/P3oO
 JBbEQ5YxhCHLEthmk20sB1mOWqZpskaabixRCq1NRdjNYz7yFzwIsqUwVkPsMTop9W
 swnSXVMYkxgU5npcgyw1F02Fv38cnhAr+k+6pB6EhRVQNJigkFEyHuNnyhdUtyah4m
 xy7hq6v/vuQqQ==
Message-ID: <sashiko-outbox-165976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 30/38] mm/vma: introduce vma[_flags]_is_mm_backed()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev,
 "Oliver Upton" <oupton@kernel.org>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, selinux@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-30-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-30-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:48:35 +0000
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

> Introduce vma[_flags]_is_mm_backed() for the purposes of identifying
> mappings which are mm-managed and whose contents were placed there by core
> mm's own fault path - rather than a custom ->fault handler - and which co=
re
> mm has not reserved the right to discard.
>=20
> Mappings not managed by core mm do not fall into this category, as they a=
re
> populated by their owner, and nor of course does memory-mapped I/O.
>=20
> We exclude fixed mappings as these have a layout core mm cannot assume
> ordinary fault semantics over.
>=20
> hugetlb mappings are fixed mappings, but core mm owns them entirely, so
> they are explicitly carved out as mm-backed, as the MADV_DODUMP check
> already does.
>=20
> Droppable mappings are excluded as core mm has promised it may discard th=
em
> at any time.
>=20
> Use this functionality to update the madvise MADV_DODUMP check to test for
> this rather than open-coding it.
>=20
> This replaces the VM_SPECIAL check which means it no longer checks for
> VMA_IO_BIT, however this is safe as we have established the invariant that
> mm-managed mappings may not set VMA_IO_BIT, so we implicitly include
> these.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D30

