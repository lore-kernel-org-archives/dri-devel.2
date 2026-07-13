Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB87C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73D010EB48;
	Mon, 13 Jul 2026 22:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="D1vjSIWx";
	dkim-atps=neutral
Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFEF10E5D6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783949137; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UnYFE64SWOzeEjXYMuc4HAEtOUyJzJDVfxKkUKJDhQs=;
 b=D1vjSIWxI4NlniQABcJhWdyIc5ghCAd7g5S/SQxWEmnkZBKGpfdkv2oMMI2YS7D3ON7lwN
 /535jmdqW7QUOScHI4YbrGB6No2wqFwPcEHADew7eMnXO3ANfRKwvVf6OGbT6hf7MSQxti
 bMsFocLL1QNa1IFQMC9dQWMrwcmAu4vCffh9Uiw2ncsqA5fJwd1/Vb3IosboGB6Oc/w8wY
 ueRNjFNU4vGTFZo7+VsTE6ZWukVWqPUNTPW4+dFGxkqRmenhq4to/FfX6p5qNKJBMpRIB1
 J/WAzCyDE7LgecngFP1fexQHbgc5Ry4DdPNI4nfW3xdf99ghHgIOiyu4tLD0lg==
Message-Id: <alTnTUq456b3Pf5d@hostpc>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Cc: "matthew.auld" <matthew.auld@intel.com>, 
 "joelagnelf" <joelagnelf@nvidia.com>, "airlied" <airlied@gmail.com>, 
 "simona" <simona@ffwll.ch>, <francois.dugast@intel.com>, 
 "dri-devel" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel" <linux-kernel@vger.kernel.org>
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS;
 Mon, 13 Jul 2026 21:25:35 +0800
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
X-Lms-Return-Path: <lba+26a54e750+af7db6+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
In-Reply-To: <4901dc21-c281-4e60-b2a2-061100a5c8a9@amd.com>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Date: Mon, 13 Jul 2026 21:25:33 +0800
References: <ak+ECwsuSljmvyKd@hostpc>
 <b4d697adea96d7ca99cf63e838b5ea9e285776bc.b951c3b7.46d1.48aa.a1ab.5d328bb9162c@feishu.cn>
 <4901dc21-c281-4e60-b2a2-061100a5c8a9@amd.com>
Subject: Re: [PATCH] gpu: buddy: avoid repeated builds of root dfs when alloc
 range
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

