Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF21C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B3810F033;
	Thu, 17 Sep 2026 17:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oI9MSfPL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619F010F033
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:36:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33B28437D1;
 Thu, 17 Sep 2026 17:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B411F00898;
 Thu, 17 Sep 2026 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666617;
 bh=TbfPAhp++7ImaEEoNafSDR6Z8m5cRS7+q11IIXOZq+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oI9MSfPL2prL2QETsXaQtBhVmoKZN43uN5fTOMdnQWD5ekghIhR9Ju662WT26q0F4
 KGC9simFo6Sg2UbHiPKP519AaIhylGwrlJrPsp/4WdfOaeZGnGpeD6npuzYxIedAoa
 mJ2TXoPnGfmoCWroO/DOykvuCDQyfMX0J3xQEMgQI307EI3zb/pKQZUte+zYl7G61q
 gUfOMXksRP6w81VCdd4F6sGkC4jYE99nLfRMjjBEYQfYsKjkPTf8WKjmyizut62Scw
 OH97ah3G7S3W824/yHTiAZuABADiiflD9H1+eXS1l9vajDpre+DbrW4+LffrRIhnBe
 rPtllfgg5Hmvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 40/40] mm/vma: introduce and use vma[_flags]_can_gup()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-rdma@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 selinux@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, bpf@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-40-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-40-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:36:55 +0000
Message-Id: <20260917173656.46B411F00898@smtp.kernel.org>
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

> GUP cannot be used for VMAs which set VMA_IO_BIT - because memory-mapped
> I/O must not be accessed on the user's behalf - or VMA_PFNMAP_BIT - becau=
se
> PFN maps have no folios which the kernel is permitted to access.
>=20
> Rather than keeping these checks open-coded, abstract them to
> vma_flags_can_gup() and its VMA wrapper vma_can_gup().
>=20
> A number of other places make the same check to decide whether a mapping
> can be populated or accessed as GUP would, so update those too.
>=20
> While here, drop a reference to 'special' and replace a use of the
> deprecated VMA flags API in vma_dump_size().
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D40

