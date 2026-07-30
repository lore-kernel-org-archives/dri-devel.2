Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1609FC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAB110EEEE;
	Thu, 30 Jul 2026 11:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JyRnzZGr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D168A10EEEE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:53:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1770600C8;
 Thu, 30 Jul 2026 11:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA241F000E9;
 Thu, 30 Jul 2026 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785412425;
 bh=c+G1pzihGG6lgf04bT/0Ay2Vq4dcuOzpw2/DQuzRfzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JyRnzZGrZcoi8r9x0iR2q/UJR+hScrxO7ka/fpuzcnwc5FKbfmM0lkSfs9BKWPfkJ
 YkrYhkKutyCHc3LAE5cdqb7IS6xwZL6GRJGI+61JBVJ/pPwAPlbA64P1PnWgg3DdLq
 m1i1P4YSp9i8u4VkTN9RgbsMISyHBCZhUzCszbLpzghMh4LVqWF0PYfv6qRO7OTiB4
 m6l0Z3Hru8QOnxPP1DH9rglKgAgtflYajUrCh+H2IcNJkg0QAL86XEDI0oKCsYknXr
 /LcbGqLZROMEE7VSiCmSy6CRWe6BBJj7sJh91x9NkzUzI1sxIeRzM2kmiuEUD5eG2s
 3LRWigA6Kxe8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] wait: Introduce non-irq variants of
 wait_event_lock_timeout
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 11:53:44 +0000
Message-Id: <20260730115345.6FA241F000E9@smtp.kernel.org>
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
- [Low] The kerneldoc comment for wait_event_lock_timeout incorrectly state=
s that the process can be awakened by a signal.
--

--- Patch [1]: [PATCH v2 1/3] wait: Introduce non-irq variants of wait_even=
t_lock_timeout ---
commit a625303b88e13551964ad465fcf368350aa20d46
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

wait: Introduce non-irq variants of wait_event_lock_timeout

This commit introduces non-irq variants of wait_event_lock_timeout and=20
wait_event_interruptible_lock_timeout. These macros are optimized for=20
spinlocks that are never acquired in an interrupt context, avoiding the=20
overhead of globally disabling IRQs.

> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index dce055e6add39..cd9b989c120e5 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
[ ... ]
> +/**
> + * wait_event_lock_timeout - sleep until a condition gets true or a time=
out
> + *		elapses. The condition is checked under the lock with IRQs
> + *		enabled. This is expected to be called with the lock taken.
> + * @wq_head: the waitqueue to wait on
> + * @condition: a C expression for the event to wait for
> + * @lock: a spinlock_t that has been locked with spin_lock(), which will=
 be
> + *	  released before schedule() and reacquired afterwards.
> + * @timeout: timeout, in jiffies
> + *
> + * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
> + * @condition evaluates to true or signal is received. The @condition is
> + * checked each time the waitqueue @wq_head is woken up.

[Severity: Low]
This isn't a bug, but is the mention of a signal being received accurate=20
here?

Since wait_event_lock_timeout places the task in TASK_UNINTERRUPTIBLE state=
,=20
it should not be awakened by signals. It looks like this sentence might hav=
e=20
been copied from the interruptible variant above it.

> + *
> + * wake_up() has to be called after changing any variable that could
> + * change the result of the wait condition.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-panthor-ca=
che-flush-fix-v2-0-28790478bfff@collabora.com?part=3D1
