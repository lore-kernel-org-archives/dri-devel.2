Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF3606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYC49GHz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582B1112118;
	Fri, 27 Nov 2026 08:07:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85C1112118
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89CB7622BF;
 Fri, 27 Nov 2026 08:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D49C1F00893;
 Fri, 27 Nov 2026 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795766812;
 bh=whGkBZSbMuSpd24uDcRJiN4J89s+PXioFAi8U4DruqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YYC49GHzWxH9rdXmrrDsHwc3Hy1NEN9vOcft+hS9RRUMCY8jaT8+se8AYH+FxKqUz
 Nn+nbyyutZTLNTcRjJt8w7Y87q1AbFKSs1uarsN/6P7Owgo6M3kLpi+T0+hCQwWO1d
 tEgPtme2RAOdIQh9i8v8c1modQe4fXbyFqGziQfWyUOFgA6mZyAaLoOzp0qZKQJMFS
 zVsN+SSYV0FVq7oi6Qn5qTYsv+7SG4F98zMXOKkZenyjHLKJVhh2HDBiG/kjuZONUb
 7rZ9T9uhAyAgx/b47E2GrWAHg3GuXI+7EMFNRh5kETRINdBmyqIxdOfyV/XlJVOI8D
 3bnhvMwhBLIrw==
Message-ID: <sashiko-outbox-236860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261127074639.277959-4-Luo.Liu@cixtech.com>
References: <20261127074639.277959-1-Luo.Liu@cixtech.com>
 <20261127074639.277959-4-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:06:51 +0000
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
- [Medium] drm/bridge: trilinear: htotal and clock overflow in
  dptx_adjust_mode()
--

commit 121beb945da3bca1311595f6221c3e03dd980739
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX DRM bridge

This commit adds the DRM bridge implementation for the Trilinear DisplayPort
transmitter, handling connector detection, EDID and downstream mode
enumeration, mode validation, and atomic modesetting callbacks.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/dr=
m/bridge/trilinear/dptx_drm.c
> new file mode 100644
> index 0000000000000..7a081873560bf
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c

[ ... ]

> +static void dptx_adjust_mode(const struct drm_display_mode *mode,
> +			     struct drm_display_mode *adjusted_mode)
> +{
> +	int diff =3D mode->htotal - mode->hsync_end;
> +
> +	if (diff < DPTX_MIN_H_BACKPORCH) {
> +		adjusted_mode->htotal =3D mode->htotal +
> +					DPTX_MIN_H_BACKPORCH - diff;
> +		adjusted_mode->clock =3D
> +			div_u64(mul_u32_u32(mode->clock, adjusted_mode->htotal),
> +				mode->htotal);
> +	}

[Severity: Medium]
Can adjusted_mode->htotal and adjusted_mode->clock overflow here when a
userspace mode has a horizontal backporch smaller than DPTX_MIN_H_BACKPORCH?

Because adjusted_mode->htotal is a u16 and adjusted_mode->clock is a signed
int, a custom mode with mode->hsync_end >=3D 65524 wraps adjusted_mode->hto=
tal
to 0..11 and truncates adjusted_mode->clock to 0 (or overflows
adjusted_mode->clock past INT_MAX when mode->clock is near INT_MAX).

dptx_bridge_mode_valid() and dptx_bridge_atomic_check() only check the upper
bound of adjusted_mode->clock, so the wrapped value passes validation and
reaches dptx_bridge_atomic_enable(), where dptx_hw_stream_timing_set()
underflows mode->htotal - mode->hdisplay and divides by zero on mode->clock:

drivers/gpu/drm/bridge/trilinear/dptx_hw.c:dptx_hw_stream_timing_set() {
    ...
	dptx_hw_write(hw, DPTX_SECONDARY_DATA_WINDOW(stream_id),
		      (mode->htotal - mode->hdisplay) * (link_rate / 40) *
		      9 / mode->clock);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127074639.2779=
59-1-Luo.Liu@cixtech.com?part=3D3
