Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F027C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7631810E32B;
	Sat, 26 Sep 2026 12:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JINl9vX9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957F310E32B
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:58:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B914C6022E;
 Sat, 26 Sep 2026 12:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3997A1F000FF;
 Sat, 26 Sep 2026 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790427495;
 bh=6QmSuOKUb5pgTEPPx55Gu29tF3XtYK3t+vwnxz8sNa4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JINl9vX9MKt9CwDU/U51DvXhSv0FP0zhOHw94JT92Xt2rdpM4ll1sYAHZ4KsSOzYl
 iEDqoYdKIXCNU21Ep6CHS+KiwkWfsIOeXHo/VSPLwWloxU7tK+HgORNvzA9WA0QyVh
 fv3SWM9liXWihOMa9MEY+mch6eiVkQ1RMrsafuFPHUk/aSxMeDSfSXAy9YEx+pXkx+
 PDfstSt3uphMX7mTWO0IEvwD1yit+ekhDqzHsf3sfrTGj8NEZpHuXf8Jj5h6F/yI5Z
 EOxmOFsq9TayVTqp/NaZ4IS/J5yR7P6G7YqxTEFVsNKJTOTvxRDO6/GM2Vwbh1XhwX
 J4A8U7v/WUUyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] gpu: nova-core: mm: get rid of Arc<BarUser> in
 BarUserAccess
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260926124405.604707-4-dakr@kernel.org>
References: <20260926124405.604707-1-dakr@kernel.org>
 <20260926124405.604707-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 12:58:14 +0000
Message-Id: <20260926125815.3997A1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] nova-core: mm: obsolete comment claims Test 4 constructs a fresh Ba=
rUser
--

commit b705dbdc6dba4759072fbccc510dc7a0935032c8
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess

There is no need for a reference count here. BarUserAccess can just
borrow from BarUser.

> diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core=
/mm/bar_user.rs
> index 6c8fa06d9f4bb..855244f069831 100644
> --- a/drivers/gpu/nova-core/mm/bar_user.rs
> +++ b/drivers/gpu/nova-core/mm/bar_user.rs
[ ... ]
> @@ -390,10 +389,6 @@ pub(crate) fn run_self_test(
>      drop(vmm);
> =20
>      // Test 4: Exercise `BarUser::map()` end-to-end.
> -    let bar_user =3D Arc::pin_init(
> -        BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast(), bar1),
> -        GFP_KERNEL,
> -    )?;
>      let access =3D bar_user.map(mm, &[test_pfn], true)?;
> =20
>      // Write pattern via PRAMIN, read via BarUserAccess.

[Severity: Low]
Should the comment just above drop(vmm) in run_self_test() in
drivers/gpu/nova-core/mm/bar_user.rs be updated?

It currently says: "Release Tests 1-3's Vmm before Test 4 constructs a fresh
BarUser on the same PDB."

Since this patch removes the construction of a fresh BarUser for Test 4,
that part of the comment is now obsolete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926124405.6047=
07-1-dakr@kernel.org?part=3D3
