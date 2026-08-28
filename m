Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F4DC61DC4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2DC10E3D9;
	Fri, 28 Aug 2026 01:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gMuL82yI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0DF10E3D9;
 Fri, 28 Aug 2026 01:00:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FD06437C4;
 Fri, 28 Aug 2026 01:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E831F000E9;
 Fri, 28 Aug 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787878841;
 bh=Shj7ETqCrriSeJgA5ziki2FtNKeahlxTwaxGFvM7XJI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gMuL82yIY0xASjVvMYvjeaO8uOuc6Z8Ji+/LwxrLpt2b7nAocUHUmN00V2oOp1w8a
 51OoU1pSaCv4z2gCO51CSa5JXZZjU/p37MRhKZv3cOiln9hYd5swpUTkyKUMrzdEG7
 J5wPVSMIb+PWkb8x5Zfet6y/Xh317aa3PiezLRaHvOfGsQy1xPksCh/gFal4NEkXgD
 R0mYRFXREexc4M/m38JziqiCwGxw+mGbuKciz3ptBgwIG8Hh/Csic3WlCgxMXxH2Mf
 WjQrmLXfVZdFqB/pppwsxIXBVvECuHEva8JP9AdPMgKLKyyMne/+yyCMvugBeUDeHs
 pkCGDwPqj/I3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Fix null pointer access in is_include_guest_event()
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260828004208.3906054-1-vinay.belgaumkar@intel.com>
References: <20260828004208.3906054-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:00:40 +0000
Message-Id: <20260828010040.D2E831F000E9@smtp.kernel.org>
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
- [High] A NULL pointer dereference occurs in `__perf_event_read_cpu` when =
reading a revoked event via BPF, leading to a kernel panic.
--

commit c13911e3a6c666fcef554ee81ad9104c9e6e198c
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Fix null pointer access in is_include_guest_event()

This commit fixes a kernel panic during PMU event unbinding by adding a
null check for event->pmu in is_include_guest_event() and ensuring
mediated_pmu_unaccount_event() is called in __pmu_detach_event().

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..e6bc08c7ba3e7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13002,6 +13005,8 @@ static void __pmu_detach_event(struct pmu *pmu, s=
truct perf_event *event,
>  	exclusive_event_destroy(event);
>  	module_put(pmu->module);
> =20
> +	mediated_pmu_unaccount_event(event);
> +
>  	event->pmu =3D NULL; /* force fault instead of UAF */

[Severity: High]
This is a pre-existing issue, but does setting event->pmu to NULL here
expose a missing check in the BPF read path?

If a userspace process places a PMU event (which supports scopes) into a BPF
PERF_EVENT_ARRAY map, the event remains alive in memory due to the BPF map
holding a reference. When the PMU device is unbound, this function sets
event->pmu =3D NULL and marks the event as PERF_EVENT_STATE_REVOKED.

If a BPF program subsequently calls bpf_perf_event_read() on this event,
it invokes perf_event_read_local(). Since perf_event_read_local() does
not appear to check if the event has been revoked (unlike perf_read() or
perf_poll()), it unconditionally proceeds to __perf_event_read_cpu():

kernel/events/core.c:perf_event_read_local() {
	...
	event_cpu =3D __perf_event_read_cpu(event, event->cpu);
	...
}

Because event->group_caps retains the PERF_EV_CAP_READ_SCOPE flag,
__perf_event_read_cpu() attempts to evaluate event->pmu->scope:

kernel/events/core.c:__perf_event_read_cpu() {
	...
	const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(event->p=
mu->scope, event_cpu);
	...
}

Can this trigger a kernel panic due to a NULL pointer dereference when
event->pmu is unconditionally dereferenced?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828004208.3906=
054-1-vinay.belgaumkar@intel.com?part=3D1
