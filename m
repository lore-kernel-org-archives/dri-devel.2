Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1263CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D2C10E100;
	Tue,  9 Jun 2026 06:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oEtdcY8o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846C110E100
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:54:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E33B3601DC;
 Tue,  9 Jun 2026 06:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DE71F00893;
 Tue,  9 Jun 2026 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988090;
 bh=mY7KlRVl2zhnqjoIykZl1aY9OXpVFkuWCDaOR1JPSI4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oEtdcY8ocjxGy3V863cLHq5zuy79prdSyU/iotNEx8wy6q0jCJEY7kgDWWET9C85D
 KUxboNP7PXamE1BR+4l+KbsWwmLlvqUHBOpnYpQhrc0jR8mx/w70oJRFhHPooxU+Vt
 r7vseqpdbcrhjY0gFIB0x+YqibHulMGfp6yq7ZUwf50h3ZzATP/trXSRHkGsaQO/xM
 ApPxWEdgAFd6+cKzgSRGUIzgByXvMJUMzyYpY1LYdNh6mE6P6WNJVo5wdMYMsWjwrG
 3+8Gp8bT4D5x21A+3ATl3mK6Gdz/hP4AfbK3mNgSYE7aNMzkQDxQd+lVMGF/uOioRM
 xoPjlpSrV0yDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] locking/locktorture: Open-code ww mutex list walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609063855.95710-2-kaitao.cheng@linux.dev>
References: <20260609063855.95710-2-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:54:49 +0000
Message-Id: <20260609065450.66DE71F00893@smtp.kernel.org>
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
- [Medium] The WW mutex documentation promotes an idiomatic pattern that re=
lies on `list_for_each_entry()` not caching the next element, which is brok=
en by the upcoming list iterator update.
--

commit 803c4bd20ba4e9475a66f9600c81114e4079f384
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

locking/locktorture: Open-code ww mutex list walk

This commit open-codes the ww mutex list walk in locktorture. It prepares
the code for an upcoming change that makes list_for_each_entry() cache the
next element before entering the loop body, which preserves the existing
dynamic traversal semantics.

> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index e618bcf75e2d8..0eb75e9bccaa6 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -644,7 +644,9 @@ __acquires(torture_ww_mutex_2)
> =20
>  	ww_acquire_init(ctx, &torture_ww_class);
> =20
> -	list_for_each_entry(ll, &list, link) {
> +	for (ll =3D list_first_entry(&list, typeof(*ll), link);
> +	     !list_entry_is_head(ll, &list, link);
> +	     ll =3D list_next_entry(ll, link)) {
>  		int err;
> =20
>  		err =3D ww_mutex_lock(ll->lock, ctx);

[Severity: Medium]
Since this patch updates locktorture to avoid regressions in the ww-mutex
list walk under the new list iterator semantics, does
Documentation/locking/ww-mutex-design.rst also need to be updated?

The documentation for "Method 2" explicitly encourages using
list_for_each_entry() for dynamic list reordering:

Documentation/locking/ww-mutex-design.rst:lock_objs() {
...
			/* we lost out in a seqno race, lock and retry.. */
			ww_mutex_lock_slow(&entry->obj->lock, ctx);

			/*
			 * Move buf to head of the list, this will point
			 * buf->next to the first unlocked entry,
			 * restarting the for loop.
			 */
			list_del(&entry->head);
			list_add(&entry->head, list);
...
}

If a developer follows this documented pattern with the new list iterator
semantics, moving the list entry to the head of the list will no longer
restart the loop. Instead, the loop will continue from the cached next
element, skipping over unlocked entries and silently failing to acquire
all required locks. Could leaving this unchanged cause regressions in
drivers that copy this pattern?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D11
