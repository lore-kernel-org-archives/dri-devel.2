Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290DC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4289610E2DD;
	Mon, 17 Aug 2026 17:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BCpYCXua";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8BC10E2DD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:39:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06E1241234;
 Mon, 17 Aug 2026 17:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F91F000E9;
 Mon, 17 Aug 2026 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786988355;
 bh=3iWlrZdt8C/JPdh67yos7xGTdEsQoODVr2SaSRLdMyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BCpYCXuaxOvrS3iUVmXmEPMiB+yqLy4NhHng7GPuc9TWBkXKmBqzAfNzHdA2Po+Su
 Eg6MzY2YcKu7A9DSm/FoZBHP51NouzYIKkJHMpGQLzESFTO9C5qWiux4MjogEHb3WP
 YjNOQcpnN6KNEZD/fHyWjgf1DbbltyY/0z0Ox3qkbW900PO+/FBtw/4qHgwBrPluKW
 oEiP0cZeWcxS2txxePYM6mJvGYVnr7OsS1G9EWhRV5d/K1rwdQaQldpdmu4Bq1r1xg
 V1hE+sd5f5W2uWTbwp1XGHc3LMtnM/HnbkcpEgGw+tikT7Koq51tMHjlMaqhKuqk2+
 gvdttq9j1VvdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] locking/lockdep: Traverse adjacency lists directly
 in zap_class()
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-7-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-7-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:39:15 +0000
Message-Id: <20260817173915.AF7F91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] zap_class() incorrectly searches the zapped class's own dependency=
 lists instead of the connected classes' lists, failing to remove remote ba=
ck-edges and causing Use-After-Free.
- [High] Out-of-bounds memory write in zap_class() due to unsafe pointer ar=
ithmetic on dynamically allocated lock_list entries.

Pre-existing issues:
- [High] lock_list entries are synchronously returned to the allocator befo=
re an RCU grace period expires, exposing lockless RCU readers to torn data =
(RCU-001 violation).
--

--- Patch [7]: [PATCH 7/9] locking/lockdep: Traverse adjacency lists direct=
ly in zap_class() ---
commit 71cf1d3ff4ec0c990dff428fe396cff0df9ba08d
Author: Jim Cromie <jim.cromie@gmail.com>

locking/lockdep: Traverse adjacency lists directly in zap_class()

Rework zap_class() to traverse class->locks_after and class->locks_before
directly, unlinking each edge and its matching counterpart on the
connected lock class via RCU while clearing the respective allocation
slot bits.

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index f0f58db090fff..c8975c9282bb9 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6285,11 +6284,29 @@ static void zap_class(struct pending_free *pf, st=
ruct lock_class *class)
>  	 * Remove all dependencies this lock is
>  	 * involved in:
>  	 */
> -	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
> -		entry =3D list_entries + i;
> -		if (entry->class !=3D class && entry->links_to !=3D class)
> -			continue;
> -		__clear_bit(i, list_entries_in_use);
> +	list_for_each_entry_safe(entry, tmp, &class->locks_after, entry) {
> +		list_for_each_entry_safe(other, other_tmp, &entry->links_to->locks_bef=
ore, entry) {
> +			if (other->links_to =3D=3D class) {

[Severity: High]
Does this code iterate the correct list to find the remote edge?

If entry->links_to points to the zapped class itself, iterating over
&entry->links_to->locks_before traverses the zapped class's own incoming
edges rather than the remote class's edges. Furthermore, the condition
(other->links_to =3D=3D class) trivially matches elements in its own list.

Does this regression cause the actual reciprocal edges in the remote
classes to be skipped, leaving dangling pointers to the freed class that
could trigger a use-after-free during subsequent lockdep graph traversals?

> +				__clear_bit(other - list_entries, list_entries_in_use);

[Severity: High]
Could this pointer arithmetic regression cause out-of-bounds memory writes?

Lockdep supports allocating lock_list entries dynamically via a folio pool
when the static list_entries array is exhausted. By calculating bit indices
with (other - list_entries), this produces an out-of-bounds offset for
dynamically allocated entries, causing __clear_bit() to overwrite arbitrary
kernel memory.

Also, does this regression leak the dynamically allocated lock_list entries
since they are never freed back to their pool?

> +				nr_list_entries--;
> +				list_del_rcu(&other->entry);

[Severity: High]
This is a pre-existing issue, but does synchronously clearing the allocation
bit before an RCU grace period expose lockless RCU readers to torn data?

zap_class() unlinks dependency edges using list_del_rcu() but immediately
marks them as available by clearing their bit in the list_entries_in_use
bitmap above. This allows concurrent calls to alloc_list_entry() to
reallocate the struct lock_list block and insert it into a different list,
modifying its next pointer.

Could lockless readers traversing the original list observe the modified
next pointer and be steered into unrelated lists or infinite loops?

> +				break;
> +			}
> +		}
> +		__clear_bit(entry - list_entries, list_entries_in_use);
> +		nr_list_entries--;
> +		list_del_rcu(&entry->entry);
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D7
