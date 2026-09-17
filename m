Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A0DC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B43210F032;
	Thu, 17 Sep 2026 17:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CU5w8uNx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF1210F032
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:36:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6BA44016C;
 Thu, 17 Sep 2026 17:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C2B1F00893;
 Thu, 17 Sep 2026 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666605;
 bh=XJ0qh6at42huWEJyKoCj2nGu0zhfQ+f/MtIbMInQeww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CU5w8uNxxLZFLsGZ4LmrcTlWiHWiP+HGDxPK1XMovccbBuf94GKQ1wBxMj4zLuuo3
 HzOY2E74gGXUaiuQgNnxNkGCNr2HIzQgGYrdmZiUVNBKKkIcHLoz6zMw6wjZXvs72w
 WdBfjnTnm7YRH5XIN5co5v3l92cZxN+FaQuR197e0wsSes8Eg3ZJ1B3wVyAwZhYgqn
 YU43/aXCMKMd0jrEqllYbG9ikYMO2KMs7+rPbEm0WA7CljJIvjiR+huPTD+T31uC43
 QKsg6ByY9FHAE62U4X727mj2arbAqHgrBwRanzRbShKy/rIi5H4GqY8WRqjf3sAQPv
 dWdO1BFwlNPSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/40] infiniband: update hfi1 to use
 remap_vmalloc_range()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-rdma@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-11-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-11-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:36:44 +0000
Message-Id: <20260917173644.E3C2B1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D11

