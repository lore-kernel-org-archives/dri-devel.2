Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D8C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E95310EF33;
	Tue,  1 Sep 2026 21:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cl8gmmLD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCDB10EF33;
 Tue,  1 Sep 2026 21:41:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F02C43C2D;
 Tue,  1 Sep 2026 21:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54321F000E9;
 Tue,  1 Sep 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788298894;
 bh=B1VYPzl+v9GmhV02tCNKLQHt0valrmhy2RkxkZHhnkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cl8gmmLDjkxnEmLwynsfhRYSLfolRi3PovJ6CiIXsQntg4mG5cnZMb8EBFw7KkIv7
 KrSerYbA17XrZ6R+Ldmo3lAA2TjUlXwwQCW9MkS0EiRC/sFVvLGmw9WtKZ30hsVYZr
 hpr3kdB2Qfgby7JHBRzt98ideNY41qn+6ac27f1ftFv8nfR0NpsEQraJzyYKL7Mqlu
 CbzK+up0J2oinVvDpFW+tF1XaF8tUCwD3/xaTdLkUuf0Otab4hXgjwwU2K0qNeJmvt
 wcDcWIDSoXONAgrPN4+FhxJvFMJzm6IhAJfP68rI2DulQ+rrGR5LJlQ1wJ6n3SPJOq
 b2K8YB3PGKPcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf: Add checks to prevent null ptr access
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260901211915.127704-3-vinay.belgaumkar@intel.com>
References: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
 <20260901211915.127704-3-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 21:41:33 +0000
Message-Id: <20260901214133.B54321F000E9@smtp.kernel.org>
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
- [Critical] The added checks for `event->pmu` and `event->state` are insuf=
ficient to prevent Time-of-Check to Time-of-Use (TOCTOU) races during concu=
rrent PMU unregistration, leading to potential NULL pointer dereferences or=
 Use-After-Free.
--

commit af8b37d090911ccca2049c1eddb3328a00155104
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Add checks to prevent null ptr access

This commit adds checks in __perf_event_read_cpu() and perf_event_read_loca=
l()
to verify that the PMU pointer is valid and the event state is not revoked
before proceeding. This aims to prevent null pointer access when reading PMU
events.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7777e82aad5e7..059f82f0cadd4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
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
This is a pre-existing issue, but does caching the PMU pointer here leave us
vulnerable to a Use-After-Free?

If the PMU driver is concurrently unloaded (e.g., via module unload),
perf_pmu_unregister() executes synchronize_rcu() before detaching events. A
BPF program starting after the RCU sync might still find the event in its m=
ap
and race with __pmu_detach_event().

Even though we pass the new !pmu check, if the concurrent unregistration
completes and frees the driver's memory immediately after, accessing
pmu->scope could result in a Use-After-Free.

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
This is a pre-existing issue, but does this check completely prevent the NU=
LL
pointer dereference further down in the function?

Later in perf_event_read_local(), there is this call:

    if (event_oncpu =3D=3D smp_processor_id())
        event->pmu->read(event);

If a BPF program invokes perf_event_read_local() concurrently with PMU
unregistration, the READ_ONCE(event->state) check might pass. However,
__pmu_detach_event() forcefully sets event->pmu =3D NULL without waiting for
perf_event_read_local() to finish. This could cause the subsequent
event->pmu->read(event) to dereference a NULL pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901211915.1277=
04-1-vinay.belgaumkar@intel.com?part=3D2
