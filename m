Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF32606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKnMQpdw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA7410FDD9;
	Thu, 26 Nov 2026 06:58:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0404110FDD9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7AD740E92;
 Thu, 26 Nov 2026 06:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413531F000C6;
 Thu, 26 Nov 2026 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676316;
 bh=tI74qM0eo3UMT0/XqsvnGMzTxZ3jb9Q5+XifCi1klaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iKnMQpdwh9x4ZQFghcZJlUAMDPhvwxgz+rg1+yQE1VnTvFiJQ6GR79TdSAwZRByxg
 ltvm5QWZWUWnb3u9FwNth+Muf4MlMuHzUi3Bvu0p5WmuNz+b/oXDeESRgwJGJYrK1Q
 2rYrNH8xI15x67F8sI2CiZS6StWAogrnAirQiKKG+pUdtlwBh/AohznfCm7TrHMGjy
 TWukN+Bn6Mi69x66vwLRHObNSNmNYipq+IJsFmuarslzoN2aTp/dKrjODjfaCU6Pus
 JZp4OIb9faELRwjft5UbxdHIUJrtj2baYwS3Krg0KPRC6jVz0DXJOs7/3JTLZmtveq
 vaZt83OA/zSEg==
Message-ID: <sashiko-outbox-234918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/21] drm/msm/dcp: Add DCP CRTCs
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-10-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-10-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:58:35 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] drm/msm/dcp: software vblank count returned in
  dcp_crtc_get_vblank_counter()
- [Medium] drm/msm/dcp: stale timestamp returned in
  dcp_crtc_get_vblank_timestamp()
- [Medium] drm/msm/dcp: skipped drm_crtc_vblank_on() in
  dcp_crtc_atomic_enable()
- [Medium] drm/msm/dcp: pending_seq_id race and underflow in
  dcp_crtc_commit_kickoff()
- [Medium] drm/msm/dcp: missing height and inactive-CRTC checks in
  dcp_crtc_atomic_check()
- [Medium] drm/msm/dcp: stale bandwidth vote when planes hide in
  dcp_crtc_atomic_begin()
- [Medium] drm/msm/dcp: per-frame sync autorefresh stall and redundant
  ROI HFI commands
- [Medium] drm/msm/dcp: async workqueue deferral and session race in
  dcp_crtc_vblank()
- [Low] drm/msm/dcp: unused fields and inaccurate lock comment in struct
  dcp_crtc
--

commit 2a044a474b64e69e569183925ccbd150a8cf4b9c
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP CRTCs

This commit adds DRM CRTC objects for firmware-owned DCP displays, including
session tracking, display topology ROI setup, atomic commit handling, and
HFI vblank callbacks.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp=
/dcp_crtc.c
> new file mode 100644
> index 0000000000000..512da8c4ddbcb
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> @@ -0,0 +1,665 @@

[ ... ]

> +	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
> +		ret =3D dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
> +					  cstate->dram_ib,  cstate->dram_ab,
> +					  cstate->llcc_ib,  cstate->llcc_ab,
> +					  cstate->core_clk);
> +		if (ret) {
> +			cstate->hfi_error =3D ret;
> +			return;
> +		}
> +	}

[Severity: Medium]
Does this leave the previous bandwidth and clock votes active in firmware
when all planes on an active CRTC are disabled or clipped off-screen?
When the aggregated cstate->core_clk and cstate->dram_ib drop to 0 while
the CRTC remains active, dcp_hfi_crtc_set_bw() is skipped and the zero vote
is never sent.

