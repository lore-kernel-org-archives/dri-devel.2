Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2638CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E774710E156;
	Fri,  9 Oct 2026 18:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FIORP8nR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99F210E156
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:43:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E84F360267;
 Fri,  9 Oct 2026 18:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DF41F000FF;
 Fri,  9 Oct 2026 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571426;
 bh=HSwubk9sFN2VqJirmaDtgctb2mn2OA3fmXV5NwYVXXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FIORP8nRPdTGuZle36NO/en6zpnKO2M9+cK/GbK1AkIF0pswjLzePJM0iEGhRI2+1
 e8So402T+YsiJULEhuMm81lht/1M5bAlfBIEfK0Biq/k/sTg5ka7hRAXK9gyZMVDV2
 yQpB0ax7SPsbw4I9cTpOoN+6WuKkBBgLfzZy+IoFirkXfpDlXG/iZJh8vCMA16vcHe
 HQ2HatFiLs/NAC1q0AQxHiUNwI3Q5EidqMAZuDNaXEe44GRMxBt+ri+sDIkQm+sghh
 SGg1V4FbLzF0MmpECVJfG52eSQfEym9Paes6tsL4BsiJdH8yve03ZTzfQCKJ+Xganc
 i+3zYCJ9xEA2g==
Message-ID: <sashiko-outbox-165963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/38] mm: remove VMA_IO_BIT check in
 vma[_flags]_is_mm_managed()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>, bpf@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org,
 kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-usb@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, selinux@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-scsi@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-25-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-25-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:43:44 +0000
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

> We have now made it such that every driver which sets VMA_IO_BIT marks it
> as not mm-managed.
>=20
> However, vma_flags_is_mm_managed() currently treats VMA_IO_BIT as
> disqualifying. This was a product of drivers previously marking a range as
> not mm-managed by
> setting VMA_IO_BIT alone.
>=20
> Fix this by removing the VMA_IO_BIT check in vma_flags_is_mm_managed(),
> and update mmap_validate_vma_flags() to use vma_flags_is_mm_managed()
> rather than open-coding the VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT check.
>=20
> This change means that vma[_flags]_can_merge() doesn't check VMA_IO_BIT a=
ny
> longer (which is now redundant) as it calls vma_flags_is_mm_managed().
>=20
> [ ... ]
> Finally, update the VMA userland merge 'special' flag tests to no longer
> assert that VMA_IO_BIT prevents merge as VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT
> now suffices.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D25

