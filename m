Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDA7CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66A710E3CC;
	Tue,  9 Jun 2026 16:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WhaY19Q6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DF410E325
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 16:27:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4B0560200;
 Tue,  9 Jun 2026 16:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D661F00893;
 Tue,  9 Jun 2026 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781022463;
 bh=2lDZwSt+OEJK+phRGNRBZcePtwSFz0EmPJhg6Hw/rG0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WhaY19Q6lgte437S+WdsDiQ4PjXm1pi6kLwQX6bzF6ZChXv8nZ2d4wGWYnD0OIVmc
 5r06kSeK5bLNgk0IbTVnJHV7BFO04OT8kLC3cFXdDtNqk96xZxYRII2shclP5+sn0M
 Q2dXi6iW3Xekdit+EJ4sG99UFgFj36XWKG8ywD1/lrxlZyKHg492JJZtsgoDtpT3M+
 Uo8uLUoOD2dILkCf5jGl7w22iPAkKe6vgNE9wQVTrc+YxWtUhDGrMAlw7Egpqu5pUH
 wXmRsAJryGByRFeMASBi1wiLQIMGBIvN6JPiqgaQveC7fYRCR276OchUoE/tM6lqpo
 7tUDTPAegLR1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: keep process name fallback for diagnostics
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609162057.5-1-ruoyuw560@gmail.com>
References: <20260609162057.5-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:27:42 +0000
Message-Id: <20260609162743.48D661F00893@smtp.kernel.org>
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
- [High] Lockless access to `task->comm` via `kstrdup()` creates a TOCTOU r=
ace leading to a non-null-terminated string and an out-of-bounds read.
--

commit f329e0d91af948bfcb07b90ac00f44ede0a2f8fc
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/xe: keep process name fallback for diagnostics

This commit addresses an issue where diagnostic paths would use a NULL
pointer for a process name if allocation failed during file open. It keeps
the "no process" fallback unless the process name was successfully
allocated.

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_g=
uc_submit.c
> index 4b247a3019d2d..697faf0f1048b 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1590,7 +1590,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *d=
rm_job)
>  	}
> =20
>  	if (q->vm && q->vm->xef) {
> -		process_name =3D q->vm->xef->process_name;
> +		if (q->vm->xef->process_name)
> +			process_name =3D q->vm->xef->process_name;
>  		pid =3D q->vm->xef->pid;
>  	}

[Severity: High]
This is a pre-existing issue, but does using this string in formatting
functions risk an out-of-bounds memory read?

Looking at xe_file_open() in drivers/gpu/drm/xe/xe_device.c, task->comm is
directly passed to kstrdup() without holding task_lock(task):

    xef->process_name =3D kstrdup(task->comm, GFP_KERNEL);

Since task->comm can be modified concurrently by userspace via
prctl(PR_SET_NAME), kstrdup() can compute a short length during its internal
strlen() call, but copy characters from a longer replacement string during
memcpy(). This results in a heap buffer missing a null terminator.

When process_name is subsequently passed to xe_gt_notice() further down in
this function and printed via the %s format specifier:

    xe_gt_notice(guc_to_gt(guc),
                 "Timedout job: seqno=3D%u, lrc_seqno=3D%u, guc_id=3D%d, fl=
ags=3D0x%lx in %s [%d]",
                 xe_sched_job_seqno(job), xe_sched_job_lrc_seqno(job),
                 q->guc->id, q->flags, process_name, pid);

Can this trigger an out-of-bounds read of adjacent slab memory, potentially
leading to KASAN panics or kernel memory disclosure?

Could the string copying in xe_file_open() be safely changed to use
get_task_comm() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609162057.5-1-=
ruoyuw560@gmail.com?part=3D1