> +
> +	mixer_count =3D cstate->topology_mixer_count;
> +	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
> +		cstate->hfi_error =3D -EINVAL;
> +		return;
> +	}
> +	for (i =3D 0; i < mixer_count; i++) {
> +		struct drm_rect *roi =3D &cstate->mixer_roi[i];
> +
> +		if (drm_rect_width(roi) <=3D 0 || drm_rect_height(roi) <=3D 0) {
> +			drm_err(crtc->dev, "CRTC%u: invalid zero-sized LM%u ROI\n",
> +				dcp_crtc->display_id, i);
> +			cstate->hfi_error =3D -EINVAL;
> +			return;
> +		}
> +
> +		ret =3D dcp_hfi_crtc_set_resource(dcp_kms->hfi, session_id,
> +						i, drm_rect_width(roi),
> +						drm_rect_height(roi),
> +						roi->x1, roi->y1);
> +		if (ret) {
> +			cstate->hfi_error =3D ret;
> +			return;
> +		}
> +	}
> +
> +	ret =3D dcp_hfi_crtc_set_dest_roi(dcp_kms->hfi, session_id, 0, 0,
> +					crtc->state->adjusted_mode.hdisplay,
> +					crtc->state->adjusted_mode.vdisplay);
> +	if (ret) {
> +		cstate->hfi_error =3D ret;
> +		return;
> +	}
> +}
> +
> +static void dcp_crtc_atomic_flush(struct drm_crtc *crtc,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	unsigned long flags;
> +	u32 session_id;
> +	int ret;
> +
> +	/* Inactive CRTCs may carry an event but must not receive HFI updates. =
*/
> +	if (!crtc->state->enable || !crtc->state->active)
> +		goto flush_done;
> +	drm_dbg_driver(crtc->dev, "DCP_FLUSH CRTC%u mask=3D0x%x err=3D%d\n",
> +		       dcp_crtc->display_id, crtc->state->plane_mask,
> +		       cstate->hfi_error);
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id)) {
> +		drm_dbg_driver(crtc->dev,
> +			       "CRTC%u: atomic flush without HFI session\n",
> +			       dcp_crtc->display_id);
> +		goto flush_done;
> +	}
> +
> +	if (cstate->hfi_error)
> +		goto flush_done;
> +
> +	ret =3D dcp_hfi_crtc_set_scan_sequence_id(dcp_kms->hfi, session_id,
> +						++dcp_crtc->commit_seq_id);
> +	if (ret)
> +		goto flush_error;
> +
> +	ret =3D dcp_hfi_crtc_set_autorefresh(dcp_kms->hfi,
> +					   session_id, true, 1);

[Severity: Medium]
Does calling dcp_hfi_crtc_set_autorefresh() on every frame stall every
page flip and async cursor update on a synchronous VirtIO round-trip?

Unlike the asynchronous HFI commands on the commit path,
dcp_hfi_crtc_set_autorefresh() calls dcp_hfi_send_sync() with
HFI_TX_FLAGS_RESPONSE_REQUIRED and blocks in wait_for_completion_timeout()
before kickoff can proceed.  In addition, dcp_crtc_atomic_begin()
unconditionally sends mixer_count dcp_hfi_crtc_set_resource() packets and
one dcp_hfi_crtc_set_dest_roi() packet on every frame even when the mode
and mixer ROIs have not changed.

[ ... ]

> +	/* MSM serializes commits, so only one frame completion may be pending.=
 */
> +	if (atomic_cmpxchg(&dcp_crtc->pending_kickoff_cnt, 0, 1)) {
> +		drm_err(crtc->dev,
> +			"CRTC%u: frame completion already pending (dropped commit_seq_id=3D%u=
, in-flight pending_seq_id=3D%u)\n",
> +			dcp_crtc->display_id, dcp_crtc->commit_seq_id,
> +			dcp_crtc->pending_seq_id);
> +		cstate->hfi_error =3D -EBUSY;
> +		return;
> +	}
> +	dcp_crtc->pending_seq_id =3D dcp_crtc->commit_seq_id;
> +
> +	ret =3D dcp_hfi_display_commit(dcp_kms->hfi, session_id);
> +	if (ret) {
> +		drm_err(crtc->dev,
> +			"HFI commit failed for CRTC%u (session=3D%u): %d\n",
> +			dcp_crtc->display_id, session_id, ret);
> +		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
> +		wake_up(&dcp_crtc->frame_done_wq);
> +	}
> +}

[Severity: Medium]
Can dcp_crtc_commit_kickoff() race with dcp_crtc_hfi_frame_done_cb() on
pending_seq_id and pending_kickoff_cnt?

CPU0                                  CPU1 (VirtIO response)
dcp_crtc_atomic_flush()
  ++dcp_crtc->commit_seq_id
  dcp_hfi_crtc_set_scan_sequence_id()
  dcp_hfi_crtc_set_autorefresh()
dcp_crtc_commit_kickoff()
  atomic_cmpxchg(&pending_kickoff_cnt,
                 0, 1)
                                      dcp_crtc_hfi_frame_done_cb()
                                        if (sequence_id !=3D pending_seq_id)
                                          return;  <-- drops new seq_id
  pending_seq_id =3D commit_seq_id

