Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C549C88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621D610F152;
	Mon, 14 Sep 2026 18:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eVzMcghq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A976A10F152
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:50:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4631F43E9A;
 Mon, 14 Sep 2026 18:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429BD1F000FF;
 Mon, 14 Sep 2026 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789411853;
 bh=I9//0LB5K81ZQWzHLCCE2klREXKnr+J5NzqH0/mcr5A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eVzMcghq8e9ClZddoNA5Ip+E/BeoV7jDyaXIiVIcm28dczlreWJBO0H/ZqBViXGSL
 VKrBwP1QJSkyTapOrXr185pObMtrnMYSaHCJDRtCaCzR/sJAdKSsY66JZWh2TrOPx1
 jSPK5VXb4zdSANAwx/k6unl94prcRA0xmuhxHPKSXL9zoKYTh9qbhRi7vjpmkAHqzJ
 INsGPqEs2g+pQC2r0/8eGfUWf0ZeCtvOoGAAEqFY2RJ8nbi9GZhV2HilH6RzG1BfOL
 hPEXkJ6OpSrb9dJ0i57w8zCXGDqat4ORk2ewMXGa13pvgeceW10O2ANJDEYMSqAffe
 uXYeOA8FCPKJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/40] mm/vma: add vma[_flags]_is_kernel_owned()
 predicates
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, selinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-15-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-15-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:50:51 +0000
Message-Id: <20260914185052.429BD1F000FF@smtp.kernel.org>
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

> Rather than referring to VMA flags with uncertain meaning, add a new
> predicate that explicitly describes what possession of the VMA_PFNMAP_BIT
> or VMA_MIXEDMAP_BIT flags mean, and then refer to that function for
> determining VMA mergeability.
>=20
> Either flag means the contents of the mapping are owned by the kernel,
> usually a driver, rather than by the core mm: the memory may be MMIO,
> kernel-allocated pages or even ordinary pages the driver maps itself, but
> the core must not populate, reclaim, migrate, copy-on-write or merge the
> range on its own initiative.
>=20
> We initially also include VMA_IO_BIT here, as by implication, these must =
be
> kernel-owned. (mlock() also sets VMA_IO_BIT transiently on ordinary VMAs
> while locking them, which is addressed later in this series.)
>=20
> However the intent is to in future remove this, as no mapping should be
> marked as an I/O mapping without also being marked with VMA_PFNMAP_BIT.
>=20
> This forms the basis of further work intended to improve how we express V=
MA
> properties such as this.
>=20
> Also update the VMA userland tests to reflect the change.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D15

