Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876BBC61DFD
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 00:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5556510E54A;
	Tue,  1 Sep 2026 00:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VykAniUj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0198B10E30D;
 Tue,  1 Sep 2026 00:09:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DF194038C;
 Tue,  1 Sep 2026 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3257D1F000E9;
 Tue,  1 Sep 2026 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788221361;
 bh=NNa0JFAuWE+wyInUbPyYpmgFazQu1V4uWKeBh6oETZA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VykAniUjrFL6AxCksngC9QsH98PB/xFJ2gYcFJrdTg+XfVzEq01VeVVZWpB2nG7zr
 tcqozHv0lJctXkkQZL/JPusKc3fgRCqhk2pA56ezTaZRBPspp9XsE2tFJ7D0CLg8Xg
 tTkevmNetdfjDA0GtO6L2dgHZLWDFoIrMSrZLibf0eWK98QcfMRiTmAN8AMC17KS83
 CSeV73Gj0wqrFRUdG6GXlxn8FI50E+zAYysqKjmocJ5FjwMUKa5dxmTJbt89hf6r4S
 O1lPWfLxTXjOehlzPCB5h+MWuxw6uRBs+w7xGC+5LC7Ilf/9Et1o4pQ+MclfZXa0Cn
 7EGbV/HGdASPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf: Fix null pointer access in
 is_include_guest_event()
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260831235030.6737-1-vinay.belgaumkar@intel.com>
References: <20260831235030.6737-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:09:20 +0000
Message-Id: <20260901000921.3257D1F000E9@smtp.kernel.org>
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

New issues:
- [High] A TOCTOU race condition in `__perf_event_read_cpu()` can cause a N=
ULL pointer dereference because the result of `READ_ONCE(event->pmu)` is no=
t cached locally.

Pre-existing issues:
- [High] Incomplete fix: TOCTOU races in `perf_event_read_local()` leading =
to NULL pointer dereference or Use-After-Free of `event->pmu`.
- [High] Blind mutation of `pmu->exclusive_cnt` on PMU unregister for non-e=
xclusive events.
--

commit 5b5202c48251a852d95e17a012ae0db3e210700b
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Fix null pointer access in is_include_guest_event()

This commit addresses a null pointer dereference in is_include_guest_event()
when perf_pmu_unregister() is called during an active session. It also adds
null and state checks in __perf_event_read_cpu() and perf_event_read_local()
to prevent similar crashes.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..f105cd7ac1524 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4794,6 +4794,9 @@ static int __perf_event_read_cpu(struct perf_event =
*event, int event_cpu)
>  	if ((unsigned)event_cpu >=3D nr_cpu_ids)
>  		return event_cpu;
> =20
> +	if (!READ_ONCE(event->pmu))
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>  		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(even=
t->pmu->scope, event_cpu);

[Severity: High]
Does this code leave a time-of-check to time-of-use race condition open?

Because the result of READ_ONCE(event->pmu) is not cached locally, a
concurrent detachment could set event->pmu to NULL immediately after the
check.

If that happens, the next line in __perf_event_read_cpu() would dereference=
 a
NULL pointer when accessing event->pmu->scope.

Could we store the PMU pointer in a local variable instead of re-reading
event->pmu?

[ ... ]

> @@ -4917,6 +4920,11 @@ int perf_event_read_local(struct perf_event *event=
, u64 *value,
>  		goto out;
>  	}
> =20
> +	if (READ_ONCE(event->state) <=3D PERF_EVENT_STATE_REVOKED) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally

[Severity: High]
This is a pre-existing issue, but does this state check fully prevent
concurrent PMU unregistration issues in perf_event_read_local()?

Even if the state check passes, a concurrent detachment could still set
event->pmu to NULL before the function completes.

Later in perf_event_read_local(), the code directly dereferences the PMU
pointer:

kernel/events/core.c:perf_event_read_local() {
	...
	if (event_oncpu =3D=3D smp_processor_id())
		event->pmu->read(event);
	...
}

Would it be possible for event->pmu to become NULL prior to this final
execution, causing a panic?

[ ... ]

> @@ -13002,6 +13013,7 @@ static void __pmu_detach_event(struct pmu *pmu, s=
truct perf_event *event,
>  	exclusive_event_destroy(event);
>  	module_put(pmu->module);
> =20
> +	mediated_pmu_unaccount_event(event);

[Severity: High]
This is a pre-existing issue, but does calling exclusive_event_destroy()
here cause problems for non-exclusive events?

In __pmu_detach_event(), exclusive_event_destroy() is invoked without
verifying if the event has the PERF_ATTACH_EXCLUSIVE flag set.

Looking at exclusive_event_destroy(), it directly modifies the PMU's atomic
exclusive counter:

kernel/events/core.c:exclusive_event_destroy() {
	...
	if (event->attach_state & PERF_ATTACH_TASK)
		atomic_dec(&pmu->exclusive_cnt);
	else
		atomic_inc(&pmu->exclusive_cnt);
	...
}

Could this blindly corrupt the PMU's reference limits during unregistration
for normal, non-exclusive events?

>  	event->pmu =3D NULL; /* force fault instead of UAF */
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831235030.6737=
-1-vinay.belgaumkar@intel.com?part=3D1
