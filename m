Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DBEC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B2A10EB93;
	Tue,  7 Jul 2026 07:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGLQ/QN8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC8610EB87
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 046E9618A8;
 Tue,  7 Jul 2026 07:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097CA1F000E9;
 Tue,  7 Jul 2026 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409617;
 bh=wRQA4HN5T0ZFW64B//7tkOJufQeVLQgQkGRx8y4cc3c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mGLQ/QN8JHoguRWt5gP2UHwGvqRVlH2lFUb6w3IVwGABTOTWAOBb05jOwYaC1B4fn
 bLAUJO1TiDnKsVLTLyu3XJ2UfaEg7aQerlcX3QSDIAClBJ1bi15LKtw+e9tZ0mJ33c
 OhdQAhgqXwAsemRotBSMFYvvDIDokUQU3binyvw1ZmaAV6RgPUMP/DzwSVGyzDC7gS
 MIwzMePanL/XrmF1UEUU622tCzdkvJ+wuFJTBxsVLG7aiPvL28h4Y91aMeZ3RMxCXP
 +oUSUYBQDGrQDXA7Cpga3RcAv0V32ARLy98qqifbLbh+pHZlOnYbySMikzmimnovMP
 F++/rDPOhMjHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 19/40] dept: apply timeout consideration to
 hashed-waitqueue wait
To: "Byungchul Park" <byungchul@sk.com>
Cc: ojeda@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 dlemoal@kernel.org, linux-rt-devel@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, tytso@mit.edu, cassel@kernel.org,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706061928.66713-20-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-20-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:36 +0000
Message-Id: <20260707073337.097CA1F000E9@smtp.kernel.org>
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
- [High] Missing `sdt_might_sleep_end()` cleanup in the error path of wait =
macros (e.g., `___wait_var_event`, `___wait_event`, `___swait_event`) bypas=
ses `dept_clean_stage()`, leaking the staged wait event state and corruptin=
g DEPT tracking.
--

commit cf04720896ab037609320947c88e8faa57dbddd7
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to hashed-waitqueue wait

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 179a616ad245a..9885ac4e1ded5 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
> @@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  	struct wait_bit_queue_entry __wbq_entry;			\
>  	long __ret =3D ret; /* explicit shadow */				\
>  									\
> -	sdt_might_sleep_start(NULL);					\
> +	sdt_might_sleep_start_timeout(NULL, __ret);			\

[Severity: High]
Does this error path properly clean up the dept wait state?

Lower in the ___wait_var_event() macro, if a signal is received it jumps to
__out:

		if (___wait_is_interruptible(state) && __int) {		\
			__ret =3D __int;					\
			goto __out;					\
		}							\
	=09
		...
	=09
	sdt_might_sleep_end();						\
__out:	__ret;								\

Because the goto __out branch skips sdt_might_sleep_end(), does it leave a=
=20
dangling stage context in the dept subsystem's tracking graph? =20

If the stage context remains populated, could a subsequent wait on the same
task be incorrectly seen as a nested stage, potentially corrupting dept
tracking or leading to false deadlock reports?

(Note: A similar goto __out pattern skipping sdt_might_sleep_end() also
exists in ___wait_event() in include/linux/wait.h and ___swait_event() in
include/linux/swait.h).

>  	init_wait_var_entry(&__wbq_entry, var,				\
>  			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
>  	for (;;) {							\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D19
