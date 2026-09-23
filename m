Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65782C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6A010E955;
	Wed, 23 Sep 2026 16:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rb/hFdrN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831C210ED47
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:25:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E59D41A44;
 Wed, 23 Sep 2026 16:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B1A1F000FF;
 Wed, 23 Sep 2026 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790180755;
 bh=7arUtVTu4iOL1Gr5cBQVpV77hSqLpz+/kioWJUkPY3E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rb/hFdrNgDRwj5RUg0xkNyRFQA/wUdcaPN1z2RcdE/lPL+vMMlxB4j5R0UkH9btJF
 nte2CGu0NoqnV+0ObaWZHwcmk+C+T0r0ba3N5QQN1s7qYUL+QozG13mg1u60M8++ZO
 DiCYrvr8L9MD8RKOyXe4Eh6XDQMXrLLpoT0qe/5DM59YUNhZ7cE4XXe/ZGwo+S7URP
 dQ002ZdQCKn/O5UJfYInAtDZQUE5FVj8CskXlv5LG6a0dzUMh8/SZMCprEZ4B31gEp
 zvlZ2ZU4vJ3FjvaDnVVkDHGf86mT0cY+rDyJVFH0Fl/ae4SctRqayttTYaiMrr0K8n
 eH5ihMG9zIY2w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v5 2/3] workqueue: Add support for real-time workers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
 <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:25:54 +0000
Message-Id: <20260923162555.03B1A1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] workqueue: Rescuer threads for WQ_RTPRI run at SCHED_NORMAL priori=
ty
- [Medium] workqueue: sysfs allows root to override strict CPU affinity for=
 WQ_RTPRI
--

commit d6923aa9186af2fdae6943a41b86cf0fc9512111
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

workqueue: Add support for real-time workers
   =20
For use cases such as the DRM scheduler submitting work to the GPU on
behalf of low latency userspace applications, where latter have sufficient
privileges to have had successfully obtained realtime Vulkan global
priority, competing with random background CPU load can create large
latency spikes which gets in the way of a smooth user experience.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index a9e96329547c9..4be11eb7f04f1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

[ ... ]

> @@ -6115,6 +6129,12 @@ static struct workqueue_struct *__alloc_workqueue(=
const char *fmt,
>  			return NULL;
>  	}
> =20
> +	if (flags & WQ_RTPRI) {
> +		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=3D
> +			         WQ_UNBOUND))
> +			return NULL;
> +	}
> +

[Severity: High]
This validation doesn't prevent combining WQ_RTPRI with WQ_MEM_RECLAIM.

If a workqueue is created with both flags, does this break the RT priority
guarantee when memory pressure triggers a rescue?

Looking at rescuer_thread() in kernel/workqueue.c, it unconditionally forces
the thread's scheduling class to SCHED_NORMAL by calling:

	set_user_nice(current, RESCUER_NICE_LEVEL);

Could this cause real-time work items to execute at standard CFS priority
instead of SCHED_FIFO during a rescue?

[ ... ]

> @@ -7810,6 +7833,10 @@ static umode_t wq_sysfs_unbound_group_visible(stru=
ct kobject *kobj,
>  	if (!(wq->flags & WQ_UNBOUND))
>  		return SYSFS_GROUP_INVISIBLE;
> =20
> +	/* Do not allow priority changes for RT workers. */
> +	if ((wq->flags & WQ_RTPRI) && !strcmp(attr->name, "nice"))
> +		return 0444;
> +
>  	return attr->mode;
>  }

[Severity: Medium]
While this protects the "nice" attribute from modification for RT workqueue=
s,
does it omit protection for "affinity_strict" and "affn_scope", leaving them
writable?

If a privileged user writes to affinity_strict, affinity_strict_store() in
kernel/workqueue.c executes:

	attrs->affn_strict =3D (bool)v;
	ret =3D apply_workqueue_attrs_locked(wq, attrs);

Could this silently strip the strict CPU affinity mandated for WQ_RTPRI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923161251.4542=
8-1-tvrtko.ursulin@igalia.com?part=3D2
