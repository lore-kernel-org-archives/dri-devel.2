Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878C3C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD8710EB98;
	Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GinPt3bi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18D510EB87
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AD2040D83;
 Tue,  7 Jul 2026 07:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB931F00A3D;
 Tue,  7 Jul 2026 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409616;
 bh=vyFEOBXlgjE04Kx9jnLW7Vk5RAaqy/+G5fDiKQUYAk0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GinPt3biey0RWOVw/w5D1DqUM4OrLxBddnq6W+p7JQDMfUFdp+Y/fagkQQZiDMAYD
 b/DGG1MC6YXTzaCEzQDUEJgrGkSxH/sQ7klqckaJ94wIyJN/PozT9/zcOZVxePydTr
 lrzjsQtTVQatp/jX9LVYdV0VICfw80qWcvwmJE+6c5OTPCnvM/vkDElieFFIqNcxKA
 7BXt5r8Jbq5NJBqIzp8wn2cN2CvgY3ii49kbhvjXzLLp5BePHGgpaB8jEtGjRvV85E
 x3JHTq8QPyDhr8I5L4gr9hY3d7Ft5J9cnhaed13AVuBN4SYZ3bRkav2BiqSEdc6pRo
 m55SfWcjMH1CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 18/40] dept: apply timeout consideration to
 waitqueue wait
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, tytso@mit.edu, ojeda@kernel.org,
 linux-kernel@vger.kernel.org, dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev, "Anna
 Schumaker" <anna@kernel.org>, linux-modules@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Chuck
 Lever" <cel@kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-19-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-19-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:34 +0000
Message-Id: <20260707073335.CAB931F00A3D@smtp.kernel.org>
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
- [Medium] The timeout consideration logic fails for wait_event_hrtimeout()=
, hashed-waitqueues, and DMA fences, causing them to be falsely treated as =
infinite waits.
- [Medium] The ___wait_event() and ___wait_var_event() macros skip the DEPT=
 sleep end annotation on the signal interruption error path, leaking the DE=
PT tracking stage context.
--

commit 25089e0217c82211740316928fec38c6d2b7e4fa
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to waitqueue wait

This commit applies timeout consideration to waitqueue waits by using the
ret parameter in ___wait_event() as a timeout value for DEPT tracking. It
leverages CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT to help reduce false positive
deadlock reports for waits that are meant to expire.

> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index c8f8b44060fb9..a9524bc8630b7 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -306,7 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  	struct wait_queue_entry __wq_entry;					\
>  	long __ret =3D ret;	/* explicit shadow */				\
>  										\
> -	sdt_might_sleep_start(NULL);						\
> +	sdt_might_sleep_start_timeout(NULL, __ret);				\

[Severity: Medium]
Does this logic also need to be applied to __wait_event_hrtimeout(),
hashed-waitqueues, and DMA fences?

For example, __wait_event_hrtimeout() passes 0 as the 'ret' parameter to
___wait_event(), causing sdt_might_sleep_start_timeout() to treat it as an
infinite wait.

Additionally, hashed-waitqueues (in ___wait_var_event) and DMA fences
(in dma_fence_default_wait and dma_fence_wait_any_timeout) still hardcode
sdt_might_sleep_start(NULL) even when taking a timeout. This seems to cause
DEPT to falsely report deadlocks for these bounded waits.

>  	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
>  	for (;;) {								\
>  		long __int =3D prepare_to_wait_event(&wq_head, &__wq_entry, state);\

[Severity: Medium]
Can the DEPT sleep end annotation be skipped on the signal interruption
error path?

Looking further down in the ___wait_event() macro, if the wait is
interruptible and interrupted by a signal, it takes the goto __out branch:

		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}
		...
	}
	finish_wait(&wq_head, &__wq_entry);
	sdt_might_sleep_end();
__out:	__ret;

This skips over sdt_might_sleep_end(), which leaks the DEPT wait stage
context. As a result, DEPT will mistakenly treat subsequent wait events for
this task as nested waits.

The same issue appears to exist in ___wait_var_event() for
hashed-waitqueues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D18
