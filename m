Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D8AC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FE410ED94;
	Tue,  8 Sep 2026 20:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnasFriX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FAE10ED96
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:47:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8EE040AFA;
 Tue,  8 Sep 2026 20:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32661F00AC4;
 Tue,  8 Sep 2026 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900438;
 bh=cUwKFWB7J3sVQVZePIjXLYJE/gtbWNYr1ZPaYna5+6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VnasFriXnrYYiPlwsRTiW3y0gbXc/WyBB/s7qhkOnIb7cIVHfV1pFgMzjimujLdGp
 wkgPpaP/EhP1jy0U2rIc9cwMYbL2NtAOc51B32c3Sy01iw2l2VMewNGGu68iKz6iMd
 e5JNV5RzPJqcSIEM0o8F6U33D68fRNoA6jBMBr7QatpiqEHjbDqW+hBAk11Yer/RGD
 9Ghx2k7r3mBxtmYPjC4EexB01hhjOPE0Zu4pkJY26OOx+XFY8hrKiQ8+JRJgClhKgn
 fr7QSOEuH4fUAIRk8LjKL5UD3gpItknPsPY/CYLoZvnmP0BmrsLtdVquK56pvT3J8L
 GEe2I5E2jHFuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 35/39] mm: avoid use of VMA_SPECIAL_FLAGS in
 migrate_vma_setup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev,
 "Oliver Upton" <oupton@kernel.org>, dri-devel@lists.freedesktop.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-35-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-35-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:47:17 +0000
Message-Id: <20260908204717.F32661F00AC4@smtp.kernel.org>
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

> Now we have the expressive vma_is_kernel_owned() and vma_is_fixed_mapping=
()
> predicates, use them to determine whether to proceed with migration. This
> drops the VMA_IO_BIT test, which is safe as only kernel-owned mappings may
> set it.
>=20
> hugetlb mappings remain excluded, as they are fixed mappings.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D35

