Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E330C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08BB10EFA4;
	Mon, 14 Sep 2026 15:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XXmRf1Y9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B4110EFBA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D54B3601FB;
 Mon, 14 Sep 2026 15:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDB81F00893;
 Mon, 14 Sep 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789401570;
 bh=grad50efz4AqE2o+MlqutHFcoywBEmBOUYINmcBHg8Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XXmRf1Y9kHfVTlFZ3mIUpb28q4G/uQ3/ahwY1PatkFwdjCZRcp2nuj/NXsQsGOr/Y
 g9NE2Htaalx2xaI+KPuHo0QfLQQ/pKp8tt0JdK8yQwtr8Ulxj4v+yXH6J4mY61s4hc
 gEqdxglmZP45C/52Lt+albTOSf7+YCTn5eEH8b3Sad5C3HhyVnv0y6xh8xrNJBG9Uo
 4Af7YYxk6Hq3QIvVe1Yym6kMTiwcfU8lg7vBU/6OWLWfFBq8LWwPqFFP58P/r+W/EV
 XajmEEAEfKIGzNSCt0WybSWyKU3mSVWvNZoDkeojCXK4whDupB+6z6MOXOmCCWE4nJ
 O+Iyaei/zJ7pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org, selinux@vger.kernel.org,
 kvm@vger.kernel.org, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 linux-rdma@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-3-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-3-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:59:29 +0000
Message-Id: <20260914155929.BBDB81F00893@smtp.kernel.org>
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

> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
>=20
> This abstracts the check and expresses it in terms of the desired behavio=
ur
> rather than an arbitrary and confusing VMA flag.
>=20
> This also lays the groundwork for making further improvements in VMA flag
> usage.
>=20
> Also update the userland VMA tests to reflect the change.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D3

