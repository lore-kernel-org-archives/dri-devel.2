Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D8C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4BE10E2EC;
	Fri, 21 Aug 2026 15:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y/RGstcX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB5A10E2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F14A41364
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A131F00A3A;
 Fri, 21 Aug 2026 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325938;
 bh=33M53nNtqKt3q+5diYcNzGDMcnrUr5Xhlim9cnjOups=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y/RGstcXhrJs7O71HTmda2ROjbh1flz0N1fLe7oHC4xn1Rfy8PMP8y5VRUN44cffU
 vdmV/9wspOe2Xpyjwxq7GxYf9+Q/TQQqOnAlwB/IJchtm2jw1oiujdz+IxvmxCn3E6
 jzRwyPuwoVLOxlmN4DDyaop1lq55mjK5fc2RGmJGqCqgqbshVnUckgYSHqsrx5A4XT
 xNdRvEtjLpoAtNfs3M5EzppcQf9r8zgoUor7qkeIx3jjMsbRZ+tHxSZ/o+7POCSbLG
 xM/ozjHjrTWYW2PkgCb9T8kmss1LSl0+t65SJVsjhm9gpW++J6ww6LlKg7s3cJVyBg
 YAEhPXAWTEhcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 35/70] drm/tiny: sharp: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-35-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-35-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:25:37 +0000
Message-Id: <20260821152538.60A131F00A3A@smtp.kernel.org>
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
- [High] The background kthread or PWM signal is not stopped on probe error=
 paths, leading to Use-After-Free when the device memory is freed.
- [High] The driver does not check the return value of kthread_run(), which=
 causes a kernel panic in the remove path if thread creation fails.
- [High] Plane atomic update callback calls sleeping functions (mutex_lock =
and spi_write) in an atomic context.
--

--- Patch [35]: [PATCH 35/70] drm/tiny: sharp: Switch to drm_atomic_helper_=
crtc_create_state ---
commit d365eb0228322a04306eb8553f60a438b3220d14
Author: Maxime Ripard <mripard@kernel.org>

drm/tiny: sharp: Switch to drm_atomic_helper_crtc_create_state

The sharp crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook. Switch to
drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/s=
harp-memory.c
> index 7efd7b567f3b2..434e73bd25a58 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -345,7 +345,7 @@ static const struct drm_crtc_helper_funcs sharp_memor=
y_crtc_helper_funcs =3D {
>  };
> =20
>  static const struct drm_crtc_funcs sharp_memory_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but does the plane atomic update
callback call sleeping functions in an atomic context?

The DRM subsystem executes plane atomic update callbacks in an atomic
context where sleeping is forbidden, but sharp_memory_plane_atomic_update()
invokes the display update flow:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_plane_atomic_update() {
    ...
    sharp_memory_fb_dirty(plane_state->fb, shadow_plane_state->data,
                          &rect, &shadow_plane_state->fmtcnv_state);
    ...
}

which then calls sleeping functions unconditionally:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_update_display() {
    ...
    mutex_lock(&smd->tx_mutex);

    /* Populate the transmit buffer with frame data */
    ...
    ret =3D sharp_memory_spi_write(smd->spi, tx_buffer, tx_buffer_size);
    ...
}

Could this lead to kernel splats and potential deadlocks on any atomic
plane update from userspace?


[Severity: High]
This is a pre-existing issue, but does the probe error path return directly
without stopping the kthread or PWM?

In sharp_memory_probe(), the background kthread is started, but if subseque=
nt
initialization steps fail, the function returns directly:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
    smd->sw_vcom_signal =3D kthread_run(sharp_memory_sw_vcom_signal_thread,
                                      smd, "sw_vcom_signal");
    ...
    if (ret)
        return dev_err_probe(dev, ret, "Failed to initialize display pipeli=
ne.\n");
    ...
}

Can this lead to a Use-After-Free memory corruption if the smd structure is
freed by devres while the running kthread continues executing and
dereferencing the freed memory?


[Severity: High]
This is also a pre-existing issue, but is the return value of kthread_run()
used without checking IS_ERR()?

If kthread creation fails in sharp_memory_probe(), smd->sw_vcom_signal would
hold an ERR_PTR:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
    smd->sw_vcom_signal =3D kthread_run(sharp_memory_sw_vcom_signal_thread,
                                      smd, "sw_vcom_signal");
    ...
}

Would this cause a kernel panic due to an invalid pointer dereference when
the driver is removed and kthread_stop() is unconditionally called?

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_remove() {
    ...
    kthread_stop(smd->sw_vcom_signal);
    ...
}

>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D35