On Mon, Jul 13, 2026 at 01:32:22PM +0530, Arunpravin Paneer Selvam wrote:
>=20
>=20
> On 7/13/2026 12:01 PM, =E5=88=98=E7=85=A7=E7=8E=89 wrote:
> > [You don't often get email from liuzhaoyu.zackary@picoheart.com. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > Please help review this patch.
> > Thanks!
> I was wondering whether this optimization provides a measurable benefit i=
n
> practice. Since mm->n_roots is typically quite small, the previous DFS li=
st
> construction only adds a few list_add_tail() operations per allocation.
> On the other hand, the new approach introduces an additional helper call =
and
> branching during candidate selection. Have you done any profiling or
> benchmarking to quantify the improvement?
>=20
> Thanks,
> Arun.

Thank you for your review, Arun.

To verify the gain, a KUnit perf case (gpu_test_buddy_range_alloc_perf)
was added locally. It sweeps fixed 1MB bias ranges across the whole
address space, allocating and freeing each range exactly, repeated
10000 iterations.

Two scenarios cover the two extremes of n_roots:
- 16MB mm  -> n_roots =3D 1  (16 bias ranges)
- 1GB-1 mm -> n_roots =3D 18 (1023 bias ranges)

Each configuration was measured 3 times and averaged. Three builds were
compared:
- baseline  : unmodified tree
- no-inline : patched, __get_candidate_block is static
- inline    : patched, __get_candidate_block is static inline

+----------+-----------------+------------------+------------------+
| mm_size  |  baseline (ns)  | no-inline (ns)   | inline (ns)      |
|          |                 | (change vs base) | (change vs base) |
+----------+-----------------+------------------+------------------+
| 16MB     |          66877  |     66598        |     64663        |
|          |                 |     -0.42%       |     -3.31%       |
+----------+-----------------+------------------+------------------+
| 1GB-1    |        9333559  |   9193052        |   9251951        |
|          |                 |     -1.51%       |     -0.87%       |
+----------+-----------------+------------------+------------------+

And, I've sent new v2 patch with inline function,
link: https://lore.kernel.org/all/alTlW8TmTXLocWKP@hostpc/

Please help review it again.

Thanks,
zackary

> >=20
> > > From: "Zhaoyu Liu"<liuzhaoyu.zackary@picoheart.com>
> > > Date:  Thu, Jul 9, 2026, 19:20
> > > Subject:  [PATCH] gpu: buddy: avoid repeated builds of root dfs when =
alloc range
> > > To: <matthew.auld@intel.com>, <arunpravin.paneerselvam@amd.com>, <joe=
lagnelf@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>
> > > Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
> > > The buddy allocator previously pre-built a DFS list by inserting all
> > > root blocks via list_add_tail() before every allocation call in
> > > __alloc_range_bias() and __gpu_buddy_alloc_range(). This is wasteful
> > > when the allocation can be satisfied by the first root or by sub-bloc=
ks
> > > produced from splits, as the remaining roots are never consumed.
> > > Introduce __get_candidate_block() which unifies the block acquisition
> > > logic for both __alloc_range_bias() and __alloc_range(): it first
> > > checks the DFS list (populated by splits during allocation or
> > > pre-filled by the caller for trim), and only when the list is exhaust=
ed
> > > does it lazily fetch the next root block through a cursor.
> > > When the caller pre-fills the DFS list (trim scenario), the cursor is
> > > initialized to mm->n_roots to disable root iteration entirely,
> > > preserving the original behavior.
> > > Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
> > > ---
> > >   drivers/gpu/buddy.c | 61 ++++++++++++++++++++++++++++++------------=
---
> > >   1 file changed, 41 insertions(+), 20 deletions(-)
> > > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > > index dc81fe0301ce..2cebb87020c7 100644
> > > --- a/drivers/gpu/buddy.c
> > > +++ b/drivers/gpu/buddy.c
> > > @@ -700,6 +700,41 @@ static void __gpu_buddy_undo_splits(struct gpu_b=
uddy *mm,
> > >           }
> > >   }
> > >=20
> > > +/**
> > > + * __get_candidate_block - Get a candidate block for allocation.
> > > + * @mm: GPU buddy manager
> > > + * @dfs: List of candidate blocks. Populated in two ways: (1) pre-fi=
lled by
> > > + *       the caller before allocation with blocks available for allo=
cation,
> > > + *       and (2) extended during allocation by block splits, which a=
dd the
> > > + *       resulting sub-blocks for subsequent finer-grained allocatio=
n.
> > > + * @cursor: Pointer to current root index, advanced when iterating r=
oots.
> > > + *          Pass in a value >=3D mm->n_roots to disable root iterati=
on entirely,
> > > + *          restricting block acquisition to @dfs only; this is used=
 in the
> > > + *          trim scenario where only pre-split sub-blocks should be =
considered.
> > > + *
> > > + * Return: Pointer to the acquired block on success, ERR_PTR(-ENOSPC=
) when no
> > > + * more blocks are available.
> > > + */
> > > +static struct gpu_buddy_block*
> > > +__get_candidate_block(struct gpu_buddy *mm, struct list_head *dfs,
> > > +                uint32_t *cursor)
> > > +{
> > > +        struct gpu_buddy_block *block;
> > > +
> > > +        block =3D list_first_entry_or_null(dfs,
> > > +                                        struct gpu_buddy_block,
> > > +                                        tmp_link);
> > > +        if (block) {
> > > +                list_del(&block->tmp_link);
> > > +                return block;
> > > +        }
> > > +
> > > +        if (*cursor >=3D mm->n_roots)
> > > +                return ERR_PTR(-ENOSPC);
> > > +
> > > +        return mm->roots[(*cursor)++];
> > > +}
> > > +
> > >   static struct gpu_buddy_block *
> > >   __alloc_range_bias(struct gpu_buddy *mm,
> > >                      u64 start, u64 end,
> > > @@ -711,25 +746,18 @@ __alloc_range_bias(struct gpu_buddy *mm,
> > >           struct gpu_buddy_block *block;
> > >           LIST_HEAD(dfs);
> > >           int err;
> > > -        int i;
> > > +        uint32_t cursor =3D 0;
> > >=20
> > >           end =3D end - 1;
> > >=20
> > > -        for (i =3D 0; i < mm->n_roots; ++i)
> > > -                list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> > > -
> > >           do {
> > >                   u64 block_start;
> > >                   u64 block_end;
> > >=20
> > > -                block =3D list_first_entry_or_null(&dfs,
> > > -                                                 struct gpu_buddy_bl=
ock,
> > > -                                                 tmp_link);
> > > -                if (!block)
> > > +                block =3D __get_candidate_block(mm, &dfs, &cursor);
> > > +                if (IS_ERR(block))
> > >                           break;
> > >=20
> > > -                list_del(&block->tmp_link);
> > > -
> > >                   if (gpu_buddy_block_order(block) < order)
> > >                           continue;
> > >=20
> > > @@ -1023,6 +1051,7 @@ static int __alloc_range(struct gpu_buddy *mm,
> > >           LIST_HEAD(allocated);
> > >           u64 end;
> > >           int err;
> > > +        uint32_t cursor =3D list_empty(dfs) ? 0 : mm->n_roots;
> > >=20
> > >           end =3D start + size - 1;
> > >=20
> > > @@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm=
,
> > >                   u64 block_start;
> > >                   u64 block_end;
> > >=20
> > > -                block =3D list_first_entry_or_null(dfs,
> > > -                                                 struct gpu_buddy_bl=
ock,
> > > -                                                 tmp_link);
> > > -                if (!block)
> > > +                block =3D __get_candidate_block(mm, dfs, &cursor);
> > > +                if (IS_ERR(block))
> > >                           break;
> > >=20
> > > -                list_del(&block->tmp_link);
> > > -
> > >                   block_start =3D gpu_buddy_block_offset(block);
> > >                   block_end =3D block_start + gpu_buddy_block_size(mm=
, block) - 1;
> > >=20
> > > @@ -1109,10 +1134,6 @@ static int __gpu_buddy_alloc_range(struct gpu_=
buddy *mm,
> > >                                      struct list_head *blocks)
> > >   {
> > >           LIST_HEAD(dfs);
> > > -        int i;
> > > -
> > > -        for (i =3D 0; i < mm->n_roots; ++i)
> > > -                list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> > >=20
> > >           return __alloc_range(mm, &dfs, start, size,
> > >                                blocks, total_allocated_on_err);
> > > --
> > > 2.34.1
>
