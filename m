Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ADCC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DAE10EAA3;
	Wed, 29 Jul 2026 06:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ve+AcaiM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709B510EAA3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:23:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37A5843258;
 Wed, 29 Jul 2026 06:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E449A1F000E9;
 Wed, 29 Jul 2026 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785306223;
 bh=aPZ7zaWlch7YgBi0Nazs9zIrozHSpe5lg0UdFb5axII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ve+AcaiM4/ah1mTySKLuYwrEtESd3cHevpSdd0uBLkWitscTW4he8sXDVn1r37r4J
 EuZf2q0qiOjt/muc7L2bxjg/LBmtg0i+6NskGsAllljwl1fRxMKbgpn/OCCqa2hUIb
 46Yosx1iDKfD4iNQN7QMVzBzX69HCDM00cBY8OJV10fMu5tirKeP3UsCM2+IGCGtSO
 W/5e+9rAfg9vtVupRXYEt7SqPBJJEcmBRTNrWo/eGvyQ0Ami6wKbo2FWds26wTFJAM
 IzzfeTfChLRMf57xBKp1BxfM3X8sc6tMsgihAJqekTZXcYIh8Y4PlCpBAp4YPEUmCU
 7nwNEqy72maVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com>
References: <20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:23:42 +0000
Message-Id: <20260729062342.E449A1F000E9@smtp.kernel.org>
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
- [Medium] API Contract Violation: out_fence_ptr is not set to -1 on certai=
n error paths
--

--- Patch [1]: [PATCH v2] drm: Fix drm_pending_vblank_event leak in error p=
ath for out_fence_ptr ---
commit ee648481e8c7946df39aedd0d40de2f6f6522bf2
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr

This commit fixes a memory leak in the error path of prepare_signaling when
DRM_MODE_PAGE_FLIP_EVENT is not set but an out_fence_ptr is provided. It
ensures the pending vblank event is properly released and the crtc state
event pointer is cleared on allocation or fence creation failures.

Link: https://patch.msgid.link/20260728-drm_pending_vblank_event_leak-v1-1-=
08429b920b16@igalia.com

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1050dddadb17e..aed6040182eb6 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1464,11 +1464,15 @@ static int prepare_signaling(struct drm_device *d=
ev,
>  		if (fence_ptr) {
>  			struct dma_fence *fence;
>  			struct drm_out_fence_state *f;
> +			struct drm_pending_vblank_event *e =3D crtc_state->event;
> =20
>  			f =3D krealloc(*fence_state, sizeof(**fence_state) *
>  				     (*num_fences + 1), GFP_KERNEL);
> -			if (!f)
> +			if (!f) {
> +				drm_event_cancel_free(dev, &e->base);
> +				crtc_state->event =3D NULL;
>  				return -ENOMEM;
> +			}

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential UAPI contract
violation here.

If krealloc fails, we return -ENOMEM before out_fence_ptr is added
to the fence_state array or num_fences is incremented.

Does this mean complete_signaling() will skip this element and fail to write
-1 back to the userspace out_fence_ptr, leaving userspace with an
uninitialized or stale fd value?

> =20
>  			memset(&f[*num_fences], 0, sizeof(*f));
> =20
> @@ -1476,12 +1480,17 @@ static int prepare_signaling(struct drm_device *d=
ev,
>  			*fence_state =3D f;
> =20
>  			fence =3D drm_crtc_create_fence(crtc);
> -			if (!fence)
> +			if (!fence) {
> +				drm_event_cancel_free(dev, &e->base);
> +				crtc_state->event =3D NULL;
>  				return -ENOMEM;
> +			}

[Severity: Medium]
This is also a pre-existing issue, but similarly, if drm_crtc_create_fence
fails, out_fence_ptr is written to the array but num_fences is not
incremented.

Will the cleanup routine skip this pointer and fail to write -1 to userspac=
e?

It looks like this same pattern also exists in the connector loop later in
prepare_signaling() when drm_writeback_get_out_fence() fails.

> =20
>  			ret =3D setup_out_fence(&f[(*num_fences)++], fence);
>  			if (ret) {
>  				dma_fence_put(fence);
> +				drm_event_cancel_free(dev, &e->base);
> +				crtc_state->event =3D NULL;
>  				return ret;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-drm_pendin=
g_vblank_event_leak-v2-1-a5074aae07df@igalia.com?part=3D1
