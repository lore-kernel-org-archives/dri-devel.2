Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E56DC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946D910ED70;
	Tue,  8 Sep 2026 20:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LmzhJDlZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1A10ED70
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:35:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FEED43534;
 Tue,  8 Sep 2026 20:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777D11F00A3A;
 Tue,  8 Sep 2026 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899711;
 bh=0EObSyqjpYUAi3FP29etQ+gO9bJfv428SfaAmw7F/yk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LmzhJDlZx8UFG2B1LZdno3eFU5ps1kiAK2rdCGGLK/6d+bKqwU/K0bIbxm5nZdcqo
 64KIpYX9h0tHaOKG2qCOWV1nT+IcTEddix2K/6ngbxYs8pLuCIW+3kV7cYrTNU4LjL
 rT+BBK5hbycWQeH4mpCgHNh05Cg6r3Kzvkpzh+YneN+erQptLBRDWPP32esNyiAckX
 fnLoR/IkQgL8biceIKkgg4LZyAXJId4jo/LO8rpqHSKgG7LJZcCwtSArA9JyThBK4u
 8x+Qz8WMMIsOBCeL99KoBWJjFxDBSCfJ5xLxNtXUphCIqOFXBp4uwdR5hFBOa/hf69
 MocWq7m7NuQjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/39] drivers/usb/mon: update to use mmap_prepare + map
 kernel pages
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev,
 "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-9-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-9-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:35:10 +0000
Message-Id: <20260908203510.777D11F00A3A@smtp.kernel.org>
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

> Replace the deprecated .mmap hook with its replacement .mmap_prepare. As
> part of this change, additionally take the approach of mapping pages upon
> mmap rather than providing a fault handler.
>=20
> The page span cannot be mutated when an mmap mapping is in place, so this
> is safe to do in advance (the MON_IOCT_RING_SIZE ioctl operation exits
> -EBUSY if it's attempted, gated by the rp->mmap_active reference count).
>=20
> Utilise the newly introduced mmap_action_map_discontig_kernel_pages() to =
do
> this, which allows for iteration over pages in mon_bin_discontig_get().
>=20
> mon_bin_discontig_init() increments the rp->mmap_active reference count to
> stabilise page spans. Should an error arise the core unmaps the VMA and
> mon_bin_vma_close() drops the reference again.
>=20
> [ ... ]
> One behavioural difference: pages are no longer faulted in on demand, so a
> page discarded with MADV_DONTNEED is not repopulated and a subsequent
> access raises SIGBUS, as with other pre-populated kernel mappings.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D9

