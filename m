Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF26CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899F710E561;
	Fri,  9 Oct 2026 18:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EbvOFCwl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0A010E561
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:46:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3727640A34;
 Fri,  9 Oct 2026 18:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6071F000FF;
 Fri,  9 Oct 2026 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571612;
 bh=HFKBoDKgPdTwbnYnYqRFjYpZs2q39uFT5lOGj3Ocqlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EbvOFCwl7vCmqFIt3haK4QWAALj/vPIXRM+4bVy4Fp9K5f6O7aab0Q5qMaLvGj1LD
 ZbPbiowO2iup3HXEvEFvKKu84X48KwpxGQLTTrFLvLYdcCloY3B8TbI0kwn4Jnx15W
 nPAn/aGDGtMgVuWOCntjbUI4rL7Wc245lCbS+NRWfnYy2dedAIoIIg9QByRPTxQ6em
 MNU+rTEP9SoKPAFsJIX8QwjlziA7pA83ESORBONiCSf4jICiIuQk5ClHkAd4rpCZP3
 aJfzH3arqwRQM+rmogzbCXJdcKfC2VOhZA1Opwpa/mzrMIMJbLVSHMVFkfz/SppwCj
 3B2dqW0icl31w==
Message-ID: <sashiko-outbox-165970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 31/38] mm/uffd: use predicates for userfaultfd checks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-usb@vger.kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 selinux@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-31-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-31-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:46:50 +0000
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

> Rather than directly checking VMA flags, use the newly introduced
> vma_is_mm_managed() and vma_is_mm_backed() helpers in userfaultfd
> when assessing VMA suitability for userfaultfd and UFFDIO_MOVE.
>=20
> Update vma_move_compatible() so it's expressed in terms of VMA
> characteristics rather than arbitrary flags.
>=20
> Additionally, update the use of the deprecated VMA flag API when checking
> VMA_SHADOW_STACK_BIT.
>=20
> A VMA_IO_BIT check is no longer required but that is fine as a hard
> invariant has been established that mm-managed mappings may not set
> VMA_IO_BIT so the check is now redundant.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D31

