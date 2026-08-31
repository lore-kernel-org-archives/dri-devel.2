Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4764C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0076110E7C1;
	Mon, 31 Aug 2026 09:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L8SKWJDY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E55810E7C1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:48:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFB49404A4;
 Mon, 31 Aug 2026 09:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67DE1F000E9;
 Mon, 31 Aug 2026 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788169728;
 bh=s8ESPzLil4/QAQFHMtffG776k5xCag1CtZgBp1RT1FQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L8SKWJDYhdixAXSxu1qTvmllQUm8y/79zlwxak+3ne7eGhjWu3/ZUWoaOq/weZsd3
 9cjyk/ecXnAYpJkr05chgNkBEeagS3IyG3GM8SCm8yywuuvv4KTw9hJ1hUWggVOWbd
 YytNdh4sByXA5JOfe2DCoQCTbPFRwz2p+7aSlTKx8QQHDL28jwokXWnvNLMdmFTE3D
 MPf9KUHi1c1EXYei21r/YuuSvcMNifVeM3Y7xbR4K7+pFDTOa2cMxuXvGhUbwJnJWJ
 LINtDVHStj7xA/VX0MtOkYuPzBfvhJxWmJPElm/sJgEQ4G0Xh/UJ0ULww32EPOvQFZ
 LT7Ee0mTPzzTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/29] drm/msm/dp: add atomic stream handling for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-23-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-23-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:48:48 +0000
Message-Id: <20260831094848.A67DE1F000E9@smtp.kernel.org>
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
- [High] Acquiring a sleeping mutex lock and calling sleeping polling funct=
ions inside the encoder `atomic_enable` and `atomic_disable` callbacks caus=
es sleep-in-atomic bugs.
- [High] Premature call to `drm_dp_remove_payload_part2()` before hardware =
update and ACT check in `msm_dp_mst_stream_disable()`.
- [High] Early error returns in `msm_dp_mst_stream_enable()` corrupt intern=
al stream tracking and MST manager state.
--

commit c8eb7290bc454899af65ca1c4ce4e1f847647c68
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add atomic stream handling for MST

This patch adds atomic check, enable, and disable operations for MST
streams in the MSM DP driver. It reserves VC payload bandwidth, updates
payloads when toggling streams, and uses a mutex to serialize link state.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 93536b6936cbd..03f9c95ca6860 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -145,6 +160,152 @@ static int msm_dp_mst_encoder_stream_id(struct msm_=
dp_mst *mst,
>  	return -1;
>  }
> =20
> +void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
> +			      struct drm_atomic_commit *state)
> +{
[ ... ]
> +	struct drm_dp_mst_atomic_payload *payload =3D
> +		drm_atomic_get_mst_payload_state(mst_state, port);
> +	int rc;
> +
> +	guard(mutex)(&mst->mst_lock);

[Severity: High]
Does this acquire a sleeping mutex from an atomic context?

The DRM subsystem guidelines designate encoder atomic_enable and
atomic_disable callbacks as executing in an atomic context where sleeping
is strictly forbidden. A userspace modeset targeting an MST stream will
invoke msm_dp_mst_stream_enable() via dpu_encoder_mst_atomic_enable().

Can this lead to kernel warnings, priority inversion, and potential
system deadlocks?

> +
> +	drm_connector_get(connector);
> +	panel->connector =3D connector;
> +
> +	rc =3D msm_dp_display_set_mode_helper(dp_display, state, encoder, panel=
);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u set_mode failed rc=3D%d\n", panel->stream_id, rc);
> +		return;
> +	}
> +
> +	rc =3D msm_dp_display_prepare_link(dp_display);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u prepare_link failed rc=3D%d\n", panel->stream_id, rc=
);
> +		msm_dp_display_unprepare(dp_display);
> +		return;
> +	}

[Severity: High]
Are these early returns going to cause state corruption when the disable
path runs?

If msm_dp_display_prepare_link() fails, msm_dp_mst_stream_enable() returns
early before completing payload allocation. Since the atomic_enable
callback returns void, the DRM core still registers the encoder as active.

When atomic_disable is later called, msm_dp_mst_stream_disable() will
unconditionally decrement payload counts that were never incremented.
Could this lead to integer underflows in the MST topology manager state?

> +
> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
> +
> +	rc =3D drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
> +	if (rc)
> +		return;

[Severity: High]
Will this early return also cause similar underflow issues in the MST
manager state if drm_dp_add_payload_part1() fails? The atomic_disable
path will still run later and unconditionally decrement the payload count.

> +
> +	msm_dp_display_set_stream_info(mst->msm_dp, panel,
> +				       payload->vc_start_slot,
> +				       payload->time_slots, payload->pbn);
> +	drm_dbg_kms(dp_display->drm_dev,
> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
> +		    panel->stream_id, payload->vc_start_slot,
> +		    payload->time_slots, payload->pbn);
> +
> +	msm_dp_display_enable_helper(dp_display, panel);
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);

[Severity: High]
Is it safe to call drm_dp_check_act_status() from within the atomic_enable
path?

This is a hardware polling function that can sleep for up to 3 seconds.
Since msm_dp_mst_stream_enable() runs in an atomic context, will this
cause sleep-in-atomic bugs?

> +
> +	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
> +}
> +
> +void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
> +			       struct drm_atomic_commit *state)
> +{
[ ... ]
> +	struct drm_dp_mst_atomic_payload *new_payload =3D
> +		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
> +
> +	guard(mutex)(&mst->mst_lock);

[Severity: High]
Does this acquire a sleeping mutex from an atomic context?

Similar to the enable path, msm_dp_mst_stream_disable() is called during
encoder atomic_disable callbacks, which strictly forbid sleeping.

> +
> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
> +
> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, =
new_payload);

[Severity: High]
Is this call to drm_dp_remove_payload_part2() premature?

This API call frees the VCPI slots in the software topology manager before
msm_dp_display_disable_helper() executes and the Allocation Change Trigger
is acknowledged by the sink.

Could this allow concurrent atomic commits to reallocate the same slots
while the hardware is still executing the removal sequence, leading to
topological corruption?

> +
> +	msm_dp_display_set_stream_info(mst->msm_dp, panel, 0, 0, 0);
> +	drm_dbg_kms(mst->msm_dp->drm_dev,
> +		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
> +		    panel->stream_id, new_payload->vc_start_slot,
> +		    new_payload->time_slots, new_payload->pbn);
> +
> +	msm_dp_display_disable_helper(mst->msm_dp, panel);
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D23
