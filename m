Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FADEC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F6D10E33C;
	Mon, 31 Aug 2026 22:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WT1dWs+T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0453C10E33C;
 Mon, 31 Aug 2026 22:33:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACBE4401C8;
 Mon, 31 Aug 2026 22:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB01F000E9;
 Mon, 31 Aug 2026 22:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788215625;
 bh=qBErF2NExui7N+sx/GiNw5W3JeR4/AskVT18QoF/qfg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WT1dWs+TO0vk0nzANSEPourKU6hSBSUOBvIgra/xL2pw9njijvChoBGU+U/dXrck5
 hBE2qyOc0L0H6IZfy4y6A8dUhoPeCo6Kbn9EXv5+eXv8SXJu/qS+D+knUCJQTplQQn
 G7DK56IR2z3Lgk5PpkQZDunoq3+QOb0O1qdFGqBiWrbN3ggLo08hTq5NGxODOpqHqb
 gB2Kg2O/DjQR5Z/qS3tN2FDNBhAOrHTYchAFuLmc+J5COM9uzfIPZWhoFJt76L9dN6
 nTZ6yypGF3bIjpZcj+2IyD7/hCZFmFcytyMcIv5tKa3FrztIIqmbcMIch537z0qu96
 MgkFuTdarvB6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf: Fix null pointer access in
 is_include_guest_event()
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260831215214.4169965-1-vinay.belgaumkar@intel.com>
References: <20260831215214.4169965-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:33:44 +0000
Message-Id: <20260831223345.57FB01F000E9@smtp.kernel.org>
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
- [High] The newly added NULL check on `event->pmu` in `__perf_event_read_c=
pu()` is vulnerable to a compiler-driven TOCTOU race condition against conc=
urrent PMU unregistration, leading to a NULL pointer dereference.

Pre-existing issues:
- [High] The early state check in `perf_event_read_local()` is insufficient=
 to protect against a concurrent PMU detachment, leading to a NULL pointer =
dereference when accessing `event->pmu->read(event)`.
--

commit 0ef394b915f311447476beda7d3775da5d00cc70
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Fix null pointer access in is_include_guest_event()

This commit addresses a kernel panic observed during PMU event unbinding
by adding null pointer checks for event->pmu in multiple functions. It
also accounts for mediated events inside __pmu_detach_event() and adds
an early state check in perf_event_read_local().

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs=
")

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..63654e2121248 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4794,6 +4794,9 @@ static int __perf_event_read_cpu(struct perf_event =
*event, int event_cpu)
>  	if ((unsigned)event_cpu >=3D nr_cpu_ids)
>  		return event_cpu;
> =20
> +	if (!event->pmu)
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>  		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(even=
t->pmu->scope, event_cpu);

[Severity: High]
Does this code allow a time-of-check to time-of-use (TOCTOU) race condition?

If a concurrent __pmu_detach_event() on another CPU sets event->pmu =3D NUL=
L,
the compiler could emit separate loads for the check and the subsequent
event->pmu->scope access since the pointer is not cached with READ_ONCE() or
similar. Can this lead to a NULL pointer dereference?

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

[ ... ]

>  	/*
>  	 * If the event is currently on this CPU, its either a per-task event,
>  	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
>  	 * oncpu =3D=3D -1).
>  	 */
>  	if (event_oncpu =3D=3D smp_processor_id())
>  		event->pmu->read(event);

[Severity: High]
This is a pre-existing issue, but does this early state check sufficiently
protect against a concurrent PMU detachment?

While perf_event_read_local() runs with local IRQs disabled,
perf_pmu_unregister() on another CPU could send an IPI to detach the event
and then set event->pmu =3D NULL.=20

If this concurrent detachment occurs after the early state check, can the
subsequent event->pmu->read(event) call dereference a NULL pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831215214.4169=
965-1-vinay.belgaumkar@intel.com?part=3D1
