Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4ACCA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AEB10E982;
	Sat,  3 Oct 2026 17:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AtPoWp0k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DB510E97A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AF0444873;
 Sat,  3 Oct 2026 17:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A31F008A3;
 Sat,  3 Oct 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050212;
 bh=ClYTsswbCIYbM/fmgQqIBazGgbYk16TfuG2VPiaWPh4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AtPoWp0k81qHL5dl4dSTYDDE0BL6Ds+3ki5psRrwl1I+RXjU3o8BMBrjCZ3t+m+II
 KgmB4/xIVMRT1g5icXqYU5BkHyZ86OvSjVclntoNjx6ItRdosXIM/DF6qkhz4QJBJ2
 r1PsDohA8J8BmCSvan4Z4jeA+8JLxNLvxRuZDoJHorpKwKzdGvBZR0PwDdyeKqtOQI
 g7ykibcSm2/dFEvo8kfiGW91+qy78EyfWnYSWh/IUjoNt3x7R/76lxNMdjCenm8WRl
 0vO4sas9HnC2FRFMGasiBDTQlP5DNTtdK8iKEFs9nFVx+pQ1wRHNWrpQ3/NVPsAlAV
 YBbh8qcLVtQYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 27/38] mm: rename is_vm_hugetlb_page() to
 vma_is_hugetlb()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, selinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-27-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-27-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:50 +0000
Message-Id: <20261003175650.D87A31F008A3@smtp.kernel.org>
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

> The is_vm_hugetlb_page() predicate is badly named - the mapping can span
> more than a page and it is inconsistent with other VMA predicates that
> typically are prefixed by vma_.
>=20
> Rename to vma_is_hugetlb() for consistency, and while we're here update
> some VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA() as to avoid unnecessary
> oopses.
>=20
> No functional change intended.
>=20
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Anup Patel <anup@brainfault.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D27

