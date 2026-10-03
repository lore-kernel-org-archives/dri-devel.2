Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B5CA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AD510E97A;
	Sat,  3 Oct 2026 17:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S8UjPvb0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8F10E97A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2327600CB;
 Sat,  3 Oct 2026 17:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0B91F008A0;
 Sat,  3 Oct 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050210;
 bh=iSVlcTDDIwilpTIFpoJd4dbbYhXAYFyiKbuOnRJzCTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S8UjPvb0uyFG2SIoLBKdnmLEppjDvwQsuoJsiNJiUqsrrcscO12yTa4/DeE0YGwqi
 RDHTsjecBuoyJ5d077/IiCui0EJTgMoXaJeW7Y+wz+3CEuGblujSmDoOXtDAGEtCiG
 XO6eEv+lpSNmJi7eL7T6ws1e3nc/+/zKJ+RaKpaQ6n3SquTCjaABkT77gKDOdRM1Lb
 NL6uNd5gsYBDXwFHyuBaZ2/+8opsCOj7jxdLmterkVLfM/R+aLlwUMDLKTlP6A7x6j
 fQH816Lye5Ud//q63qAFBBIQPQrM2RCXaRUQOICZubydjeDVVOXVRB1KMgBOqlySYQ
 0J3FhibLulEWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/38] mm/vma: only allow mmap to clear
 VMA_MAYWRITE_BIT if not mm-managed
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, selinux@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-15-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-15-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:49 +0000
Message-Id: <20261003175649.8D0B91F008A0@smtp.kernel.org>
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

> For ordinary files the only way the VMA_MAYWRITE_BIT flag is cleared is if
> the underlying file is itself read-only.
>=20
> This means that mprotect() cannot mark a shared mapping of a read-only fi=
le
> as read/write, as doing so would violate the read only attribute, and
> permit writes.
>=20
> In general, we do not want file systems to be able to do this for
> read/write files.
>=20
> Doing so would violate fundamental user expectation of file attributes and
> likely break userspace.
>=20
> However, drivers pose a tricky problem here - the /dev/xxx file may be
> read/write but provide access to a resource which is fundamentally
> [ ... ]
> As no driver which clears VMA_MAYWRITE_BIT establishes an mm-managed
> mapping, no functional change is intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D15

