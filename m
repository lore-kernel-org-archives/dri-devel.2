Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBJuaKFV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCD8112606;
	Thu, 26 Nov 2026 17:09:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF90D112606
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 17:09:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2E6B60CC9;
 Thu, 26 Nov 2026 17:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7375A1F000D4;
 Thu, 26 Nov 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712971;
 bh=2CjxuHa96LufmwKR/lTX/nO6JG1QlIH7Y3CUJFfU/+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kBJuaKFVFRzhk8sPdNb8hQdBU48ihreXoDTWckagNA4sJy8vr7LuoGNfH0Py25Ad4
 jQ04umxkAv5W3NRKTJjiOyZl/L3Mla7ECLHZ0wBKKJCp0yHwpsTa9JVpp4D/b7j1LJ
 FKKvQC6QHx1mhtjkHl+Uxqpf6XhbW16RZKXBJKC/g81xVbfyeImTmLV0lKufVJL5st
 cJmyRuX8VaxyUgDI1Qopq83/CU/I7+repEOcnfh/DxYNowVGwA2oyvoNvYQdxBgfvL
 AFwxPsDbcwsOL7HGlSo4lhklktAZs02GLI7fUeaxYPi0nMJ/EyA3ZtWO8f7BfOiePp
 kTGOt5ZzJLQyQ==
Message-ID: <sashiko-outbox-235963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/vkms: copy a full-screen frame straight to
 writeback
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-composer-fastpath-v2-2-292ed6d4c4d6@gmail.com>
References: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
 <20261126-composer-fastpath-v2-2-292ed6d4c4d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 17:09:31 +0000
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
- [High] drm/vkms: out-of-bounds dereference in compose_active_planes()
  with 0 planes
--

commit 78d03e558f502868143b5675a866d31e9e3f5440
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: copy a full-screen frame straight to writeback

This commit copies a single full-screen XRGB8888 plane directly into a
matching writeback framebuffer without allocating or blending through the
16-bit line buffer when CRC generation and gamma LUT are disabled.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 4e2dd568bc3e3..239fdaca2926a 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c

[ ... ]

> @@ -690,6 +734,17 @@ static int compose_active_planes(struct vkms_writeba=
ck_job *active_wb,
>  	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
>  		return -EINVAL;
> =20
> +	direct =3D compose_direct(crtc_state);
> +
> +	plane =3D crtc_state->active_planes[0];
> +
> +	if (direct && writeback_direct(crtc_state, active_wb, plane, crc_on)) {
> +		for (int y =3D 0; y < crtc_state->base.mode.vdisplay; y++)
> +			vkms_writeback_row_direct(active_wb, plane, y);
> +
> +		return 0;
> +	}

[Severity: High]
Can this dereference crtc_state->active_planes[0] when
crtc_state->num_active_planes is 0?

When an active CRTC has no visible planes, vkms_crtc_atomic_check()
allocates active_planes with kzalloc_objs(..., 0), which returns
ZERO_SIZE_PTR.  compose_direct() checks that num_active_planes =3D=3D 1 and
returns false, but reading crtc_state->active_planes[0] before testing
direct faults on ZERO_SIZE_PTR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-composer-f=
astpath-v2-0-292ed6d4c4d6@gmail.com?part=3D2
