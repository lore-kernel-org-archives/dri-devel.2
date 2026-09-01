Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F9FC624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D15E10E63A;
	Tue,  1 Sep 2026 12:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R4v0rwJ/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA3C10E63A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:10:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6519E42A7E;
 Tue,  1 Sep 2026 12:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CAE1F000E9;
 Tue,  1 Sep 2026 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788264601;
 bh=R035hwq1kLOiK76FnT2j9EncGwg8GOvMVwK6iEN4j2E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R4v0rwJ/TbJ/EvQA4RgvxXIq/RkC0SjyWDRlr5+BswtZTo8+ep4KCT1eFFi/887GX
 B3dArhuEiCWYyyCfakDXjfe2yqLB942R4fSgzW5HiDSjVAZ2kqScpfjjX8trbv07wp
 LwtAqNGEgPjLxe3JU/eN0pbhUbC981OIiKJWEIbUoOFcglOjO6BRJBeQSAyC32YlUm
 j3/bqYk5/uu+vd2VaxlTj08alhCKxUJu+3TtyVE3I5cN6TyEVrhA+Xr0wBMdGvUpRS
 klltyN7sJk17VPYWvB75mAP4xIFwsbg0JT7Ys12cTzF3xjIBe2JA34Uu0pnCae5VqA
 ih2axCzn+iDrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 1/2] drm/tiny: sharp-memory: fix line address
 assignment on partial update
To: "Tobias Johansson" <tobias.johansson@axis.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-flickering-v1-1-eaf7bbf9c000@axis.com>
References: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
 <20260901-flickering-v1-1-eaf7bbf9c000@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 12:10:00 +0000
Message-Id: <20260901121001.36CAE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Background kthread is not stopped on probe error paths, leadin=
g to a critical Use-After-Free.
- [High] Calling sleeping functions from a plane atomic_update callback vio=
lates DRM atomic context rules.
- [High] Line addresses are truncated to 8 bits, breaking hardware support =
for panels with more than 255 lines.
- [High] Missing IS_ERR check for kthread_run leads to a kernel panic durin=
g device removal.
- [High] Truncation in pitch calculation for non-byte-aligned widths causes=
 missing hardware dummy bits.
--

commit c42f51bc1dfa5c55a57f8a64e3aa97d5ec5bc008
Author: Tobias Johansson <tobias.johansson@axis.com>
Subject: drm/tiny: sharp-memory: fix line address assignment on partial upd=
ate

This patch modifies sharp_memory_set_tx_buffer_addresses() to only iterate
over the damaged line count and offset the assigned addresses by the clip
start. This fixes corrupted address-to-data mapping on partial updates where
incorrect line addresses were being sent to the panel.

> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/s=
harp-memory.c
> index cbf69460ebf32..595926ed660e5 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -120,8 +120,8 @@ static inline void sharp_memory_set_tx_buffer_address=
es(u8 *buffer,
>  							struct drm_rect clip,
>  							u32 pitch)
>  {
> -	for (u32 line =3D 0; line < clip.y2; ++line)
> -		buffer[line * pitch] =3D line + 1;
> +	for (u32 line =3D 0; line < drm_rect_height(&clip); ++line)
> +		buffer[line * pitch] =3D clip.y1 + line + 1;

[Severity: High]
This isn't a bug introduced by this patch, but does the computed line addre=
ss
get truncated?

Since buffer is an 8-bit u8 array and SHARP_ADDR_PERIOD is hardcoded to
8 bits, addresses > 255 might overflow and be truncated. Could this break
hardware support for panels with more than 255 lines, like ls032b7dd02 which
can have up to 536 lines?

>  }

I also noticed some other pre-existing issues in this file:

[Severity: High]
This is a pre-existing issue, but does this violate DRM atomic context rule=
s?

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_plane_atomic_update() {
    ...
	if (drm_atomic_helper_damage_merged(old_state, plane_state, &rect))
		sharp_memory_fb_dirty(plane_state->fb, shadow_plane_state->data,
				      &rect, &shadow_plane_state->fmtcnv_state);
    ...
}

sharp_memory_plane_atomic_update() executes in an atomic context where
sleeping is forbidden. However, it delegates to
sharp_memory_update_display() which acquires a mutex:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_update_display() {
    ...
	mutex_lock(&smd->tx_mutex);
    ...
}

Additionally, it calls drm_fb_xrgb8888_to_mono() which allocates memory with
GFP_KERNEL:

drivers/gpu/drm/drm_format_helper.c:drm_fb_xrgb8888_to_mono() {
    ...
	src32 =3D drm_format_conv_state_reserve(state, len_src32 + linepixels,
					      GFP_KERNEL);
    ...
}

Could this lead to system instability, kernel warnings, and potential deadl=
ocks
during non-blocking atomic commits?


[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free on the probe er=
ror
path if initialization fails?

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
	smd->sw_vcom_signal =3D kthread_run(sharp_memory_sw_vcom_signal_thread,
					  smd, "sw_vcom_signal");
    ...
	return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
    ...
}

If subsequent steps like sharp_memory_pipe_init() fail, the probe function
returns directly without stopping the sw_vcom_signal kthread. The devres
framework automatically frees the smd structure, but the still-running kthr=
ead
might dereference it to toggle vcom and update the display.


[Severity: High]
This is a pre-existing issue, but what happens if kthread_run() fails and
returns an ERR_PTR?

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
	smd->sw_vcom_signal =3D kthread_run(sharp_memory_sw_vcom_signal_thread,
					  smd, "sw_vcom_signal");
    ...
}

There doesn't appear to be an IS_ERR() check on the return value. If thread
creation fails due to memory limits, the ERR_PTR is stored in
smd->sw_vcom_signal.

When the device is later removed, it seems to unconditionally call
kthread_stop() on that unvalidated error pointer, which could cause a kernel
panic:

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_remove() {
    ...
	kthread_stop(smd->sw_vcom_signal);
    ...
}


[Severity: High]
This is a pre-existing issue, but does this pitch calculation truncate inst=
ead
of rounding up?

drivers/gpu/drm/tiny/sharp-memory.c:sharp_memory_probe() {
    ...
	smd->pitch =3D (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERI=
OD) / 8;
    ...
}

For non-byte-aligned widths (e.g., the ls018b7dh02 panel with hdisplay =3D =
230),
this integer division evaluates to 246 / 8 =3D 30 bytes (240 bits).

However, the panel requires 230 bits of data, which drm_fb_xrgb8888_to_mono=
()
expands to 29 bytes. With 1 byte for the address and 29 bytes for data,
the 30 bytes of pitch are fully consumed. This appears to entirely omit
the required 8-bit dummy period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-flickering=
-v1-0-eaf7bbf9c000@axis.com?part=3D1
