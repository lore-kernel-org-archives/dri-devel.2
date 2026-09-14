Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1541C88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBCD10E0DB;
	Mon, 14 Sep 2026 20:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cUW+ecle";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFA410E0DB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 20:33:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7049960142;
 Mon, 14 Sep 2026 20:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542D91F000FF;
 Mon, 14 Sep 2026 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789418007;
 bh=s2mFw2wtqxr0yCUl07my9NMd3YnR6498rqp607KPz4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cUW+ecle5oNAuY7aEZEZt07v/VlHF+hyBtKnNLbY88MzGxIfmlJl2hpk8Xl0CZyvq
 6YPkgoOygcBTZL9KMnHYgFCiySsyNwS+nYwtLy+e+hKJzfJEEtb5qJNpbYN284Mzyh
 poTjBVztaRCr0uuztI1OL2x3hIMHozlNtQSMoP4IMDfNha8EF9pvPCUt0OuXgNZsWZ
 WeItayAcJR9h0PeTMByCxPaltjmAsNJIOsPS4h9G+l48lEIHZTyeJ9kiCRg9IqvYRt
 kjcYexNigshMaisV5t3ibzMTRF2kaH4DY245Ad+t9bycXF+hnYrVtMBcyxflk9zB2F
 NAMSpbPvXxE9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/40] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-scsi@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-21-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-21-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 20:33:25 +0000
Message-Id: <20260914203326.542D91F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D21

