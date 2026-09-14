Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7F3C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92D510F70E;
	Mon, 14 Sep 2026 22:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k3EQhx8Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CC110F6E3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C419B41FC6;
 Mon, 14 Sep 2026 22:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24AE1F00893;
 Mon, 14 Sep 2026 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424770;
 bh=K1whoTuIPvEZm+ajxZr6H/l62B8RMmj9n/opWEIrEDI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k3EQhx8YjtQQr0FX+doB7EYdJiI4X1NTivVkUGkPbXEoXt5VY6fVpx7n/0rf7DaPz
 GzdXtVl6t0enNdnjLEEVzxcwmw4bnQeFRYcvfn/F5O0VhyRqU8D1Z5eeF/YUQWhH/N
 M6W8eNXP3ccZ/whhTNZZp+lXQEpNz2XoD5Z9fBz5II9YhXaP5lfDOs7zbcqJg+jl+7
 voNiCu229AvnThBQ6Z8SpXX4Kl9lJEPYGpEy6A38L8n2NkP8ivA2Qb6OuvxFjkv6fG
 m9Ll+4qTqyJ87rc3QyukjjnFXoneu82DyTV6ObWN/nDll6+gjWxGgBUptoqw6JS/rp
 hvmCE5zVgDUjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 39/40] mm/huge_memory: remove vma_is_special_huge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 "Oliver
 Upton" <oupton@kernel.org>, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, selinux@vger.kernel.org,
 kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-39-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-39-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:26:09 +0000
Message-Id: <20260914222609.D24AE1F00893@smtp.kernel.org>
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

> vma_is_special_huge() tests whether either the VMA_PFNMAP_BIT or
> VMA_MIXEDMAP_BIT is set (i.e. whether the VMA is a kernel-owned mapping),
> but with a DAX carve-out.
>=20
> DAX however no longer sets VMA_MIXEDMAP_BIT, so this carve-out is no long=
er
> required.
>=20
> Therefore test for vma_is_kernel_owned() instead and also drop the
> VMA_IO_BIT check, as it is now redundant since it is enforced that only
> kernel-owned mappings can set this flag.
>=20
> This also eliminates another overloaded use of 'special' within mm.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D39

