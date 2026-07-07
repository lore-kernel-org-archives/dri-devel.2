Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB56CC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115B610EB89;
	Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G1tFwiSL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF87810E472
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5609F618A8;
 Tue,  7 Jul 2026 07:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D11F00A3F;
 Tue,  7 Jul 2026 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409602;
 bh=B+/XC3pWnPrw6raRJdBi8Hg3nc0HCH4EyJEtBIzzqSk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G1tFwiSLEda+byN8nnSKVdu3qVjBOOZYzY2j16VjNJigoIn3WwphRuPeCyNBpvyvw
 99zgbLByOUlVwf0F1OOtjiW6gYWSx4dhImgxj9fFaneYt1YQ9kPB6H4IPpbhKslTUi
 oGZtz1Hf2P7k+5APd7MkLlOF4cREHrvpHC+K61mhvZMSu8uNk4+MLZPTN9mAjhzSVY
 bZd7Dec6fOUyXk1M0godpj8iRUNS77AajVsYR7Ytrt4sjMoVNRcXXb5XDrIG9SrdYF
 qSNScWun/V/ow2Qnvfj50W0uabFczVfumIusXx9ptKmCAN3YkJ3L2uY9N86XynN04s
 porkYJkw4jCGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/40] dept: apply sdt_might_sleep_{start, end}() to
 waitqueue wait
To: "Byungchul Park" <byungchul@sk.com>
Cc: dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev,
 cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, linux-kernel@vger.kernel.org, dlemoal@kernel.org,
 linux-modules@vger.kernel.org, linux-ide@vger.kernel.org, ojeda@kernel.org,
 "Jeff
 Layton" <jlayton@kernel.org>, tytso@mit.edu, "Anna Schumaker" <anna@kernel.org>
In-Reply-To: <20260706061928.66713-13-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-13-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:21 +0000
Message-Id: <20260707073321.731D11F00A3F@smtp.kernel.org>
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
- [High] The `sdt_might_sleep_end()` cleanup macro is bypassed when wait lo=
ops (`___wait_event`, `___swait_event`) are interrupted by a signal, perman=
ently leaking a DEPT dependency stage.
--

commit 1300cac9c94eeb3955744b6d40ed8dce8cfc059f
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
   =20
Make dept able to track dependencies by waitqueue waits.

> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index dce055e6add39..c8f8b44060fb9 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h

[ ... ]

> @@ -305,6 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  	struct wait_queue_entry __wq_entry;					\
>  	long __ret =3D ret;	/* explicit shadow */				\
>  										\
> +	sdt_might_sleep_start(NULL);						\
>  	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
>  	for (;;) {								\
>  		long __int =3D prepare_to_wait_event(&wq_head, &__wq_entry, state);\
> @@ -323,6 +325,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  			break;							\
>  	}									\
>  	finish_wait(&wq_head, &__wq_entry);					\
> +	sdt_might_sleep_end();							\
>  __out:	__ret;									\
>  })

[Severity: High]
Does this bypass sdt_might_sleep_end() when interrupted by a signal?

Looking at ___wait_event(), if ___wait_is_interruptible(state) and __int is
set, it will take the goto __out path:

		if (___wait_is_interruptible(state) && __int) {			\
			__ret =3D __int;						\
			goto __out;						\
		}								\

If that path is taken, sdt_might_sleep_end() is bypassed, which permanently
leaks a DEPT dependency stage. A stale wait context remains in the task's
dependency tracker state. When the task later sleeps for unrelated reasons,
the scheduler might attribute the sleep to the leaked context, leading to
false-positive lockup splats.

Also, does this same structural issue exist in ___swait_event() in
include/linux/swait.h for simple waitqueues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D12
