Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA21CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C94B10E988;
	Sat,  3 Oct 2026 17:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hlKFlBbO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438A210E984
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC9E760DB8;
 Sat,  3 Oct 2026 17:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69F51F0089E;
 Sat,  3 Oct 2026 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050217;
 bh=yGZ63lBideQLacZz14i18qtGsmnxQTUO08t8Q3rPVsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hlKFlBbOJnLe0+/drHmdYmgNCqpCVEY/mwNelXGzcknf6cbBjO+/2yla0lCk55yMP
 SLepTAFzZnvpLAuILypiGEqmOvonU3grRCBRl12Q9yghzz86+WsR3THOrAhrrRQiSx
 polgTrc7NyXF12fphKJDGiRIih/A3W6oyb47fdbwhY+RANeh7Fw1IFogqN/TEKJn2b
 FP/KXWUCybhKMzKiWLWaS5fmELv2z4B3WyssvnbgwoI34A8rHvz9/tH9FTDknEsdlK
 XqRz+FOQWhrpRuy2HVg/gPF6fI5pOB97ExuAh19IxcdLjPq++Q0vg0IinM49WSranZ
 dfTJze7iA9F8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/38] mm: remove VMA_IO_BIT check in
 vma[_flags]_is_mm_managed()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, linux-rdma@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-scsi@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, selinux@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-25-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-25-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:56 +0000
Message-Id: <20261003175656.A69F51F0089E@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D25

