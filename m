Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBCAC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB7310E9EB;
	Tue, 25 Aug 2026 12:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bOJpczUR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB22F10E9EB
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:02:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B3D242339;
 Tue, 25 Aug 2026 12:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8D91F000E9;
 Tue, 25 Aug 2026 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787659373;
 bh=eXRAsEyO0FIDt5KvbTlVkgC1+/Me8/Ey163p/tCuIAQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=bOJpczUR6sSSpA6DdnBU8nVPInzGKm7wt3VExrO6v57+DcxuJWRu2a6eo9Gcmqn5i
 mniZRjBcfuAQa7vgzToLynBdLw2nCMyHZYW2FyBIrq5s+whczUdLNb/RySyxIDIYWH
 fu2Ix3tw2nP+mhVO9qyaxLDIMpE0dig7pp7RMq64Ysrm9NuLqWm4oxpa7wS5cba3J7
 UiqQlz9vKI+P+nVNtkqt2ItbBMcmmZBPrT7Uqq6r55wOHv3cFR7qyR/WerJ8sPRAQW
 smBjA+jEvrI4Sh5rYTiIhvs2NievCJ9UX74sNfRUEqiLPR3ga7tJHP3aq5S9HK3GGJ
 UqSq7n6BBWAZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:02:49 +0200
Message-Id: <DKY0CX15JCPZ.2P2HLLYE9O28I@kernel.org>
Subject: Re: [PATCH v2] drm/sched: Guard against NULL dev in drm_sched_job
 trace event
Cc: "Matthew Brost" <matthew.brost@intel.com>, "Philipp Stanner"
 <phasta@kernel.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Shixiong Ou" <oushixiong@kylinos.cn>
To: <oushixiong1025@163.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260825103615.661200-1-oushixiong1025@163.com>
In-Reply-To: <20260825103615.661200-1-oushixiong1025@163.com>
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

On Tue Aug 25, 2026 at 12:36 PM CEST, oushixiong1025 wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> The drm_sched_job trace event class calls dev_name() on
> sched_job->sched->dev without checking for NULL. Since the
> dev field in drm_sched_init_args is optional (used for
> debugging), a NULL dev causes a kernel oops when the trace
> event fires.
>
> The DRM scheduler KUnit tests do not set the dev field in
> drm_sched_init_args, leaving sched->dev as NULL. This causes
> a NULL pointer dereference when the drm_sched_job trace event
> fires during test execution, as dev_name(NULL) is called.
>
>   Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000050
>   Call trace:
>    trace_event_raw_event_drm_sched_job+0x90/0x258
>    __traceiter_drm_sched_job_queue+0x4c/0x78
>    drm_sched_entity_push_job+0x188/0x380
>    drm_sched_basic_entity_cleanup+0xfc/0x240
>    kunit_try_run_case+0x74/0x170
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v1->v2:
>   Change each line of the message to be within 75 characters
> =09
>  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gp=
u/drm/scheduler/gpu_scheduler_trace.h
> index 261713dd7d5a..319a3ec54bec 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -61,7 +61,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>  			     __string(name, sched_job->sched->name)
>  			     __field(u32, job_count)
>  			     __field(int, hw_job_count)
> -			     __string(dev, dev_name(sched_job->sched->dev))
> +			     __string(dev, sched_job->sched->dev ?
> +				      dev_name(sched_job->sched->dev) : "none")

I don't think that we should make such changes for Kunit tests only; it imp=
lies
that a NULL dev now would be a valid value for the scheduler.

Why can't we have the Kunit test create a fake device for this? For instanc=
e,
this is where struct faux_device becomes useful.
