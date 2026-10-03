Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23846CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A54D10E995;
	Sat,  3 Oct 2026 17:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FJxk8tJz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC3B10E98B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4BAB60D9F;
 Sat,  3 Oct 2026 17:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE8A1F0089B;
 Sat,  3 Oct 2026 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050221;
 bh=/NgCQciV8YSe9Yp6Z5A+AvBAEOtXELuAL7XD5DazBS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FJxk8tJzUmtLXb8IjjraO2tW/UFcyH+5lhTYKGCdN9Gyc2EupoqJsx4KCxb7jU4WG
 vPrUoaLKyZ5K1C7CJrk5oVpRYneJT7O06gIYdp84XqRE2nb11e0hqPktvbR5TQURoq
 xxu254tvtTZcciunr955eOXNnxD0icpq+FLAV3JQHjTtST7nd1clKIP6TZw/qmtQWu
 nI7qQQSK8DHNhoaQMBsmW76QSFxELtoa8EU5wgM7rDpFRhswU8F426rOBmEI8Jk9Rm
 p1YXV9AV560m06PPqpZLCNbmMNpUGbDPeavEW0/dGXhTau7v6OVZcz6lLEBCcfamuQ
 DZPLoDqyjxppg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/38] infiniband: update hfi1 to use
 remap_vmalloc_range()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, selinux@vger.kernel.org,
 linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-10-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-10-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:00 +0000
Message-Id: <20261003175700.BCE8A1F0089B@smtp.kernel.org>
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

> In cases which map chip memory from vmalloc()'d ranges, the hfi1 infiniba=
nd
> drivers currently installs a fault handler, and then smuggles the kernel
> virtual address of this range in vma->vm_pgoff.
>=20
> This is exposing KASLR-sensitive internal kernel state in the VMA, and is
> entirely unnecessary.
>=20
> Instead, use remap_vmalloc_range() to remap the VMA to the span, and
> eliminate the fault handler altogether.
>=20
> remap_vmalloc_range() checks that the VMA does not extend beyond the
> vmalloc area, and the driver already requires the VMA to exactly match the
> span of the memory being mapped, so this has no impact.
>=20
> The memory is all preallocated so not having a fault handler has no impact
> [ ... ]
> There is a change in behaviour in that pages mapped using
> remap_vmalloc_range() will now have normal GUP-able pages, however this
> should have no impact as there is no reason not to allow this.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D10

