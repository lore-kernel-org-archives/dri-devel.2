Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71204CA5FF0
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FAE10E976;
	Sat,  3 Oct 2026 17:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hRa7JBbv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF4C10E984
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45E1D40B71;
 Sat,  3 Oct 2026 17:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A911F0089D;
 Sat,  3 Oct 2026 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050216;
 bh=xZeSacpFvuoxtACYfDAMbNx6dn6Xo2hSDFgMYcvRIe8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hRa7JBbvzW2K9kmHBHvislYSaomh9ADFd1watbyWUpE7lAu5ESpTTDucBS91OpuWi
 gUCmhfSTG2Qo7QyuxzOzaMQFzM7b/wXx5oS13O3gUFzktcnljaihkaNAy9MGJ2+P7J
 wY+xMFPeq5MTHgdBFrNOHxP3J9MpUgl7cgpy5jYtyyG3iokmaR+sHbSLoehTUEnplj
 Mw0hrAOUCKSBa4wwRZ7krg/R/caun59mFaCSCzH0u1VBHv38N7BtFiVUvCEzB+14i5
 gtAY8kuAc3GoL2jtl+lN3R8QzhP8cxIBGEarvV1W5wdjrfXpXm4HhB6REdsot0vadp
 r+DFXVmc809PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/38] mm/vma: enforce that mm-managed mappings may
 not set VMA_IO_BIT
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, selinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 kvmarm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-24-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-24-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:54 +0000
Message-Id: <20261003175655.52A911F0089D@smtp.kernel.org>
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

> It makes no sense for a mapping whose contents the kernel does not own to
> specify that the range is MMIO.
>=20
> Prior to this patch, all in-tree drivers which did so have been updated
> such that they are marked as not being mm-managed. The check WARNs and
> fails the mmap for any out-of-tree driver that still sets VMA_IO_BIT
> without a kernel mapping.
>=20
> No functional change intended for in-tree code.
>=20
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D24

