Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE32CD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 08:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F8F10E2EF;
	Sat, 23 May 2026 08:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="qaao5P/Q";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD4310E2E8;
 Sat, 23 May 2026 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6DnjAV+e0BPdgxX5HYfwVC6Dah6WI/Ye8CquYY2VvH8=; b=qaao5P/QcniVLHE3ME2LcbEukq
 SrIo6hj4dvHt0G2bxbOuTRNOiXMIOo9FzfmZzFBoSaHjVL1SFtjrUoEyAWeB2v0o9c1PmcEEW+y3l
 m8Mms7mYkFEJxD9v+J3pCZy69MI1+pRH0zosEhS6Q6Yx4Z6IA1I7tOrE6tqFSSrFie9vzJcA5EzN7
 /qYw4J3etq3OT8eB2VfQsMzzb/bGpUsztVlX0FY0MspB+JGKA0Ua/HxPCwcC7QwtPPyFH9M8Of0Bd
 fyOZv+EktMgKfETulP5ABe0AFwKZbLCcbAnv0Dpzw2xrrPshUHTa82a3AyFkTC8HHEcK8986InMM0
 DkiNRYhg==;
Received: from
 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wQhuj-00000006BAm-3WcE; Sat, 23 May 2026 08:40:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 30D8F300329; Sat, 23 May 2026 10:40:56 +0200 (CEST)
Date: Sat, 23 May 2026 10:40:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
Message-ID: <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523013326.129491-1-jhubbard@nvidia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, May 22, 2026 at 06:33:24PM -0700, John Hubbard wrote:
> perf_allow_cpu() and perf_allow_tracepoint() are static inline and
> reach into a non-exported sysctl, so modular drivers that want the
> same permission model as system-wide perf end up writing partial
> copies of this code. Let's instead export these properly so that modules
> can call them.
> 
> Commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
> for permissions") already moved perf_allow_kernel() out of line and
> exported it. Patch 1 does the same for the other two, and provides
> !CONFIG_PERF_EVENTS stubs so the helpers stay callable when perf is
> compiled out.
> 
> Patch 2 converts drm/xe's OA and EU stall paths to call
> perf_allow_cpu(), so xe observation now respects the system
> perf_event_paranoid policy and consults the LSM hook. Sites that have
> already configured an LSM perf policy or tuned the paranoid sysctl will
> now see those settings honored on xe as well.
> 
> Changes since v1:
> 
> * Patch 1: add !CONFIG_PERF_EVENTS stubs that fall back to
>   perfmon_capable() so the helpers remain callable when perf is
>   compiled out. The sashiko-bot AI review caught that the v1 code
>   would otherwise fail to build with PERF_EVENTS=n.
> 
> John Hubbard (2):
>   perf/core: out-of-line and export perf_allow_cpu/tracepoint()
>   drm/xe: gate observation streams with perf_allow_cpu()
> 
>  drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
>  drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
>  drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
>  drivers/gpu/drm/xe/xe_observation.h |  3 +--
>  include/linux/perf_event.h          | 31 ++++++++++++++--------------
>  kernel/events/core.c                | 18 ++++++++++++++++
>  6 files changed, 79 insertions(+), 35 deletions(-)

Sure, works for me. How do you want to route these things, Xe tree or
-tip?
