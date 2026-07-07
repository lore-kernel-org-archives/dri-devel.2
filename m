Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CB8C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821B410EBA4;
	Tue,  7 Jul 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KBj+Nsf6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2662310EB9E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D89F618B6;
 Tue,  7 Jul 2026 07:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EC01F00A3A;
 Tue,  7 Jul 2026 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409628;
 bh=5Q67Ks3EtT/rviD16v/y5//PZ31a2ZTmmYZGkyVwukM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KBj+Nsf6/iUkquQMKGvR/GDwyZrSB36Nlqsb4zJRVKyaHRRlYKBedR+OzYrEU7ktI
 BXuSFymw1NnUB/bFxipAGuVZkOrHIKpVn7E1PL2pvxGMoxRJ/wkKHxXtw37R6tali+
 cD3UDhh1+uSAKKv9Wf3SXh6NeaLNql6c7JOkVKwVppqOMEUW4MrxhX/wuMBpDUryAo
 xLma9eT3JDAtZcBrqsIdMR3Mc4BUlS2HIxP3ZW0gcxNBQdbkRwTc4Sj6SdDK2z9WAJ
 GvAM0HPrUC92s8BTkKOmGaImcWQ6soMHNnYzKD0X5EsexG4chvKJDBQnHCN9ARHmn6
 ej7MznerlbndQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 30/40] dept: make dept stop from working on
 debug_locks_off()
To: "Byungchul Park" <byungchul@sk.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev,
 linux-ide@vger.kernel.org, cassel@kernel.org, ojeda@kernel.org, "Anna
 Schumaker" <anna@kernel.org>, dlemoal@kernel.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260706061928.66713-31-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-31-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:47 +0000
Message-Id: <20260707073347.A1EC01F00A3A@smtp.kernel.org>
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
- [Medium] DEPT fails to stop when lock debugging is globally disabled via =
kernel tainting.
- [Low] dept_stop_emerg() is unnecessarily exported via EXPORT_SYMBOL_GPL d=
espite having no module callers.
- [Low] Implicit reliance on transitive header inclusion for dept_stop_emer=
g().
--

commit 3772379470ad3a639343d641bfb17cbd105fc9a5
Author: Byungchul Park <byungchul@sk.com>

dept: make dept stop from working on debug_locks_off()

The commit adds a dept_stop_emerg() call inside debug_locks_off() to
stop the DEPT feature when panic or other lock debugging suspensions occur.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 048348ea64d29..007e1bc7d201e 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c

[ ... ]

> @@ -187,6 +187,12 @@ static void dept_unlock(void)
>  	arch_spin_unlock(&dept_spin);
>  }
> =20
> +void dept_stop_emerg(void)
> +{
> +	WRITE_ONCE(dept_stop, 1);
> +}
> +EXPORT_SYMBOL_GPL(dept_stop_emerg);

[Severity: Low]
Does this function need to be exported to loadable modules?

CONFIG_DEPT is a boolean configuration, so kernel/dependency/dept.c is
always built-in. Its only caller in lib/debug_locks.c is also always
built-in, making this export unnecessary.

> +
>  enum bfs_ret {
>  	BFS_CONTINUE,
>  	BFS_DONE,
> diff --git a/lib/debug_locks.c b/lib/debug_locks.c
> index a75ee30b77cb8..14a965914a8fb 100644
> --- a/lib/debug_locks.c
> +++ b/lib/debug_locks.c

[ ... ]

> @@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
>   */
>  int debug_locks_off(void)
>  {
> +	dept_stop_emerg();

[Severity: Low]
Is it possible to explicitly include <linux/dept.h> in lib/debug_locks.c?

Relying on implicit transitive header inclusion for dept_stop_emerg()
could break the build if inner header structures like spinlock.h or
lockdep.h change in the future.

> +
>  	if (debug_locks && __debug_locks_off()) {

[Severity: Medium]
Will this miss DEPT shutdown when the system is tainted?

For example, when a system fault occurs, add_taint() disables lockdep via
__debug_locks_off():

kernel/panic.c:add_taint() {
    ...
    if (lockdep_ok =3D=3D LOCKDEP_NOW_UNRELIABLE && __debug_locks_off())
        pr_warn("Disabling lock debugging due to kernel taint\n");
    ...
}

Because this bypasses debug_locks_off(), DEPT remains enabled when the
system lock state is already unreliable, potentially leading to false
positive dependency splats or further crashes.

>  		if (!debug_locks_silent) {
>  			console_verbose();
>  			return 1;
>  		}
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D30
