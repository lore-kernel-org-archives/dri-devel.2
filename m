Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97CDC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D2210ED89;
	Tue,  8 Sep 2026 20:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DaDfOxJ8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D373310ED89
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:44:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE2FE601DE;
 Tue,  8 Sep 2026 20:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AF91F00A3A;
 Tue,  8 Sep 2026 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900298;
 bh=mRnPDcXMWqJ1P/zFpsAwW/ySeVmozD1iTl1dP9pNxR8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DaDfOxJ891PO/Pdlj5xTby3oBEfZ3Nk9hDeVU7MueShhNS+e4XG/UBCn4PA/gvMqH
 GeZEUllw+v1cFFj5rW8kWnYYYsYAuYkwkJuRI34Nbzhmya7hF9KiAonsnnkAE4cy6Y
 v67HiiqY0n6J5fXBK7Imkk6WOjNlnKEEXU5ZRCvUgxoldep56i58HGTEr+xwrU+pTX
 CwVGmvLP5X58MYs6920RQH8YG3a7tRNhVBOU0O4Dm3tacHoXgM/hP9r4ThRhG9RuoH
 G0AOpYcJok6ONY+RHhw4SHDg81Ua9Z4wIxfJjk2dgXIwx35wfVEQ70XCJBMM/C7R6T
 1hEDLDgUZD3Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 39/39] mm/vma: introduce and use vma[_flags]_can_gup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-scsi@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-perf-users@vger.kernel.org,
 selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, bpf@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-39-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-39-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:44:57 +0000
Message-Id: <20260908204458.21AF91F00A3A@smtp.kernel.org>
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

> GUP cannot be used for VMAs which set VMA_IO_BIT - because memory-mapped
> I/O must not be accessed on the user's behalf - or VMA_PFNMAP_BIT - becau=
se
> PFN maps have no folios which the kernel is permitted to access.
>=20
> Rather than keeping these checks open-coded, abstract them to
> vma_flags_can_gup() and its VMA wrapper vma_can_gup().
>=20
> This is useful as there are a number of additional places within the kern=
el
> that need to check whether a mapping can be accessed via GUP.
>=20
> Therefore, update all such occurrences.
>=20
> While here, drop a reference to 'special' and replace a use of the
> deprecated VMA flags API in vma_dump_size().
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D39

