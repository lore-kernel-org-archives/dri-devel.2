Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EFECA5FED
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619810E955;
	Sat,  3 Oct 2026 17:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CApnRc8t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3E910E94B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0295600CB;
 Sat,  3 Oct 2026 17:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ACD1F0089D;
 Sat,  3 Oct 2026 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050199;
 bh=guDK4ipqit1C8gOrnrgRAemtCZfSwKUDyfH3BgXFvz0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CApnRc8tlNHkyKJVXjdW2Vf8xycjuADWDD+AZKenodzUWijzQmxz/GJpSLPCYA0Z5
 2UQ1LCZGeNc/dG+FdF9RCC8yRXgXQ3PJLk8xW+7qS1mz1beo+O77bVjjjryen5TgM2
 PZmF8D11V2KnstGIfnfvnsY19K3cAS2m5C/s8U9/0J4cnPH2gUjCRNLva0hC8wIg81
 5drQfXuO3+In0FhuwrfGyGyRtqBZZWAHlaDT8fZNGZaKdcPnHzz6vsIU4xd20ZoPIy
 m0TtjMz0fGqEoh6XlQvc91+qD5rfR71SO74t5ek0zf3OozIKsEzjOT4Jm3zmnP/ha2
 e8FUJLfVuziYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/38] mm/vma: introduce and use vma_[flags_]can_merge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-rdma@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, selinux@vger.kernel.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-2-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-2-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:38 +0000
Message-Id: <20261003175638.A4ACD1F0089D@smtp.kernel.org>
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
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D2

