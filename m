Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABFBC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17B610E04A;
	Mon,  3 Aug 2026 14:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R7RrTkHh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB79010E604
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:33:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 474D760A81;
 Mon,  3 Aug 2026 14:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E31F00A3D;
 Mon,  3 Aug 2026 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785767600;
 bh=nV542CgoNEKtf4DVWxD4tCwX+nAaxcDjleNbtYi16E4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R7RrTkHhAwXwvBdX9w5kNsZ/QivJ2vYVuqlEL4LKfJEfU61590a69BvLqFk4jvUuA
 +zhdNREBlvCyFP7J3Nx75IirBLsOnWyo6xJyCTfnRxv3x2+83UMRASlid9ArGvkWGL
 682ScogHysicUUvMQYol190Fc1JMbuLXMVI9pX+xgs2A0zdlS4T3xK+3iV5mxnTHD1
 4lbnzQaKV/MlXx8otfqW7w7OngXCNWV/plxxOHm4esSQhwumfIJZiJ5E2Pl9E8j5U2
 4V7KATJuIuLG4nfjlSk8ERxTYC5QeyEtr40Jur+aYjpAZMA2cI7xjKH4424zaLAhOR
 oZ17WmD7J+hAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/panthor: use local variables for firmware
 interface counts
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803141149.68182-1-osama.abdelkader@gmail.com>
References: <20260803153555.70ca46de@fedora1.home>
 <20260803141149.68182-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:33:18 +0000
Message-Id: <20260803143319.CF1E31F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents TOCTOU vulnerabilities during firmware interfac=
e initialization by using READ_ONCE() for `group_num` and `stream_num`, but=
 fails to apply this protection to `panthor_sched_init()`, which re-reads t=
hese exact same fields directly from the volatile firmware-shared memory. T=
his can lead to an initialization mismatch and a subsequent NULL pointer de=
reference.
- [High] Userspace queue creation validates `group_args->queues.count` agai=
nst the hardcoded `MAX_CS_PER_CSG`, but fails to validate it against the fi=
rmware-reported and initialized `cs_slot_count`, allowing a NULL pointer de=
reference.
- [Medium] The patch adds `READ_ONCE()` for `group_num` and `stream_num` bu=
t leaves `group_stride` and `stream_stride` unprotected, allowing potential=
 out-of-bounds memory accesses if the compiler rematerializes the reads.
--

--- Patch [1]: [PATCH v3] drm/panthor: use local variables for firmware int=
erface counts ---
commit 49abfdca3f9a1c66d7525434ea16162686b42354
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panthor: use local variables for firmware interface counts

The firmware exposes the global group count and per-group stream count in
the shared control interface. These values are validated before being used
as loop bounds.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 10b7e12c1f1ed..fbc4d10aed1fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -955,6 +955,7 @@ static int panthor_init_csg_iface(struct panthor_devi=
ce *ptdev,
>  	u64 shared_section_sz =3D panthor_kernel_bo_size(ptdev->fw->shared_sect=
ion->mem);
>  	u64 iface_offset =3D CSF_GROUP_CONTROL_OFFSET +
>  			   ((u64)csg_idx * glb_iface->control->group_stride);

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are preventing
TOCTOU vulnerabilities with READ_ONCE(), should group_stride (and
stream_stride in panthor_init_cs_iface) also be protected?

If the compiler rematerializes the reads for the strides after the bounds
checks, could a malicious firmware modify the stride concurrently and cause
out-of-bounds pointer arithmetic when setting up the interface pointers?

> +	u32 stream_num;
>  	unsigned int i;
> =20
>  	if (iface_offset > shared_section_sz ||

[ ... ]

> @@ -1036,13 +1043,18 @@ static int panthor_fw_init_ifaces(struct panthor_=
device *ptdev)
>  		return -EINVAL;
>  	}
> =20
> -	if (glb_iface->control->group_num > MAX_CSGS ||
> -	    glb_iface->control->group_num < MIN_CSGS) {
> +	/*
> +	 * To protect against self-modifying control sections
> +	 * take a single snapshot from the control section so validation and
> +	 * iteration use the same value.
> +	 */
> +	group_num =3D READ_ONCE(glb_iface->control->group_num);
> +	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
>  		drm_err(&ptdev->base, "Invalid number of control groups");
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but does the scheduler also need to use these
protected values?

In drivers/gpu/drm/panthor/panthor_sched.c:panthor_sched_init(), the code
re-reads these fields directly from the volatile firmware memory:

	sched->csg_slot_count =3D num_groups;
	sched->cs_slot_count =3D csg_iface->control->stream_num;

If the firmware increases stream_num after the bounds checks here in
panthor_fw_init_ifaces(), could the scheduler configure cs_slot_count to a
larger value than the initialized structures in ptdev->fw->iface?

Later, when iterating up to these counts in tick_ctx_apply() or
csg_slot_prog_locked(), could the driver retrieve a zero-initialized
interface structure and dereference NULL pointers?


[Severity: High]
This is also a pre-existing issue, but is the userspace queue count properly
bounded by the initialized firmware slot count?

In drivers/gpu/drm/panthor/panthor_drv.c:panthor_ioctl_group_create(),
the queue count is validated against the hardcoded maximum:

	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
		return -EINVAL;

However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
panthor_fw_init_ifaces() will only initialize that smaller number of
stream interfaces.

If unprivileged userspace requests more queues than the firmware reported
(but less than MAX_CS_PER_CSG), could cs_slot_prog_locked() fetch an
uninitialized stream interface and crash when dereferencing
cs_iface->input->ringbuf_base?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803141149.6818=
2-1-osama.abdelkader@gmail.com?part=3D1
