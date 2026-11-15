Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98592606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdJklU8e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D5210E912;
	Sun, 15 Nov 2026 14:47:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D8610E2D7;
 Sun, 15 Nov 2026 14:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF09C456E7;
 Sun, 15 Nov 2026 14:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B81F000C4;
 Sun, 15 Nov 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794754062;
 bh=F1EA/BUNTKsMoS7heRFAO7TcF/IyTYXWc3RwqtqlWJo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LdJklU8eoa9T1OQ+kpvIPeIAZWd9wDSq/y6rVz/Ia/9U0YNDBajFeDHt1A/L6xMOP
 qg2NQfaElCWRawj1yXu9mE8V4sTJABTK9ARrrx8Gc6vYG41tXFeURlVjN98vhxOVri
 JyRWKk0xMSfHXAvYLuF8ir5xe/D0kCmsTSwgzPuMWbW6wptusn29ayKicwfEOf66kL
 n2C50FtteXCcdi/tLN8sSHS/Q8m31LoNFg8niRArXteqkUS4HgGdf5taLnP1NYn39n
 73bqXScNdzVticdY3qX22jo15KrMY/facvt8GASDzPtXU0DPkX3Cz01noxxaiL1EyA
 O1HlnBzIgPraQ==
Message-ID: <sashiko-outbox-215590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: Ignore disabled planes in async flip
 checks
To: "Erwin Springer" <aot.lerwin@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261115-i915-async-planes-v1-1-d13498d0b6be@gmail.com>
References: <20261115-i915-async-planes-v1-1-d13498d0b6be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:47:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/i915/display: reachable drm_WARN_ON() in
  intel_async_flip_check_hw() with NV12 Y-plane
--

commit b042ec62b54473b2633218f68a54b0d394afbc1e
Author: Erwin Springer <aot.lerwin@gmail.com>

drm/i915/display: Ignore disabled planes in async flip checks

This commit skips planes that have neither an old nor a new framebuffer
in intel_async_flip_check_uapi() and intel_async_flip_check_hw() so that
unchanged disabled planes included in an atomic commit do not cause async
flips to be rejected.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index f79caeb5a82ec..defa55da52a74 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6173,6 +6173,14 @@ static int intel_async_flip_check_uapi(struct inte=
l_atomic_state *state,
>  		if (plane->pipe !=3D crtc->pipe)
>  			continue;
> =20
> +		/*
> +		 * Userspace may add planes it doesn't change to the commit.
> +		 * A plane that is disabled and stays disabled takes no part
> +		 * in the async flip.
> +		 */
> +		if (!old_plane_state->uapi.fb && !new_plane_state->uapi.fb)
> +			continue;
> +
>  		/*
>  		 * TODO: Async flip is only supported through the page flip IOCTL
>  		 * as of now. So support currently added for primary plane only.
> @@ -6238,6 +6246,10 @@ static int intel_async_flip_check_hw(struct intel_=
atomic_state *state, struct in
>  		if (plane->pipe !=3D crtc->pipe)
>  			continue;
> =20
> +		/* Disabled planes that stay disabled take no part in the flip. */
> +		if (!old_plane_state->hw.fb && !new_plane_state->hw.fb)
> +			continue;
> +
>  		/*
>  		 * Only async flip capable planes should be in the state
>  		 * if we're really about to ask the hardware to perform

[Severity: Medium]
Can this trigger drm_WARN_ON(display->drm, new_crtc_state->do_async_flip
&& !plane->async_flip) in intel_async_flip_check_hw() when a non-primary
plane is scanning out a planar YUV framebuffer (such as NV12 on ICL+)?

When a plane scans out a planar format, icl_check_nv12_planes() links it
to an unused SDR Y-plane via link_nv12_planes().  That Y-plane remains
disabled in UAPI (uapi.fb is NULL), but has a non-NULL hw.fb and
planar_linked_plane set.

If userspace submits atomic async flips on the primary plane while
including all UAPI-disabled planes on the pipe,
intel_async_flip_check_uapi() now skips the Y-plane because its old and
new uapi.fb are NULL.  Later in intel_atomic_check_planes(),
intel_joiner_add_affected_planes() sees the Y-plane's planar_linked_plane
and pulls the UV plane into the atomic state, and icl_check_nv12_planes()
re-links them with non-NULL hw.fb.  Once new_crtc_state->do_async_flip is
set on the following async flip, both planes bypass the !hw.fb check in
intel_async_flip_check_hw() and hit the drm_WARN_ON() because
plane->async_flip is NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-i915-async=
-planes-v1-1-d13498d0b6be@gmail.com?part=3D1
