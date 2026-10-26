Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A3606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYTs39fr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F164910E2F7;
	Mon, 26 Oct 2026 06:58:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDE710E2F7
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:58:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5327F601DE;
 Mon, 26 Oct 2026 06:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD35D1F01825;
 Mon, 26 Oct 2026 06:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792997885;
 bh=AbK87O2XyTNzCdq4XW1LsVZjCV0uMRGm8KEcoU6ddEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WYTs39frFypqbAcA/olYUVPDgFUrqLVO7XQgpqdc4GdR2G1Kj+dPtMMHr2zEomlnB
 b2w97I+RirRq3p62CkNxn0XdcqI+fUfVbX2LUTfqjqsZapKwTuoFA/TDY1jUYY7Ib8
 6GaPuw5sLsfivS5W1WKGM8qw92MB/3YWsQAUjCdgyzDWY+9pg9s9rheXIIlrodD7/V
 X+Y9r3TvIVhx84UQl4Pau4By2BNI8mshQpSoVEAQ4k7hFTwkfJp0nrOvBJDs2zZ0c9
 6ouJtdNulvFV5EjX0j2Jy6zSgNbI/faNFolsM/VmUR1mrztRacTZx9FBpgt39WJvdU
 3biF0AnI/e1FQ==
Message-ID: <sashiko-outbox-184634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
To: "Dave Airlie" <airlied@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 06:58:04 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] gpu: nova-core: Gpu::new() always passes Some for total_fb_end t=
o GpuMm::new()
--

commit c48efe432798819fed4e7632bc17f4fc720dd7e4
Author: Dave Airlie <airlied@redhat.com>

gpu: nova-core: make pramin/buddy optional

This commit updates GpuMm so that the GpuBuddy allocator and Pramin manager
are optional to support GPU systems with no framebuffer memory.

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 4e59072cab507..5d53fde2cdc1e 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -564,18 +564,19 @@ pub(crate) fn new<'a>(
> =20
>              // Create GPU memory manager owning memory management resour=
ces.
>              mm: {
> -                let usable_vram =3D gsp_static_info.usable_fb_regions.fi=
rst().ok_or(ENODEV)?;
> -                let buddy_params =3D GpuBuddyParams {
> -                    base_offset: usable_vram.start,
> -                    size: usable_vram.end - usable_vram.start,
> -                    chunk_size: Alignment::new::<SZ_4K>(),
> -                };
> +                let buddy_params =3D gsp_static_info.usable_fb_regions.f=
irst().map(|usable_vram| {
> +                    GpuBuddyParams {
> +                        base_offset: usable_vram.start,
> +                        size: usable_vram.end - usable_vram.start,
> +                        chunk_size: Alignment::new::<SZ_4K>(),
> +                    }
> +                });
> =20
>                  GpuMm::new(
>                      bar,
>                      gsp_resources.spec.chipset,
>                      buddy_params,
> -                    VramAddress::from_raw(gsp_static_info.total_fb_end),
> +                    Some(VramAddress::from_raw(gsp_static_info.total_fb_=
end)),
>                  )?
>              },

[Severity: Medium]
In Gpu::new(), the total_fb_end argument to GpuMm::new() is unconditionally
wrapped in Some(...). Since Gpu::new() is the only caller of GpuMm::new(),
won't GpuMm::new() always receive Some(...) for total_fb_end and
unconditionally call pramin::Pramin::new(), which writes the hardware BAR0
PRAMIN window base register via hal.write_pramin_window_base(bar, base) and
leaves GpuMm::pramin populated even on systems without framebuffer memory?

Also, in drivers/gpu/nova-core/gsp/commands.rs, GetGspStaticInfoReply::read=
()
still requires msg.total_fb_end() to be present when called from
Gpu::new() -> Gsp::get_static_info():

drivers/gpu/nova-core/gsp/commands.rs:GetGspStaticInfoReply::read() {
    ...
    let total_fb_end =3D msg.total_fb_end().ok_or(EINVAL)?;
    ...
}

When GSP reports no framebuffer regions, msg.total_fb_end() returns None,
causing GetGspStaticInfoReply::read() to fail probe with EINVAL before
GpuMm::new() is reached.

Should GetGspStaticInfoReply::total_fb_end be changed to Option<u64> (or
Option<VramAddress>) and passed through to GpuMm::new() without wrapping it
unconditionally in Some(...)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-nova-prami=
n-option-v1-1-d073b3f047fc@redhat.com?part=3D1
