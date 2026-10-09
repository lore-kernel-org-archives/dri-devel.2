Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69A2CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AE310E649;
	Fri,  9 Oct 2026 18:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UBQSQElt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4729610E649
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:41:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDA3060267;
 Fri,  9 Oct 2026 18:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA81F000FF;
 Fri,  9 Oct 2026 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571304;
 bh=koP1Z9CZm/xKMbdyR1YkUTISaE1uE4NJvhP8UiPCNcM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBQSQEltlf58pXyfBUgcflfQu49vXzilhQkb4oLU+VgUkQv9P2cTQJ/TRv2j4K4Ib
 2StTtrKpHTUSrI4kcnhBvAwZYZHMffrFwOJzi6SK8rTEWyTyzZJfi/keWqyHcK2nZv
 RrTcIldU4n+0YJFu0IxC1F5hregzXEMRMEOhitZ587TqM4fZmNVrbB3u0DizuSxQ6y
 ofemRYnJeFdW8pCWVGEGiQkwOj1phG/0B4dCYLVtssUEax9PXA9UncpHBrq/m6S9jV
 vDbspnK0RQ3z/YTkzcNhtbEV3VddY6JkunYr9UtQlUI8WNpvqQXih29qYYVC5rRMVw
 mxt4h1d1RVjeQ==
Message-ID: <sashiko-outbox-165962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-scsi@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 selinux@vger.kernel.org, linux-perf-users@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-21-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-21-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:41:42 +0000
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

> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>=20
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this is
> the appropriate flag to set for those.
>=20
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>=20
> However this has no meaningful impact as these are refcounted and thus can
> be GUPed.
>=20
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>=20
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>=20
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>=20
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D21

