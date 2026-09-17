Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FFAC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AE710F004;
	Thu, 17 Sep 2026 17:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ia3avcmk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE6010F004
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:30:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9A046020A;
 Thu, 17 Sep 2026 17:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC88D1F000FF;
 Thu, 17 Sep 2026 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666252;
 bh=4xh76FaC1Y6V3vEMO/lt4Zv37crcHMuvNHrxjU/1JCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ia3avcmkpTpvuz+wXWTipzEb3hi+te/YkFH5JTkbB3ipE+deqYcOnP9os8UQB39/j
 cyjG+j5XV6RzLucZrWm8ducEpdrhj/WVqgFnjQnmoGSKSuPMkT+lH1+zhV1c1R0j2e
 r2jdMV2orAQZXEYA4b6VrtKIhGz91X3b2bkz1ihjH1KwgocDtfVugEQ4UU3lzZyhRs
 9pMAkHQA4DgvwceJH2p/PNrXUk/tBXq3zN3fSyFV6qlxKYjpv48IREEJUWkLcbyNSh
 d/HBfCwCqdGbz3uNYljGTxyAEGSbrXWcsC1zzllz3x5vFZU3Mk2vC9ATlO/95klaPL
 dvpofggkytP4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/40] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>,
 kvmarm@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, selinux@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-21-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-21-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:30:51 +0000
Message-Id: <20260917173051.CC88D1F000FF@smtp.kernel.org>
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

> When populating a VMA range via the aptly named populate_vma_page_range()
> an unreadable VMA will always eventually fail with -EFAULT.
>=20
> That a VMA is accessible is always checked, however VMA_MAYREAD_BIT is no=
t.
>=20
> All user mappings always have VMA_MAYREAD_BIT set, so this check only
> impacts kernel mappings.
>=20
> It is implemented specifically to disallow population of uprobes XOL
> mappings which are exec-only.
>=20
> A nasty interaction with these mappings may occur if they are mlocked, so
> actively disallow this early.
>=20
> This allows a subsequent commit to remove the VM_IO check in
> __mm_populate() which otherwise requires non-MMIO mappings to be wrongly
> flagged simply as a workaround.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D21

