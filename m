Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C49FCD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1AC10E10D;
	Tue,  9 Jun 2026 06:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CRyBowMC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29AE10E10D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:59:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55B27600AE;
 Tue,  9 Jun 2026 06:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC20B1F00893;
 Tue,  9 Jun 2026 06:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988392;
 bh=6PMzg1WoSSi6Fs890h+2XJv0x1TfAu7cZFqrbJPTl4I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CRyBowMCEGz6PeTDWtgIpigJfROYQhRPaLmanbR8C3adItwEGsHYDk7DAl5Plucqi
 38Wg5R9MRxjVCvNSV9l66qPkbJ11UvHcckhHneOz21WUlIstEY2gpK5duBtAePU69Y
 IEPfq38v1F5UCQlELb9EP28XYAc+AI2rLizEmpog5cTmrnLehIsaYn4YJyTx1U+kSr
 R8nblJttsnsmLEx8K1xfiJGHgtBnn5o+mdPPOqu0nHkerm6+Fdx1Fbpil3CWorjSCz
 Q8CH/O/oPZq1KxSpo1Q2UumLvhJWJrBznCngVyswOOIJ5NVNP4+i8GgZRhrdnv9/FQ
 NSD5pGupLfmOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] list: Cache cursors in entry iterators
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609064122.95825-2-kaitao.cheng@linux.dev>
References: <20260609064122.95825-2-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:59:51 +0000
Message-Id: <20260609065951.DC20B1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Modifying the standard list iterators to pre-cache the `next` =
pointer fundamentally changes their traversal semantics from dynamic to sta=
tic evaluation, causing use-after-free (UAF) vulnerabilities and silently b=
reaking loops that modify the list ahead of the cursor or skip elements by =
advancing `pos`.
- [High] Eliminating the distinction between safe and non-safe list iterato=
rs obscures code intent, removes a vital visual guardrail for destructive o=
perations, and introduces severe backporting risks.
--

commit e1c09f66ccd28cca66865681febeb6f8233f0a36
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

list: Cache cursors in entry iterators

This commit introduces private next and previous cursor variables into the
standard list iteration macros. It changes the semantics of the
list_for_each_entry() family to cache the next pointer before executing the
loop body. It also updates comments to recommend the non-safe variants over
the safe ones when a temporary cursor is not needed.

> diff --git a/include/linux/list.h b/include/linux/list.h
> index 09d979976b3b8..9df84a56a789b 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -809,6 +809,29 @@ static inline size_t list_count_nodes(struct list_he=
ad *head)
>  #define list_entry_is_head(pos, head, member)				\
>  	list_is_head(&pos->member, (head))
> =20
> +#define __list_for_each_entry(pos, next, head, member)			\
> +	for (typeof(pos) next =3D list_next_entry(pos =3D			\
> +		list_first_entry(head, typeof(*pos), member), member);	\
> +	     !list_entry_is_head(pos, head, member);			\
> +	     pos =3D next, next =3D list_next_entry(next, member))

[ ... ]

> @@ -816,9 +839,7 @@ static inline size_t list_count_nodes(struct list_hea=
d *head)
>   * @member:	the name of the list_head within the struct.
>   */
>  #define list_for_each_entry(pos, head, member)				\
> -	for (pos =3D list_first_entry(head, typeof(*pos), member);	\
> -	     !list_entry_is_head(pos, head, member);			\
> -	     pos =3D list_next_entry(pos, member))
> +	__list_for_each_entry(pos, __UNIQUE_ID(next), head, member)

[Severity: Critical]
Does caching the next pointer fundamentally change the dynamic traversal
semantics of the standard list iterators kernel-wide?

A common kernel pattern is pinning the current entry (pos), dropping the
lock to perform a blocking operation, and reacquiring the lock. With
dynamic evaluation, pos->next is safely fetched under the lock.

With the new cached next pointer, if the next element was removed and freed
by a concurrent thread while the lock was dropped, next becomes a dangling
pointer, which could lead to a use-after-free when the loop steps.

Will this also silently skip dynamically inserted elements? If a loop body
inserts a new element immediately after pos, the old macro would naturally
visit it next. The new macro appears to silently skip it because it advances
using the pre-cached next.

Could this also overwrite manual cursor updates? If the loop body explicitly
alters pos to skip elements, the loop increment (pos =3D next) might overwr=
ite
the updated cursor with the pre-cached next, negating the skip and potentia=
lly
causing incorrect traversal behavior.

[ ... ]

> @@ -901,6 +917,8 @@ static inline size_t list_count_nodes(struct list_hea=
d *head)
>   * @n:		another type * to use as temporary storage
>   * @head:	the head for your list.
>   * @member:	the name of the list_head within the struct.
> + *
> + * Prefer list_for_each_entry() unless the temporary cursor is needed.
>   */
>  #define list_for_each_entry_safe(pos, n, head, member)			\

[Severity: High]
Does advising developers to prefer list_for_each_entry() over the _safe
variant for removals obscure the intent of the code?

The _safe variant explicitly signals to reviewers and static analysis tools
that the loop body may mutate the list. Conflating variable-scoping
convenience with traversal safety constraints removes a visual guardrail for
destructive operations.

Additionally, does this introduce a backporting hazard? If developers write
new code that unlinks elements using list_for_each_entry(), backporting tho=
se
patches to older stable kernels (which lack this caching patch) will compile
cleanly but might reliably introduce use-after-free vulnerabilities, as old=
er
kernels evaluate pos->next after pos has been unlinked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D14
