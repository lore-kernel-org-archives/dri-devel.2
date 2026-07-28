Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03286C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA0510E4B9;
	Tue, 28 Jul 2026 05:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="guI/AOeX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EBC10E4B9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 05:58:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B1EF600FC;
 Tue, 28 Jul 2026 05:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72B91F000E9;
 Tue, 28 Jul 2026 05:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785218315;
 bh=Yyr8NPWYXTpErYHzdyl6TRtm7IifxYDY3Vmh1lwGIRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=guI/AOeXfivJAhNSZklD8glx377WkB4SdJEjr4qchGZCMiS1U68dcqQmS67Pfxprn
 LBf3U0rzhRbOB8DF/vXWlS29lqgAhy24MCZsi4iB3H4Gf5sUEdTb9DLkm09Ah9dSi5
 BiUbRlkwo0OGanHLEPhqIm0BzM70sa1KqSo36nwPi6/T01LvH14aUOpHS1kLu9aDRq
 42mS/JAjBfxLRPIOIVz1BJL+uA9WFupbMlZ32gVVp6lJImUfe4v+xx9yCvF+VHtKjg
 R7ClF9nxFv5b/NiWPgMxPT3RlT0dY/kDchpH83dZn9WqUHN/7N98nUTPnqriNgWsIZ
 lzhTUJib7pQNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: "Tejas Upadhyay" <tejas.upadhyay@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728054808.2664272-6-tejas.upadhyay@intel.com>
References: <20260728054808.2664272-4-tejas.upadhyay@intel.com>
 <20260728054808.2664272-6-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:58:34 +0000
Message-Id: <20260728055834.A72B91F000E9@smtp.kernel.org>
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
- [Medium] Mutex locked in test kthread but unlocked in executor thread via=
 KUnit cleanup action, causing lockdep violations.
- [Medium] Wrapping kunit_add_action() in KUNIT_ASSERT_EQ() causes resource=
 leaks and assertion failures if action registration fails.
--

--- Patch [2]: [PATCH 2/2] gpu/tests/gpu_buddy: Add KUnit test for gpu_budd=
y_allocated_addr_to_block ---
commit 3fa726703b9976a0e41d2e06fbab74aae75245bd
Author: Tejas Upadhyay <tejas.upadhyay@intel.com>

gpu/tests/gpu_buddy: Add KUnit test for gpu_buddy_allocated_addr_to_block

Add a new KUnit test gpu_test_buddy_addr_to_block() that validates the
gpu_buddy_allocated_addr_to_block() helper which traces a physical
address back to its allocated buddy block.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 89698563c61b2..1f4048d7c823e 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c

[ ... ]

> @@ -1422,6 +1422,103 @@ static void gpu_test_buddy_alloc_exceeds_max_orde=
r(struct kunit *test)
> +	/*
> +	 * Cleanup runs in LIFO order:
> +	 *   4. free_blocks  (lock held)
> +	 *   3. mutex_unlock
> +	 *   2. buddy_fini
> +	 *   1. mutex_destroy
> +	 */
> +	mutex_lock(&mgr->lock);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_mutex_unlock,=
 &mgr->lock), 0);

[Severity: Medium]
Does this code result in the mutex being unlocked by a different thread than
the one that locked it?

KUnit executes test cases in a dedicated kthread to catch crashes and
timeouts, but deferred cleanup actions registered via kunit_add_action()
run in the parent executor thread after the test kthread exits.

Because mgr->lock is acquired here in the test kthread, but the unlock is
delegated to kunit_action_mutex_unlock(), the test kthread exits with the
mutex held. The executor thread then attempts to unlock a mutex it does not
own, triggering lockdep warnings for task exited with locks held and bad
unlock balance.

> +
> +	/* 3. Allocate blocks and register block cleanup action inside the lock=
 context */
> +	KUNIT_ASSERT_EQ(test, gpu_buddy_alloc_blocks(&mgr->mm, 0, test_size, al=
loc_size,
> +						     chunk_size, &mgr->allocated_list, 0), 0);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action(test, kunit_action_free_blocks, =
mgr), 0);

[Severity: Medium]
Can this sequence cause a resource leak and subsequent kernel panic if the
action registration fails?

kunit_add_action() dynamically allocates an action context using
kzalloc_obj() and can fail with -ENOMEM. When wrapped in KUNIT_ASSERT_EQ(),
a failure aborts the test kthread without running the action that just
failed to register. Because the blocks were acquired before this
registration attempt, they are leaked.

When the previously registered kunit_action_buddy_fini runs during cleanup,
it calls gpu_buddy_assert(mm->avail =3D=3D mm->size), which will panic due =
to
the leaked blocks. Should this use kunit_add_action_or_reset() instead to
guarantee cleanup execution on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728054808.2664=
272-4-tejas.upadhyay@intel.com?part=3D2
