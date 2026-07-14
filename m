Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E45C10E032;
	Tue, 14 Jul 2026 08:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="NV46Y87z";
	dkim-atps=neutral
Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910310E002
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1784009648; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=h2kDDyA4R1iz8bA/Op/Mo9JnTpsOUBAxmXhZ+mnpboE=;
 b=NV46Y87zhnk6yUNBrvhz8sNBkMum6JkdOYGG9IrJcv/rpL3qs9YCRUrvrgvpHbYoMISTpI
 ff0GBbvASzVA8jX2VA1dsFtROFJgojbdHyO0uhzy2uWiZRdQ+O+mCf8y1xAkjl2nWGSdUN
 itnilJ6VhAaKZ7v0lRRieqh1oM7FhYjGhawiuONSoL6tDyJ4dYakJL0wk5nmE6VHA4EDrc
 kcYJ7V21Ik7Ybzh5bHRT0zijcPuk53vexkV2hca/GxozRMLDDLnxqbCLi2l8PZguafjXCn
 OzXiTsZKJimpx2janahPybBuxp4VQcKeMbdn3a48N9n9Tv/YNpcSREyaKQLbPQ==
Cc: <dri-devel@lists.freedesktop.org>
Date: Tue, 14 Jul 2026 14:14:03 +0800
Message-Id: <alXTqyPqSKwoOGZ6@hostpc>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v2] gpu: buddy: avoid repeated builds of root dfs when
 alloc range
Mime-Version: 1.0
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Content-Transfer-Encoding: quoted-printable
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS;
 Tue, 14 Jul 2026 14:14:05 +0800
To: <sashiko-reviews@lists.linux.dev>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
X-Lms-Return-Path: <lba+26a55d3af+d0ee8d+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
References: <alTlW8TmTXLocWKP@hostpc>
 <20260713133132.18DB21F000E9@smtp.kernel.org>
Content-Disposition: inline
In-Reply-To: <20260713133132.18DB21F000E9@smtp.kernel.org>
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:29:11 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jul 13, 2026 at 01:31:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Spurious -ENOSPC failure in __alloc_range() for fully free memor=
y ranges due to unmerged SPLIT blocks.
> --

As mentioned by AI, this is a pre-existing issue.
The reported problem is unrelated to the optimization patch we=E2=80=99re s=
ubmitting currently.
If this problem can be reproduced and confirmed as valid,
we will send a separate follow-up patch to fix it later.

Thanks,
zackary

>=20
> --- Patch [1]: [PATCH v2] gpu: buddy: avoid repeated builds of root dfs w=
hen alloc range ---
> commit 87b87afa0112d6b6bc23de2294a961d8ef1fb83e
> Author: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
>=20
> gpu: buddy: avoid repeated builds of root dfs when alloc range
>=20
> This commit optimizes the buddy allocator by avoiding wasteful repeated b=
uilds
> of the DFS list during range allocations. It introduces __get_candidate_b=
lock()
> to unify block acquisition, falling back to lazily fetching the next root=
 block
> only when the DFS list is exhausted.
>=20
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index 3c73ae87f3c5b..72f521c51b3fa 100644
> > --- a/drivers/gpu/buddy.c
> > +++ b/drivers/gpu/buddy.c
>=20
> [ ... ]
>=20
> > @@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm,
> >  		u64 block_start;
> >  		u64 block_end;
> > =20
> > -		block =3D list_first_entry_or_null(dfs,
> > -						 struct gpu_buddy_block,
> > -						 tmp_link);
> > -		if (!block)
> > +		block =3D __get_candidate_block(mm, dfs, &cursor);
> > +		if (IS_ERR(block))
> >  			break;
> > =20
> > -		list_del(&block->tmp_link);
> > -
> >  		block_start =3D gpu_buddy_block_offset(block);
> >  		block_end =3D block_start + gpu_buddy_block_size(mm, block) - 1;
>=20
> [Severity: High]
> This is a pre-existing issue, but could allocations fail spuriously in
> __alloc_range() due to unmerged SPLIT blocks?
>=20
> Looking further down in this same loop in __alloc_range():
>=20
>     if (contains(start, end, block_start, block_end)) {
>         if (gpu_buddy_block_is_free(block)) {
>             ...
>         } else if (!mm->clear_avail) {
>             err =3D -ENOSPC;
>             goto err_free;
>         }
>     }
>=20
> If a previous allocation attempt splits a large free block but fails and =
does
> not undo the splits, the parent block is left marked as SPLIT with fully =
FREE
> children.
>=20
> If the system globally has no available clear memory (mm->clear_avail =3D=
=3D 0), a
> subsequent call to __alloc_range() requesting a range that completely
> encompasses this SPLIT block will satisfy the contains() check. However,
> because the parent block is SPLIT rather than FREE, it hits the
> !mm->clear_avail condition and immediately aborts the entire allocation w=
ith
> -ENOSPC.
>=20
> Should this logic instead traverse down to allocate the perfectly free
> children instead of aborting?
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alTlW8TmTXLocWKP@=
hostpc?part=3D1
