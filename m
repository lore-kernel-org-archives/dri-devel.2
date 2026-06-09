Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB5CD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525F910E0FD;
	Tue,  9 Jun 2026 06:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCXe/qMr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0243010E0FD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:53:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C20B643A19;
 Tue,  9 Jun 2026 06:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D981F00893;
 Tue,  9 Jun 2026 06:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988024;
 bh=LIvk1W5v0du+bXJZBDtPswBP8EEuCOAzbcG1YXnnIU4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PCXe/qMr7atADMpk28guRrp6QdrDdImfZ1XHrOm+pMQPxJQgkQ6HPjiGeFrn69kb4
 KwuH3k1HTVR95hQJ0WQvPFz6oj+fjsgP6Jr9MRoAq/Huo4V+CuBHDSay2uuejjtw9K
 v3nWI3q0CfoWCa6UymM6FPe+/DKBevcIPSuHYIYgVP4I1eH0Wp5KW05/rxow/ETyYe
 ydJ0Hnez+4VlCkVnGwzrxCBjtHo6kvW2z/rVjYiAyaXzIqPlR4FY5N+FL6VwsLhRc7
 6KFVbc3odpTBnOfByTqFnT6gGJqqZCxDGk5oZ4uXpf1p1UOu80fdq40TAMWvckEZuX
 wCEvb2+GDFY6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] drbd: Open-code transfer log list walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609061347.93688-2-kaitao.cheng@linux.dev>
References: <20260609061347.93688-2-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:53:43 +0000
Message-Id: <20260609065344.73D981F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Dropping `req_lock` during transfer log iteration allows the curre=
nt request to be moved to a different list, causing out-of-bounds reads and=
 an infinite loop.
--

commit eaa3f881c5752fd80fb9f58149972d66629f2d5b
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

drbd: Open-code transfer log list walk

This commit open-codes the transfer log list walk in drbd_debugfs.c to
preserve the existing traversal semantics where the cursor is revalidated
after temporarily dropping a lock, in preparation for an upcoming change
to list_for_each_entry().

> diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_=
debugfs.c
> index 12460b584bcb9..e90cead90e9db 100644
> --- a/drivers/block/drbd/drbd_debugfs.c
> +++ b/drivers/block/drbd/drbd_debugfs.c
> @@ -308,7 +308,9 @@ static void seq_print_resource_transfer_log_summary(s=
truct seq_file *m,
> =20
>  	seq_puts(m, "n\tdevice\tvnr\t" RQ_HDR);
>  	spin_lock_irq(&resource->req_lock);
> -	list_for_each_entry(req, &connection->transfer_log, tl_requests) {
> +	for (req =3D list_first_entry(&connection->transfer_log, typeof(*req), =
tl_requests);
> +	     !list_entry_is_head(req, &connection->transfer_log, tl_requests);
> +	     req =3D list_next_entry(req, tl_requests)) {

[Severity: High]
This is a pre-existing issue, but can this loop run infinitely or read
out-of-bounds memory when resource->req_lock is dropped inside the loop bod=
y?

Later in seq_print_resource_transfer_log_summary(), the lock is dropped
to yield:

			spin_unlock_irq(&resource->req_lock);
			cond_resched();
			spin_lock_irq(&resource->req_lock);
			req_next =3D list_next_entry(req, tl_requests);

While the lock is dropped, if another thread calls drbd_restart_request() in
drivers/block/drbd/drbd_main.c, the current req can be moved from
connection->transfer_log to the global retry.writes list via list_move_tail=
():

drivers/block/drbd/drbd_main.c:drbd_restart_request() {
    ...
	spin_lock_irqsave(&retry.lock, flags);
	list_move_tail(&req->tl_requests, &retry.writes);
	spin_unlock_irqrestore(&retry.lock, flags);
    ...
}

When the lock is reacquired, req remains valid because of the kref_get() ca=
ll,
but list_next_entry() will now follow retry.writes instead of transfer_log.

Because the loop terminates by checking against &connection->transfer_log,
traversing retry.writes bypasses the break condition.

Furthermore, if do_retry() concurrently splices retry.writes onto a local s=
tack
list, can this traversal continue into unmapped or overwritten stack memory?

>  		unsigned int tmp =3D 0;
>  		unsigned int s;
>  		++count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D1
