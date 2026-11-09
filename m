Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBE606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L65GWZUU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769DA10E579;
	Mon,  9 Nov 2026 14:29:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBEC10E7D2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:29:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01C8763372;
 Mon,  9 Nov 2026 14:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872891F0089F;
 Mon,  9 Nov 2026 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234565;
 bh=8HhD4rcbCrWDuuz+K8nE9ZQ5ds3S9mMe82vW9vtx+L4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=L65GWZUUUhGcGyg+3SzoBzPvzEN/GKQdvr50wNH7X84wFc/oTX41/Mm+iDPJ3g54i
 08iIgU0lHLENBb6h//NTMS4/bcl9BlmoNnHxZKR5fjj4ZugG6AlQkZ01aHaMewiBz8
 KBsIJBZlq83Xy7G9uqUr9q95qLbkIsq7gTa2BtBd4nMpbC887Njc+/yKX+6pXLmiWo
 p9WCCzl8Rl4zX7knmQdEK9KSsT7xvK7U3wmP2nbktxWDSiO5MzbwJL1E8TzzScmMYM
 D2Plzfe7wusWD8GO04GZDWcWFHs+8+zeDGUYes/rZC9d3HptY7lOTtouzKQw5Iu4RH
 NXg1apMGeuHKw==
Message-ID: <sashiko-outbox-205103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/15] drm/msm: Import adreno_snapshot.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261109142111.256630-2-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
 <20261109142111.256630-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:29:25 +0000
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

commit 30e0a0488a18c22d584e9e55b2a78d947238fbf2
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Import adreno_snapshot.h

This commit imports adreno_snapshot.h, defining snapshot header and section
structures for gen8 devcoredump support.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/d=
rm/msm/adreno/adreno_snapshot.h
> new file mode 100644
> index 0000000000000..f9956e0bc1d5f
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
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
@ prefix (@GX_DBGC: and @CX_DBGC:), so scripts/kernel-doc treats both enum
values as undescribed.

In struct adreno_snapshot_trace_buffer, the top-level comment omits the
"struct" keyword ("struct adreno_snapshot_trace_buffer - ..."), which
causes scripts/kernel-doc to parse the declaration as a function prototype,
and the inline comment above segment repeats @dbgc_ctrl instead of
@segment.

Also, struct adreno_snapshot_eventlog and struct
adreno_snapshot_gmu_version use inline /** @member: ... */ comments without
a preceding /** struct ... */ kernel-doc header on the structures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109142111.2566=
30-1-robin.clark@oss.qualcomm.com?part=3D1
