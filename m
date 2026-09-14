Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5CFC88E77
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DAD10F29F;
	Mon, 14 Sep 2026 22:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PpIQW5YZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9505F10F29F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:22:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B28D41791;
 Mon, 14 Sep 2026 22:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFB01F000FF;
 Mon, 14 Sep 2026 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424571;
 bh=Z34JAPx3JGf7PaQpWdL0oB0ltwVLoFA0NQGPq53eC1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PpIQW5YZJWZwCwgTj4+9lBzo1LcS7Btc2u6NP/iaqTpuYeHkyZysVW0NE0y+HAm+2
 bKz2X2qoroAxlPLkFtS15h7sPkCEuPyrDS68n5M8DzKtexHj+RxHQOjvq3/NQkAn8a
 gg7v4pd2VYtdMEzFaFbDQ/SYn8SKN6hPVnwVc/qU54p1jd5d+xo8iJ781QAJ+CmlqH
 0Az/HvRwI78Q4ps1TXrUSkuYVAePdIchilNODFGpXcRghIlq6IelT9Gs3iNUB5trP0
 vx/jAU+tbIrNC6WVaxO/bCY8vidUDkPx207Bqhg93OXULXXiMUGJfiWPvECaPNH5/q
 A35+e5mXvj67Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 35/40] mm: eliminate VMA_SPECIAL_FLAGS check in
 lru_gen_look_around()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, selinux@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-35-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-35-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:22:49 +0000
Message-Id: <20260914222250.5AFB01F000FF@smtp.kernel.org>
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

> A kernel-owned or fixed mapping is one which sets VMA_PFNMAP_BIT,
> VMA_MIXEDMAP_BIT or VMA_DONTEXPAND_BIT, which is precisely what
> VMA_SPECIAL_FLAGS tests for other than VMA_IO_BIT, which is safe to drop =
as
> only kernel-owned mappings may set it.
>=20
> Using these predicates rather than VMA_SPECIAL_FLAGS makes the check
> self-documenting and helps eliminate the confusion around 'special' flags.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D35

