Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D085CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEB210E121;
	Thu, 25 Jun 2026 12:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bzsklwGb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FB710E121
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7ACD43831;
 Thu, 25 Jun 2026 12:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93711F00A3A;
 Thu, 25 Jun 2026 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782392050;
 bh=M9QIS+Us/+c7r1jGxHF0Ka3J4W+iRmKqFz4+9cgu3a8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bzsklwGbUIflLNsQXX36vCxUYtvfi7BJ/Zgp265m49QuWuIPJzbyIboLUcGfneWbt
 35lhRNuwOJZxrmnjCd6atxmOZWmlDGafzcWh7ILeSll0YDEHDILz5mT+wlx/0q9/lA
 IRQxHfPLsp3iKT0Y4S4fWgfSaYZ3kTWnzH3clJgNa0jkC4cRHaD8EyvCmFFzkI6IcJ
 rZbFS9vjxgbmHa6o9b1catN9VwqhJxT5A6efUkmkOnfT8ELtU/KRtW2rQeYNC4geLI
 IRIMgcZYLK25YgjfbWyR9+u7pBevlgfBnEvHWnecEm5Iy6ZPe9K7UtKwC5H/s1DUZJ
 12mPWztHygLAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] drm/panthor: Fix potential invalid pointer deref
 in group_process_tiler_oom()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-misc-fixes-v1-4-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-4-b67ed973fea6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:54:09 +0000
Message-Id: <20260625125409.D93711F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] `group->fatal_queues` is modified without any locking in `group_pr=
ocess_tiler_oom()`, leading to a data race with other contexts that update =
it, and `group->fatal_lock` is completely unused.
- [High] Firmware render pass counter validation check is vulnerable to 32-=
bit integer wrap-around, which can erroneously reject valid memory allocati=
ons.
--

commit 849043d96182c6a00588e13d1652d042b8e7a787
Author: Boris Brezillon <boris.brezillon@collabora.com>
drm/panthor: Fix potential invalid pointer deref in group_process_tiler_oom=
()

This commit prevents a potential invalid pointer dereference when
panthor_heap_pool_put() is called with an error pointer by ensuring heaps is
set to NULL on failure.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D2

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index e97f29469d28a..8fd4d97b062e0 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1600,7 +1600,10 @@ static int group_process_tiler_oom(struct panthor_=
group *group, u32 cs_id)
>  	if (unlikely(csg_id < 0))
>  		return 0;
> =20
> -	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >=3D vt_start) {
> +	if (IS_ERR(heaps)) {
> +		ret =3D -EINVAL;
> +		heaps =3D NULL;
> +	} else if (frag_end > vt_end || vt_end >=3D vt_start) {
                                        ^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does this condition incorrec=
tly
handle 32-bit unsigned wrap-arounds for the FW pass counters?

If a long-running graphical application issues enough render passes, the 32=
-bit
counters can wrap around. For example, if vt_start =3D 0x00000001 and
vt_end =3D 0xFFFFFFFF, the direct comparison vt_end >=3D vt_start evaluates=
 to
true even though vt_start is logically ahead.

This causes valid tiler OOM requests to fail with -EINVAL, marking the
affected queue as fatal.

Should sequence arithmetic like (s32)(vt_end - vt_start) >=3D 0 be used here
instead to safely compare wrapping sequence numbers?

>  		ret =3D -EINVAL;
>  	} else {
>  		/* We do the allocation without holding the scheduler lock to avoid

[Severity: High]
This is a pre-existing issue, but is there a data race when updating
group->fatal_queues later in this same function?

In group_process_tiler_oom(), which executes in the heap_alloc_wq workqueue,
the fatal_queues bitmask is updated without holding any locks:

drivers/gpu/drm/panthor/panthor_sched.c:group_process_tiler_oom() {
    ...
    if (ret && ret !=3D -ENOMEM) {
        drm_warn(&ptdev->base, "Failed to extend the tiler heap\n");
        group->fatal_queues |=3D BIT(cs_id);
    ...
}

Concurrently, cs_slot_process_fatal_event_locked() updates this same field
from process_fw_events_work in the sched->wq workqueue. Because |=3D is a
non-atomic read-modify-write operation, concurrent execution could result
in lost updates, potentially leaving a queue that experienced a fatal error
incorrectly marked as healthy.

Additionally, panthor_group defines spinlock_t fatal_lock to protect access
to fatal fields, but this lock appears to be completely unused.

Could fatal_lock be used here to prevent the race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-mi=
sc-fixes-v1-0-b67ed973fea6@collabora.com?part=3D4
