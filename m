Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC23C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E9510ED80;
	Tue,  8 Sep 2026 20:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jW484Q3r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9B910ED80
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:40:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DCB2601DE;
 Tue,  8 Sep 2026 20:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670501F00A3A;
 Tue,  8 Sep 2026 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900001;
 bh=nZP0chXgSajYLY4pSNJKUrrR2eFjUEXUiEpF5faqrsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jW484Q3rycw9v9F9BMLOpquDZkZu6kl73ZR7lNSci4TkpoOHVMILOrdNeF6iPgO+/
 ygt2Qxklp8ineSkoZgkjSL/HQPIGag+ZzXyGPhlPAd4RpyFoGoqNdlaDL8U4rU7Ws8
 iwMPa2pEo7rjN9mIBaldDSHBgJ9dBdhnBUnKz/fa3z6P/7aj+fYNPHHaDJ5slu22qn
 aEInbDCnhgbnVS/tkDslxJCYqUTE9YTNAadeez1w3/QWs68jq1kyqD2sSp+YfNQB7f
 0orwBFX6fMVDXzpop+leJ/RFl3wgRqTfGjanOJiB3yBRl47IAKKOH+fKEO7Da1RWMl
 p0xlh+wlAkckw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/39] mm: drop some redundant checks around hugetlb VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-28-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-28-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:39:59 +0000
Message-Id: <20260908204000.670501F00A3A@smtp.kernel.org>
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

> Adjust code which inadvertently perform redundant checks on hugetlb VMAs
> and clean them up:
>=20
> * hugetlb VMAs have VMA_DONTEXPAND_BIT set so a VMA_SPECIAL_FLAGS check
>   suffices. (migrate_vma_setup() regains an explicit hugetlb test later in
>   the series, once VMA_SPECIAL_FLAGS is removed.)
>=20
> * hugetlb VMAs unconditionally set vma->vm_ops, so they are never
>   anonymous.
>=20
> * hugetlb VMAs do not set VMA_PFNMAP_BIT so checking for this is redundan=
t.
>=20
> While we're here also drop a VM_BUG_ON() which the simplified check above
> makes unreachable, and use the new VMA flag API.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D28

