Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4309BC44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0D910EB9A;
	Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YFY2+nEC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586D610EB98
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF9E4618BB;
 Tue,  7 Jul 2026 07:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D416C1F00A3D;
 Tue,  7 Jul 2026 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409621;
 bh=MD3sDUe6wOddXx22FYVGBhoZj9I+j/JyYjpvUNaHU0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YFY2+nECFmNvehvL3XZDuItawP8I4TGA6CBZ7TVwGuqFoNgo4Qjq2bs0KGdNZve12
 H24IZpLEZS1oraN+H9ccdplmbPr6Vbw8QqO1RTyoeNHx2/XAMSC8kJ9p6RI3fycXLb
 wxbb6lQjTFKIPPVaqonPcblRlSuFll3QVsKThaTiy2E9nXQzwZo27FVX2D1sTgAFeD
 cHDjCB81pwXldvkQINr3VBEKoxvhmD+ca91XeIHPddwC6oYOtVuXpX87hyuie8WWui
 1oQfL8O7KX8SIV0Ljc2oaXjm6rIQYYD+IOBjfAU6rywHjQfUrhDfMClH0NaZj1v/76
 tu19pnRAXdHsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 23/40] dept: print staged wait's stacktrace on report
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tytso@mit.edu,
 cassel@kernel.org, "Anna Schumaker" <anna@kernel.org>, dlemoal@kernel.org,
 "Chuck Lever" <cel@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, ojeda@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706061928.66713-24-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-24-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:40 +0000
Message-Id: <20260707073340.D416C1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Data race on `dt->stage_m` leading to zeroed class keys and kernel=
 warnings.
--

commit 02dbd1fb0ecda3493e1e312bcf532860fa1353de
Author: Byungchul Park <byungchul@sk.com>

dept: print staged wait's stacktrace on report

This commit modifies the dependency tracking (dept) system to capture and
print the stacktrace of the wait that an event wakes up. This provides more
context for interpreting dept's reports.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index e425d3ab05e5a..5bf32633e1fbd 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c

[ ... ]

> @@ -2561,6 +2580,14 @@ void dept_request_event_wait_commit(void)
> =20
>  	wg =3D next_wgen();
>  	WRITE_ONCE(dt->stage_m.wgen, wg);
> +
> +	/*
> +	 * __schedule() can be hit multiple times between
> +	 * dept_stage_wait() and dept_clean_stage().  In that case,
> +	 * keep the first stacktrace only.  That's enough.
> +	 */
> +	if (!dt->stage_wait_stack)
> +		dt->stage_wait_stack =3D get_current_stack();
>  	arch_spin_unlock(&dt->stage_lock);
> =20
>  	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);

[Severity: High]
This isn't a bug introduced by this patch, but does accessing dt->stage_m
here, immediately after dropping the stage_lock, introduce a data race with
a concurrent wakeup?

If a task begins scheduling out, it calls dept_request_event_wait_commit()
from __schedule(). It acquires dt->stage_lock, updates fields, and unlocks
it. Before it can call __dept_wait(&dt->stage_m, ...), an interrupt or
another CPU could concurrently call try_to_wake_up() on the same task.

The waking CPU would acquire dt->stage_lock in dept_ttwu_stage_wait() and
zero out dt->stage_m via __dept_clean_stage():

kernel/dependency/dept.c:__dept_clean_stage() {
    memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
    ...
}

If __dept_wait(&dt->stage_m) executes concurrently on the original CPU, it
reads the zeroed structure. This would cause it to look up a class with key
0 and trigger DEPT_WARN_ON(!valid_class(c)), breaking dependency tracking
and potentially panicking the system if panic_on_warn is enabled.

Could this be prevented by either copying the required parts of dt->stage_m
to local variables while the lock is still held, or expanding the lock
coverage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D23
