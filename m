Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C353C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A352510EBA2;
	Tue,  7 Jul 2026 07:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ForedeT4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F02510EB9E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8A36618AB;
 Tue,  7 Jul 2026 07:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD41F000E9;
 Tue,  7 Jul 2026 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409629;
 bh=airgbxL1sKuMal1d1K2gcZrKH108O2x+A+oa7Ozs7L4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ForedeT47kO0wBQhKgthZ7tn0tN4JC6GHOJxBuqdQLVSc/dBuDuWlv+7x6Zhp/i7O
 9aFNz0503vIJ2EsZHgcsF1sxh43X6agklD4xrRMVQ3V9khWQWTGm/WZkcZxY0UetCA
 x5EukxIJLT1L1k3a2yXMvwwEtI1OVVyzRv78BIdBIUSMv033kFMkZzszGUr3yny2zy
 HiS7k/8b5iCaQ7ivf7fGHCnXQ7nHZyvT0tAWwbISbbeZn7K2XopEkiU8vdZrUGLdSH
 e+JyqiMxQumtd0kDIv3g6l2oHzVSyNkVxdgd95YL3tvTTZpLhU0s30ARC7Z7pd+INm
 hjDtyerYy/uPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 31/40] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-rt-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, ojeda@kernel.org, "Chuck Lever" <cel@kernel.org>,
 cassel@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 tytso@mit.edu
In-Reply-To: <20260706061928.66713-32-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-32-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:48 +0000
Message-Id: <20260707073348.D3FD41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `wait_for_completion_*_timeout` macros evaluate their timeout =
argument `t` multiple times, creating a side-effect vulnerability.
- [High] The `wait_for_completion_*` wrapper macros declare local variables=
 (`__ret` and `__m`) that shadow variables in the caller's scope, leading t=
o uninitialized memory usage.
- [High] The `wait_for_completion` macros now implicitly depend on GPL-only=
 exported symbols, breaking non-GPL module compilation when CONFIG_DEPT is =
enabled.
- [Medium] The C helper function `rust_helper_wait_for_completion` defeats =
the primary goal of the patch for the Rust subsystem by mapping all Rust ca=
llers to a single `dept_key`.
--

commit 18fd6796eb79fb0d0201e71c6791aa80955604b2
Author: Byungchul Park <byungchul@sk.com>

dept: assign unique dept_key to each distinct wait_for_completion() caller

This patch assigns a unique dept_key to each distinct wait_for_completion()
caller to avoid false positive reports from DEPT. It also adds a C helper
for the Rust subsystem to avoid build errors.

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
[ ... ]
> +#define wait_for_completion(x)						\
> +({									\
> +	sdt_might_sleep_start_timeout(NULL, -1L);			\
> +	__wait_for_completion(x);					\
> +	sdt_might_sleep_end();						\
> +})

[Severity: High]
Will these macros implicitly depend on GPL-only exported symbols, breaking
non-GPL module compilation when CONFIG_DEPT is enabled?

The original wait_for_completion() functions are exported via EXPORT_SYMBOL,
making them available to non-GPL modules.

The new macros wrap these primitives with calls to dept_stage_wait() and
dept_clean_stage() via sdt_might_sleep_start_timeout().

Since those tracker functions are exported via EXPORT_SYMBOL_GPL, could this
cause linkage failures for non-GPL modules using the macro?

[ ... ]
> +#define wait_for_completion_timeout(x, t)				\
> +({									\
> +	unsigned long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __wait_for_completion_timeout(x, t);			\
> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})

[Severity: High]
Does this macro evaluate the timeout argument t twice?

If a caller passes an expression with side effects (like a stateful
function call or a pre/post-increment) as the timeout argument, the
expression will be executed multiple times.

Would this lead to incorrect timeouts or potential kernel crashes if the
expression modifies sensitive state?

[Severity: High]
Could the internal __ret variable shadow a variable in the caller's scope?

If a caller passes an expression for the timeout t or the completion x
that relies on a variable named __ret in their own scope, the macro's
inner uninitialized __ret might shadow the caller's variable.

Would this result in the underlying wait functions receiving uninitialized
stack memory instead of the intended parameter?

[ ... ]
> diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> --- a/rust/helpers/completion.c
> +++ b/rust/helpers/completion.c
[ ... ]
> +void rust_helper_wait_for_completion(struct completion *x)
> +{
> +	wait_for_completion(x);
> +}

[Severity: Medium]
Does this C helper function defeat the primary goal of the patch for the
Rust subsystem?

The patch explicitly changes wait_for_completion() to a macro so that a
unique static dept_key is instantiated at each distinct call site, avoiding
false positive dependency reports.

However, by wrapping the macro into a single out-of-line C function,
wouldn't all Rust callers of completions share the exact same dept_key,
reintroducing the false positive reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D31
