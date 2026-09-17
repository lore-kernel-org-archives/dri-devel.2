Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569F1C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F44910EFEB;
	Thu, 17 Sep 2026 17:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hdZQgrxs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C5110ED85
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:07:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA03660202;
 Thu, 17 Sep 2026 17:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902F61F000FF;
 Thu, 17 Sep 2026 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789664878;
 bh=K8GmGw+ly7aq2IiC9ErXSqow6NQtT9XEbDR//zdXljU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hdZQgrxs6PWCLS3JKXPDXs7bWesaG7AZbkjx2CSrftDofYBxyToTyHRdKCOk+PBkM
 Y1ZaB8sSGiLS0Kf5xWe98tb8iIZAymt9J1USeIKf7kMJQTqbE0i21pK4BVrTELG/p0
 5GRVCh2uAQGUq6hInjvtU6m360FSvy0uYB0XUle5wV2wOgOk6apbArgRYeN2n/gd3L
 1a9ZszzFa/6sXe/vnwFjKNx3arPOlEnXc9RzsZaLVP1UFo+E42nn7E06xmtqtwI5vT
 o4Kxb5vyFvTknKetWC/4iOX9lh0/U9jwKp/k8o+IA29qYo1fLb4GW/FKFx5XYxqW+d
 vVEA++cPtCLmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/40] mm/vma: predicate setting mmap_prepare VMA
 fields on new vma alloc
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, selinux@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:07:57 +0000
Message-Id: <20260917170757.902F61F000FF@smtp.kernel.org>
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

> It only makes sense to manipulate VMA fields if we allocated a new VMA,
> rather than merged it.
>=20
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since it
> never touches an existing VMA. Previously set_vma_user_defined_fields()
> overwrote the merged VMA's fields with those set for the new mapping. In
> practice these are the same values, with rare exceptions such as shmem
> selecting vm_ops based on whether the file has been unlinked, so no
> user-visible change is expected.
>=20
> Make this dependency explicit, and additionally constify have_mmap_prepare
> while we're here.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D2

