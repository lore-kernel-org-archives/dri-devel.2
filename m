Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE0CA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8864A10E9B1;
	Sat,  3 Oct 2026 17:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K2WF2DVj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C52910E9D8
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:57:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54B314011A;
 Sat,  3 Oct 2026 17:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B021F0089B;
 Sat,  3 Oct 2026 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050245;
 bh=RC989HcI12wPyOanWxIBD7MOcc65XB3Vn73cbeKYUO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K2WF2DVjiC8L1kPZ54UxDD5eHjxBabtTANH5an1GfV6t6jTmGvOxU6KJG6zQKCejW
 0WiJkYypgBhUcLXN2OzZxIK7DzJz1DspyPvG6YxTrNDbLWoV/eqF/X5s7Mc4QrkjdV
 +f1f5zletnmvEN2WG+66+Regx3w82JzYk5TdvvPsGOmfGoGHT+IiF6H4hZQdaRbBY3
 Feiw+L6a7dvqJ3oV4gvIOwd5tiSWXcX+MVb1hLcqoBYPLpTgeT0/xgC+eHT9dOmAtd
 vDk60pFydgLEsAmmcjGny+rKdj3qhmpcYXBadwkJVyqCTtqV23kadO+euiZMI/6BsG
 gON285uyAdURg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 36/38] mm: eliminate VM_SPECIAL, VMA_SPECIAL_FLAGS
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-scsi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 selinux@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-36-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-36-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:57:24 +0000
Message-Id: <20261003175724.A0B021F0089B@smtp.kernel.org>
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

> Every user of the VM_SPECIAL or VMA_SPECIAL_FLAGS has now been converted =
to
> predicates which explicitly express what is actually being checked for
> rather than the nebulous concept of possessing 'special' VMA flags.
>=20
> In any case 'special' is not so special a term of art in mm - it includes
> VDSO/VVAR mappings, special in the sense of vm_normal_folio() and probably
> other cases too.
>=20
> Therefore make things less special by eliminating these now unused flags.
>=20
> No functional change intended.
>=20
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D36

