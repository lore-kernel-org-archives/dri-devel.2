Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7531DC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A2710F030;
	Thu, 17 Sep 2026 17:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ssd7PpXw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ED010F02D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:34:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E689601FF;
 Thu, 17 Sep 2026 17:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEDE1F000FF;
 Thu, 17 Sep 2026 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666471;
 bh=KdBYnzSoOUWFOS8U3CtxnViyabu/LqXcHUGFNUSOJdk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ssd7PpXwb+W53EddLrnj8P6zJGEf/OLU5s+7/bvimiHxKHkoh3556uXw/lAl3Qv6+
 lz5zxHxVdG5H3rgjECM1YKMLj391oU9zsrVGhD4jDuzun4d5UsvInTQBbQ08ZgsYzu
 1sUrxKDOTZAvT7b12Gx+kKyNx7SIciKhaIEsRkl3lzaFylbHz81m3kzJJAUSBY3zjA
 3iRm2ruUZATtmO2r/ZiGa+qRo083hGbZKeFD/UqhtfHggfOjIB3eREG7aXvnyaHf5N
 hqB1sCBP4msB6lsrlOLZ9nKp4Y+EwX1TfFvw1EdJhKqNLebSWQezw36tjr1lSV0qPX
 Io5p4/7Ye1exA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/40] mm: remove VMA_IO_BIT check in
 vma[_flags]_is_kernel_owned()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, selinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-26-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-26-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:34:30 +0000
Message-Id: <20260917173431.3EEDE1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D26