Because commit_seq_id and autorefresh are already programmed in
dcp_crtc_atomic_flush(), or if a late completion for the previous frame
arrives before pending_seq_id is updated, dcp_crtc_hfi_frame_done_cb()
reads the stale pending_seq_id without locking: a callback for the new
sequence ID is dropped (stalling dcp_crtc_wait_for_commit_done() for
500ms), while a late callback for the old sequence ID matches and clears
the new commit's pending_kickoff_cnt early.

Also, if dcp_hfi_display_commit() fails after a racing callback already
decremented pending_kickoff_cnt to 0, the unconditional atomic_dec()
underflows pending_kickoff_cnt to -1 (and omits setting cstate->hfi_error =
=3D
ret), causing dcp_crtc_wait_for_commit_done() to time out.

[ ... ]

> +static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
> +				 struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	struct drm_crtc_state *crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc_state);
> +	u32 mixer_count;
> +	int ret;
> +
> +	drm_dbg_atomic(crtc->dev, "CRTC%u: atomic_check enable=3D%d active=3D%d=
 mode=3D%s\n",
> +		       crtc->base.id, crtc_state->enable, crtc_state->active,
> +		       crtc_state->mode.name[0] ? crtc_state->mode.name : "none");
> +
> +	if (!crtc_state->enable || !crtc_state->active)
> +		return 0;
> +
> +	mixer_count =3D cstate->topology_mixer_count;
> +	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
> +		drm_dbg_atomic(crtc->dev,
> +			       "CRTC%u: invalid mixer count %u (limit 1..%u)\n",
> +				crtc->base.id, mixer_count, DCP_MAX_MIXERS);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D dcp_crtc_setup_mixer_rois(crtc, crtc_state, cstate);
> +	if (ret)
> +		return ret;
> +
> +	if (crtc_state->adjusted_mode.hdisplay > dcp_kms->caps->max_width) {
> +		drm_dbg_atomic(crtc->dev,
> +			       "CRTC%u: mode width %d exceeds DCP max width %u\n",
> +			       crtc->base.id,
> +			       crtc_state->adjusted_mode.hdisplay,
> +			       dcp_kms->caps->max_width);
> +		return -E2BIG;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should dcp_crtc_mode_valid() and dcp_crtc_atomic_check() also validate
vdisplay against dcp_kms->caps->max_height, and run when crtc_state->enable
is true even if crtc_state->active is false?

Neither function checks vdisplay against caps->max_height (and
dcp_crtc_setup_mixer_rois() does not reject vdisplay =3D=3D 0, leaving
zero-height ROI detection to dcp_crtc_atomic_begin()).  Returning early in
dcp_crtc_atomic_check() when !crtc_state->active also skips mixer ROI setup
and mode validation on an enabled but DPMS-off CRTC, which can allow an
invalid configuration to succeed until a later DPMS-on commit.

> +
> +static u32 dcp_crtc_get_vblank_counter(struct drm_crtc *crtc)
> +{
> +	return drm_crtc_vblank_count(crtc);
> +}

[Severity: High]
Does returning drm_crtc_vblank_count(crtc) from
drm_crtc_funcs.get_vblank_counter corrupt DRM vblank accounting and trigger
a warning in drm_update_vblank_count()?

get_vblank_counter is meant to return a raw hardware frame counter (or be
left NULL when the driver has none), whereas drm_crtc_vblank_count() reads
the cooked software counter vblank->count.  After store_vblank() sets
vblank->last =3D cur_vblank and increments vblank->count, the next non-IRQ
call to drm_update_vblank_count() sees cur_vblank !=3D vblank->last: with
max_vblank_count =3D=3D 0 this hits drm_WARN_ON_ONCE(dev, cur_vblank !=3D
vblank->last), and with max_vblank_count =3D=3D 0xffffffff it computes diff=
 =3D 1
and spuriously advances the vblank counter on every vblank enable and
disable.

> +
> +static bool dcp_crtc_get_vblank_timestamp(struct drm_crtc *crtc, int *ma=
x_error,
> +					  ktime_t *vblank_time, bool in_vblank_irq)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	u64 timestamp_ns =3D READ_ONCE(dcp_crtc->hw_vblank_timestamp_ns);
> +
> +	if (!timestamp_ns)
> +		return false;
> +
> +	*vblank_time =3D ns_to_ktime(timestamp_ns);
> +	return true;
> +}

