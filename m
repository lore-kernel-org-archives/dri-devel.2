Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C3B10F565;
	Mon, 14 Sep 2026 22:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CvoJgdSX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0579910F565
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:16:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7CBC43431;
 Mon, 14 Sep 2026 22:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F11F000FF;
 Mon, 14 Sep 2026 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424177;
 bh=XamPDl9NXlZRtpllZkc5ElLHE++HgOKjnxkf4Fhft6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CvoJgdSXfrot0Eqzk4UtAnIGExifHja0JllTayBjcyT6eWu8erwjsAt3Rlose/UYB
 lyNGDm7U1L1NDxiEyu2xM0YoCTVS6Qryy6hNRSfBBQvMfXE9fXop5P5XnOwIQIqnSB
 huWU82Zvf/cK08nAFvbPSjQWQ5ZtZl77bwkv4rlahqbFCxPqsWZQUTrhK0HIjwUbaN
 DcfgooTbIXdNK6cQJXY+7a4ghthtLVTa2tNsz7wL+ojGoSpu1zXllT3bhNiav2tqyC
 /Q5cBOdIkSQ5hnHRVizPKvFMYRawtoBHh1qFPOvyUcmA/aUUxCz4Lwrs9ldiRq6G0j
 s+15ujKGfQXzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/40] mm/uffd: use predicates for userfaultfd checks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, selinux@vger.kernel.org, bpf@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org,
 "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-32-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-32-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:16:16 +0000
Message-Id: <20260914221616.D57F11F000FF@smtp.kernel.org>
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

> Rather than directly checking VMA flags, use the newly introduced
> vma_is_kernel_owned() and vma_is_persistent() helpers in userfaultfd when
> assessing VMA suitability for userfaultfd and UFFDIO_MOVE.
>=20
> Update vma_move_compatible() so it's expressed in terms of VMA
> characteristics rather than arbitrary flags.
>=20
> Additionally, update the use of the deprecated VMA flag API when checking
> VMA_SHADOW_STACK_BIT.
>=20
> A VMA_IO_BIT check is no longer required but that is fine as a hard
> invariant has been established that only kernel-owned mappings may set
> VMA_IO_BIT so the check is now redundant.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D32

