Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E1C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4F310E117;
	Mon, 13 Jul 2026 17:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BlqnILAv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB14F10E117
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:55:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FCCD41477;
 Mon, 13 Jul 2026 17:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069571F000E9;
 Mon, 13 Jul 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783965305;
 bh=vgOCHDhRZ3PMoBsRbwv5p8183lMuW0AEq/rkGM1rzgM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BlqnILAvOBCQiwvTyVM7VWlWC7gEFz2QWoPU57PnUPNs/W1caiPPuhyhayC4dYJkq
 2JtrWM4KvRkhJDB05NhBm7ZxT5i2qqxtxGp0oD9TdM8NFWbih4Af8xtjjMg7rMJ3A7
 LHApQHLY7qR5oJGt+XEifJERRI5J1Ef8CqcPG/QfR8GF8o4ZDqAvMX6t2gk4W/gysq
 f53XzJM77PK8RMHfMqT+AjKBAuTeageeQfFcV3zU8Tq5dbGie4LkYJI3ZTeEm+jv1v
 Y1jowvs0+IeCMXCvcHWLwUEwD9P6oQqWCbIysXIuj6xAPjJQg8EB9jQa9Atl7ncDsk
 alZsZ3rtWONJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] accel/amdxdna: reject user command submission
 without a command BO
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713173030.87541-2-doruk@0sec.ai>
References: <20260713173030.87541-1-doruk@0sec.ai>
 <20260713173030.87541-2-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:55:04 +0000
Message-Id: <20260713175505.069571F000E9@smtp.kernel.org>
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
- [High] The current task's `mm_struct` is assigned to `job->mm` without ta=
king a reference count. If the submitting process exits before the DRM sche=
duler asynchronously executes the job, `job->mm` will point to a freed `mm_=
struct`, leading to a use-after-free when the scheduler thread accesses it =
via `mmget_not_zero()`.
--

--- Patch [1]: [PATCH 1/2] accel/amdxdna: reject user command submission wi=
thout a command BO ---
commit 66fd358bad7187572b37789ea6dae38b8738ff00
Author: Doruk Tan Ozturk <doruk@0sec.ai>

accel/amdxdna: reject user command submission without a command BO

This commit adds a check in amdxdna_cmd_submit() to ensure user command
submissions have a valid command BO handle. It rejects invalid handles
early to prevent a NULL pointer dereference in the drm_sched worker.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 8f8df9d04ec56..a5c8c2c4de6d9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>  			ret =3D -EINVAL;
>  			goto free_job;
>  		}
> +	} else if (!drv_cmd) {
> +		/*
> +		 * Only internal driver commands (drv_cmd !=3D NULL) may omit a
> +		 * command BO. A user command submission with the invalid handle
> +		 * would leave job->cmd_bo NULL and later fault when the scheduler
> +		 * dereferences it in amdxdna_cmd_set_state().
> +		 */
> +		XDNA_DBG(xdna, "Command BO handle required for user submission");
> +		ret =3D -EINVAL;
> +		goto free_job;
>  	}
> =20
>  	ret =3D amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, arg_bo_cnt);

[ ... ]

> 	job->hwctx =3D hwctx;
> 	job->mm =3D current->mm;

[Severity: High]
This is a pre-existing issue, but is it possible for job->mm to become a
dangling pointer if the submitting process exits before the DRM scheduler
asynchronously executes the job?

The current task's mm_struct is assigned to job->mm without taking a refere=
nce
via mmgrab(). If a process opens the DRM file descriptor, shares it with a =
child
process that submits a command and then immediately exits, the parent keepi=
ng
the file descriptor open prevents the file's release callback from flushing
pending jobs.

When the DRM scheduler asynchronously picks up the child's job in
aie2_sched_job_run(), it calls mmget_not_zero(job->mm) on the freed mm_stru=
ct:

drivers/accel/amdxdna/aie2_ctx.c:aie2_sched_job_run() {
    ...
    if (!mmget_not_zero(job->mm))
        return ERR_PTR(-ESRCH);
    ...
}

Would it be better to pin the mm_struct when assigning it to the job to pre=
vent
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713173030.8754=
1-1-doruk@0sec.ai?part=3D1
