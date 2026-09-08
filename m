Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7B5C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDF910ED93;
	Tue,  8 Sep 2026 20:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UO5F/4p5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C777410ED93
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:47:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84C5D431D7;
 Tue,  8 Sep 2026 20:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB971F00A3A;
 Tue,  8 Sep 2026 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900422;
 bh=JJa1OO12s87ryIs9oCBAxGrrN8+UTcZipnv+AvPk7ww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UO5F/4p5pGeS17jHBcESniZi08TuamoiBbhahfXjcRybz8fzbMMp4+hfkC+HfGWax
 B2pqToBd5urLYg1uWB0AjeIBm+Z3djxhVmYWTgEZF2HND7e/JdRGTJ5CRTEcLpK+ZP
 TqC257GA7lNk8TVPK7nlE/f28pK9BixYiyK5Spf/ld/lXmlPmsPEhR74VqTVLZYfcU
 0MmMgpxto7/ADrWFVFHDwoYUVZ9GUAiRMsTziy4YyNqGElFuf7SeIzt3ol8sj34A9P
 QfcHkexS1TRDfVy8t4zAzCF0v0OdJV7TbuJpv1qvRPVnY8voSw3OF4QF8j6io8C9WT
 3qSdRomLKj4zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 30/39] mm/vma: introduce vma[_flags]_is_persistent()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-30-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-30-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:47:01 +0000
Message-Id: <20260908204701.9EB971F00A3A@smtp.kernel.org>
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

> Introduce vma[_flags]_is_persistent() for the purposes of identifying
> mappings that are persistent in the sense that bytes to the mapping stay
> there, and bytes read from the mapping are the same unless changed by
> actions taken by userland.
>=20
> Kernel-owned mappings do not fall into this category, as their owner may
> change the contents without the user having initiated it, and nor of cour=
se
> does memory-mapped I/O.
>=20
> We exclude fixed mappings as these are singled out as being unmergeable a=
nd
> so cannot be guaranteed to persist user data.
>=20
> hugetlb mappings are fixed mappings, but their contents are entirely the
> user's, so they are explicitly carved out as persistent, as the MADV_DODU=
MP
> check already does.
>=20
> It excludes droppable mappings, which by their nature are ephemeral.
>=20
> Use this functionality to update the madvise MADV_DODUMP check to test for
> persistence rather than open-coding this.
>=20
> This replaces the VM_SPECIAL check which means it no longer checks for
> VMA_IO_BIT, however this is safe as we have established the invariant that
> only kernel-owned mappings may set VMA_IO_BIT, so we implicitly include
> these.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D30

