Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63477CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B762F10EB1B;
	Fri,  9 Oct 2026 18:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TZ5rAexz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3BE10EB1D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:49:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEA71405D1;
 Fri,  9 Oct 2026 18:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81C1F000FF;
 Fri,  9 Oct 2026 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571750;
 bh=O3hl0CgJ8hJt5Vn6Rrv76b8YeVHvaAYVx4UhQfyf/Gk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TZ5rAexzQX9pb3RldVcXkpUp9sxsORHrSKjj9c1kAsE2l2/q0aZnqI9RZvie4v6V/
 8ZsBJED75V5m6dwfvCWoO5GEib1bXkykJw1woz7q7T9Rtht5HB7mOYq/kfpGBKvYF9
 IdZF+G/3Qqkla+4WsOfHLUoJbvv29k2OS25FUXbWk5ZiDGkmsKc/qzeWmHdHBvtuZY
 BzXHSyal6EGxBl0jqRnq4lEP8qErw8Ata9jgJ63hwh6fPzuYN8+QdM16SDUDYKw6tO
 0VEmDHCcEIc0DmW0WMDshINXTEsi96frDfKf5vUK6jXf+7aAk3KPtHtSON5qA3dvq1
 pR50ZHlOwpGJQ==
Message-ID: <sashiko-outbox-165979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/38] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 selinux@vger.kernel.org, linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev,
 "Marc Zyngier" <maz@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-23-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-23-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:49:09 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D23

