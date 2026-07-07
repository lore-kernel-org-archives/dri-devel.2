Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E28C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EACA10E45A;
	Tue,  7 Jul 2026 07:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gx68qnDT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F43F10E45A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF38D618A8;
 Tue,  7 Jul 2026 07:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C831F000E9;
 Tue,  7 Jul 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409598;
 bh=9mf44biJiePoNWQuGF44qWqC9KC06niE51csrHqMLss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gx68qnDThE1KqZUlF0/I/Z37aZFJQcIEXAI4J2h6MzFlHgVZwFU8yXTUtjbLaB4jN
 8Y7uM0LEHvI/LITeDkKcyr/KWmg+ognQSQjJ7FS5NfpApdsg+hqg8ZW1pqRGatmVY3
 Z9WPX0dAa66lMF074ov+2fX8rlFnS6RFuiPeYrSNCG2qPPvLRS1zuIFqfQjWw45mzi
 1/R7I3O9FWAoNGEjgq7DsUFWj2XA4upuz00nBdezB3r7lpFvhpAstzd+iJ1MrPrAIJ
 ffIzO1/JPSwIi3Hx8nnUjz8dM9IEyfs/AD+apHd385tZXvbefKOTDW++YW3xhjNJ7b
 jcuEmC0SIyQnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/40] dept: apply sdt_might_sleep_{start, end}() to
 hashed-waitqueue wait
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, tytso@mit.edu,
 "Anna Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org,
 dlemoal@kernel.org, dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev, ojeda@kernel.org,
 linux-modules@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-14-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-14-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:16 +0000
Message-Id: <20260707073317.37C831F000E9@smtp.kernel.org>
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
- [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_var_=
event` is interrupted, leaving the DEPT tracker in an inconsistent state.
- [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_even=
t` is interrupted, leaving the DEPT tracker in an inconsistent state.
--

commit 0bd2d42866fa6b852ee5317edcaf6890a90c3c65
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait

Make dept able to track dependencies by hashed-waitqueue waits.

> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 9e29d79fc790a..179a616ad245a 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
[ ... ]
> @@ -257,6 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  	struct wait_bit_queue_entry __wbq_entry;			\
>  	long __ret =3D ret; /* explicit shadow */				\
>  									\
> +	sdt_might_sleep_start(NULL);					\
>  	init_wait_var_entry(&__wbq_entry, var,				\
>  			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
>  	for (;;) {							\
> @@ -274,6 +276,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  		cmd;							\
>  	}								\
>  	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
> +	sdt_might_sleep_end();						\
>  __out:	__ret;								\
>  })

[Severity: Medium]
If this wait is interrupted by a signal, the loop executes a goto __out
which bypasses sdt_might_sleep_end(). Does this leave the dept tracker
in an inconsistent state where the task's stage remains permanently armed?

This could cause false positive dependency tracking splats on subsequent
waits, or fail to record new dependencies because the tracker is blinded by
the stale stage.

I noticed the exact same issue is present in ___wait_event():

include/linux/wait.h:___wait_event() {
    ...
		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}
    ...
	sdt_might_sleep_end();
__out:	__ret;
})

[Severity: Medium]
Does ___wait_event() also skip sdt_might_sleep_end() when interrupted?
By missing the paired cleanup call, the task's stage could remain
permanently armed here as well.

Would it make sense to move the __out label above sdt_might_sleep_end(),
or otherwise ensure the state is cleaned up on the interrupted paths for
both of these macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D13
