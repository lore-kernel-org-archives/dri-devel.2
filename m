Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE0606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS/YivB0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380A1113096;
	Fri,  6 Nov 2026 23:42:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDAA113087
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:42:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 668184139C;
 Fri,  6 Nov 2026 23:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FC41F0089F;
 Fri,  6 Nov 2026 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794008568;
 bh=H9Vj2xtsZWPdG3ppCHaD/a1CXzJwTi2k82Zzhh6xWa0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bS/YivB0FAGCtmDC1S03sZ4YHMgEG33M1ipmtWI9d8pPTN0bO3NNtCf7qjkvy0gS+
 xxW+qGOWriAGg96jGsQb1hahakeQC0AUG4R9LvGmxdzylzfYambXtB1zUhPYbCYo3B
 aXTYcimsHi9jSlP8HXjHtg9S1Jf7RC8FQCzKHx3aBhfOjf3/07TXOwuS1Jp0ZNow4n
 wxRgXxmSdLT0qcJhVG93gyFOcWHIPQ6+COnNOQn6pt7b8c+8U95CaGoyxL4LVA8RLX
 veGjhIvcuOpChA0sK0I3/9X1Dhv/EEhWfIm851Cm0XLgXp63qiTdRy5Yyr9wGvcVLM
 Q+P6OoJ0emrTQ==
Message-ID: <sashiko-outbox-202380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/15] drm/msm: Import adreno_snapshot.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261106232220.47602-2-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
 <20261106232220.47602-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 23:42:47 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/adreno: malformed kernel-doc comments in
  adreno_snapshot.h
--

commit d4dcc2967909e832420e6404773b1b84a722a8f5
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Import adreno_snapshot.h

This commit imports adreno_snapshot.h from downstream kgsl_snapshot.h to
define snapshot structures and constants for gen8 devcoredump.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> new file mode 100644
> index 0000000000000..f9956e0bc1d5f
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
> @@ -0,0 +1,321 @@

[ ... ]

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
Will scripts/kernel-doc warn on these comments?

In enum trace_buffer_source, GX_DBGC and CX_DBGC are missing the leading
@ prefix (@GX_DBGC: and @CX_DBGC:).  In struct
adreno_snapshot_trace_buffer, the header comment omits the "struct"
keyword (causing kernel-doc to parse it as a function prototype), and the
inline comment above segment is a duplicate "@dbgc_ctrl:" tag instead of
"@segment:".  Also, struct adreno_snapshot_eventlog and struct
adreno_snapshot_gmu_version use inline "/** @member: */" kernel-doc tags
without a top-level "/** struct ... */" comment block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106232220.4760=
2-1-robin.clark@oss.qualcomm.com?part=3D1
