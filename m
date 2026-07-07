Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C934C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD40A10EBA1;
	Tue,  7 Jul 2026 07:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="becB94z1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F43710EB9E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 032B7618AE;
 Tue,  7 Jul 2026 07:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0965F1F00A3E;
 Tue,  7 Jul 2026 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409630;
 bh=c+VSnSjFRcFL2UYOIKKOUNT7KazPYUK7QU08PtQTxxM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=becB94z18LgfMpYXzuHELj6ZtB6sKdTUr8mZ2PW4SgPauseZ1dFRDkU8i8BDTKgYb
 exG3677WXn7VOpoQQQOwCcuCrOslNSSv7hED2xinrObDCIelvuv9M8vLq91ITxJkbe
 SmloJHXHbeO/eKpObxjD74SLSrS8p7Ky8VjyWt4AhWkNgPSnThA3xzGvD4h7UVg/GG
 HJIEZ08WmgNfS8+qwrAgDuchnG+Uo0kd/nnoQsI7SF+8l9QOchA9wFfA+6Il23iuH/
 3HfylDskRvSVrxct5vdwBSuJg+37FyFKAToss0JvwmZPcQNtNEkrsZYuvHCxABzr9Y
 3JqTC0VfXq52Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 32/40] completion, dept: introduce
 init_completion_dmap() API
To: "Byungchul Park" <byungchul@sk.com>
Cc: dlemoal@kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rt-devel@lists.linux.dev, cassel@kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, linux-ide@vger.kernel.org,
 "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260706061928.66713-33-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-33-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:49 +0000
Message-Id: <20260707073350.0965F1F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Double evaluation of arguments in wait_for_completion macros leads=
 to skipped array indices and memory corruption.
- [Medium] Unconditional struct growth of a widely used primitive for a deb=
ug feature.
- [Medium] Wait event macros skip calling sdt_might_sleep_end() on signal i=
nterruptions, leaking DEPT tracking state and stacks.
--

commit 5b626a37ee940081b6d37187cde51c2f272e370c
Author: Byungchul Park <byungchul@sk.com>

completion, dept: introduce init_completion_dmap() API

Currently, dept uses dept's map embedded in task_struct to track
dependencies related to wait_for_completion() and its family.  So it
doesn't need an explicit map basically.

However, for those who want to set the maps with customized class or
key, introduce a new API to use external maps.

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> index 4d8fb1d95c0a6..e50f7d9b4b974 100644
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -27,17 +27,15 @@
>  struct completion {
>  	unsigned int done;
>  	struct swait_queue_head wait;
> +	struct dept_map *dmap;
>  };

[Severity: Medium]
Since struct completion is heavily embedded in many kernel data structures,
does unconditionally adding the dmap pointer increase the global memory
footprint even on production non-debug kernels? Should this new field be
guarded by an #ifdef?

[ ... ]

> @@ -136,13 +140,13 @@ extern void complete_all(struct completion *);
> =20
>  #define wait_for_completion(x)						\
>  ({									\
> -	sdt_might_sleep_start_timeout(NULL, -1L);			\
> +	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
>  	__wait_for_completion(x);					\
>  	sdt_might_sleep_end();						\
>  })

[Severity: High]
Does evaluating the argument x multiple times in this macro lead to issues
if callers pass an expression with side effects?

For example, if a caller like mlx5_vdpa_exec_async_cmds() does:

	while (completed < issued)
		wait_for_completion(&cmds[completed++].cmd_done);

Would completed++ be executed twice per iteration, skipping array elements
and potentially causing out-of-bounds memory accesses?

[ ... ]

[Severity: Medium]
Do wait event macros such as ___wait_event() in include/linux/wait.h skip
calling sdt_might_sleep_end() when interrupted by a signal?

In include/linux/wait.h:___wait_event():

		if (___wait_is_interruptible(state) && __int) { \
			__ret =3D __int; \
			goto __out; \
		}
        ...
	sdt_might_sleep_end(); \
__out:	__ret; \
})

If the wait is interrupted by a signal, it escapes via goto __out. Because
__out is placed after sdt_might_sleep_end(), it seems the cleanup is
skipped.

Does this permanently leak the tracking state and its underlying stack
objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D32
