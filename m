Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AF606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On5nDb8Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F13A10E70E;
	Mon,  2 Nov 2026 22:10:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4776E10E70E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:10:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41E2E609ED;
 Mon,  2 Nov 2026 22:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAC31F00A1B;
 Mon,  2 Nov 2026 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793657432;
 bh=ICLWD+tPF+XyW1RvgYsFJKdkn5AG+iQHnkPqj/+uRtU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=On5nDb8Zza5YIoMzaugFianEM2nlDe33gBARxoPTwiqvvx5+E4f+c/6lvs511d4Yn
 jjZWU5tVBvOt0N0GvyYFTewhzfv0bJJFOVW3lTNLW4g5jjMlBfsly6ETi8aWrktVik
 wtiia64CvWsjP+AoZJefWkIBrJdTxMBvpreQ/AQneB8ICnN9hVTMkiowIVWnrnaNY2
 ZwZ/GVSTTJn20rHD7PaapSG02ADyb2cs351awk15DFb4c5ns7kZZCuSJotadOGQtLx
 j7kvTZT9o8BMC6K+jn8v78XpX63IiSTl1aqccnv0CVA0sngufbApimUmtzC23iS83f
 xFRsnFyPlXCnw==
Message-ID: <sashiko-outbox-194259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/15] drm/msm: Import adreno_snapshot.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102220405.30730-2-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
 <20261102220405.30730-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:10:31 +0000
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

commit a4a9326d5b47d5886718e595e77013dc5431312b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Import adreno_snapshot.h

This commit imports adreno_snapshot.h, based on kgsl_snapshot.h from the
downstream KMD, to be reused for gen8 devcoredump support.

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
As reported by Sashiko on v4 [1], running scripts/kernel-doc on
drivers/gpu/drm/msm/adreno/adreno_snapshot.h produces several kernel-doc
parser warnings.

In enum trace_buffer_source, GX_DBGC and CX_DBGC are missing the leading @
prefix (@GX_DBGC: and @CX_DBGC:), causing kernel-doc to warn that both enum
values are undescribed.

In struct adreno_snapshot_trace_buffer, the top-level comment header omits
the struct keyword ("adreno_snapshot_trace_buffer:" instead of "struct
adreno_snapshot_trace_buffer -"), which causes kernel-doc to treat it as a
function prototype and fail. Additionally, the inline comment for the
segment member is a copy-paste duplicate of @dbgc_ctrl rather than
@segment.

Finally, struct adreno_snapshot_eventlog and struct
adreno_snapshot_gmu_version use inline /** @member: ... */ kernel-doc
comments on their fields without a preceding /** struct ... */ kernel-doc
header on the enclosing structures.

Could these comments be updated to follow standard kernel-doc syntax (or
converted to regular /* ... */ comments if kernel-doc generation is not
intended)?

[1] https://lore.kernel.org/r/20261030211928.45761-2-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102220405.3073=
0-1-robin.clark@oss.qualcomm.com?part=3D1
