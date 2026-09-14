Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD6C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4E610F2B0;
	Mon, 14 Sep 2026 22:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OfArqOFi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE810F2B0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:23:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3A2F43F76;
 Mon, 14 Sep 2026 22:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AAE1F000FF;
 Mon, 14 Sep 2026 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424582;
 bh=c4XH58/I7392Xbk505A1UsC6J0SJtiYPHplEBssQvpI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OfArqOFiZJRAZCBve6VPTmk2T0X8YczKKSzCSjfUxEB1i70GQjj2FTxFIiqCz3dvh
 szRaPChmWgbuj1efViCjHQuQ4R1jcMH8QycYUAYLVc9y/1QmB9RwbImB5KlenS7Nus
 TtdR4+UhVdvO4BNWuQele3uMIAmVpCGqV4C6Hw9MT6I3Q/1h3ntdQwTgtzg+8tujr8
 EhV/j18klnflUc/2/txROQAUsoq2cgTK5ZwxQPYwXfpeembS6HNJ4pgfsj8anWt1jX
 TymusSkPJXTJwvipaYlqrIQjCyRpMb/1iDUAt6PCY7gxFnHfufJZT54tIixj3TLAjo
 xzozslx3mIoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/40] mm: avoid use of VMA_SPECIAL_FLAGS in
 migrate_vma_setup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>,
 linux-scsi@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org,
 kvm@vger.kernel.org, selinux@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvmarm@lists.linux.dev
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-36-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-36-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:23:01 +0000
Message-Id: <20260914222301.D3AAE1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D36

