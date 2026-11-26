Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D7606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUOXCYpq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FD311256D;
	Thu, 26 Nov 2026 16:01:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6AF11256D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:01:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7FC661D0A;
 Thu, 26 Nov 2026 16:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887F31F000D1;
 Thu, 26 Nov 2026 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795708873;
 bh=1euGQyyIiUIoszx3IDZrsKtBTddUDqula4SHqbKPINU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fUOXCYpq8v0sXfHSQAJ3cMyQhuXnCYA0EJkU+tX+4xqI7cILBA74ZG1NtVk6uua+P
 bDVRg2Pits5XkORZN3fWpgPaN+scG55wSdplMYsOX+SHh/Pq9gC8nVlsTKcnzB/DI3
 W2KQIvni6Nv905tENz0J3ygU8M1pVtNFXHoJEZjqQvm1Q8sIhxGd3LqF9t7JOR3mcK
 92ijUK6faIuRMYXQWCmAIA+toeI777W5Zy8dzdavwCPL9Lr//Udzy/YagXMEdGtmMO
 nzJMJUFhxeyP8Jo98rxvFKVgwpMec6BHwmvJhFBD+HkZ4FdhMBGcq+ktwu3pwoHjak
 N/e3yUHXehQLQ==
Message-ID: <sashiko-outbox-235870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vkms: copy a full-screen frame straight to
 writeback
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-composer-fastpath-v1-2-aa7458d84a7b@gmail.com>
References: <20261126-composer-fastpath-v1-0-aa7458d84a7b@gmail.com>
 <20261126-composer-fastpath-v1-2-aa7458d84a7b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:01:13 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/vkms: uncomputed zero CRC queued after writeback_direct()
  fast path
- [Low] drm/vkms: missing kernel-doc descriptions for writeback_direct()
  and blend()
--

commit b8f92ae3007226a9078822ce948db7eb0d6b0153
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: copy a full-screen frame straight to writeback

This commit adds a fast path to copy a full-screen 32-bit plane directly
into a matching writeback framebuffer when no CRC calculation, gamma LUT,
rotation, or blending is active.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 4e2dd568bc3e3..7ecd8b459ed26 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -581,6 +581,49 @@ static bool compose_direct(const struct vkms_crtc_st=
ate *crtc_state)
>  	return true;
>  }
> =20
> +/**
> + * writeback_direct() - Can the frame skip the line buffer?
> + * @crtc_state: the state to compose
> + * @wb: the writeback job, or NULL
> + *
> + * True when nothing needs 16-bit pixels: no CRC, no LUT, no colour pipe=
line,
> + * same 32-bit format on both sides.
> + *
> + * Returns: true if the frame can be copied straight into the writeback =
buffer.
> + */
> +static bool writeback_direct(const struct vkms_crtc_state *crtc_state,
> +			     const struct vkms_writeback_job *wb,
> +			     const struct vkms_plane_state *plane)
> +{
> +	const struct vkms_output *output;
> +	const struct drm_format_info *format;
> +
> +	if (!wb)
> +		return false;
> +
> +	/* The CRC is computed over the 16-bit line buffer. */
> +	output =3D drm_crtc_to_vkms_output(crtc_state->base.crtc);
> +	if (READ_ONCE(output->crc_enabled))
> +		return false;
> +
> +	/* The gamma LUT is applied to the 16-bit line buffer. */
> +	if (crtc_state->gamma_lut.y)
> +		return false;
> +
> +	/* The copy walks source rows, so the plane cannot be rotated. */
> +	if (plane->frame_info.rotation !=3D DRM_MODE_ROTATE_0)
> +		return false;
> +
> +	if (plane->frame_info.src.x1 || plane->frame_info.src.y1)
> +		return false;
> +
> +	format =3D plane->frame_info.fb->format;
> +	if (format !=3D wb->wb_frame_info.fb->format)
> +		return false;
> +
> +	return format->cpp[0] =3D=3D 4;
> +}
> +
>  /**
>   * blend - blend the pixels from all planes and compute crc
>   * @wb: The writeback frame buffer metadata
> @@ -597,7 +640,8 @@ static bool compose_direct(const struct vkms_crtc_sta=
te *crtc_state)
>  static void blend(struct vkms_writeback_job *wb,
>  		  struct vkms_crtc_state *crtc_state,
>  		  u32 *crc32, struct line_buffer *stage_buffer,
> -		  struct line_buffer *output_buffer, size_t row_size)
> +		  struct line_buffer *output_buffer, size_t row_size,
> +		  bool direct)

[Severity: Low]
The kernel-doc comments above writeback_direct() and blend() are missing
descriptions for the @plane and @direct parameters, which will trigger
W=3D1 kernel-doc warnings.

[ ... ]

> @@ -690,6 +734,15 @@ static int compose_active_planes(struct vkms_writeba=
ck_job *active_wb,
>  	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
>  		return -EINVAL;
> =20
> +	direct =3D compose_direct(crtc_state);
> +
> +	if (direct && writeback_direct(crtc_state, active_wb, crtc_state->activ=
e_planes[0])) {
> +		for (int y =3D 0; y < crtc_state->base.mode.vdisplay; y++)
> +			vkms_writeback_row_direct(active_wb, crtc_state->active_planes[0], y);
> +
> +		return 0;
> +	}

[Severity: Medium]
Can this fast path cause vkms_composer_worker() to enqueue an uncomputed
0x00000000 CRC entry when CRC collection is opened concurrently?

When writeback_direct() returns true, compose_active_planes() skips
blend() and leaves crc32 at 0, but vkms_composer_worker() still
unconditionally passes crc32 to drm_crtc_add_crc_entry():

drivers/gpu/drm/vkms/vkms_composer.c:vkms_composer_worker() {
    ...
	u32 crc32 =3D 0;
    ...
	if (wb_pending)
		ret =3D compose_active_planes(active_wb, crtc_state, &crc32);
    ...
	while (frame_start <=3D frame_end)
		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
}

In crtc_crc_open(), crc->entries is allocated and published before
.set_crc_source() (vkms_set_crc_source()) updates output->crc_enabled:

CPU0 (vkms_composer_worker)       CPU1 (crtc_crc_open)
                                  spin_lock_irq(&crc->lock)
                                  crc->opened =3D true
                                  crc->entries =3D entries
                                  spin_unlock_irq(&crc->lock)
compose_active_planes()
  writeback_direct()
    READ_ONCE(output->crc_enabled) -> false
  vkms_writeback_row_direct()
                                  vkms_set_crc_source()
                                    WRITE_ONCE(out->crc_enabled, true)
drm_crtc_add_crc_entry(..., &crc32)
  <-- queues uncomputed crc32 =3D=3D 0 into crc->entries

Even if crtc_crc_open() runs after writeback_direct() checks
output->crc_enabled, drm_crtc_add_crc_entry() will still see the newly
opened ring buffer and enqueue a bogus zero CRC for the in-flight frame.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-composer-f=
astpath-v1-0-aa7458d84a7b@gmail.com?part=3D2
