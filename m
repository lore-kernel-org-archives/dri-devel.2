Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75903CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA58C10E100;
	Tue, 13 Oct 2026 17:42:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A884010E100
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:42:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7599C60A59;
 Tue, 13 Oct 2026 17:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030E91F000FF;
 Tue, 13 Oct 2026 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791913342;
 bh=PCUNEcPjjSxbfQq0j3DlIjWZndYWNHJsKEvtY3zCNzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHzcU7G+hmfRNpE5P5KOnbuJWTEGvW6ExDicRPtVQN3QzdEPfSMmK+0BNNHUj4PGO
 +iYEhQ18BaTse8figzwBVtO9iP401073WTSmQ9NZA31TSfmboKnmTsv5Ogy3jhUbI8
 DqKyZqb4uv79Uv88p92awGgBRBTkRYU8TvySB/ItVVKNaIMGhcor8Bg+gvE1F0fztt
 leeeOVeG1mdlaWfe81SQ8Ma9gFEeTb3+H1WYxA/Pz4S5ihVlFqU10oOnyJLwk+sLZH
 OHhXJr+dVdolZtxHakJyPBcYHGlpddX/EvkMGh6g0HxTf134OJM/hlNyS0lXpSm8pq
 kEHdFZsgR+g+Q==
Message-ID: <sashiko-outbox-170245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: count the pending frame before kicking
 it off
To: "Michael Burch" <me@michaelburch.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013172703.12273-1-me@michaelburch.net>
References: <20261013172703.12273-1-me@michaelburch.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:42:21 +0000
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
- [High] drm/msm/dpu: unbalanced frame_pending decrements in clone mode
--

commit 8cc8441c63a33addc5000cc2ffb1005c0a8221b2
Author: Michael Burch <me@michaelburch.net>

drm/msm/dpu: count the pending frame before kicking it off

This commit moves the frame_pending counter increment to precede the encoder
kickoff to fix an issue where a frame completing quickly could miss the
increment. It introduces dpu_crtc_count_pending_frame() and calls it before
kickoffs in both clone mode and normal mode.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 42d0a529b4d51..81282a8a5d9d1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
[ ... ]
> @@ -1062,6 +1075,8 @@ static int dpu_crtc_kickoff_clone_mode(struct drm_c=
rtc *crtc)
> =20
>  	dpu_vbif_clear_errors(dpu_kms);
> =20
> +	dpu_crtc_count_pending_frame(crtc);
> +
>  	/*
>  	 * Kickoff real time encoder last as it's the encoder that
>  	 * will do the flush
>  	 */
>  	dpu_encoder_kickoff(wb_encoder);
>  	dpu_encoder_kickoff(rt_encoder);

[Severity: High]
Does this code introduce an unbalanced decrement of frame_pending?

In dpu_crtc_kickoff_clone_mode(), dpu_crtc_count_pending_frame() increments
frame_pending once per CRTC commit. However, the function subsequently kicks
off both wb_encoder and rt_encoder independently.

When they complete, both encoders independently trigger
dpu_encoder_frame_done_callback(), queueing two separate
DPU_ENCODER_FRAME_EVENT_DONE events to the CRTC:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_frame_done_callback=
() {
	if (!dpu_enc->frame_busy_mask[0]) {
		...
		dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_FRAME_DONE);
		if (dpu_enc->crtc)
			dpu_crtc_frame_event_cb(dpu_enc->crtc, event);
	}
}

The worker then drops the counter on each DONE event:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_frame_event_work() {
	...
	} else if (atomic_dec_return(&dpu_crtc->frame_pending) =3D=3D 0) {
		/* release bandwidth and other resources */
		trace_dpu_crtc_frame_event_done(DRMID(crtc), fevent->event);
		dpu_core_perf_crtc_release_bw(crtc);
	}
	...
}

If multiple clone-mode commits are interleaved, could the second event from=
 an
earlier commit arrive after the next commit sets frame_pending to 1?

This would cause the worker to decrement the count to 0 and release
system memory bandwidth prematurely before the real-time encoder has actual=
ly
finished rendering the next commit. This might lead to FIFO underflows,
visual artifacts, or display hangs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172703.1227=
3-1-me@michaelburch.net?part=3D1
