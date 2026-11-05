Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4D606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i37qkAjc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3B310E354;
	Thu,  5 Nov 2026 20:49:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B57B10E354
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:49:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16896411C9;
 Thu,  5 Nov 2026 20:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB4C1F0089F;
 Thu,  5 Nov 2026 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793911777;
 bh=7I7FKo60NhyA+Ovzy/GMN1d7WbcbI6ttCKJTtrefl+g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=i37qkAjcBzWXT9a7YWqXDVNGpLUDP+xAfmQhXe+IuhvdvTibR0lT8MSYNBE++QlaV
 XW3Qaol5/udR8W30Jt7dEsluvCbAc1w1+SNxZ/Hb0xfGwTZeydPrePH+UW/zYn8M+3
 9VQ/j8KsTVzbkNqa2ovxReH39Rv0sEyMH0GAJyHN7S/Q13HP3KjjrITItxb+XZyFMi
 95VjqBZJ06ksolJRA6U8KJf3rzQAc2kPKUwsUGs7mAzH4d/AlHijtOc3TlCmdj1TQj
 7j5VLUGYausnrhhRdmZb88zkLcI9OkntJh65f52iQvVbOV6M8m4kcj245kbZEfAdSu
 KWHeSIJkd7zVQ==
Message-ID: <sashiko-outbox-200151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/15] drm/msm: Import adreno_snapshot.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261105203057.66520-2-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:49:36 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/msm/adreno: malformed kernel-doc comments in adreno_snapshot.h
--

commit cce63614223b6a3b321ff4a500f669844fe5791c
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Import adreno_snapshot.h

This commit imports adreno_snapshot.h, containing snapshot data structures
and section definitions based on downstream kgsl_snapshot.h for reuse in
gen8 devcoredump support.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> new file mode 100644
> index 0000000000000..f9956e0bc1d5f
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
> @@ -0,0 +1,321 @@

[ ... ]

> +#define TRACE_BUF_NUM_SIG 4
> +
> +/**
> + * enum trace_buffer_source - Bits to identify the source block of trace=
 buffer information
> + * GX_DBGC : Signals captured from GX block
> + * CX_DBGC : Signals captured from CX block
> + */
> +enum trace_buffer_source {
> +	GX_DBGC =3D 1,
> +	CX_DBGC =3D 2,
> +};
> +
> +/**
> + * adreno_snapshot_trace_buffer: Header Information for the tracebuffer =
in snapshot.
> + */
> +struct adreno_snapshot_trace_buffer {
> +	/** @dbgc_ctrl: Identify source for trace */
> +	__u16 dbgc_ctrl;
> +	/** @dbgc_ctrl: Identify source for trace */
> +	__u16 segment;
> +	/** @granularity: The total number of segments in each packet */
> +	__u16 granularity;
> +	/** @ping_blk: Signal block */
> +	__u16 ping_blk[TRACE_BUF_NUM_SIG];
> +	/** @ping_idx: Signal Index */
> +	__u16 ping_idx[TRACE_BUF_NUM_SIG];
> +	/** @size: Number of bytes in the dump */
> +	__u32 size;
> +} __packed;
> +
> +#define SNAPSHOT_GPU_OBJECT_SHADER  1
> +#define SNAPSHOT_GPU_OBJECT_IB      2
> +#define SNAPSHOT_GPU_OBJECT_GENERIC 3
> +#define SNAPSHOT_GPU_OBJECT_DRAW    4
> +#define SNAPSHOT_GPU_OBJECT_GLOBAL  5
> +
> +struct adreno_snapshot_gpu_object_v2 {
> +	int type;      /* Type of GPU object */
> +	__u64 gpuaddr; /* GPU address of the object */
> +	__u64 ptbase;  /* Base for the pagetable the GPU address is valid in */
> +	__u64 size;    /* Size of the object (in dwords) */
> +} __packed;
> +
> +struct adreno_snapshot_eventlog {
> +	/** @type: Type of the event log buffer */
> +	__u16 type;
> +	/** @version: Version of the event log buffer */
> +	__u16 version;
> +	/** @size: Size of the eventlog buffer in bytes */
> +	u32 size;
> +} __packed;
> +
> +struct adreno_snapshot_gmu_version {
> +	/** @type: Type of the GMU version buffer */
> +	u32 type;
> +	/** @value: GMU FW version value */
> +	u32 value;
> +} __packed;

[Severity: Low]
As reported by Sashiko on v5 [1], running scripts/kernel-doc on
drivers/gpu/drm/msm/adreno/adreno_snapshot.h will trigger warnings due to a
few malformed kernel-doc comments here:

1. In enum trace_buffer_source, the GX_DBGC and CX_DBGC descriptions are
missing the leading @ prefix (@GX_DBGC: and @CX_DBGC:), causing kernel-doc
to warn that both enum values are not described.

2. Above struct adreno_snapshot_trace_buffer, the comment header omits the
struct keyword ("adreno_snapshot_trace_buffer:" instead of
"struct adreno_snapshot_trace_buffer -"), causing kernel-doc to parse it as
a function prototype and fail.

3. Inside struct adreno_snapshot_trace_buffer, the inline comment for the
segment member is duplicated as @dbgc_ctrl instead of @segment, overwriting
the dbgc_ctrl description and leaving segment undocumented.

4. Both struct adreno_snapshot_eventlog and struct adreno_snapshot_gmu_vers=
ion
use inline /** @member: ... */ kernel-doc comments without a top-level
/** struct ... */ kernel-doc comment on the enclosing structures.

Could these comments be updated to match the expected kernel-doc format (or
converted to regular comments if kernel-doc generation is not intended)?

[1] https://lore.kernel.org/r/20261102220405.30730-2-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105203057.6652=
0-1-robin.clark@oss.qualcomm.com?part=3D1
