Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132DFCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D32310EAEF;
	Fri,  9 Oct 2026 18:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ek16SYIg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40B410EAEF
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47C1F43E2C;
 Fri,  9 Oct 2026 18:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441BD1F000FF;
 Fri,  9 Oct 2026 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570984;
 bh=JCqh1EtcYjZW0RH7Et7NA4otY8ggCzC3ELzMG8X53C8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ek16SYIgc2VoBs6MnvrygaV6SlEwjqQGZ29u7RkoN/ZqSa10RBRzJt14Gi6G4P8vh
 fYLZORJRzDuFYqCFy9zAjyaiD9s2mBbMZzvaxRTy0ws6ZeczP+EdX1s/ejX/oIaYP/
 hrVFZZCwPpXjcf1jFntdbu+XwI241rZ0EVXFJsmdj9vqY1ObJsWu+qlsog85di1FR7
 tuTQze5AWb/KvI6WAWDosdx9lM0skGuKjM6T2TgmAMhTAQAhTQyOOEyPG51mYJlZ3u
 pVXrp0ua+j+c3S5OR3UPQPWyC0AoG+2fKlroN8iCzGdh92daqMoLiV50jCnlD41XtK
 gN050VH2QmrjA==
Message-ID: <sashiko-outbox-165954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/38] mm/vma: enforce that mm-managed mappings may
 not set VMA_IO_BIT
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, selinux@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev,
 "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-24-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-24-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:36:22 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D24

