Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D63BCA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5E610E9AB;
	Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GGGKTcS2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E919610E9A7
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2CDD43566;
 Sat,  3 Oct 2026 17:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF081F0089B;
 Sat,  3 Oct 2026 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050235;
 bh=8QzmomK192UuCjKCJEilSVPRLqRAwu/fnjK2QKAFSCc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GGGKTcS2A1H0M5vag4dzmTqeD7dPp45/Iqo1ZzhwYclmkZB5ViYAGZVS8SRcow/la
 supYst6SV/SQ5npqOpVOc6iadM6w9M/DtfZXE7y2Fb+LD33uYZeb0cxxObUnVAQXdx
 0NU7q87aWk7eKHXJV4pROZHVoLbIaBuSXaKypRp4XQ3tyK/DXO7AUflHTpxgbv1FLg
 c/7VDP5xxW64ECDssSoC9OUuw0Qy/29bieIr72360vayn7cgupqZfakotNULjzemqx
 Tc0x1aHwa1MyvdOokAwqlABCmUCCtMS5awGXRf/7hszDakWtSOkbwQ4HeVGxDfNXPL
 JgVb4laSPq36w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 30/38] mm/vma: introduce vma[_flags]_is_mm_backed()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org, kvmarm@lists.linux.dev,
 bpf@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-30-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-30-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:13 +0000
Message-Id: <20261003175713.DFF081F0089B@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D30

