Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47BEC44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58F510EB97;
	Tue,  7 Jul 2026 07:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i6SRejcT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53DA10EB89
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47BEC618A6;
 Tue,  7 Jul 2026 07:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE41F00A3D;
 Tue,  7 Jul 2026 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409610;
 bh=4HO9NTC2IIFbYOH0gv4YNtH+ly33tb1GqBVw0WwfVWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i6SRejcTyfs1vj6La4zFnYx5R9fC3HOSqKDwoSonnzoQBhJgMF4y4z61bXtwYY6m/
 fF8xcIQHCM4szZAEPG4NtK4d0ImheL8ek9uh6+t5Dn0REdumrqFx1SQQtqmP/5fvmK
 wsrDWVd45JwkNpUXMU2gbV+jHY2hQR5k0LFMn23M7qvJ3+zkMb+Q/WuYTZ/JrNp6Jq
 DgTHr/gH2g/Jc45XusSmKkqziIMCsmEy5HFbTSdqIC4jdTby29RMDwocQSUdbOHXHN
 KZVHh+FEkn+eIhnqghH8jzINQNZMQBop2Y9YymGsaz2oJZhKs6J94PiZWwYoGshjMT
 VdTh69UYojrBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 17/40] dept: apply timeout consideration to swait
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev, tytso@mit.edu,
 dlemoal@kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260706061928.66713-18-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-18-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:28 +0000
Message-Id: <20260707073328.A4CE41F00A3D@smtp.kernel.org>
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
- [High] When a wait event is interrupted by a signal, it bypasses sdt_migh=
t_sleep_end(), permanently leaking the DEPT wait stage.
--

commit 264d829a8f72641205caea8b130ee3c25557563a
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to swait
   =20
Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index 277ac74f61c39..233acdf55e9bc 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
> @@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, =
struct swait_queue *wait);
>  	struct swait_queue __wait;					\
>  	long __ret =3D ret;						\
>  									\
> -	sdt_might_sleep_start(NULL);					\
> +	sdt_might_sleep_start_timeout(NULL, __ret);			\

[Severity: High]
Is this a regression where a signal-interrupted wait event permanently leaks
the dept wait stage tracking state?

Looking at ___swait_event(), if the task receives a signal while waiting, it
evaluates ___wait_is_interruptible(state) && __int as true and takes the
goto __out path:

		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}

This jumps completely over the cleanup call:

	finish_swait(&wq, &__wait);
	sdt_might_sleep_end();
__out:	__ret;

Without calling sdt_might_sleep_end() and its underlying dept_clean_stage(),
the dept state isn't cleaned up for the current task. Subsequent waits by t=
his
task will fail to register new dependency maps and instead repeatedly commit
the stale wait map during __schedule(). This irreversibly corrupts the lock
dependency graph and triggers false deadlock reports.

The exact same bypass flaw appears to be present in ___wait_event() in
include/linux/wait.h and ___wait_var_event() in include/linux/wait_bit.h.

>  	INIT_LIST_HEAD(&__wait.task_list);				\
>  	for (;;) {							\
>  		long __int =3D prepare_to_swait_event(&wq, &__wait, state);\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D17
