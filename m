Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424D9C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5555210F01E;
	Thu, 17 Sep 2026 17:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SszozQN5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443D10F01E
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7693141ACA;
 Thu, 17 Sep 2026 17:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811891F00893;
 Thu, 17 Sep 2026 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666312;
 bh=+Ec0BUb2k6aj32bDnhEPV1iOCTJIsMnKCwDRipXlmUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SszozQN5DKg59dq3zPlxk8QzsxOkEKu2kzMyCA5kq1oPDPG7CcVklmxy6LvJN4kZz
 XAUjIINAAbEu7MPwDgLxKWZTmJEfaAUT0XSdfGe8N3Crz0b0NFe98w+A6HtmeA3/R0
 zbXu2rs5wQAj28v8Yl9AK69mVV95tAGS24HCJNNYmmooETVOBFDMWajZtXQJ7n7ecn
 q7XKjrKlampOwXaQVSPQkPQY1jlo5ws/4UjRFMycN6IAHYd0ZfmeCwzZHeLDCZFqt4
 UnP1JgT2/NM9oLgn0/qJ0CBEpACGayowQ8vi20SHkQE6z1G3loqoZd1hrmXhVG24GF
 Q+dCE5/zIx6xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/40] mm/vma: enforce that only kernel-owned
 mappings may set VMA_IO_BIT
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, bpf@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-25-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-25-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:31:51 +0000
Message-Id: <20260917173151.811891F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D25

