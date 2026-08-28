Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C36C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2E210F494;
	Fri, 28 Aug 2026 21:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P3tmm2SW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2E810E656;
 Fri, 28 Aug 2026 21:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D1B760217;
 Fri, 28 Aug 2026 21:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15951F00A3F;
 Fri, 28 Aug 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787953946;
 bh=xTpwAFM1FIXKRTJKcKM7iTb47OdFg3JFWNtGIHnBj0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P3tmm2SWYDgPvtvhPRQJQ63cLOtpHXiMjtdVvjyrZoC0KJU4Q9o2LdxnE4VQVEElz
 VhtkxpMNCorCdtitiCJYWRgh67PpnSKJpoqrZZhf4jZTgYiAAPxmLl3lLcxuPe3V88
 wVVzRQsb5aSsYSe+tXD1xYRUTibEBzlbhKhdrqhA76jOQUHkT8cAiQbmwaIRXSrMFa
 oioMjku0GOxHlufwoc+aIuPTbO7ComAjfLKJYykuejWqfbsCeOzGDjR0tAaYUL9Nhr
 yVjsO3nt6ZWfghBWw4UnXKdnbDu0XzKPVjzTb5gknKnIhdMdZcBr5B6Juv9poc/ODg
 C4ET+hobWMxKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: Fix null pointer access in
 is_include_guest_event()
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260828212803.3963976-1-vinay.belgaumkar@intel.com>
References: <20260828212803.3963976-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:52:25 +0000
Message-Id: <20260828215225.F15951F00A3F@smtp.kernel.org>
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

New issues:
- [Medium] The patch silently alters the behavior of perf_event_read_local(=
) by explicitly returning -EINVAL for revoked or dead events.

Pre-existing issues:
- [High] TOCTOU race in `perf_event_read_local()` allows NULL pointer deref=
erence or Use-After-Free of `event->pmu` despite the newly added state chec=
k.
--

commit 3c330c9904a35189d22ecaa756a6d8b5458cfb9c
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Fix null pointer access in is_include_guest_event()

A kernel panic is observed when an application has a perf connection open
and the driver managing the pmu event unbinds. The issue occurs when
perf_pmu_unregister() is called while there is an active perf session. The
null pointer error is seen when the event is freed through __free_event()
and mediated_pmu_unaccount_event is called. There is a missing null check
inside is_include_guest_event(). Also call mediated_pmu_unaccount_event()
inside __pmu_detach_event() similar to __free_event().

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..9809fc10c4f51 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4917,6 +4917,11 @@ int perf_event_read_local(struct perf_event *event=
, u64 *value,
>  		goto out;
>  	}
> =20
> +	if (event->state <=3D PERF_EVENT_STATE_REVOKED) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +

[Severity: Medium]
Does this explicitly change the return value for revoked or dead events to
-EINVAL? The commit message describes fixing a null pointer access in
is_include_guest_event(), but does not mention altering the behavior of
perf_event_read_local() for revoked events. Could this be documented in the
commit message?

[Severity: High]
This is a pre-existing issue, but does this lockless state check leave a
time-of-check to time-of-use race window that can still lead to a null
pointer dereference of event->pmu?

If CPU A calls perf_event_read_local(), disables interrupts, and locklessly
checks event->state, it can pass if the event state is
PERF_EVENT_STATE_INACTIVE.

Concurrently, if CPU B calls perf_pmu_unregister() which leads to
__pmu_detach_event(), it will not send an IPI to synchronize with CPU A
since the event is inactive. CPU B then sets event->state to
PERF_EVENT_STATE_REVOKED and clears event->pmu to NULL.

When CPU A continues and calls __perf_event_read_cpu(event, event->cpu),
if the event has PERF_EV_CAP_READ_SCOPE, it will dereference
event->pmu->scope, which was just set to NULL by CPU B, causing a panic.

Can this sequence be synchronized safely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828212803.3963=
976-1-vinay.belgaumkar@intel.com?part=3D1
