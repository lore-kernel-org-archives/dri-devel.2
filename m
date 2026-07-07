Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F51C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C004910EB83;
	Tue,  7 Jul 2026 07:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DqQWJ3Fo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5AD10EB83
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94019618A9;
 Tue,  7 Jul 2026 07:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D0B1F00A3A;
 Tue,  7 Jul 2026 07:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409605;
 bh=q1qmzs0JWCup+6ZnnyrDQIMc9BCRVCv1Kv2bAsrdH4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DqQWJ3FoU2Dt+4egUJ0cJlYjWVqa/kVou1g6ZYLoOIzIVmIUkn1u3vncJrrhaWgr7
 KJ9XcE78FYdlMl7w0B5HwLnaFj+jpbau8KggsUG94B4yPbu4c0phf5MYj6C0QPbOXZ
 Wa1Q0Kdh8V6ppsnhfhTdJeCkksGvhjvcq0hYDeDyPrwlzS+D/I8vJlOaZ0uDcxnq6/
 WCBbQeSCGQuR15LM52LsjjgFIoxY0740XVK8AzlTFHGHZC67suYrtr+Kkh/zhs6ud+
 dQCi/1p7RMjGphe4iYe3GJrVFCLRt+WnMqrUvx9hcGYZlRiWIMTlXLwkgV+WeEZHrx
 fivlHc87tUTEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/40] dept: add proc knobs to show stats and
 dependency graph
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-modules@vger.kernel.org, cassel@kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, dri-devel@lists.freedesktop.org,
 "Anna
 Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, linux-rt-devel@lists.linux.dev, ojeda@kernel.org,
 linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260706061928.66713-6-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-6-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:24 +0000
Message-Id: <20260707073324.B1D0B1F00A3A@smtp.kernel.org>
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
- [High] Lockless traversal of `dept_classes` and `fc->dep_head` in procfs =
read operations causes kernel panic due to LIST_POISON pointer dereference =
and Use-After-Free.
--

commit e2e753e7050a1aa0365bc001321fe4e79158b5b4
Author: Byungchul Park <byungchul@sk.com>

dept: add proc knobs to show stats and dependency graph

This commit introduces procfs knobs to expose internal stats and the depend=
ency
graph for the dependency tracker at runtime.

> diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
> new file mode 100644
> index 0000000000000..97beaf397715f
> --- /dev/null
> +++ b/kernel/dependency/dept_proc.c

[ ... ]

> +static void *l_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	/*
> +	 * XXX: Serialize list traversal if needed. The following might
> +	 * give a wrong information on contention.
> +	 */
> +	return seq_list_next(v, &dept_classes, pos);
> +}
> +
> +static void *l_start(struct seq_file *m, loff_t *pos)
> +{
> +	/*
> +	 * XXX: Serialize list traversal if needed. The following might
> +	 * give a wrong information on contention.
> +	 */
> +	return seq_list_start_head(&dept_classes, *pos);
> +}

[Severity: High]
Is it safe to traverse dept_classes without locks here?

If a concurrent module unload occurs, dept_free_range() calls list_del() on=
 the
class node:

kernel/dependency/dept.c:dept_free_range() {
	...
	list_del(&c->all_node);
	...
}

Because list_del() poisons the removed node's next pointer with LIST_POISON=
1,
a concurrent lockless reader in seq_list_next() will dereference LIST_POISO=
N1
and cause a kernel panic, rather than just returning wrong information.

> +
> +static void l_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +static int l_show(struct seq_file *m, void *v)
> +{
> +	struct dept_class *fc =3D list_entry(v, struct dept_class, all_node);
> +	struct dept_dep *d;
> +	const char *prefix;
> +
> +	if (v =3D=3D &dept_classes) {
> +		seq_puts(m, "All classes:\n\n");
> +		return 0;
> +	}
> +
> +	prefix =3D fc->sched_map ? "<sched> " : "";
> +	seq_printf(m, "[%p] %s%s\n", (void *)fc->key, prefix, fc->name);
> +
> +	/*
> +	 * XXX: Serialize list traversal if needed. The following might
> +	 * give a wrong information on contention.
> +	 */
> +	list_for_each_entry(d, &fc->dep_head, dep_node) {

[Severity: High]
Does traversing fc->dep_head without rcu_read_lock() risk a use-after-free?

Since the dependency objects in this list are RCU-managed, traversing them
without holding rcu_read_lock() might allow the objects to be freed to the
pool while they are still being iterated.

> +		struct dept_class *tc =3D d->wait->class;
> +
> +		prefix =3D tc->sched_map ? "<sched> " : "";
> +		seq_printf(m, " -> [%p] %s%s\n", (void *)tc->key, prefix, tc->name);
> +	}
> +	seq_puts(m, "\n");
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D5
