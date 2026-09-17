Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B87C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C288C10F022;
	Thu, 17 Sep 2026 17:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A9MytrAd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B57910F022
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:32:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13A8B407DC;
 Thu, 17 Sep 2026 17:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564781F00898;
 Thu, 17 Sep 2026 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666339;
 bh=8e5lPCnPfILQlY1CXCm5oem5W/gzCwK+SwdkuZ8N6tQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A9MytrAd0M82iRMpQnofhgO2Pilbhorygomfiqk5zIYcK2s5pICXhvrPYIAoSjpuF
 wGIE6L/fT3hIMmx2H03s+R+c19al8DL9mQZ7FQapPXf1f5thtCMcJueagNiiOCyYIs
 RhPKaBRGDF13xy26l8/BW/1lnCyfaH3tu8IoWv8atoCRNebPKBaaXE1wo2ZfrhIZ7R
 dIqQhqNCk+yNYJsDjnIRFH3uMbmUVqc36U3hbp80JzaI/R+suda4RHbLwUzloKvBX4
 L1nddFBZZKinwKp+7euqcDi7Nx5kSmBGUPSs9fX+fHryW5XIuMvgPS8OIrsozJs/uq
 nLRpa9OVky9pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/40] mm/mlock: clear VMA_LOCKED_MASK over mmap
 callback
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-scsi@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-rdma@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-23-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-23-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:32:15 +0000
Message-Id: <20260917173216.564781F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D23

