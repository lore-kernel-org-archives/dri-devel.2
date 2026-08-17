Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA826C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A57310E8C2;
	Mon, 17 Aug 2026 17:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ifgn5lnu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1405410E2DD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:35:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BF86600AE;
 Mon, 17 Aug 2026 17:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D21F000E9;
 Mon, 17 Aug 2026 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786988154;
 bh=FpzT0v1cRUPESt2bDvGvM8vB+H3T8gdYEnTfhOqi6e0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ifgn5lnu6ZuqGh+m2qmRfzBiXkXDd+RHn8eAjHepdbAO/dn5bjr9OxkrwMp7vhucc
 zvvML74oGpL2MU/CgPohJRhe/DKO9MTmp1tytGKbomX2XU4B/ke9/K2gV+XztME4ba
 V0SrLkEj24qtT4iVgBGya6z4ZaBr5Ki8i8mMMiv6tlTJ5VRakUpqNwiS4QB8AQ7cY/
 KyIiqILurDTcizOWRj9Bua6mexGbC2zDX9fis0f8hzkJ7H9XOA/QDKr6+j6ZUiAMCu
 Fwc36XDxnbYYgJzn3HLegqq10fWnufM+bh/kbqEqQ8S8FiS/Z7h3Cf6ZzCwYbFEWQZ
 PtkwJovqZ1ydQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] netfilter/nf_tables: Add folio_scratchpad collector
 to struct nftables_pernet
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-folio-pool-v1-v1-2-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-2-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:35:53 +0000
Message-Id: <20260817173554.143D21F000E9@smtp.kernel.org>
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
- [Critical] Asynchronous reset and synchronous abort paths cause severe us=
e-after-free, memory corruption, and spinlock corruption due to sharing a s=
ingle per-net scratchpad across overlapping batch lifecycles.
- [High] Transaction batches that consist exclusively of creation operation=
s permanently leak the memory used for their `nft_trans` objects.
- [Medium] Re-initialization of the scratchpad during an abort drops the fe=
ature-toggle static key and hardcodes the allocation order, causing memory =
over-allocation on some architectures.
--

--- Patch [2]: [PATCH 2/9] netfilter/nf_tables: Add folio_scratchpad collec=
tor to struct nftables_pernet ---
commit 210be9d0ffcaa1541a9b10d23109de51629b6996
Author: Jim Cromie <jim.cromie@gmail.com>

netfilter/nf_tables: Add folio_scratchpad collector to struct nftables_pern=
et

This commit introduces a folio_scratchpad to struct nftables_pernet to hand=
le
variable-sized transaction object allocations. It aims to improve allocation
and teardown speed by replacing standard SLUB allocations with bulk teardow=
n.

> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> [ ... ]
> @@ -221,7 +238,7 @@ static void nft_trans_list_del(struct nft_trans *tran=
s)
>  static void nft_trans_destroy(struct nft_trans *trans)
>  {
>         nft_trans_list_del(trans);
> -       kfree(trans);
> +       nft_trans_free(trans);
>  }

[Severity: High]
During commit for creation operations, nft_trans_destroy() unlinks the
transaction and calls nft_trans_free(), which is a no-op for scratchpad
chunks.

By the time the code reaches nf_tables_commit_release(), the commit_list is
completely empty.

This causes nf_tables_commit_release() to return early and skip scheduling
the destroy worker. Since the asynchronous worker never runs,
folio_scratchpad_reset() is never called.

Can batches consisting only of creation operations permanently leak memory?

> [ ... ]
> @@ -10267,6 +10286,8 @@ static void nf_tables_trans_destroy_work(struct w=
ork_struct *w)
>                 nft_trans_list_del(trans);
>                 nft_commit_release(trans);
>         }
> +
> +       folio_scratchpad_reset(&nft_net->trans_scratchpad);
>  }

[Severity: Critical]
When nf_tables_commit_release() schedules nf_tables_trans_destroy_work()
and drops the commit_mutex, a new batch can immediately begin allocating
transactions from this exact same scratchpad.

Meanwhile, the asynchronous worker for the previous batch will unconditiona=
lly
call folio_scratchpad_reset() here.

This rewinds the allocator's free pointer and destroys the memory actively
being used by the new batch.

Does this shared per-net scratchpad suffer from a race condition between
concurrent batches?

> [ ... ]
> @@ -11491,6 +11514,9 @@ static int nf_tables_abort(struct net *net, struc=
t sk_buff *skb,
>         else
>                 nf_tables_module_autoload_cleanup(net);
> =20
> +       folio_scratchpad_free(&nft_net->trans_scratchpad);
> +       folio_scratchpad_init(&nft_net->trans_scratchpad, 4);
> +
>         mutex_unlock(&nft_net->commit_mutex);

[Severity: Critical]
If the first batch's async worker is currently accessing the folios or
waiting on the internal scratchpad spinlock, calling
folio_scratchpad_free() and folio_scratchpad_init() here will free the
underlying folios and re-initialize the spinlock.

Does this synchronous abort corrupt the allocator state if the previous
batch's asynchronous worker is still running?

[Severity: Medium]
In nf_tables_init_net(), the scratchpad is initialized properly using
folio_scratchpad_init_key() with get_order(SZ_64K) and the
nft_trans_scratchpad_key.

Passing the literal 4 here instead of get_order(SZ_64K) forces the
allocator to request 1MB pages on systems with 64KB pages.

Additionally, folio_scratchpad_init() sets sp->key =3D NULL, which
permanently strips the feature toggle validation from all subsequent
allocations in this network namespace.

Does this re-initialization hardcode the allocation order and drop the
feature toggle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D2
