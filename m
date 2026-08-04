Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E7C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C46B10E9E2;
	Tue,  4 Aug 2026 12:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m0i3gaYT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1C610E9E2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:14:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E04CB42ADF;
 Tue,  4 Aug 2026 12:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1D01F000E9;
 Tue,  4 Aug 2026 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785845656;
 bh=lo8F2pHYcPGGO3cjI9cGy2z2kBDlyc/XA0gqGb4TGhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m0i3gaYTjhi6Jo0IJ0Kt8kWvKLnli3ns9F0MgkWmNGsCwMPjDD3IJQ4DLl2fjcA9N
 WneUyZnMhJsQ8ncYx8VKIK8sv0zWj3M5wJD+tURNPk3VQPubmxDjwLrzcuNgR0L59q
 iEBdAp3xK91gzJQsbtxfv/BCNumTn6EygwDNVdTYnIi+0Gn3aQaVhGRDRVdoG3xhu0
 9cMJHShljELSqFZpSZqCMdZ7UeiXkufB+9ShaN62Vgwe6MHRCZYlPJ51hT+92sEzBG
 qXynHGm8v9nEsfhq3xUA2jR5/lR4tRONb47ReM1h1pTR6U6hwDggjuhV6ABA6WWdjh
 q2PCCBsh6jLlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] mm: pull writability check to follow_pfnmap_start()
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260804120529.1730187-6-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:14:15 +0000
Message-Id: <20260804121416.6C1D01F000E9@smtp.kernel.org>
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

> All callers of follow_pfnmap_start() except s390_pci_mmio_write()
> are following it, if they are doing a write, with a check that
> args.writable is true; for s390_pci_mmio_write() that's a bug.
> Also, most of them return -EFAULT if it is not.  Pull the check
> directly into follow_pfnmap_start() through another input parameter
> args.write_fault, to eliminate the need to do it in the caller.
>=20
> This also fixes an issue where follow_pfnmap_start() would return
> 0 for a PFN that is mapped read-only, and the caller would not
> attempt to call fixup_user_fault() on it; this can happen with
> vm_ops that set .pfn_mkwrite(), for example.  Instead, now the
> caller (for example hva_to_pfn_remapped()) sees an error,
> does attempt to fix it, and only returns -EFAULT if the
> fixup was fruitless.
>=20
> Reported-by: Sergio Lopez <slp@redhat.com>
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in=
 mmap")
> Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=3DbE=
HmfnG54qyBAHFg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D5

