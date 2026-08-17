Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD5EC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82B689FC9;
	Mon, 17 Aug 2026 17:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MCxNdOOc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6009089FC9
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:36:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C3E7401D9;
 Mon, 17 Aug 2026 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59EE1F000E9;
 Mon, 17 Aug 2026 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786988175;
 bh=CoekG0a3uNSGXf4IkS2/4//XmpC00cK/0oFy3wlviwc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MCxNdOOc+qEu/9biGAnPH+0DRu6xrsXqCh3DSiuChl+iwnlkbLApaIEY7PecWzlky
 yvwrYO+UI2G2kl4yC5a6xFO59mUtoc3mMGCbSv061p/pXBjTOVgiuEddx4MI444etO
 KJLkK5nksmLo2/Ic5dEV+OSNL5jskSygr7MQX+6Z7DZbx9biiQXakaSgQZmnMuE7nb
 rt9VeMXybkVQAXwi/aoW8pkg5O3nTHH9jRjejP2uznflcYBRgL7VUl0gZDHwcxlCG3
 67ZsQ2uu/qxPW2WMJq5OpaDHoyNUgDKrH7PzbfmjCxxhIl0n/yE3J9n7h6lRg40b53
 MI5OW6Tmapntg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] locking/lockdep: Fallback to folio_pool in
 alloc_list_entry when static pool is full
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-folio-pool-v1-v1-6-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-6-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:36:14 +0000
Message-Id: <20260817173614.C59EE1F000E9@smtp.kernel.org>
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
- [High] Atomic context violation and RT-deadlock in lockdep dynamic alloca=
tion.
- [High] Use-After-Free and memory leak due to untracked dynamic lock depen=
dencies.
- [Low] Undefined behavior in pointer arithmetic for dynamically allocated =
lock entries.
--

--- Patch [6]: [PATCH 6/9] locking/lockdep: Fallback to folio_pool in alloc=
_list_entry when static pool is full ---
commit 618b3b19dc7c789afe3ea0f17bf4c674f06ef1f3
Author: Jim Cromie <jim.cromie@gmail.com>

locking/lockdep: Fallback to folio_pool in alloc_list_entry when static poo=
l is full

Use struct folio_pool to dynamically expand lock dependency storage when
the static list_entries pool is exhausted, avoiding premature lockdep
disabling.

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 2d4c5bab5af88..f0f58db090fff 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
[ ... ]
> @@ -1404,11 +1429,19 @@ static struct lock_list *alloc_list_entry(void)
>  				      ARRAY_SIZE(list_entries));
> =20
>  	if (idx >=3D ARRAY_SIZE(list_entries)) {
> +		struct lock_list *p;
> +
> +		p =3D folio_pool_alloc_type(&lockdep_pool, struct lock_list,
> +					  GFP_ATOMIC);

[Severity: High]
Does dynamically allocating via folio_pool while holding a raw spinlock
violate atomic context rules?

alloc_list_entry() is called by add_lock_to_list() during lockdep graph upd=
ates,
which always run under the raw lockdep_lock (via graph_lock()).

Even with GFP_ATOMIC, folio_pool_alloc_type() acquires a standard spinlock_t
(sp->lock) and can call into the page allocator. On PREEMPT_RT, acquiring a
sleepable spinlock_t or calling the page allocator from within a raw spinlo=
ck
section causes a kernel panic (sleeping in atomic context). On non-RT kerne=
ls,
calling the allocator inside lockdep's graph lock violates its strict
non-reentrancy rules, which risks deadlocks if the allocator triggers warni=
ngs
or console output.

> +		if (p) {
> +			nr_list_entries++;
> +			return p;
> +		}

[Severity: High]
Could these dynamically allocated lock entries cause a use-after-free and
memory leak when modules are unloaded?

Dynamically allocated dependencies are not tracked in the list_entries_in_u=
se
bitmap.

When a module is unloaded, zap_class() unlinks dependencies:

kernel/locking/lockdep.c:zap_class() {
    ...
	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
		entry =3D list_entries + i;
		if (entry->class !=3D class && entry->links_to !=3D class)
			continue;
		__clear_bit(i, list_entries_in_use);
		nr_list_entries--;
		list_del_rcu(&entry->entry);
	}
    ...
}

Because dynamic entries aren't in this bitmap, zap_class() will skip them
and fail to unlink them from class->locks_after and class->locks_before.
When the module's memory is freed, lockdep retains dangling pointers to
the module's lock structures. Furthermore, the folio_pool bump allocator
does not support freeing individual elements, making the leaked
dependencies permanently unrecoverable.

[Severity: Low]
Could this result in undefined behavior when logging lock errors?

When lockdep detects a structural mismatch, it prints an error using pointer
subtraction:

kernel/locking/lockdep.c:class_lock_list_valid() {
    ...
	list_for_each_entry(e, h, entry) {
		if (e->links_to !=3D c) {
			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
			       c->name ? : "(?)",
			       (unsigned long)(e - list_entries),
    ...
}

If the entry e was dynamically allocated via folio_pool, it does not reside
within the static list_entries array. Subtracting pointers from different
memory objects is undefined behavior and produces a nonsensical array
index in the log.

>  		if (!debug_locks_off_graph_unlock())
>  			return NULL;
> =20
>  		nbcon_cpu_emergency_enter();
> -		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
> +		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low and folio_pool exh=
austed!");
>  		dump_stack();
>  		nbcon_cpu_emergency_exit();
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D6
