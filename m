Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A10C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A98610E218;
	Mon, 17 Aug 2026 17:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDA9i1tL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A32710E218
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:52:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CA81600AE;
 Mon, 17 Aug 2026 17:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F207C1F000E9;
 Mon, 17 Aug 2026 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786989170;
 bh=8VwdM8pG/Mh7gZhtKp5gG9KFQuWtYOfSsl6zNqKQnww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KDA9i1tLRKKuo7yqn7yYCNB5e91tPbyxtwzc+jGCq04Jg6w4eIbcgw1K+RrIhexCy
 g/QBVwAkAEJKHFe1VCcXs/OrtuulZEzL6rqo7pjQirB1D1F9tUdQtbWju7bBk3uTu6
 6uUSKZCjSwxW9pZxOfffHhzW4/jl/BarOXGKtU8Qi7ue5aSGidBlacxvAlP8iONSP+
 I+sUmKqFR9u0h0IFVmHHUep1ftNdHE8Z6/jCwsxRgM1v8l+bx5QH7h0rv4JXcCsNKA
 JVVToMJPu6jGf6zbh459yto9dnOlfHajRepcQYya6ESY2klUldIzLb87yK58LnNIvk
 aEWiB+XnRAYCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] locking/lockdep: Shrink static list_entries array
 to early bootstrap buffer
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-folio-pool-v1-v1-8-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-8-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:52:49 +0000
Message-Id: <20260817175249.F207C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Dynamically allocated lock_list entries from lockdep_pool are perm=
anently leaked when lock classes are zapped.
- [High] Allocating from folio_pool under graph_lock violates lock nesting =
rules and will deadlock on PREEMPT_RT.
- [High] `nf_tables_abort()` resets the scratchpad incorrectly, breaking su=
bsystem toggles and hardcoding chunk sizes.
- [High] Transient operations are leaked on every map/unmap due to lack of =
scratchpad reset in DRM GPUVM.
- [High] BPF `generic_map_update_batch()` unconditionally fails with `-ENOM=
EM` for maps with large elements.

Pre-existing issues:
- [High] Synchronous clearing of list_entries_in_use allows reallocation of=
 bootstrap entries before an RCU grace period elapses, causing UAF for lock=
less readers.
--

--- Patch [8]: [PATCH 8/9] locking/lockdep: Shrink static list_entries arra=
y to early bootstrap buffer ---
commit 50e28e082c0e7079e9acf36ed3d4b7ea1bf5fae3
Author: Jim Cromie <jim.cromie@gmail.com>

locking/lockdep: Shrink static list_entries array to early bootstrap buffer

Shrink the static compile-time list_entries[] array and its tracking
bitmap from MAX_LOCKDEP_ENTRIES (32,768 entries, ~1.31 MB BSS) down to
a 4096-entry early boot bootstrap buffer (~160 KB BSS).

[ ... ]

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c8975c9282bb9..5968a976bf8ea 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c

[ ... ]

