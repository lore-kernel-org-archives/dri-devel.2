Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041ACA5FF0
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C954710E9A8;
	Sat,  3 Oct 2026 17:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="itBPGsKD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F186C10E9A7
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB01A403A2;
 Sat,  3 Oct 2026 17:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5AD1F008A7;
 Sat,  3 Oct 2026 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050236;
 bh=UUQsrvx8/5TX6+rkKkzjqv5g7+EQwrzRsGJpOkhwMh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=itBPGsKDC5orPTgI0bU4+blQXNfWnL/Gd/SCL0C7KdjwLdRe4AoIM6uC4N9qPLDsm
 0tfkYAC77wNg9th+OXZ405eAYu8A2HGDqoLVOuSztP9e5JA0GIXwOZOKWMKJ3WtMya
 dGYTS85RhkBpKm29e1d89gJp+80NWhVukx6gPzJ5cZB1PenpmZW6jppa57GQgDIJiV
 8OPe/FdV++eOHR2BHguTN5SIR4gI9NKBZywwgVLs788ef4UZ0LpqO9c0qmdTlLZ9BZ
 g3NRIQAbiffs2OMj/p2YSps/CZiQjLjdrRfIrBi94wxe8smKt7iqqQHaDDEo7Jczcq
 Sux2z5iBaIpdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/38] scsi: sg: convert mmap hook to mmap_prepare
 and rework
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-scsi@vger.kernel.org,
 selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, bpf@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-17-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-17-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:15 +0000
Message-Id: <20261003175716.2F5AD1F008A7@smtp.kernel.org>
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

> Move from the deprecated mmap hook to the new mmap_prepare hook.
>=20
> We are mapping kernel pages here, so use the discontiguous kernel mapping
> mmap action to do so.
>=20
> Unwind the rather confusing loop and instead map as many pages as we can =
at
> one time.
>=20
> Note that we do not need to pay attention to rsv_schp->k_use_sg here, as
> the pages are populated for the length of the buffer at
> rsv_schp->page_order granularity as compound pages.
>=20
> The discontiguous kernel page mapping logic handles the compound pages for
> us.
>=20
> sfp->mmap_called keeps the buffer stable for us. As before it is never
> cleared, so a failed mmap also leaves it set.
>=20
> We also remove some useless vma, vma->vm_file NULL checks - these will
> always be non-NULL if you reached the mmap hook logic.
>=20
> We retain log output for consistency, but change what's output on page
> mapping to indicate that sg_discontig_get() does the work now.
>=20
> Note that we drop the VMA_IO_BIT flag for the VMA here. It was never
> necessary as we invoke alloc_pages() which gives us refcounted folios that
> are fine for GUP to access (VMA_IO_BIT would prevent that).
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D17

