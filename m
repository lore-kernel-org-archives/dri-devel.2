Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4644ACDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C90F10F07A;
	Thu, 25 Jun 2026 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZFjU5vAQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A1410E164;
 Thu, 25 Jun 2026 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782385606; x=1813921606;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=3mMUyu41hsUV3+8vmn2FEljozTYUkLukSLGnNifcCP4=;
 b=ZFjU5vAQ8TToVEyFbJjdpAuqiQT/e/pM77n1BHV4WyLWer9SRFrymgPH
 ECfPiScvkrFfnxaDdlt1sM2pxqoKXrT9TT2AC4epJpZJs13+fEVbDxNDS
 ElPjcwsUZ9VlPu4SZlhkHVIeQnoPpZ0/wSWu7vcM4j8TaPtHPgPUQxI+p
 eg21m0LKkY0V3yWDRn6Ez46uvG+gEB3HZxE5aVdlt/+poL9WLOzbbAjlp
 PcheLFUNojQ6lrYul3a/HreB6ea6YWuLhLUAAYKZdEK0fSfpUzmhIroiq
 D336ES1RwMk0YYijfHnG/fldm0F2v77tiI9GVpxNZOxM9pW/mkD+Tz3Uc Q==;
X-CSE-ConnectionGUID: FNOKNt0OR6aKFPGEP2dCIw==
X-CSE-MsgGUID: bxWt7Lq5QxyOXfOtwI1b6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82144903"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82144903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 04:06:05 -0700
X-CSE-ConnectionGUID: Ff5wjq2eS3y4NEnYZUPVEg==
X-CSE-MsgGUID: /T55+aBtS92ybM5/4REhrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="249131302"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.126])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 04:05:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 0/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
In-Reply-To: <20260625104007.041432666@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625104007.041432666@kernel.org>
Date: Thu, 25 Jun 2026 14:05:56 +0300
Message-ID: <2037b6b62264c0192d45733ec1099c3ec14085a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 25 Jun 2026, Steven Rostedt <rostedt@kernel.org> wrote:
> Remove trace_printk.h by creating a trace_controls.h for those places that
> need access to tracing prototypes like tracing_off() and for the places that
> need trace_printk() directly, to have it included directly.
>
> Changse since v3: https://lore.kernel.org/all/20260624081806.120105649@kernel.org/
>
> - Always include trace_controls.h in rcu.h (kernel test robot)
>
>   There are other configs that may include tracing_off() in rcu.h besides
>   the one that had the include of trace_controls.h. Just always include
>   it in that header to be safe.
>
> Steven Rostedt (2):
>       tracing: Move non-trace_printk prototypes into trace_controls.h
>       tracing: Remove trace_printk.h from kernel.h
>
> ----
>  arch/powerpc/kvm/book3s_xics.c         |  1 +
>  arch/powerpc/xmon/xmon.c               |  1 +
>  arch/s390/kernel/ipl.c                 |  1 +
>  arch/s390/kernel/machine_kexec.c       |  1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
>  drivers/gpu/drm/i915/i915_gem.h        |  2 ++

For the i915 parts,

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree.

>  drivers/hwtracing/stm/dummy_stm.c      |  1 +
>  drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
>  drivers/tty/sysrq.c                    |  1 +
>  drivers/usb/early/xhci-dbc.c           |  1 +
>  fs/ext4/inline.c                       |  1 +
>  include/linux/ftrace.h                 |  2 ++
>  include/linux/kernel.h                 |  1 -
>  include/linux/sunrpc/debug.h           |  1 +
>  include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
>  include/linux/trace_printk.h           | 56 ++--------------------------------
>  kernel/debug/debug_core.c              |  1 +
>  kernel/panic.c                         |  1 +
>  kernel/rcu/rcu.h                       |  1 +
>  kernel/rcu/rcutorture.c                |  1 +
>  kernel/trace/ring_buffer_benchmark.c   |  1 +
>  kernel/trace/trace.h                   |  1 +
>  kernel/trace/trace_benchmark.c         |  1 +
>  lib/sys_info.c                         |  1 +
>  samples/fprobe/fprobe_example.c        |  1 +
>  samples/ftrace/ftrace-direct-too.c     |  1 -
>  samples/trace_printk/trace-printk.c    |  1 +
>  27 files changed, 82 insertions(+), 55 deletions(-)
>  create mode 100644 include/linux/trace_controls.h

-- 
Jani Nikula, Intel
