Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCED0C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1840C10E1EF;
	Mon, 14 Sep 2026 22:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bggv7pdH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834D210E1EF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:18:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BF2040DE8;
 Mon, 14 Sep 2026 22:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790E71F000FF;
 Mon, 14 Sep 2026 22:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424316;
 bh=+zEca/XAs29lC1ZfUNKoIoVzuS+RxeoqsW0hSIQYQS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bggv7pdHTu+0gwWWovqi9bVQa42ua4VkvGaqWAgeijsIbhOGlhYwge364zyx12gpe
 h30x6dxI6tG+VhSJTgxAbOFXyBkYx7+fa7awRyAedX1KIENefWt99nZi2PWDlG0UW5
 MqEuolBDlGdgcgBZnS38wfkMkQwL0qx9IqETKJvTz8Hc5OOInlJC7lvrmCqXHjiJ/l
 AJM0sa61B94dd8ipNUFuQcPGn2C8x/VSTsk8pK2y7wtzlIvOsmM+S4mzMoaMZDD5XL
 FVrtJsIxjwSr3iU1JLyeUcVKWCdfdVJIa59dqjtPbMIQ9Sp2YxFoeTeiwkxTHWMVuq
 XDT/PG3aoszeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/40] mm/vma: enforce that only kernel-owned
 mappings may set VMA_IO_BIT
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 bpf@vger.kernel.org, kvm@vger.kernel.org, selinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-25-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-25-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:18:35 +0000
Message-Id: <20260914221835.790E71F000FF@smtp.kernel.org>
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
> such that they are marked as kernel-owned. The check WARNs and fails the
> mmap for any out-of-tree driver that still sets VMA_IO_BIT without a kern=
el
> mapping.
>=20
> No functional change intended for in-tree code.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D25

