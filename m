Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CFFC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE89E10EB87;
	Tue,  7 Jul 2026 07:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRpw9U/n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA77B10EB87
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D42054351C;
 Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A61F000E9;
 Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409614;
 bh=6raXW6tTfXqLQeqQS8TRI54npNDxeghgUG26veqYNbM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eRpw9U/nhJusw4HUKV66OsxwuiaoEbrC1gdaz2HQVDmAeHntR1C8/dtXwR7W00YC6
 8/f2CqEFY2z2Iy+B5u8Sp+A8Wm4Hx3C3nBJ3s1LzdYuCbTnF6CXveNbMzOpZyYdU6g
 CduLSoEzfK7yvr+8vp6QsxJvySO5XPbefS+zL/URxbd6Sig5EqmELXynrxvALXedpB
 301qVULhA5K8ZR+KkQy3oopB/1j1L8FIZH5IX4rMHvpnjrwnVAZ/LjnUEGoE0X6fJE
 d4YYiY1h6d248F1jsSLin0brAdCKayH/WorZ9w8nDMvAAS0BJuix9WJYfV/526wCeo
 y7W2okuJDQF1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/40] dept: distinguish each work from another
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-rt-devel@lists.linux.dev, cassel@kernel.org,
 linux-ide@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, linux-modules@vger.kernel.org,
 "Chuck Lever" <cel@kernel.org>, ojeda@kernel.org, dlemoal@kernel.org,
 dri-devel@lists.freedesktop.org, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20260706061928.66713-8-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-8-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:33 +0000
Message-Id: <20260707073334.0E5A61F000E9@smtp.kernel.org>
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
- [Medium] `dept_update_cxt()` hardcodes the process context ID, failing to=
 track bottom-half (BH) work items in softirq context and corrupting the co=
ntext of preempted tasks.
--

commit b8dda7d95e5377770d28c6712cf8fe7fafa98ade
Author: Byungchul Park <byungchul@sk.com>

dept: distinguish each work from another

This commit updates DEPT to assign a different context ID to each work item.
Since workqueues provide their own concurrency control, wait operations in a
work item do not prevent events in other works from executing.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c6ea96d5b7167..4a4075d0697c7 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
[ ... ]
> @@ -3204,6 +3205,8 @@ __acquires(&pool->lock)
> =20
>  	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
>  #endif
> +	dept_update_cxt();
> +

[Severity: Medium]
Will this unconditionally modify the process context ID, even when tracking
bottom-half (BH) work items running in softirq context?

When a BH workqueue executes multiple work items in a single softirq batch,
process_one_work() executes them and calls dept_update_cxt(). However,
dept_update_cxt() is implemented as:

kernel/dependency/dept.c:dept_update_cxt() {
    struct dept_task *dt =3D dept_task();
    dt->cxt_id[DEPT_CXT_PROCESS] +=3D 1UL << DEPT_CXTS_NR;
}

This hardcodes the increment to DEPT_CXT_PROCESS rather than checking
cur_cxt() to increment DEPT_CXT_SIRQ. Does this cause DEPT to fail in
distinguishing sequential BH work items and falsely report dependencies?

Also, can this corrupt the continuous dependency tracking context of
whatever task was preempted by the softirq?

>  	/* ensure we're on the correct CPU */
>  	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
>  		     raw_smp_processor_id() !=3D pool->cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D7
