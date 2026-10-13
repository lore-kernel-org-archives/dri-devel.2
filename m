Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55257CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2B410E8F7;
	Tue, 13 Oct 2026 15:04:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C22010E8F7
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:04:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4156B4140C;
 Tue, 13 Oct 2026 15:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE19D1F00893;
 Tue, 13 Oct 2026 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903854;
 bh=wO5auagr7j9YuovsuOoCpa9rWcK5UQOr4XUGzA6mqIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YSurYeFcfRHKqjV9pKgBcrx5dgYdj8blseXI37etP7LCa5v59CX07yrZmZNJ5IT3v
 S/FoztN6rV5i7bPLIUvdAVe2XcMZzaXmaVlMJzub6W/ETNBXpbmN1zOiY2nKFZPVoy
 tmodYd1l4wQ2zRgh2pbDao7GB5lXH4lWsyF3wi8gvTpikRTNrJ4vS9+WvyrBYtslYz
 v+iJtqme6hYP3/iGuQx/jP8bOlQGGAVCnrEIwbKlQYMKuZ/ujMXlkQaRTjf/p57uHo
 gGBHm9V2290Z9GwKaQmhWXwcTEHs2xbBKwt46GB6lhSbOdA3zjoApp+teYhtPqpqNp
 0QTRv/eWp2xPQ==
Message-ID: <sashiko-outbox-169964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: count the pending frame before kicking it off
To: "Michael Burch" <me@michaelburch.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013145007.13111-1-me@michaelburch.net>
References: <20261013145007.13111-1-me@michaelburch.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:04:13 +0000
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
- [Medium] drm/msm/dpu: bandwidth leak due to missed frame_pending 0-transi=
tion in error path
--

commit 09d9db34ac4a7e898d02571dc93cd542a14a8979
Author: Michael Burch <me@michaelburch.net>

drm/msm/dpu: count the pending frame before kicking it off

This commit moves the increment of frame_pending in dpu_crtc_commit_kickoff=
()
to occur before kickoff to prevent event worker races. It also adds a rollb=
ack
decrement in the clone mode error path.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 42d0a529b4d51..c8bd9c305a59a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
[ ... ]
> @@ -1105,9 +1105,19 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
>  		}
>  	}
> =20
> +	/* The frame-done event may be handled before the kickoff below returns=
. */
> +	if (atomic_inc_return(&dpu_crtc->frame_pending) =3D=3D 1) {
> +		/* acquire bandwidth and other resources */
> +		DRM_DEBUG_ATOMIC("crtc%d first commit\n", crtc->base.id);
> +	} else {
> +		DRM_DEBUG_ATOMIC("crtc%d commit\n", crtc->base.id);
> +	}
> +
>  	if (drm_crtc_in_clone_mode(crtc->state)) {
> -		if (dpu_crtc_kickoff_clone_mode(crtc))
> +		if (dpu_crtc_kickoff_clone_mode(crtc)) {
> +			atomic_dec(&dpu_crtc->frame_pending);

[Severity: Medium]
Does this unconditional atomic_dec() bypass the 0-transition check required=
 to
release CRTC bandwidth, causing a bandwidth leak?

If Frame N-1 is executing and Frame N is committed, dpu_crtc_commit_kickoff=
()
bumps frame_pending to 2. If dpu_crtc_kickoff_clone_mode() fails, it
decrements the count back.

If the hardware interrupt for Frame N-1 fires concurrently and its event wo=
rker
runs, it will decrement the count to 1, skipping the
dpu_core_perf_crtc_release_bw() call that requires a 1-to-0 transition.

The error path then blindly decrements the count to 0 with atomic_dec() and
also skips the dpu_core_perf_crtc_release_bw() call, permanently leaking the
allocated bandwidth until the CRTC is fully disabled.

>  			goto end;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013145007.1311=
1-1-me@michaelburch.net?part=3D1
