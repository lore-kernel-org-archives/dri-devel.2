Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C8C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28A110E5D2;
	Tue, 25 Aug 2026 07:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WRDKP7Ep";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C8010E5D2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:14:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hTfD26D2lz8sp8;
 Tue, 25 Aug 2026 09:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787642066; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIJZZD/XaPkQPLVFhESspAkltHs+LixM6ANfzdKnl8Q=;
 b=WRDKP7EpQORH1V1XZv2cV2vKkh6v2tJ1HENpxAJ3tkKlHIGCT3E8oOztlKSuB90W7756MT
 0QQGfGSctWCIf1RIsr/WP7H6D09ro/LO/uNuoFkEZm5CQwWjWN4hrFs1FepUEPlAK9QZMV
 LfIdLKn6voz17KTQMK0BIRs9YDQiPnTsRBCeCN5VXWQwjvgfM3NnRGUbPP5/TGLER+1eFU
 mYjqpQ9yq/uVr68mSWJJCHKycVsP0RYH/M7sCX9obtwaqHs0ihJZYuabApFW2FNLZ9iVfY
 QzanWa3WOkSXo+lYlwAjpF+BMQVEvAL84KVUiRdHLkqkQpSziItdGt3VVGdgAg==
Message-ID: <13be98c209664e14d6dda700775c4d6c6366bb92.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Guard against NULL dev in drm_sched_job
 trace event
From: Philipp Stanner <phasta@mailbox.org>
To: oushixiong1025@163.com, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Shixiong Ou	
 <oushixiong@kylinos.cn>
Date: Tue, 25 Aug 2026 09:14:20 +0200
In-Reply-To: <20260821084748.543645-1-oushixiong1025@163.com>
References: <20260821084748.543645-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: f8a830b610e67b2e361
X-MBO-RS-META: agp4y6hfurxmuymkj81c9z9cpmkszcez
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 2026-08-21 at 16:47 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The drm_sched_job trace event class calls dev_name() on
> sched_job->sched->dev without checking for NULL. Since the
> dev field in drm_sched_init_args is optional (used for
> debugging), a NULL dev causes a kernel oops when the trace
> event fires.
>=20
> The DRM scheduler KUnit tests do not set the dev field in
> drm_sched_init_args, leaving sched->dev as NULL. This causes
> a NULL pointer dereference when the drm_sched_job trace event
> fires during test execution, as dev_name(NULL) is called.
>=20
> =C2=A0 Unable to handle kernel NULL pointer dereference at virtual addres=
s 0000000000000050
> =C2=A0 Call trace:
> =C2=A0=C2=A0 trace_event_raw_event_drm_sched_job+0x90/0x258
> =C2=A0=C2=A0 __traceiter_drm_sched_job_queue+0x4c/0x78
> =C2=A0=C2=A0 drm_sched_entity_push_job+0x188/0x380
> =C2=A0=C2=A0 drm_sched_basic_entity_cleanup+0xfc/0x240
> =C2=A0=C2=A0 kunit_try_run_case+0x74/0x170

Yes, that looks correct, thx for fixing.

Can you send a v2 with your commit message's line length set to 72
characters? Only the title line should be aimed to be 50 chars wide.


Regards,
P.

>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gp=
u/drm/scheduler/gpu_scheduler_trace.h
> index 261713dd7d5a..319a3ec54bec 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -61,7 +61,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __string(name, sched_job->sched->name)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __field(u32, job_count)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __field(int, hw_job_count)
> -			=C2=A0=C2=A0=C2=A0=C2=A0 __string(dev, dev_name(sched_job->sched->dev=
))
> +			=C2=A0=C2=A0=C2=A0=C2=A0 __string(dev, sched_job->sched->dev ?
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(sched_job->sched->dev) : "no=
ne")
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __field(u64, fence_context)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __field(u64, fence_seqno)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __field(u64, client_id)