[Severity: Medium]
Does returning the cached hw_vblank_timestamp_ns when in_vblank_irq is
false expose stale timestamps to DRM vblank and async commit scheduling?

hw_vblank_timestamp_ns is only updated when an HFI VSYNC event arrives and
is never cleared in dcp_crtc_atomic_disable().  When callers query
get_vblank_timestamp() outside vblank IRQ context (such as
drm_crtc_next_vblank_start() in msm_atomic_commit_tail() or
drm_reset_vblank_timestamp() during drm_crtc_vblank_on()), they receive the
timestamp from the last VSYNC before vblanks or the CRTC were disabled,
causing async commit timers to expire immediately and timestamp-based
vblank diffing in drm_update_vblank_count() to jump the vblank counter.

> +
> +static void dcp_crtc_atomic_enable(struct drm_crtc *crtc,
> +				   struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id))
> +		return;
> +
> +	ret =3D dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
> +					  HFI_MODE_DPMS_ON);
> +	if (ret) {
> +		drm_err(crtc->dev, "CRTC%u: DPMS ON failed: %d\n",
> +			to_dcp_crtc(crtc)->display_id, ret);
> +		cstate->hfi_error =3D ret;
> +	}
> +
> +	drm_crtc_vblank_on(crtc);
> +}

[Severity: Medium]
If dcp_crtc_get_session() returns false here, does skipping
drm_crtc_vblank_on(crtc) underflow vblank->refcount later in the commit?

Because crtc->state->active is true, msm_atomic_commit_tail() still runs
vblank_get() followed by vblank_put() on this CRTC.  With vblank->inmodeset
still set, drm_crtc_vblank_get() fails with -EINVAL without incrementing
vblank->refcount, and the unconditional drm_crtc_vblank_put() in
vblank_put() drops the inmodeset reference to 0.

[ ... ]

> +static const struct drm_crtc_funcs dcp_crtc_funcs =3D {
> +	.set_config             =3D drm_atomic_helper_set_config,
> +	.page_flip              =3D drm_atomic_helper_page_flip,
> +	.atomic_create_state    =3D dcp_crtc_atomic_create_state,
> +	.atomic_duplicate_state =3D dcp_crtc_atomic_duplicate_state,
> +	.atomic_destroy_state   =3D dcp_crtc_atomic_destroy_state,
> +	.enable_vblank          =3D msm_crtc_enable_vblank,
> +	.disable_vblank         =3D msm_crtc_disable_vblank,

[Severity: Medium]
Can deferring enable_vblank and disable_vblank through
msm_crtc_enable_vblank() and msm_crtc_disable_vblank() race with HFI
session teardown or frame kickoff?

dcp_crtc_vblank() already uses the atomic-safe
dcp_hfi_display_event_register_async() and
dcp_hfi_display_event_deregister_async() helpers.  Routing it through
priv->kms->wq allocates a GFP_ATOMIC work item on every vblank toggle,
discards errors from dcp_crtc_vblank(), allows flush_commit() to trigger a
frame before the worker registers HFI_EVENT_VSYNC, and lets a disable work
item queued by drm_crtc_vblank_off() in dcp_crtc_atomic_disable() run
after the session has been cleared or replaced.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.h b/drivers/gpu/drm/msm/dcp=
/dcp_crtc.h
> new file mode 100644
> index 0000000000000..b6a435a686c53
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
> @@ -0,0 +1,85 @@

[ ... ]

> +	/* Protects CRTC-local vblank and commit state. */
> +	spinlock_t        spin_lock;
> +	u32     vblank_cb_count;
> +	ktime_t vblank_cb_time;
> +	/* Latest firmware-reported VSYNC timestamp; 0 until the first HFI VSYN=
C. */
> +	u64     hw_vblank_timestamp_ns;
> +	bool    enabled;

[Severity: Low]
This isn't a bug, but enabled is unused, vblank_cb_count and
vblank_cb_time are only ever written in dcp_crtc_vblank_callback() and
never read, and spin_lock only protects session_id and session_valid rather
than vblank or commit state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D10
