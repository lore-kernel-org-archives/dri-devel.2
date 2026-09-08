Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE865C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FE110ED78;
	Tue,  8 Sep 2026 20:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLqvSoZ9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04CD10ED78
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34CF2601F6;
 Tue,  8 Sep 2026 20:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474C71F00A3A;
 Tue,  8 Sep 2026 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899830;
 bh=vKY+yw4xM33mk6fiECJIDoF9uX3TRcvPPahTr1AkOwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NLqvSoZ9u/s7AzQdCGQbOwpQQATcRISGifpcG89xXd60mummWSH13rJhgxmZ89q2l
 aTDv/ryxne2Dd36UI6UOzlWG/1ScTwNOrJJHzrzTBD81Uoq3Isz9pYyXhA5vwXLk0B
 JVgL2qSIUHniv05ZRAyur6eZyKlAfLUZsBv9sXQIMm9npiUST0YBWRKdDtIUA+VDXE
 /Oaa0iJyG+JjPhNyb5E4dMgnvGFGSRv100vFoQnJdISw2Rl39Pow4AN/I20yQyW7IG
 DWR4fyydePQNnsp3ifWDMdYR1E38Bpnjr5WoHMaDA+L4Bxs065WG4mnjwrXdLHMfsT
 R7EqJORON9kQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/39] mm: remove VMA_IO_BIT check in
 vma[_flags]_is_kernel_owned()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, bpf@vger.kernel.org, linux-scsi@vger.kernel.org,
 selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-25-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-25-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:37:08 +0000
Message-Id: <20260908203709.474C71F00A3A@smtp.kernel.org>
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
> as kernel-owned.
>=20
> However, vma_flags_is_kernel_owned() currently checks for VMA_IO_BIT. This
> was a product of drivers previously marking a range as kernel-owned by
> setting VMA_IO_BIT alone.
>=20
> Fix this by removing the VMA_IO_BIT check in vma_flags_is_kernel_owned(),
> and update mmap_validate_vma_flags() to use vma_flags_is_kernel_owned()
> rather than open-coding the VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT check.
>=20
> This change means that vma[_flags]_can_merge() doesn't check VMA_IO_BIT a=
ny
> longer (which is now redundant) as it calls vma_flags_is_kernel_owned().
>=20
> Now that the predicate means precisely VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT,
> [ ... ]
> Finally, update the VMA userland merge 'special' flag tests to no longer
> assert that VMA_IO_BIT prevents merge as VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT
> now suffices.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D25

