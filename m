Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7488C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0443C10E7FD;
	Mon, 13 Jul 2026 07:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="s/cfqzMI";
	dkim-atps=neutral
Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2754A10E556
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783924272; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Jrdy0f1+juHU6GH9PNE4PQoVFMe5EqsuMACg/Y+VOpQ=;
 b=s/cfqzMIuivnz2Fr1YUbuaqJTYRsD6hSpUhp35snRvVhFfLbxYb/RDtYLYddynj+8+8IKu
 CvR0PEz7fVAKQPSGR2WvAJ0GF378rZtkj0H2D3N5AnhYXwU10aHtOVy/9JPAgThbLcNspG
 G9IKNQKS0FT8+dcdgnu3+OfD73U62/+TQl0s2DDIzTtSCMxRM0YvULo3yY7YymTSXPc6ic
 v5K3N2Ywlo4WsOLl28+0QAkXD0RzlpKKvSdcFRFvwj+Q58G++Uznslu2l2dFyiJpQdtl4Y
 q4zIffUyKnTsliNV66rDx3hGa8rSL4Xa+Fip9SH6b60p+Gw22rZFCwpHuvR8+w==
To: "matthew.auld" <matthew.auld@intel.com>, 
 "arunpravin.paneerselvam" <arunpravin.paneerselvam@amd.com>, 
 "joelagnelf" <joelagnelf@nvidia.com>, "airlied" <airlied@gmail.com>, 
 "simona" <simona@ffwll.ch>, 
 "francois.dugast@intel.com" <francois.dugast@intel.com>
Cc: "dri-devel" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: buddy: avoid repeated builds of root dfs when alloc
 range
From: =?utf-8?q?=E5=88=98=E7=85=A7=E7=8E=89?= <liuzhaoyu.zackary@picoheart.com>
X-Lms-Return-Path: <lba+16a54862e+33231a+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <b4d697adea96d7ca99cf63e838b5ea9e285776bc.b951c3b7.46d1.48aa.a1ab.5d328bb9162c@feishu.cn>
Mime-Version: 1.0
References: <ak+ECwsuSljmvyKd@hostpc>
In-Reply-To: <ak+ECwsuSljmvyKd@hostpc>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:31:08 +0800
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

Please help review this patch.
Thanks!

> From: "Zhaoyu Liu"<liuzhaoyu.zackary@picoheart.com>
> Date:=C2=A0 Thu, Jul 9, 2026, 19:20
> Subject:=C2=A0 [PATCH] gpu: buddy: avoid repeated builds of root dfs when=
 alloc range
> To: <matthew.auld@intel.com>, <arunpravin.paneerselvam@amd.com>, <joelagn=
elf@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>
> Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
> The buddy allocator previously pre-built a DFS list by inserting all
> root blocks via list_add_tail() before every allocation call in
> __alloc_range_bias() and __gpu_buddy_alloc_range(). This is wasteful
> when the allocation can be satisfied by the first root or by sub-blocks
> produced from splits, as the remaining roots are never consumed.
>=C2=A0
> Introduce __get_candidate_block() which unifies the block acquisition
> logic for both __alloc_range_bias() and __alloc_range(): it first
> checks the DFS list (populated by splits during allocation or
> pre-filled by the caller for trim), and only when the list is exhausted
> does it lazily fetch the next root block through a cursor.
>=C2=A0
> When the caller pre-fills the DFS list (trim scenario), the cursor is
> initialized to mm->n_roots to disable root iteration entirely,
> preserving the original behavior.
>=C2=A0
> Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
> ---
> =C2=A0drivers/gpu/buddy.c | 61 ++++++++++++++++++++++++++++++------------=
---
> =C2=A01 file changed, 41 insertions(+), 20 deletions(-)
>=C2=A0
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dc81fe0301ce..2cebb87020c7 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -700,6 +700,41 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy=
 *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> +/**
> + * __get_candidate_block - Get a candidate block for allocation.
> + * @mm: GPU buddy manager
> + * @dfs: List of candidate blocks. Populated in two ways: (1) pre-filled=
 by
> + * =C2=A0 =C2=A0 =C2=A0 the caller before allocation with blocks availab=
le for allocation,
> + * =C2=A0 =C2=A0 =C2=A0 and (2) extended during allocation by block spli=
ts, which add the
> + * =C2=A0 =C2=A0 =C2=A0 resulting sub-blocks for subsequent finer-graine=
d allocation.
> + * @cursor: Pointer to current root index, advanced when iterating roots=
.
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Pass in a value >=3D mm->n_roots to=
 disable root iteration entirely,
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0restricting block acquisition to @d=
fs only; this is used in the
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trim scenario where only pre-split =
sub-blocks should be considered.
> + *
> + * Return: Pointer to the acquired block on success, ERR_PTR(-ENOSPC) wh=
en no
> + * more blocks are available.
> + */
> +static struct gpu_buddy_block*
> +__get_candidate_block(struct gpu_buddy *mm, struct list_head *dfs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *cursor=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpu_buddy_block *block;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D list_first_entry_or_null(dfs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 gpu_buddy_block,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_li=
nk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (block) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&block-=
>tmp_link);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return block;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*cursor >=3D mm->n_roots)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-=
ENOSPC);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return mm->roots[(*cursor)++];
> +}
> +
> =C2=A0static struct gpu_buddy_block *
> =C2=A0__alloc_range_bias(struct gpu_buddy *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64=
 start, u64 end,
> @@ -711,25 +746,18 @@ __alloc_range_bias(struct gpu_buddy *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpu_buddy_block *block;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(dfs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t cursor =3D 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D end - 1;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < mm->n_roots; ++i)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&m=
m->roots[i]->tmp_link, &dfs);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 block_s=
tart;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 block_e=
nd;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D list_f=
irst_entry_or_null(&dfs,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct gpu_buddy_block,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tmp_link);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!block)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D __get_=
candidate_block(mm, &dfs, &cursor);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(block=
))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&block-=
>tmp_link);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gpu_bud=
dy_block_order(block) < order)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;
> =C2=A0
> @@ -1023,6 +1051,7 @@ static int __alloc_range(struct gpu_buddy *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(allocated);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t cursor =3D list_empty(dfs) ? 0 : mm=
->n_roots;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D start + size - 1;
> =C2=A0
> @@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 block_s=
tart;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 block_e=
nd;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D list_f=
irst_entry_or_null(dfs,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct gpu_buddy_block,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tmp_link);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!block)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D __get_=
candidate_block(mm, dfs, &cursor);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(block=
))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&block-=
>tmp_link);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_start=
 =3D gpu_buddy_block_offset(block);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_end =
=3D block_start + gpu_buddy_block_size(mm, block) - 1;
> =C2=A0
> @@ -1109,10 +1134,6 @@ static int __gpu_buddy_alloc_range(struct gpu_budd=
y *mm,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head *bloc=
ks)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(dfs);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < mm->n_roots; ++i)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&m=
m->roots[i]->tmp_link, &dfs);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __alloc_range(mm, &dfs, start, s=
ize,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blocks, total_allocated_on_err);
> --=C2=A0
> 2.34.1
>=C2=A0
