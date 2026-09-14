Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F6C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B50110F2B2;
	Mon, 14 Sep 2026 22:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lO0Ce06w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C54410F2B2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:08:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E83A60252;
 Mon, 14 Sep 2026 22:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784CD1F000FF;
 Mon, 14 Sep 2026 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789423718;
 bh=WoNRymsDtMx0indCFrDBQWLcq1c1c1hScGVe9WFZ1a0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lO0Ce06wepaswViDsWnuypcA16rVVixQFdjlmi07ll8y1RISY8730mNqykbmyBOs3
 +/sVxQSJpPAc2ypIprbhpD69WIYyD29pBaH2ALbSb4k+j8qA5ZWhF8wEmbjW0dbshC
 PlGc1w9CVv7vqKxQIiff645szr42N5PhCce6/6odVkMM21iBldMFMXb0/zG6fSPL9o
 PuzhpeEbHjHRUtDf8Qg+7MYKuRtdMyNCTTbnkdaMUZa9MYzptJfH6ewss1SdvAyFPT
 cLj5XbZ0FBTZHckabJuv+iRk5MUGZCJp/WOUD558WLjeAZ7YjXNbPvbXC+Ps0CRWzI
 3Tom2Icbh+GyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/40] mm: drop some redundant checks around hugetlb
 VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-scsi@vger.kernel.org, linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 selinux@vger.kernel.org, kvm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Oliver Upton" <oupton@kernel.org>, bpf@vger.kernel.org,
 kvmarm@lists.linux.dev
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-29-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-29-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:08:37 +0000
Message-Id: <20260914220837.784CD1F000FF@smtp.kernel.org>
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
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D29

