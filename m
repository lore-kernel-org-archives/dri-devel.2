Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E742606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWjTVxdB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1B910E2E1;
	Thu,  5 Nov 2026 14:12:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B4510E2E1;
 Thu,  5 Nov 2026 14:12:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CB7642E87;
 Thu,  5 Nov 2026 14:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474B1F00A15;
 Thu,  5 Nov 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793887961;
 bh=1L8SFwsbCq8ib1q3/FLH2P/dD3IRfBmCfNyQaGx79ds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JWjTVxdB3MuqR1DbV450wviKMuccNG+KozL4NydKaXiqMlNzH/wNhhC2r/w7YffzU
 nRxiNVzJWrPKmB0rQktStfFzHzUVc+zcOfsjblCX2fUID0BNEhhW3DpZh1BGsyMqt9
 YklLmmAA2cfo47Os12Fgk+xzpeMrHQN0oat8Ym6vleVFFIPdqvfac81dvAcSBQDCme
 4rMEvAvI1Kem4FUsCm7L9HQvwXnne+zEL1ephhyWscWFiR8pj5wijIp6dp1971/Y9v
 zuMPCi11FbmobPeVQ115/V3suBbaldNxM/qKzysmNja8ZJMsoFhtkFnCLguNCx09Fa
 MbHMJJjXdMYvQ==
Message-ID: <sashiko-outbox-199210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dsb: Fill all padding before GOSUB
To: "Hanson Wang" <hanson.wang@ugreen.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105134658.3724628-1-hanson.wang@ugreen.com>
References: <20261105134658.3724628-1-hanson.wang@ugreen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:12:40 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/i915/dsb: intel_dsb_gosub_align() duplicates intel_dsb_align_ta=
il()
--

commit 9778ee8e90748be72ffe6e979a8d71a200d84540
Author: Hanson Wang <hanson.wang@ugreen.com>

drm/i915/dsb: Fill all padding before GOSUB

This commit updates intel_dsb_gosub_align() to zero all bytes skipped when
aligning free_pos to a cacheline boundary before emitting a GOSUB
instruction, rather than only zeroing the gap when at most two QW slots
remain.

> diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i=
915/display/intel_dsb.c
> index 299d778520a22..83aeb3fc89425 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsb.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsb.c
> @@ -608,8 +608,13 @@ static void intel_dsb_gosub_align(struct intel_dsb *=
dsb)
>  	/*
>  	 * Wa_16024917128
>  	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-=
7)"
> +	 *
> +	 * free_pos always advances to the next cacheline, so the skipped
> +	 * bytes remain inside the programmed command range. Fill the whole
> +	 * gap with NOPs; clearing only slots 6 and 7 leaves a larger gap
> +	 * uninitialized.
>  	 */
> -	if (aligned_tail - tail <=3D 2 * 8)
> +	if (aligned_tail > tail)
>  		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
> =20
>  	dsb->free_pos =3D aligned_tail / 4;

[Severity: Low]
Wa_16024917128 states that GOSUB must not be placed in cacheline QW slot 6
or 7 (where 0 < aligned_tail - tail <=3D 2 * 8). When tail is in QW slots 0
through 5, GOSUB is allowed at that slot, and the trailing
intel_dsb_align_tail(dsb) call at the end of intel_dsb_gosub() already pads
the instructions following GOSUB within that cacheline with NOPs:

drivers/gpu/drm/i915/display/intel_dsb.c:intel_dsb_gosub() {
	...
	intel_dsb_gosub_align(dsb);
	...
	intel_dsb_emit(dsb, lower_32_bits(head_tail),
		       (DSB_OPCODE_GOSUB << DSB_OPCODE_SHIFT) |
		       upper_32_bits(head_tail));

	/*
	 * "NOTE: the instructions within the cacheline
	 *  FOLLOWING the GOSUB instruction must be NOPs."
	 */
	intel_dsb_align_tail(dsb);
}

In commit 2c41d62f6fb1, intel_dsb_gosub_align() checked
if (aligned_tail - tail <=3D 2 * 8) to detect QW slots 6 and 7, but left
dsb->free_pos =3D aligned_tail / 4 outside the conditional block, which cau=
sed
free_pos to advance to the next cacheline without zeroing the skipped bytes
when tail was in QW slots 1 through 5.

With this change to if (aligned_tail > tail), intel_dsb_gosub_align()
becomes an exact duplicate of intel_dsb_align_tail() defined immediately
above it:

static void intel_dsb_align_tail(struct intel_dsb *dsb)
{
	u32 aligned_tail, tail;

	intel_dsb_ins_align(dsb);

	tail =3D dsb->free_pos * 4;
	aligned_tail =3D ALIGN(tail, CACHELINE_BYTES);

	if (aligned_tail > tail)
		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);

	dsb->free_pos =3D aligned_tail / 4;
}

Should dsb->free_pos =3D aligned_tail / 4 instead be moved inside the
if (aligned_tail - tail <=3D 2 * 8) block so that free_pos only advances to
the next cacheline when GOSUB would land in QW slot 6 or 7, or if
unconditional cacheline alignment before GOSUB is intended, should
intel_dsb_gosub() call intel_dsb_align_tail() directly instead of
duplicating it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105134658.3724=
628-1-hanson.wang@ugreen.com?part=3D1
