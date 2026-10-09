Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC72CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41510EB05;
	Fri,  9 Oct 2026 18:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E4Y08uAp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C41110EB05
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:40:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75C6360AB9;
 Fri,  9 Oct 2026 18:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3931F000FF;
 Fri,  9 Oct 2026 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571257;
 bh=CbUuwLNvkSUIssFDvORMfbSyMCT9GgkV9uxRHbTo96s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E4Y08uAp2X0TJ1+UXhnwyLBOaYf7PZOjfr1WXqfyl3ns5RUHkbX26GBAP2513qsnu
 ZyunRZPfqjQsFhAJT2oElKuCJcjBNlxYDd6Z13rF8RjjwU2oJ4QFI4u+JG1EUpCYAw
 l2wjmhumC0qphVQ/4oukfaXW/V5Rj1mETecHWDMOj6ttZhHDGk0Hp5lG+2lsxM05hh
 QAsuB9XB1AGet5jN3NVr6ZtCvEImjL/H8oUDZYhLZbUbvp36e1SUh4FaPIcHfNUCo0
 jsd5m0WIG0KNwB4S35j6otn3l43D7wh/EXXorKGmYCoFXH89FNQZSP8509XwDcGEdH
 ubYqvKuz4z0tA==
Message-ID: <sashiko-outbox-165961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/38] mm/mlock: clear VMA_LOCKED_MASK over mmap
 callback
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 kvm@vger.kernel.org, linux-scsi@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-22-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-22-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:40:55 +0000
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
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D22

