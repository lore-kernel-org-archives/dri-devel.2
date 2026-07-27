Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A75C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 21:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E5E10E4DD;
	Mon, 27 Jul 2026 21:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b/KKTSp2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6185310E742
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 21:26:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 695036013A;
 Mon, 27 Jul 2026 21:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDE91F00A3A;
 Mon, 27 Jul 2026 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785187608;
 bh=vut7nL0kXH2gpOrV2CtJrgUZsy4tni/ZnbJ0ix/3VrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b/KKTSp2TLkEs9grEORK7/X0y7A75ouo+lHI7VHnPs4WEotwHDA+Muj6iIrDJLLIG
 H8dJcYG6fg7PkaGA+uvotkWfSOmaotGjG9txV2/3k9x7HRZFlQZaLg5tobrTVsML7j
 mP0ebuOBZe2BpAsJ5Dl80nR0EVg0tegkU2GOPj9Uh9UspTNtzgvWxsN0LWb4i6w8yg
 Aj0qNQ5YhKVVUTpVNbk05mCyKzAs5xLwNVX8iSZstENRkO6fhq88IVbavd18EzpB62
 3QAqSv1uq/SQUAv7hIRo3MTr9atJk+C2iPKW/PavUXjU3BMWzUnBxvxI3owDuf9JQa
 aQbNRgONczsDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
References: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 21:26:47 +0000
Message-Id: <20260727212647.ACDE91F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of drm_pending_vblank_event in prepare_signaling() err=
or path.
--

--- Patch [1]: [PATCH] drm: Fix drm_crtc_commit leak if signaled when PAGE_=
FLIP_EVENT is used ---
commit 7e124359c795a6d6965d1810c1067f7ff33a7631
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

This commit fixes a memory leak in the atomic commit path when the ioctl is
signaled while waiting for fences. It ensures the reference to the
drm_crtc_commit is properly dropped if the event allocated in
prepare_signaling() is cleared in complete_signaling().

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index e997917819e8e..7b951af5ab320 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1563,6 +1563,8 @@ static void complete_signaling(struct drm_device *d=
ev,
>  		 * to prevent a double free in drm_atomic_commit_clear.
>  		 */
>  		if (event && (event->base.fence || event->base.file_priv)) {

[Severity: High]
This is a pre-existing issue, but does this conditional inadvertently leak =
the
event under certain error conditions?

If userspace calls DRM_IOCTL_MODE_ATOMIC with an OUT_FENCE_PTR but without
the DRM_MODE_PAGE_FLIP_EVENT flag, prepare_signaling() allocates the event:

    e =3D create_vblank_event(crtc, arg->user_data);
    if (!e)
        return -ENOMEM;
    crtc_state->event =3D e;

Since PAGE_FLIP_EVENT is not set, drm_event_reserve_init() is skipped, leav=
ing
event->base.file_priv as NULL. If setup_out_fence() then fails (for example,
due to file descriptor exhaustion), prepare_signaling() returns an error
before event->base.fence is set:

    ret =3D setup_out_fence(&f[(*num_fences)++], fence);
    if (ret) {
        dma_fence_put(fence);
        return ret;
    }

When complete_signaling() cleans up the error path, both event->base.fence
and event->base.file_priv are NULL, causing this block to be skipped.=20

The event is left in crtc_state->event, but=20
__drm_atomic_helper_crtc_destroy_state() does not free it (it only frees
state->commit->event), leading to a memory leak. Could this be triggered by
untrusted userspace to reliably exhaust kernel memory?

> +			if (crtc_state->commit && crtc_state->commit->abort_completion)
> +				drm_crtc_commit_put(crtc_state->commit);
>  			drm_event_cancel_free(dev, &event->base);
>  			crtc_state->event =3D NULL;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-drm_crtc_a=
tomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=3D1
