Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC55C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3954E10ED75;
	Tue,  8 Sep 2026 20:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vw+3Z/GT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA4510ED75
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D57A601F7;
 Tue,  8 Sep 2026 20:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7401F00A3D;
 Tue,  8 Sep 2026 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899785;
 bh=wAJ7ikObQ7BdyD8JmXGdd6lEUfR3W8m2ceywh5stGKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vw+3Z/GTh+Dohhq4+9hT2hyhF257D90BGoxNyy/dMiyI/kx8l6o6yVGHmfV6TsCbu
 QJrR/OaDvqjzK6rjaBrKBmWKgVL/Q7kn9hHdw9Yli24KxnWoBB/40l/JJQKCI9AM3c
 jDuNOhAciZQLyDR5AIG4nLKerI+QUAy1b9L1JOqJM7pbEh1f/xZ2yfRPm+OSXyJFtC
 3rpdr03OoNwCl+Y0FoCgxz7P5cjya9oXD2mhS23ex3fN17k/sqm1E6HiawWTZoDkkZ
 RAvKOnbiNyGtmQfyRwUQA0S4cRYW+mG98TCfG40v4QN0a11r/k8Sgu3XfmUZVckyR4
 Irs0EZPvowRcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/39] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, selinux@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 kvmarm@lists.linux.dev, linux-scsi@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-20-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-20-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:36:24 +0000
Message-Id: <20260908203625.2E7401F00A3D@smtp.kernel.org>
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

> When populating a VMA range via the aptly named populate_vma_page_range()
> an unreadable VMA will always eventually fail with -EFAULT.
>=20
> That a VMA is accessible is always checked, however VMA_MAYREAD_BIT is no=
t.
>=20
> All user mappings always have VMA_MAYREAD_BIT set, so this check only
> impacts kernel mappings.
>=20
> It is implemented specifically to disallow population of uprobes XOL
> mappings which are exec-only.
>=20
> A nasty interaction with these mappings may occur if they are mlocked, so
> actively disallow this early.
>=20
> This allows a subsequent commit to remove the VM_IO check in
> __mm_populate() which otherwise requires non-MMIO mappings to be wrongly
> flagged simply as a workaround.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D20

