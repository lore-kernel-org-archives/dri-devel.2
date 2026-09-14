Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C674C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9A010F495;
	Mon, 14 Sep 2026 22:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yq/XoPYm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7748110F495
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:09:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F027660252;
 Mon, 14 Sep 2026 22:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49DF1F000FF;
 Mon, 14 Sep 2026 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789423744;
 bh=wmrbbXUbTwIS8+vtF4g6brqrLOVn41/DFfBZFXEVcWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yq/XoPYmTucKxhBE8Ye8ynWH6wph+RH85HwtW+8/IPMzP6N8x6quAxYXuaIFgpfIh
 vEjayndAOpzLaJOR+c/3YwsYfCrGophglw9WkQCRi6OIIiSEhuTAVedUTLKX6G9xv8
 cmzOOCQEibRxc/+QTuijYM+AjM1MvMSjSdsq82Syt6b0XvgD4fZKAzP6LmaXXufhjF
 xykXbSkdqnzMKNZlh0i+9up62cSLT4dCI1VpSCf1uCU6sT44o9Vc6D7P77tFQ1GmNt
 F+qH8bWjZChi/B+GFarON64H3T1miWS9+VaE/kUpIS8x3WWvbTW5Bfr+VgDLkFrMyl
 9jVX/nneF6IKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/40] mm: remove hugetlb_inline.h
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, selinux@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-27-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-27-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:09:03 +0000
Message-Id: <20260914220903.D49DF1F000FF@smtp.kernel.org>
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

> This header really makes little sense - every place it is included mm.h is
> also included, and the header itself includes mm.h, so it does nothing to
> reduce header size.
>=20
> It also oddly does an #ifdef around checking VMA_HUGETLB_BIT, however
> VMA_HUGETLB_BIT is unconditionally available, and will never be set if
> hugetlb is not enabled.
>=20
> Simply remove the header, eliminate the odd ifdeffery and place the
> predicates in mm.h.
>=20
> The naming of these predicates is odd, but to keep changes separate, we
> will address this in a separate patch.
>=20
> The file was never put into MAINTAINERS so there's no change required
> there.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D27

