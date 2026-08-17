Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18BFC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F266310E8C0;
	Mon, 17 Aug 2026 17:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbXKAh6U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE05510E8C0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:35:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6DC4600AE;
 Mon, 17 Aug 2026 17:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE71F000E9;
 Mon, 17 Aug 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786988108;
 bh=5SRqUiXfhOxEAGd38bP5L26GZkvbAUv+wQXWboGWojQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fbXKAh6UDwfYQep3KOxKhgvaGMPxUdybxKjQc4t4Ts0qJiUt67YLd5LRQNvk1MQH9
 wZF+o2P7QNFVN1+sakM7oEPlVn/cQAqsSVM++NKjHxUcnT9A0WHjf0oQ+YjmEySq4T
 Vs/V9gPnk94Xc5fwwpWKTF3Kd8xq2DrsTHug7opS9z10JrHJ+CEkziJhyJZfbqL1Gn
 M0OGG3MNdvtmUplxaIq81mp19S2LZvChnQIPOjDhhpeluC5bl6RDckXmK/oCCFexjI
 bbTes7mpY9XiUUV/5170X5hIxccozhkTl5uLI4NSLVIjOcqXbH5hse71z08Xt2iCgx
 0YksUaCBl/ULA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] bpf/verifier: Route verifier stack state node
 allocations to folio_pool
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-3-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-3-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:35:07 +0000
Message-Id: <20260817173508.44AE71F000E9@smtp.kernel.org>
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
- [High] Unbounded bump-allocation of `bpf_verifier_stack_elem` causes seve=
re transient memory bloat during BPF verification.
--

--- Patch [3]: [PATCH 3/9] bpf/verifier: Route verifier stack state node al=
locations to folio_pool ---
commit 1f1ee699bf3c9e5a960869e7d6dbd7c57b050ee5
Author: Jim Cromie <jim.cromie@gmail.com>

bpf/verifier: Route verifier stack state node allocations to folio_pool

This commit embeds a folio_pool inside bpf_verifier_env to allocate transie=
nt
bpf_verifier_stack_elem frames, releasing them in bulk at the end of
bpf_check().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1725,7 +1725,7 @@ static int pop_stack(struct bpf_verifier_env *env, =
int *prev_insn_idx,
>  		*prev_insn_idx =3D head->prev_insn_idx;
>  	elem =3D head->next;
>  	bpf_free_verifier_state(&head->st, false);
> -	kfree(head);
> +	folio_pool_free_elem(head);

[Severity: High]
Does this cause unbounded memory growth during verification?

Looking at include/linux/folio_pool.h, folio_pool_free_elem() appears to be=
 a
no-op for pointers allocated from the pool:

static inline void folio_pool_free_elem(const void *ptr)
{
	if (!ptr || is_folio_pool_ptr(ptr))
		return;
	kvfree(ptr);
}

Since elements popped from the verifier stack are not actually freed, won't
the memory consumption scale with the total number of branches explored
rather than the maximum depth of the verification stack?

>  	env->head =3D elem;
>  	env->stack_size--;
>  	return 0;

[ ... ]

> @@ -1751,7 +1753,9 @@ static struct bpf_verifier_state *push_stack(struct=
 bpf_verifier_env *env,
>  	struct bpf_verifier_stack_elem *elem;
>  	int err;
> =20
> -	elem =3D kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT=
);
> +	elem =3D folio_pool_alloc_obj(env, state_pool,
> +				    struct bpf_verifier_stack_elem,
> +				    GFP_KERNEL_ACCOUNT);

[Severity: High]
With every explored branch allocating a new stack element here, and
pop_stack() abandoning the memory, can this transient memory bloat lead to
memory exhaustion and potential OOMs when verifying complex BPF programs
with many branches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D3
