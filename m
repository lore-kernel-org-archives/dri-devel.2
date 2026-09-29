Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D86C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148C510E538;
	Tue, 29 Sep 2026 04:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CR7D+D6f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267F610E538
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90EBB60210;
 Tue, 29 Sep 2026 04:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7E41F000FF;
 Tue, 29 Sep 2026 04:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657669;
 bh=JYSp8DU2irz/QzTwHxJeroylidm18ydfRvWGBAF0/hA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CR7D+D6fBgsYrjcxnArMlagTFERmf4PYaAFVjE233kPTKXTZlZ8Hc33c9VpFaM/UL
 5HRUZN+rl7/qrLQinZcp0y6uCN53XdLyOss1QIc/F4zZYPBlK7F1aQj5tOtkg8G0jF
 dt6HeejQtAJ6lOLFzC8XNBR8MZI59cU99jlhwW7vXdv2sAEDcoGJitJCAVWDimm53y
 inybNLe+dmisak5QzktFBQ925WeBF3rMyU7EeHhrW1JLgSg/72NWqfyE7t8k7SxwLE
 vaNdES7jMHL5Bx2+vtkxyLvVFfM/VtADY4Bjw1u4nIoV68HVWGhmzsCJ3DHY1Ezngy
 gvIIuCp86atKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/35] drm/msm/dp: add atomic stream handling for MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-24-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-24-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:54:28 +0000
Message-Id: <20260929045429.1C7E41F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: MST topology state corruption on early return in atomi=
c_enable
- [High] drm/msm/dp: sleeping in atomic context via mutex_lock in encoder c=
allbacks
- [High] drm/msm/dp: NULL pointer dereference in msm_dp_mst_remove_payload
- [High] drm/msm/dp: kernel panic from division by zero in drm_dp_atomic_fi=
nd_time_slots
- [High] drm/msm/dp: hardware desynchronization and crash on atomic_enable =
failure
--

commit b9a18785615c02ba155b20dae0aa027c5d95b815
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add atomic stream handling for MST

