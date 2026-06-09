Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51822CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA4610E2C3;
	Tue,  9 Jun 2026 12:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MR+kvUke";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4C10E2C3
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2C12601D6;
 Tue,  9 Jun 2026 12:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A59E1F00893;
 Tue,  9 Jun 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781008393;
 bh=OqA6DrsX5CF1HMvLtOYCIWCXgnmByKiofZ277b/c6Yc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MR+kvUkekGcLs3tvLOyUTK4Th/i5KtVNR7RxpVz+CkvZ92qTPRLS5nURqp7kwjVN/
 yJ45J7PAfssVeNKOsLUErLt56Cu99hUdFsv7ryMwQdPLsw974FflX1Ie9zbEr5mbiY
 glyYuv91EigSjXAa5yNtWXHp381a7BsgzhsVWLOl++1DcovJ5qRSFST4RrTcAVBMw3
 K3GaWeN5/VtxPaPZZ9AEUK3RS3+M4URYNR2zFFl6Vn61d/UqzPmuZv+rpXUi/AH1lc
 6mJxlsfgkwrKJiIoYkNaYs/BYBjLQypK4+oDYGnnEGaSFiv/VWLl5r+OYa3Sgn+7gU
 cXamNkkz89ykw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] drm/atomic: only add states of active or
 transient active colorops
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-2-mwen@igalia.com>
References: <20260609121230.1358786-2-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:33:12 +0000
Message-Id: <20260609123313.7A59E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete refactoring: drm_atomic_helper_duplicate_state still =
calls drm_atomic_add_affected_colorops.

Pre-existing issues:
- [High] Architectural Flaw: Colorops are omitted from the atomic state dur=
ing normal plane updates.
--

commit a131c9a42c3beaf39f56794937e21266031060d8
Author: Melissa Wen <mwen@igalia.com>

drm/atomic: only add states of active or transient active colorops

Only consider affected colorop states those that are part of an active
color pipeline or a pipeline that is about to be activated or
deactivated in the same atomic commit.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 170de30c28ae4..0d36a955c4d43 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
[ ... ]
> @@ -1591,11 +1642,9 @@ drm_atomic_add_affected_planes(struct drm_atomic_c=
ommit *state,
>  		if (IS_ERR(plane_state))
>  			return PTR_ERR(plane_state);
> =20
> -		if (plane_state->color_pipeline) {
> -			ret =3D drm_atomic_add_affected_colorops(state, plane);
> -			if (ret)
> -				return ret;
> -		}
> +		ret =3D drm_atomic_add_pipeline_colorops(state, plane);
> +		if (ret)
> +			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but since
drm_atomic_add_affected_planes() executes exclusively during CRTC modesets,
does this mean active colorops are never added to the atomic state during a
simple plane update like a page flip?

Drivers that iterate over state->colorops via for_each_new_colorop_in_state=
()
(like intel_plane_color_copy_uapi_to_hw_state() in the intel driver)
will silently fail on page flips since the hardware state blobs remain
empty. Should the color pipeline dependency tracking be anchored to the
plane's inclusion in the state, perhaps within drm_atomic_get_plane_state()?

[Severity: Medium]
Also, the commit message states the goal is to remove the condition for
plane_state->color_pipeline to handle deactivations. Did this patch miss
updating drm_atomic_helper_duplicate_state() in drm_atomic_helper.c?

It still checks if (plane_state->color_pipeline) and calls the old
drm_atomic_add_affected_colorops(), which loops over all colorops belonging
to the plane:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_duplicate_state() {
	...
	if (plane_state->color_pipeline) {
		err =3D drm_atomic_add_affected_colorops(state, plane);
		if (err)
			goto free;
	}
	...
}

Should it be updated to use the newly introduced
drm_atomic_add_pipeline_colorops() unconditionally to ensure consistent sta=
te
duplication during suspend/resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D1