> @@ -6287,26 +6295,30 @@ static void zap_class(struct pending_free *pf, st=
ruct lock_class *class)
>  	list_for_each_entry_safe(entry, tmp, &class->locks_after, entry) {
>  		list_for_each_entry_safe(other, other_tmp, &entry->links_to->locks_bef=
ore, entry) {
>  			if (other->links_to =3D=3D class) {
> -				__clear_bit(other - list_entries, list_entries_in_use);
> +				if (is_bootstrap_entry(other))
> +					__clear_bit(other - list_entries, list_entries_in_use);

[Severity: High]
This is a pre-existing issue, but does synchronous clearing of
list_entries_in_use allow reallocation of bootstrap entries before an
RCU grace period elapses?

When a module is unloaded, zap_class() unlinks the class's lock_list entries
and clears their bootstrap_entries_in_use bit immediately. If
alloc_list_entry() instantly reallocates the bootstrap entry and mutates its
list pointers while lockless RCU readers are actively iterating over it,
can this cause a use-after-free or RCU violation for lockless readers?

>  				nr_list_entries--;
>  				list_del_rcu(&other->entry);

[Severity: High]
Are dynamically allocated lock_list entries from lockdep_pool being
permanently leaked when lock classes are zapped?

Because the underlying folio_pool allocator does not support individual
element deallocation via a simple unlink, entries that are not bootstrap
entries are permanently forgotten after being unlinked.

Since unloading modules registers and unregisters lock classes, could this
eventually lead to a system out-of-memory condition?

>  				break;
>  			}

[ ... ]

[Severity: High]
Does allocating from folio_pool under graph_lock violate lock nesting rules
and deadlock on PREEMPT_RT?

As mentioned in the commit message, alloc_list_entry() spills subsequent
allocations to the lockdep_pool. When called with graph_lock() held (which
acquires an arch_spinlock_t and disables interrupts), it invokes the
folio_pool allocator:

kernel/locking/lockdep.c:alloc_list_entry() {
    ...
	p =3D folio_pool_alloc_type(&lockdep_pool, struct lock_list, GFP_ATOMIC);
    ...
}

lib/folio_pool.c:folio_scratchpad_alloc() {
    ...
	spin_lock_irqsave(&sp->lock, flags);
    ...
}

Because sp->lock is a spinlock_t, which maps to a sleepable rt_mutex on
PREEMPT_RT, attempting to acquire it while holding a raw spinlock causes a
sleep-in-atomic deadlock. Can this cause an invalid wait context deadlock a=
nd
lockdep splat?


[Severity: High]
Does nf_tables_abort() reset the scratchpad incorrectly, breaking subsystem
toggles and hardcoding chunk sizes?

When an nf_tables transaction is aborted (e.g., due to an error in a batch
ruleset load), nf_tables_abort() reinitializes the scratchpad:

net/netfilter/nf_tables_api.c:nf_tables_abort() {
    ...
	folio_scratchpad_free(&nft_net->trans_scratchpad);
	folio_scratchpad_init(&nft_net->trans_scratchpad, 4);
    ...
}

On architectures with 64KB pages, order 4 results in 1MB chunks instead of
the intended 64KB chunks, wasting large amounts of memory. Additionally,
passing a NULL key (implicitly through folio_scratchpad_init) permanently
disconnects the scratchpad from the nft_trans_scratchpad_key module paramet=
er.


[Severity: High]
Are transient operations leaked on every map/unmap due to lack of scratchpad
reset in DRM GPUVM?

drm_gpuva_op structures are allocated dynamically via gpuva_op_alloc() using
folio_scratchpad_alloc_obj(). When the operation completes, it is freed:

drivers/gpu/drm/drm_gpuvm.c:gpuva_op_free() {
    ...
	else
		folio_scratchpad_free_elem(op);
}

The caller assumes this frees the operation state, but because
folio_scratchpad_free_elem() is a no-op for bump allocators, and drm_gpuvm
never explicitly calls folio_scratchpad_reset() between operations, the
embedded va_scratchpad will endlessly consume memory.

Could this lead to a rapid out-of-memory condition when continuously mapping
and unmapping GPU memory?


[Severity: High]
Does generic_map_update_batch() unconditionally fail with -ENOMEM for maps
with large elements?

When a user issues a BPF_MAP_UPDATE_BATCH syscall, the batch_sp scratchpad
is initialized with chunk_order =3D 0:

kernel/bpf/syscall.c:generic_map_update_batch() {
    ...
	folio_scratchpad_init_key(&batch_sp, 0, &bpf_batch_scratchpad_key);

	key =3D folio_scratchpad_alloc(&batch_sp, map->key_size,
				     sizeof(void *), GFP_USER | __GFP_NOWARN);
    ...
}

Because the stack-local bump allocator cannot satisfy requests larger than =
the
chunk size (page limit minus header), it will unconditionally return NULL f=
or
keys or values exceeding a single page. Does this deterministically break
backward compatibility for large map elements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D8
