Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B12606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Pg2H9YEW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7F510E0CA;
	Wed, 21 Oct 2026 14:53:07 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2F410E0CA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:53:01 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j8shp37xHzKm8D;
 Wed, 21 Oct 2026 16:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792594378; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BRUt1iojLuEcX+vMeK5+C49tlWQeMAcHtO6iWl2Ic0=;
 b=Pg2H9YEWrURWx9bBhwK6Of1BcZIBk0WlQra9uAWuN3F2DTAVt2nCNiBCZ0TwHXp6gI0UyY
 ir8kTFi2UhPaxD0YYf/aMgAtwnT4QjvwQYW9Y9Ya+asnQ4MwVgVmDt4cSu6j4A+vY4psJg
 iPlql2LwurhtuXH/d5j0EQF5EZPjXbZgRJnzNcEaEL8Vm7YmkSpukHzuMG3/JU74RfEwZm
 izojZsvOR0hmIxEeAq9Qh+3pAQ2UXBGVDkNWiKjSpPYzSuTa9ZMp+f2FbNKPlqKy4OkuIA
 doRFgSNhDxFAUxETKfxOQ2s5RPamsm/smboXPahqqHsrwDfszq5he9p8qZQ4DQ==
Message-ID: <0968fe5558e744f6f1ae2bddbbc075d016372e25.camel@mailbox.org>
Subject: Re: [PATCH 2/2] dma-buf/dma-fence: Order setting of the
 signaled-bit properly
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Yury
 Norov	 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Arnd Bergmann <arnd@arndb.de>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich	 <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, "Paul E .
 McKenney"	 <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Date: Wed, 21 Oct 2026 16:52:56 +0200
In-Reply-To: <ae7ae97d-cac9-451d-a0d4-bd52d0f063d4@amd.com>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-4-phasta@kernel.org>
 <ae7ae97d-cac9-451d-a0d4-bd52d0f063d4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3mbci7q54gc3gc16qrngwixwcrgrpqn5
X-MBO-RS-ID: e8dc92e6f44407bcc32
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-21 at 15:47 +0200, Christian K=C3=B6nig wrote:
> On 10/21/26 11:55, Philipp Stanner wrote:
> > dma_fence_is_signaled() can return true *while* the fence is still
> > signaling. This is fragile and has been involved in at least two bugs:
> >=20
> > 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> > 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")
> >=20
> > The signaled-bit is set under lock-protection but read without it.
> > Adding the lock has been rejected on the grounds of the lock-acquisitio=
n
> > shooting down cache lines of parties that merely want to check whether
> > the fence is already signaled.
> >=20
> > Make sure the bit can only become visible as 1 once the callbacks have
> > ran. To achieve this, read the bit with test_bit_acquire() and set it
> > with set_bit_release().
>=20
> That has been suggested and rejected before.
>=20
> Background is that the signaling bit must be visible before the
> callbacks are run or things like dma_fence_default_wait() (as an
> example) just break.

dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long time=
out)
{
	struct default_wait_cb cb;
	unsigned long flags;
	signed long ret =3D timeout ? timeout : 1;

	dma_fence_lock_irqsave(fence, flags);

	if (dma_fence_test_signaled_flag(fence))
		goto out;

	if (intr && signal_pending(current)) {
		ret =3D -ERESTARTSYS;
		goto out;
	}

	if (!timeout) {
		ret =3D 0;
		goto out;
	}

	cb.base.func =3D dma_fence_default_wait_cb;
	cb.task =3D current;
	list_add(&cb.base.node, &fence->cb_list);

	while (!dma_fence_test_signaled_flag(fence) && ret > 0) {
		if (intr)
			__set_current_state(TASK_INTERRUPTIBLE);
		else
			__set_current_state(TASK_UNINTERRUPTIBLE);
		dma_fence_unlock_irqrestore(fence, flags);


That function evaluates the flag under lock-protection, with full
ordering. The bit is only ever set under lock-protection, with full
ordering.

So currently, the bit is 1 before the callbacks ran. It becomes 1
before the callbacks ran, but dma_fence_default_wait() can only see
that after it took the lock, and it can only do that after the lock is
released after the callback ran.

So behavior for this function is unchanged, unless I miss sth.

Actually, this barrier makes things more robust, since things like

if (dma_fence_is_signaled(f))
  ts =3D dma_fence_timestamp(f)

could misorder the accesses to the signaled-bit.


Do you have another example of what would break?


You see, the bit sometimes being locked and sometimes being lockless
causes confusion.


P.
