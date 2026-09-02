Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601CEC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819CC10E4B5;
	Wed,  2 Sep 2026 14:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jxboh07r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14ED610E021;
 Wed,  2 Sep 2026 14:41:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1CD7402FB;
 Wed,  2 Sep 2026 14:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF131F000E9;
 Wed,  2 Sep 2026 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788360090;
 bh=HoNRIq8axkeZlkW9x5KJodxcA+EN2kvUq8aKX/Emc8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jxboh07rLuZTl8hMMDRVolFd51k06DSXbbWZJeMeyGTuDGgZhwjBdBGQCjSWF0AnT
 Fa7d8iLaQqndW5n1Qp76vCnAStRmT5wuBiPSWoH1c7mPiykfMADFD5M5j7yZuEyx8X
 LOz6YFC9MBtKV1PQ8ivJ3gNEBq6pzk3yfzruu2tZlhuq6t/6Uv1+hDz+7XRrx5OKD6
 aTGGyymjxvbA/2FU7FRwrmBbosTVHrXSH2DFqI+lDWgra20Nk0Q7fGtaGM1oc0/T0c
 deHWT2Dp5E6C5VjsGlEin0vW4Sl8nY/aie2K1hm8wLtp1r7v5N/guduyeyA4dCSVpj
 RM+FwgDkkX+3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf: Add checks to prevent null ptr access
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260902141824.733112-3-vinay.belgaumkar@intel.com>
References: <20260902141824.733112-1-vinay.belgaumkar@intel.com>
 <20260902141824.733112-3-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:41:30 +0000
Message-Id: <20260902144130.9FF131F000E9@smtp.kernel.org>
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
- [High] The lockless checks for revoked state and NULL PMU pointers are in=
sufficient to prevent a Use-After-Free of the PMU structure or a NULL point=
er dereference during concurrent unregistration.
--

commit 4a985bf8ccfd6853c89a279d4b7181e83c33bcef
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Add checks to prevent null ptr access

This commit adds a check for revoked states in perf_event_read_local() and
a null pointer check for the PMU in __perf_event_read_cpu().

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

[Severity: High]
This is a pre-existing issue, but does this lockless check provide a false
sense of security against concurrent PMU unregistration? A concurrent
perf_pmu_unregister() can set event->pmu =3D NULL and free the PMU memory. =
Since
this check relies on a cached pointer without holding locks that serialize
against unregistration (e.g., ctx->lock), the PMU can be freed immediately
after this check passes.

>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> -		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(even=
t->pmu->scope, event_cpu);
> +		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(pmu-=
>scope,
> +										event_cpu);

[Severity: High]
This is a pre-existing issue, but can this lead to a Use-After-Free when
accessing pmu->scope? If the PMU is unregistered and freed by another CPU
after we cache it but before we dereference it here, pmu->scope will read f=
rom
freed memory.

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

[Severity: High]
This is a pre-existing issue, but is this check vulnerable to a TOCTOU race?
The event state can change immediately after this check if the event contex=
t is
inactive or belongs to a different CPU, allowing a concurrent unregistratio=
n to
detach the event and free the PMU while perf_event_read_local() continues
executing. This leaves the subsequent call to event->pmu->read(event)
unprotected, potentially resulting in a NULL pointer dereference or
Use-After-Free.

>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902141824.7331=
12-1-vinay.belgaumkar@intel.com?part=3D2
