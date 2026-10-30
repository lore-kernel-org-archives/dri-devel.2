Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938C606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmPlrS8Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFAC10E1CB;
	Fri, 30 Oct 2026 21:27:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB7610E1CB
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D36041485;
 Fri, 30 Oct 2026 21:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572511F000C1;
 Fri, 30 Oct 2026 21:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793395632;
 bh=xpwmODK+Og6GIHJdiKUlsEqevm8Xpf6WKWl6JRZbXJc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=LmPlrS8QXueWVjSpsok7gu9dWXx52woYpdCAdKicDof17bo7J+JTa8ha0OXw6xHkk
 oz2xPSpCmfgvM7HGSkWEVFXW4oD7AtEYUkN99RyQgfrfyD3wLW9b9XMhLbYcoPtuDm
 VVkIMpveJo4aNFGeu8wUJJZtF6gOuBidoAaHiZIUi7s5sgbMai6bYCcg7xWHBNDLE0
 jzwSIOndD0Z3p4FBGJWCwO/yw2nnh+cOIdCLuWTAS+vklsubuWZaVm6zQboCcjEm1+
 z07eG4ab596HLpI4jRAKgg47DJoGXCuR9H8Ig3rInryp1ygyN/cAmZJ5KxGe60rrxY
 oh2K3EhSPxO9A==
Message-ID: <sashiko-outbox-191526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] drm/msm: Import adreno_snapshot.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030211928.45761-2-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:27:11 +0000
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

commit 4b4f4543f019fd5896ff1aace169bcf52f15975d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Import adreno_snapshot.h

This commit imports adreno_snapshot.h based on downstream kgsl_snapshot.h f=
or
use with gen8 devcoredump support.

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

[Severity: Low]
This isn't a bug, but there are a few kernel-doc formatting issues here when
running scripts/kernel-doc on drivers/gpu/drm/msm/adreno/adreno_snapshot.h:

1. In enum trace_buffer_source, should GX_DBGC and CX_DBGC have the leading=
 @
prefix (@GX_DBGC: and @CX_DBGC:) so scripts/kernel-doc recognizes the
enumerator descriptions?

2. In the comment header for struct adreno_snapshot_trace_buffer, should it
begin with "struct adreno_snapshot_trace_buffer -" so scripts/kernel-doc do=
es
not parse it as a function prototype?

3. Inside struct adreno_snapshot_trace_buffer, the inline kernel-doc comment
above the segment field repeats @dbgc_ctrl instead of documenting @segment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030211928.4576=
1-1-robin.clark@oss.qualcomm.com?part=3D1
