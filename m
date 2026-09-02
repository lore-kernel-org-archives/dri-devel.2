Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58E7C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7B810E00B;
	Wed,  2 Sep 2026 16:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U13dr6ib";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD0A10E00B;
 Wed,  2 Sep 2026 16:12:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7E2D600D0;
 Wed,  2 Sep 2026 16:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E151F00A3D;
 Wed,  2 Sep 2026 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788365551;
 bh=RtSuxHb75r6u85srw+7fGh+ZVX0eYNhJKesXp7/lcQ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U13dr6ibgnlRFkWnVayGJJOhFWeHBIISRT7py2qoGYySJcWmdJzR5XkAapJxPdAG5
 KeSXiXU6B8ifQxp3bZonlNk9Z5U26hTnCKxpbzlGTL5RytoH0ilIldWfVWdgDN/pAz
 XqaFg/CMRJhDC8myJtmnQA4QmEHvZLvF5CMORt5rNGn2dkpiUs9VztdEmiKCkYlGuy
 WklACaOOTmFufcWHw42Ob3W8yp5b+YeGY/948adBakBHVHe8x3IWPWifLHHf9dRIN8
 JJ3RNQ2rVHGGmydQsSC6eLj0hCh8zHeOV6gr4vhG87n9RrLqLMwWb9G3Kd8m+j4u9O
 tlB+3IfWTB2Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf: Add checks to prevent null ptr access
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902154852.742844-3-vinay.belgaumkar@intel.com>
References: <20260902154852.742844-1-vinay.belgaumkar@intel.com>
 <20260902154852.742844-3-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:12:31 +0000
Message-Id: <20260902161231.79E151F00A3D@smtp.kernel.org>
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
- [Critical] The added NULL and state checks do not fully resolve the Time-=
of-Check to Time-of-Use (TOCTOU) race condition against PMU unregistration,=
 leaving NULL pointer dereference and Use-After-Free (UAF) vulnerabilities.
--

commit 63da6f63d2cf2058c6cbd31229c510f17f749641
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Add checks to prevent null ptr access

This patch attempts to prevent null pointer accesses by adding revoked
state checks in perf_event_read_local() and null checks in
__perf_event_read_cpu().

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cp=
u_topology_cpumask(unsigned int
> =20
>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
> +	struct pmu *pmu =3D READ_ONCE(event->pmu);
>  	int local_cpu =3D smp_processor_id();
>  	u16 local_pkg, event_pkg;
> =20
>  	if ((unsigned)event_cpu >=3D nr_cpu_ids)
>  		return event_cpu;
> =20
> +	if (!pmu)
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> -		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(even=
t->pmu->scope, event_cpu);
> +		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(pmu-=
>scope,
> +										event_cpu);

[Severity: Critical]
This is a pre-existing issue, but does reading pmu->scope here leave us
vulnerable to a use-after-free if the PMU object is concurrently freed?

Since we only read the pointer with READ_ONCE() and do not appear to be
holding RCU or a lock protecting the PMU's lifetime against unregistration,
could the PMU be detached and freed right before we access it?

[ ... ]

> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event=
, u64 *value,
>  		goto out;
>  	}
> =20
> +	if (READ_ONCE(event->state) <=3D PERF_EVENT_STATE_REVOKED) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but does this state check fully
resolve the time-of-check to time-of-use race condition against PMU
unregistration?

If a userspace program triggers a BPF map update on a perf event array, it
calls perf_event_read_local() without holding rcu_read_lock(). If a concurr=
ent
hardware hot-unplug calls perf_pmu_unregister(), it might issue an IPI to a
remote CPU to detach the event while this local CPU passes the revoked state
check.

If that race occurs, the PMU can be freed immediately after this check, but
further down in perf_event_read_local() we still directly dereference
event->pmu:

    if (event_oncpu =3D=3D smp_processor_id())
        event->pmu->read(event);

Could this lead to a NULL pointer dereference or use-after-free since the
local IRQ disable doesn't serialize against the remote IPI during PMU
unregistration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154852.7428=
44-1-vinay.belgaumkar@intel.com?part=3D2