This commit adds the atomic check, enable, and disable operations for MST
streams. It reserves VC payload bandwidth based on the negotiated link
parameters and updates the MST payload when enabling or disabling streams. =
The
patch also serializes access to the shared MST link state.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 533109b4365c3..933dbfd30b567 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2747,16 +2747,29 @@ static const struct drm_encoder_helper_funcs dpu_=
encoder_helper_funcs =3D {
>  static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
>  				      struct drm_atomic_commit *state)
>  {
> +	if (msm_dp_mst_stream_enable(enc, state))
> +		return;
> +

[Severity: High]
Does this early return cause hardware desynchronization if
msm_dp_mst_stream_enable() fails?

The DRM core ignores atomic_enable failures, which means the state will
transition to active. The enable sequence bails out on error here, skipping=
 the
virtual encoder initialization in dpu_encoder_virt_atomic_enable().

>  	dpu_encoder_virt_atomic_enable(enc, state);
>  }
> =20
>  static void dpu_encoder_mst_atomic_disable(struct drm_encoder *enc,
>  				       struct drm_atomic_commit *state)
>  {
> +	msm_dp_mst_stream_disable(enc, state);
>  	dpu_encoder_virt_atomic_disable(enc, state);

[Severity: High]
Does this unconditionally access hardware during teardown, assuming
dpu_encoder_virt_atomic_enable() had succeeded?

Since the virtual encoder might never have been initialized or clocked if t=
he
early return in dpu_encoder_mst_atomic_enable() was taken, this call attemp=
ts
to access unclocked hardware registers (e.g., waiting for TX completion) wh=
ich
can result in a bus error, system hang, or kernel crash.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 88687b97ed6e6..fd8fd6fd10bdf 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -133,6 +136,45 @@ static int msm_dp_mst_connector_atomic_check(struct =
drm_connector *connector,
[ ... ]
> +static void msm_dp_mst_remove_payload(struct msm_dp_mst *mst,
> +				      struct drm_dp_mst_topology_state *mst_state,
> +				      struct msm_dp_panel *panel)
> +{
> +	struct msm_dp_panel *dp_panel;
> +	struct drm_dp_mst_atomic_payload *payload;
> +	int i;
> +
> +	msm_dp_display_set_stream_info(mst->msm_dp, panel, 0, 0, 0);
> +
> +	/* Apply the slot shift to the remaining payloads. */
> +	for (i =3D 0; i < mst->max_streams; i++) {
> +		dp_panel =3D mst->mst_encoders[i].dp_panel;
> +		if (dp_panel =3D=3D panel || !dp_panel->connector)
> +			continue;

[Severity: High]
Could this dereference a NULL pointer?

The mst->mst_encoders array is zero-initialized. If an encoder was never
attached to a specific index, dp_panel will be NULL.

The || operator evaluates left-to-right. If dp_panel is NULL, the condition
dp_panel =3D=3D panel evaluates to false, and the code immediately evaluates
!dp_panel->connector, which will dereference the NULL pointer.

> +
> +		payload =3D drm_atomic_get_mst_payload_state(mst_state,
[ ... ]
> +int msm_dp_mst_stream_enable(struct drm_encoder *encoder,
> +			      struct drm_atomic_commit *state)
> +{
[ ... ]
> +	int rc;
> +
> +	guard(mutex)(&mst->mst_lock);
> +

[Severity: High]
Does this acquire a sleeping lock inside an atomic context?

The DRM subsystem guidelines state that display encoder atomic_enable and
atomic_disable callbacks execute in atomic context where sleeping is strict=
ly
forbidden. This function is called from the atomic context via
dpu_encoder_mst_atomic_enable() and acquires a sleeping lock, which can cau=
se
scheduler violations, kernel warnings, and potential deadlocks.

> +	drm_connector_get(connector);
> +	panel->connector =3D connector;
> +
> +	rc =3D msm_dp_display_set_mode_helper(dp_display, state, encoder, panel=
);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u set_mode failed rc=3D%d\n", panel->stream_id, rc);
> +		return rc;
> +	}
> +

[Severity: High]
Does this early return bypass drm_dp_add_payload_part1()?

By returning early here, the MST payload state is left uninitialized for the
later disable path. Because the DRM core does not handle atomic_enable
failures, the commit completes and the payload's vc_start_slot remains -1.

> +	rc =3D msm_dp_display_prepare_link(dp_display);
> +	if (rc) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] stream:%u prepare_link failed rc=3D%d\n", panel->stream_id, rc=
);
> +		return rc;
> +	}
> +

[Severity: High]
Does this early return also bypass the required MST software state updates?

> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
[ ... ]
> +void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
> +			       struct drm_atomic_commit *state)
> +{
[ ... ]
> +	struct drm_dp_mst_atomic_payload *new_payload =3D
> +		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
> +
> +	guard(mutex)(&mst->mst_lock);
> +

[Severity: High]
Is this mutex acquisition also performed in the atomic disable path?

> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
> +
> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, =
new_payload);
> +

[Severity: High]
Does this unconditional cleanup execute during teardown regardless of wheth=
er
the enable succeeded?

If drm_dp_add_payload_part1() was bypassed during enable,
drm_dp_remove_payload_part2() will subtract old_payload->time_slots from
mgr->next_start_slot and shift all payloads with a vc_start_slot greater th=
an
-1. Because the payload count was never incremented, this underflows the
payload count and incorrectly shifts the slots of all active payloads,
permanently corrupting the shared MST topology manager state.

> +	msm_dp_mst_remove_payload(mst, new_mst_state, panel);
[ ... ]
> +void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
> +				    struct drm_atomic_commit *state)
> +{
[ ... ]
> +	struct msm_dp_panel *panel =3D msm_dp_mst_panel_from_encoder(mst, encod=
er);
> +
> +	guard(mutex)(&mst->mst_lock);
> +

[Severity: High]
Is this mutex acquisition also performed in the atomic post-disable path?

> +	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
[ ... ]
> +int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
[ ... ]
> +	mst_state =3D drm_atomic_get_mst_topology_state(crtc_state->state, &mst=
->mst_mgr);
> +	if (IS_ERR(mst_state))
> +		return PTR_ERR(mst_state);
> +
> +	if (!dfixed_trunc(mst_state->pbn_div)) {
> +		mst_state->pbn_div =3D
> +			drm_dp_get_vc_payload_bw(mst->link->link_caps.rate,
> +						 mst->link->link_caps.num_lanes);
> +	}
> +

[Severity: High]
Can this calculate the payload bandwidth without verifying if the link rate=
 is
valid, passing a zero divisor down to the DRM helpers?

If link_caps.rate is 0 (which can occur if the sink is disconnected or link
training failed prior to the atomic commit), drm_dp_get_vc_payload_bw() ret=
urns
0, setting pbn_div.full to 0.

The code then calls drm_dp_atomic_find_time_slots(), which executes
DIV_ROUND_UP(..., topology_state->pbn_div.full). Userspace can trigger an
atomic commit at any time via the DRM IOCTL, and doing so when the link rate
is 0 triggers a division by zero, which results in a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D24
