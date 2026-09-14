Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3701AC88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBBB10F26D;
	Mon, 14 Sep 2026 21:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nA4osmvt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B43A10F26D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:09:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A69AD6025F;
 Mon, 14 Sep 2026 21:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02F1F000FF;
 Mon, 14 Sep 2026 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789420143;
 bh=QNKiHNVVQITS2ZEMsnVYihCQciysFQAVe9ZcKtFzzs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nA4osmvt+3w2NX7xPPnlIGpN/7wQ/mMwDj4YJIz1fLA9C6hm2m5WCMN4Ok0ZGUe7T
 aV0ebLen3kqvvcsMfRkLpWDzRi8Nhr1V58kpnVXc9EtxLIkrhsJVg0V9j88mTpWgKE
 dFNp8LYZQyige5E8unVZ1kI06p3hcagR5LU4Abch7PopNvmCAKAXwzADbaOQ2c92is
 i2VXn2hig+Q2RBbpaYY4atRjmwA4wkD0FxeQBV1VUT+jEtEU+2RGUsLxgVt4g9BP9v
 weFmhlhM8qNO3b56CJlgO0oY+1lFqL+dRIdOGvWXLFJlck+DxhFXFPILGXCVyAjeWn
 /rANuoit+rUEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/40] mm/mlock: clear VMA_LOCKED_MASK over mmap
 callback
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, selinux@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 kvm@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-23-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-23-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:09:02 +0000
Message-Id: <20260914210902.BD02F1F000FF@smtp.kernel.org>
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

> Currently there's a confusing mess around VMA_LOCKED_BIT and
> VMA_LOCKONFAULT_BIT.
>=20
> It is permitted for drivers to set any flags they like, with the VMA
> already possessing lock flags.
>=20
> This results in the absurd situation of a VMA possessing both
> VMA_SPECIAL_FLAGS and VMA_LOCKED_MASK flags, which is not permitted.
>=20
> This has resulted in mlock_vma_folio() having a very silly check for this
> scenario to work around it.
>=20
> There is no need for this - just clear the flags before invoking the hook
> and reinstate them afterwards if they are required.
>=20
> Nothing relies upon this being set during the mmap operation.
>=20
> mmap_prepare is unaffected by this so requires no fix.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D23

