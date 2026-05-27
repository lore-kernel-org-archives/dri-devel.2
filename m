Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C59CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 16:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8316210E26B;
	Wed, 27 May 2026 16:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="TydIpMij";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A7A10E262;
 Wed, 27 May 2026 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hjubwyUGpvii4yHrQN7iWzf9058y+MhOuurWOoQQtoU=; b=TydIpMijDe4+FJpLkzynelnYRK
 VNJ9izAdgq8fYnktpyOTgB5E00ytSNQsFYRHl6ioo0y7Qq5hm6Bn5Hg+efQ1/kFjAbo0ZWgjaX84M
 rBbH7+2d61R/Y29S52qfADU1wPPtB49DsId57QDyAlYpWMFbnGD4eMKm5smUIKk8MtQuNLdA49L3D
 zqE3Iv60SGRCONJE31I1YpvUzgUZnJAHcDaUhrFmwwtvPsawIbBhbTrN4V5PCkPMATC9KK6vkIVTZ
 jpW06LeZImeIzGbDYH/hUJts4UPFAHj3qbFO8pqQJWz31/B9ktN7JQS8n5Ly0QMnTZFCH9sap5K8v
 odAAJHFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wSH94-0000000EUWv-2M56; Wed, 27 May 2026 16:30:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6249E300673; Wed, 27 May 2026 18:30:14 +0200 (CEST)
Date: Wed, 27 May 2026 18:30:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
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
Message-ID: <20260527163014.GI3102624@noisy.programming.kicks-ass.net>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
 <8871a158-7a68-4247-a09f-bb3d970d6dc2@nvidia.com>
 <87ecixv82m.wl-ashutosh.dixit@intel.com>
 <ahcQ9Ns5mjsnrbEa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcQ9Ns5mjsnrbEa@intel.com>
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

On Wed, May 27, 2026 at 11:42:44AM -0400, Rodrigo Vivi wrote:
> On Tue, May 26, 2026 at 08:34:57PM -0700, Dixit, Ashutosh wrote:
> > On Sat, 23 May 2026 10:52:16 -0700, John Hubbard wrote:
> > >
> > > On 5/23/26 1:40 AM, Peter Zijlstra wrote:
> > > > On Fri, May 22, 2026 at 06:33:24PM -0700, John Hubbard wrote:
> > > ...
> > > >>    perf/core: out-of-line and export perf_allow_cpu/tracepoint()
> > > >>    drm/xe: gate observation streams with perf_allow_cpu()
> > > >>
> > > >>   drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
> > > >>   drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
> > > >>   drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
> > > >>   drivers/gpu/drm/xe/xe_observation.h |  3 +--
> > > >>   include/linux/perf_event.h          | 31 ++++++++++++++--------------
> > > >>   kernel/events/core.c                | 18 ++++++++++++++++
> > > >>   6 files changed, 79 insertions(+), 35 deletions(-)
> > > >
> > > > Sure, works for me. How do you want to route these things, Xe tree or
> > > > -tip?
> > >
> > > Hi Peter,
> > >
> > > Maybe -tip, but really, either way is perfectly OK with me.
> > 
> > I've R-b'd both the patches. If you want to merge via Xe tree, let me know
> > and we can get them merged.
> 
> To get them through drm-xe trees we need ack from performance events subsystem
> maintainers.
> 
> Peter, Ilgo, anyone, ack here?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
