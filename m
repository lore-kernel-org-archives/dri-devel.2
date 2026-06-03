Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217DCCD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC1F10FD7C;
	Wed,  3 Jun 2026 12:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xs/2vF3O";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F76210FD7B;
 Wed,  3 Jun 2026 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780490564; x=1812026564;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XTlsnxEr/OWPJYQJCSlfj0Pbc/0kEKa6q2+HltaVgI8=;
 b=Xs/2vF3OnE5EOnhdhRGJVW6oHmE57H1dIoIJCy+M+OyMQtsxmAa1QQU1
 6AACm+WUeSi1+6krdSuJFQBMCNq1FEV6IF/QSAJDdFtQ2ebNhoeyBxVBX
 imJYd7itAzWr1O/XMqmWG0HhyMDU/3r0x/qNvZfz9ykucosZtM9+Mf+c0
 /8HyLmwCeOn6Xp0AfbRRbz1EpLH0MTJ0nz1n0G4JTz9QM/JPsAlRsDDYg
 cByIoqd656rVsI5Ij3o2olAL71GAPYjHmFibR6A91SH7wn0goTfm+Shfw
 gb7kGO+TrZ/mMvHLeFVFixLTFNRryEfeJXrHJB9M2Q/ESYOYvcxlaOPyZ w==;
X-CSE-ConnectionGUID: eacFXWIzS8WQtIOtO5dl6w==
X-CSE-MsgGUID: bEZACAOjTN6j3XtVr6jClg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106749174"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="106749174"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:42:43 -0700
X-CSE-ConnectionGUID: wgbJQtD7Qvy/WhX4JrmTIg==
X-CSE-MsgGUID: lJT+HzrSQcqEpj6Ygaklbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="237880299"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.195])
 ([10.245.244.195])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 05:42:41 -0700
Message-ID: <5634e7fc-6931-465f-ba3d-4068b4fe53ba@intel.com>
Date: Wed, 3 Jun 2026 13:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/xe: skip banning kernel migration queue on
 TDR timeout
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 nirmoy.das@intel.com, umesh.nerlige.ramappa@intel.com,
 thomas.hellstrom@linux.intel.com, matthew.brost@intel.com,
 niranjana.vishwanathapura@intel.com, thomas.hellstrom@intel.com,
 fei.yang@intel.com, himal.prasad.ghimiray@intel.com,
 matthew.d.roper@intel.com, maarten.lankhorst@intel.com,
 joonas.lahtinen@intel.com
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03/06/2026 13:06, Sanjay Yadav wrote:
> guc_exec_queue_timedout_job() unconditionally bans the queue once a
> job times out. For the kernel migration queue this is fatal — once
> banned, no page table migrations can complete and the GPU is
> effectively dead until driver reload.
> 
> The submission is already stopped and the timed-out job is erred out,
> so banning is not needed for correctness. GT reset handles the actual
> hardware recovery. Skip banning for kernel queues so they remain
> available after reset.

Is wedging/reload not the more correct thing here? Kernel job is usually 
performing critical and potentially security sensitive work, like memory 
clearing, migrations, binding etc. If something goes wrong in one of 
those jobs, how should we go about recovering from that? Is driver 
reload/wedge not the more appropriate thing here, or least would need a 
more elaborate recovery?

For example, memclear get nuked, what stops the user from accessing 
uncleared memory later? Or a migration/copy/save/restore/ job gets 
nuked, from correctness pov how do we recover from that?

> 
> Fixes: bb63e7257e63 ("drm/xe: Avoid toggling schedule state to check LRC timestamp in TDR")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc_submit.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index ab501513d806..e6ad57cbbf0e 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1543,7 +1543,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
>   	if (!exec_queue_killed(q))
>   		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
>   
> -	set_exec_queue_banned(q);
> +	if (!(q->flags & EXEC_QUEUE_FLAG_KERNEL))
> +		set_exec_queue_banned(q);
>   
>   	/* Kick job / queue off hardware */
>   	if (!wedged && (exec_queue_enabled(primary) ||

