Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D6606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI48tDqs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ABD10E57D;
	Tue, 17 Nov 2026 07:36:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9E110E57D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A879B4117F;
 Tue, 17 Nov 2026 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEB71F000C4;
 Tue, 17 Nov 2026 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794900995;
 bh=oxtOW+8o1OWMqy2mhC7tTgcQdorkqjn7+JHZw5UPVxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kI48tDqs1gE3ED5a5doEGM4R6MLtdqhWt2oYFg1+3xVLqeoeZoOCi89Mk4az2u3Hs
 PoZkRiw9sHefCEgBw8Hd24sdDTkhX1GZUbBj8qw0mEw946BJQy2kjVULLQ58q+WzHk
 KtTPtwvcCEUPB7NZ2PO0FbYN4v51dSwFEO6taTD3GBOCQLhoAinSsnOjYvs6Jf502+
 Cnh4aXtg9AdZHXs3xniwFc81Bb4TgNh0MifPQ2Iv+BvHQTNG2WaudVeQU8/UfmMDwu
 /EmiwpKr7/v84hyoEtlLH4cg0FWQvgPZ6gx3RogENyfdrVOyEJVjKkg4qObhGtzUyM
 9FrwafenQ2kig==
Message-ID: <sashiko-outbox-218361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/cix: add Sky1 DisplayPort transmitter driver
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261117064552.85256-3-Luo.Liu@cixtech.com>
References: <20261117064552.85256-1-Luo.Liu@cixtech.com>
 <20261117064552.85256-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:36:34 +0000
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

Thank you for your contribution! Sashiko AI review found 22 potential
issues to consider:
- [High] drm/cix/dptx: wrong callback signature for
  cix_dptx_dev_release()
- [High] drm/cix/dptx: unlocked crtc->state access in cix_dp_get_mode()
  on HPD IRQ
- [High] drm/cix/dptx: __cix_dp_detect() ignores connect error and skips
  disconnect
- [High] drm/cix/dptx: suspend race in cix_dp_pm_prepare() and lost OOB
  HPD
- [High] drm/cix: uninitialized connector->fwnode breaks USB-C OOB
  hotplug events
- [High] drm/cix: premature drm_connector_cleanup() in
  cix_dp_bridge_detach()
- [High] drm/cix: use-after-free and destroyed mutex lock after device
  unbind
- [Medium] drm/cix/dptx: broken VSC SDP colorimetry in
  cix_dp_needs_vsc_sdp()
- [Medium] drm/cix/dptx: bridge PM callbacks toggle drm_device polling
- [Medium] drm/cix/dptx: DPTX_STATE_SUSPENDED blocks
  cix_dpcd_power_down() on suspend
- [Medium] drm/cix/dptx: CIX_DPTX_ENHANCED_FRAMING_ENABLE not cleared in
  cix_dp_link_configure()
- [Medium] drm/cix/dptx: hpd_event_work queued on multiple workqueues
- [Medium] drm/cix: unhandled DRM_BRIDGE_ATTACH_NO_CONNECTOR in
  cix_dp_bridge_attach()
- [Medium] drm/cix: force_hpd overwritten during suspend in
  cix_dp_oob_hotplug_event()
- [Medium] drm/cix: overly strict minbpp in
  cix_dp_connector_mode_valid() for fallback formats
- [Medium] drm/cix: late crtc_state->mode_changed assignment in
  cix_dp_bridge_atomic_check()
- [Medium] drm/cix: unlocked sink cap reads in atomic_check/mode_valid
  and HPD status race
- [Medium] drm/cix: unchecked connector->state allocation in
  cix_dp_connector_create()
- [Medium] drm/cix: broken sync polarity flags and pixel clock check in
  cix_dp_adjust_mode()
- [Medium] drm/cix: unlocked drm_helper_probe_detect() in
  cix_dp_hpd_event_work_func()
- [Low] drm/cix: missing error on RBR downshift in
  cix_dp_mode_configure()
- [Low] drm/cix: missing content_type check in
  cix_dp_bridge_atomic_check()
--

commit 91969ec67c0ae274ce458c0bfa9354271adf193d
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/cix: add Sky1 DisplayPort transmitter driver

This commit adds a DRM bridge driver for the CIX Sky1 DisplayPort
transmitter, handling DP link training, EDID probing, mode validation,
YCbCr 4:2:0 output, and hotplug events.

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.c b/drivers/gpu/drm/cix/dp=
tx/cix_dptx.c
> new file mode 100644
> index 0000000000000..882c4a92f5118
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c
[ ... ]
> +static int cix_dp_mode_configure(struct cix_dp *dp, int pclk, u8 bw, u8 =
bpp,
> +				 bool downshift)
> +{
> +	int max_rate =3D dp->link_config.max_rate;
> +	int lane_cnt;
> +	int bw_code;
> +	int link_rate;
> +
> +	if (!downshift)
> +		bw_code =3D bw;
> +	else
> +		switch (bw) {
> +		case DP_LINK_BW_8_1:
> +			bw_code =3D DP_LINK_BW_5_4;
> +			break;
> +		case DP_LINK_BW_5_4:
> +			bw_code =3D DP_LINK_BW_2_7;
> +			break;
> +		case DP_LINK_BW_2_7:
> +			bw_code =3D DP_LINK_BW_1_62;
> +			break;
> +		case DP_LINK_BW_1_62:
> +			bw_code =3D DP_LINK_BW_1_62;
> +			break;

[Severity: Low]
Should downshifting from DP_LINK_BW_1_62 return -EINVAL instead of keeping
DP_LINK_BW_1_62 and returning 0?

cix_dp_train_loop() only breaks out of its inner downshift loop when
cix_dp_mode_configure() returns a negative error, so returning 0 causes it
to repeat training at 1.62 Gbps up to four times per outer loop iteration.

[ ... ]
> +static int cix_dp_link_configure(struct cix_dp *dp)
> +{
> +	u8 bw_code =3D dp->mode.bw_code;
> +	u8 lane_cnt =3D dp->mode.lane_cnt;
> +	int ret;
> +
> +	cix_dp_write(dp, CIX_DPTX_LANE_COUNT_SET, lane_cnt);
> +
> +	if (dp->caps.enhanced_framing) {
> +		cix_dp_write(dp, CIX_DPTX_ENHANCED_FRAMING_ENABLE, 1);
> +		lane_cnt |=3D DP_LANE_COUNT_ENHANCED_FRAME_EN;
> +	}

[Severity: Medium]
Does cix_dp_link_configure() leave CIX_DPTX_ENHANCED_FRAMING_ENABLE set to
1 when switching to a sink that does not support enhanced framing?

cix_dp_core_off() does not reset the transmitter when a stream is disabled,
so if a sink without enhanced framing is connected after one that enabled
it, the transmitter keeps sending enhanced framing while
DP_LANE_COUNT_ENHANCED_FRAME_EN is cleared in the sink's DPCD.

[ ... ]
> +	value =3D (mode->htotal - mode->hdisplay) *
> +		(dp->mode.link_rate / 40) * 9 / mode->clock;
> +
> +	cix_dp_write(dp, CIX_DPTX_SECONDARY_DATA_WINDOW(stream_id), value);
> +	cix_dp_write(dp, CIX_DPTX_DATA_CONTROL(stream_id), data_control);
> +	cix_dp_write(dp, CIX_DPTX_USER_PIXEL_COUNT(stream_id),
> +		     dp->pixel_per_cycle);
> +}
> +
> +static struct drm_display_mode *cix_dp_get_mode(struct cix_dp *dp,
> +						int stream_id)
> +{
> +	struct drm_crtc *crtc;
> +
> +	if (stream_id < 0 || stream_id >=3D dp->max_streams)
> +		return NULL;
> +
> +	if (!dp->active_panels[stream_id] || !dp->bridge.encoder)
> +		return NULL;
> +
> +	crtc =3D dp->bridge.encoder->crtc;
> +	if (!crtc || !crtc->state)
> +		return NULL;
> +
> +	return &crtc->state->adjusted_mode;
> +}
> +
> +/*
> + * Link retraining can lower the bandwidth or the lane count while a str=
eam
> + * is already enabled. TU and timing were programmed for the previous li=
nk,
> + * so write them again from the trained mode.
> + */
> +static void cix_dp_update_active_streams(struct cix_dp *dp)
> +{
> +	struct cix_dp_panel *panel;
> +	struct drm_display_mode *mode;
> +	int bpp;
> +	int i;
> +
> +	for (i =3D 0; i < dp->max_streams; i++) {
> +		panel =3D dp->active_panels[i];
> +		if (!panel || !panel->connector)
> +			continue;
> +
> +		mode =3D cix_dp_get_mode(dp, i);
> +		if (!mode)
> +			continue;
> +
> +		bpp =3D panel->connector->config.bpp;
> +		cix_dp_mode_set_transfer_unit(dp, panel->source_id, mode,
> +					      bpp);
> +		cix_dp_mode_set_timing(dp, panel->source_id, mode, bpp);
> +	}
> +}

[Severity: High]
Can cix_dp_get_mode() cause a use-after-free on crtc->state or a
divide-by-zero in cix_dp_mode_set_timing() when called from
cix_dp_hpd_irq_work_func()?

cix_dp_hpd_irq_work_func() runs under dp->session_lock without holding
crtc->mutex, while a concurrent atomic commit (such as a page flip or CRTC
disable) swaps and frees crtc->state without taking dp->session_lock:

CPU0 (atomic commit)              CPU1 (hpd_irq_work)
drm_atomic_helper_commit()        cix_dp_hpd_irq_work_func()
                                    cix_dp_train_loop()
                                      cix_dp_update_active_streams()
                                        mode =3D cix_dp_get_mode()
                                          return &crtc->state->adjusted_mode
  drm_atomic_helper_swap_state()
  drm_atomic_commit_put()
    kfree(old_crtc_state)
                                        cix_dp_mode_set_timing(..., mode, .=
..)
                                          ... / mode->clock  <-- UAF

If a CRTC disable commit has just swapped in a disabled crtc->state before
cix_dp_bridge_atomic_disable() acquires dp->session_lock, mode->clock is 0
and cix_dp_mode_set_timing() also divides by zero. Caching adjusted_mode in
struct cix_dp under dp->session_lock during cix_dp_bridge_mode_set() would
avoid touching crtc->state from the HPD worker.

[ ... ]
> +static ssize_t cix_dp_aux_transfer(struct drm_dp_aux *aux,
> +				   struct drm_dp_aux_msg *msg)
> +{
> +	struct cix_dp *dp =3D container_of(aux, struct cix_dp, aux);
> +	size_t to_access =3D 0;
> +	size_t accessed_bytes =3D 0;
> +	u32 reply_mask;
> +	u32 reply_ack;
> +	u32 state;
> +	ssize_t ret;
> +
> +	/*
> +	 * AUX has its own lock instead of session_lock: the driver calls
> +	 * drm_dp_*() helpers while holding session_lock, and those helpers
> +	 * re-enter aux->transfer. host_init() and host_deinit() take this
> +	 * lock while they enable or gate the APB clock.
> +	 */
> +	mutex_lock(&dp->aux_lock);
> +
> +	state =3D READ_ONCE(dp->state);
> +	if (!(state & DPTX_STATE_INITIALIZED) ||
> +	    (state & DPTX_STATE_SUSPENDED) ||
> +	    (!cix_dp_get_hpd_state(dp) && !READ_ONCE(dp->aux_ignore_hpd))) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}

[Severity: Medium]
Does rejecting AUX transfers when DPTX_STATE_SUSPENDED is set prevent
cix_dpcd_power_down() from putting the sink into D3 during suspend and
shutdown?

cix_dp_pm_prepare() sets DPTX_STATE_SUSPENDED before cix_dp_host_deinit()
or the KMS atomic disable path calls cix_dp_core_off() ->
cix_dpcd_power_down(). Because DPTX_STATE_INITIALIZED remains set while
apb_clk is enabled, checking only !(state & DPTX_STATE_INITIALIZED) here
would allow the D3 write to complete before cix_dp_host_deinit() gates the
clock.

[ ... ]
> +static bool cix_dp_needs_vsc_sdp(enum cix_dp_format output_format,
> +				 int colorspace)
> +{
> +	if (output_format =3D=3D CIX_DP_FORMAT_YCBCR420)
> +		return true;
> +
> +	switch (colorspace) {
> +	case DRM_MODE_COLORIMETRY_SYCC_601:
> +	case DRM_MODE_COLORIMETRY_OPYCC_601:
> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}

[Severity: Medium]
Why does cix_dp_needs_vsc_sdp() omit the DCI-P3 and xvYCC colorimetries
that cix_dp_vsc_colorimetry() handles?

Because the non-VSC path in cix_dp_set_misc() never writes colorimetry bits
to MISC0, selecting DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65,
DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER, DRM_MODE_COLORIMETRY_XVYCC_601, or
DRM_MODE_COLORIMETRY_XVYCC_709 on an RGB, YCbCr 4:4:4, or YCbCr 4:2:2
stream leaves VSC SDP disabled and makes the DCI-P3 cases in
cix_dp_vsc_colorimetry() unreachable for RGB.

In addition, cix_dp_vsc_colorimetry() maps colorspace without checking
whether it matches the active pixel format, so YCbCr 4:2:0 with DCI-P3
emits 0x4 (which encodes sYCC601 in a YCbCr VSC SDP), RGB with BT2020_YCC
emits 0x7 (Reserved for RGB), and a YCbCr fallback with BT2020_RGB emits
0x6 (BT2020_CYCC instead of BT2020_YCC).

[ ... ]
> +static int __cix_dp_detect(struct cix_dp *dp)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&dp->session_lock);
> +
> +	/*
> +	 * This task is the HPD worker and suspend is already published.
> +	 * Leave the IRQ and the host down. A modeset on another task still
> +	 * goes through cix_dp_resume_locked().
> +	 */
> +	if ((dp->state & DPTX_STATE_SUSPENDED) &&
> +	    READ_ONCE(dp->hpd_worker) =3D=3D current)
> +		return -EBUSY;
> +
> +	ret =3D cix_dp_resume_locked(dp);
> +	if (ret)
> +		return ret;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		dev_warn_once(dp->dev, "detect with uninitialized host\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!cix_dp_get_hpd_state(dp))
> +		return -ENODEV;
> +
> +	cix_dp_handle_connect_locked(dp);
> +
> +	return 0;
> +}

[Severity: High]
Does __cix_dp_detect() report a connected sink even when
cix_dp_handle_connect_locked() fails to read the DPCD, and leave
DPTX_STATE_CONNECTED set when HPD is deasserted?

If cix_dp_panel_read_sink_caps() fails over AUX, __cix_dp_detect() still
returns 0, so cix_dp_connector_detect() reports connector_status_connected
with zeroed dp->caps and stale dp->dpcd, and the next modeset fails with
-ENODEV in cix_dp_prepare(). Conversely, when !cix_dp_get_hpd_state(dp),
returning -ENODEV without calling cix_dp_handle_disconnect_locked(dp)
leaves DPTX_STATE_CONNECTED set across an unplug/replug if a poll runs
before hpd_event_work, causing cix_dp_handle_connect_locked() to skip
reading the new sink's DPCD.

[ ... ]
> +	drm_helper_probe_detect(&dp->connector.base, NULL, false);
> +
> +	cix_dp_session_lock(dp);
> +	status =3D dp->status;
> +	if (READ_ONCE(dp->hpd_stopped) || !dp->dp_panel.connector ||
> +	    !cix_dp_regs_accessible(dp)) {
> +		cix_dp_session_unlock(dp);
> +		goto out;
> +	}
> +	if (status =3D=3D connector_status_connected)
> +		cix_dp_handle_connect_locked(dp);
> +	else
> +		cix_dp_handle_disconnect_locked(dp);
> +	cix_dp_session_unlock(dp);
> +
> +	if (old_status !=3D status && dp->drm)
> +		drm_helper_hpd_irq_event(dp->drm);

[Severity: Medium]
Why does cix_dp_hpd_event_work_func() call drm_helper_probe_detect()
without holding dp->drm->mode_config.mutex before calling
drm_helper_hpd_irq_event()?

When ctx is NULL, drm_helper_probe_detect() only takes
mode_config.connection_mutex while reading connector->status and
incrementing connector->epoch_counter, which are protected by
mode_config.mutex, and then drm_helper_hpd_irq_event() immediately runs
detection a second time under mode_config.mutex. Moreover, if
cix_dp_replay_deferred_hotplug() schedules hpd_event_work during
cix_dp_bridge_attach() before the KMS driver calls
drm_kms_helper_poll_init(), the first drm_helper_probe_detect() updates
dp->status while drm_helper_hpd_irq_event() bails out because
!poll_enabled, leaving connector->status unknown and suppressing subsequent
hotplug events because old_status =3D=3D status.

[ ... ]
> +	if (value & CIX_DPTX_INTERRUPT_HPD_EVENT)
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
> +
> +	if (value & CIX_DPTX_INTERRUPT_HPD_IRQ)
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);

[Severity: Medium]
Can queuing dp->hpd_event_work onto system_freezable_wq here while
cix_dp_replay_deferred_hotplug(), cix_dp_pm_complete(), and
cix_dp_oob_hotplug_event() use schedule_delayed_work() allow
cix_dp_hpd_event_work_func() to run concurrently on two CPUs?

schedule_delayed_work() queues onto system_wq, and workqueue non-reentrancy
only prevents concurrent execution when a work item is queued onto the same
workqueue it is currently running on. Two instances of
cix_dp_hpd_event_work_func() can therefore run simultaneously and race on
dp->hpd_worker (and cix_dp_oob_hotplug_event() also queues
dp->sw_hpd_irq_work onto system_wq instead of system_freezable_wq).

[ ... ]
> +static int cix_dp_pm_prepare(struct cix_dp *dp)
> +{
> +	if (dp->drm && dp->drm->mode_config.poll_enabled)
> +		drm_kms_helper_poll_disable(dp->drm);

[Severity: Medium]
Should a bridge driver's PM callbacks call drm_kms_helper_poll_disable()
and drm_kms_helper_poll_enable() on the shared struct drm_device?

Connector polling is device-wide state managed by the KMS master driver;
calling drm_kms_helper_poll_enable(dp->drm) in cix_dp_pm_complete()
re-enables polling across the whole drm_device as soon as the first
cix-dptx bridge instance resumes, while the display controller and sibling
bridges may still be suspended.

> +
> +	cix_dp_irq_off(dp);
> +
> +	/*
> +	 * Publish SUSPENDED before the cancel. oob and a running HPD
> +	 * worker then leave the IRQ and the host down.
> +	 */
> +	cix_dp_session_lock(dp);
> +	dp->state |=3D DPTX_STATE_SUSPENDED;
> +	cix_dp_session_unlock(dp);
> +
> +	cix_dp_cancel_hpd_works(dp);
> +
> +	cix_dp_session_lock(dp);
> +	if (!dp->active_stream_cnt)
> +		cix_dp_host_deinit(dp);
> +	dp->status =3D connector_status_unknown;
> +	dp->state &=3D ~DPTX_STATE_CONNECTED;
> +	cix_dp_session_unlock(dp);
> +
> +	return 0;
> +}

[Severity: High]
Can a concurrent detect or modeset between cix_dp_session_unlock() and the
second cix_dp_session_lock() undo suspend and leave dp->irq enabled with
apb_clk gated?

CPU0 (suspend)                    CPU1 (other task or hpd_worker)
cix_dp_pm_prepare()
  cix_dp_irq_off(dp)
  dp->state |=3D DPTX_STATE_SUSPENDED
  cix_dp_session_unlock(dp)
  cix_dp_cancel_hpd_works(dp)
                                  cix_dp_detect() / cix_dp_prepare()
                                    cix_dp_resume_locked(dp)
                                      cix_dp_host_init(dp)
                                      enable_irq(dp->irq)
                                      dp->state &=3D ~DPTX_STATE_SUSPENDED
  cix_dp_session_lock(dp)
  cix_dp_host_deinit(dp)
    clk_disable_unprepare(dp->apb_clk)  <-- IRQ left enabled with clock off

Any task other than dp->hpd_worker calling __cix_dp_detect() (such as
userspace probing or a sibling port's hpd_event_work running
drm_helper_hpd_irq_event()), or dp->hpd_worker itself calling
cix_dp_prepare() via drm_helper_hpd_irq_event() ->
drm_client_dev_hotplug(), will call cix_dp_resume_locked(dp) while
cix_dp_pm_prepare() has dropped session_lock. In addition,
cix_dp_oob_hotplug_event() overwrites dp->force_hpd with
connector_status_disconnected when DPTX_STATE_SUSPENDED is set, losing any
USB-C connect event that arrives during suspend.

[ ... ]
> +static void cix_dp_deinit(struct cix_dp *dp)
> +{
> +	if (!(dp->state & DPTX_STATE_CONFIGURED))
> +		return;
> +
> +	cix_dp_session_lock(dp);
> +	WRITE_ONCE(dp->hpd_stopped, true);
> +	cix_dp_session_unlock(dp);
> +
> +	cix_dp_irq_off(dp);
> +	cix_dp_cancel_hpd_works(dp);
> +
> +	cix_dp_session_lock(dp);
> +	cix_dp_stop_streams_locked(dp);
> +	cix_dp_host_deinit(dp);
> +	dp->state &=3D ~(DPTX_STATE_CONFIGURED);
> +	cix_dp_session_unlock(dp);
> +
> +	mutex_destroy(&dp->session_lock);
> +	mutex_destroy(&dp->aux_lock);
> +}

[Severity: High]
Can unbinding the platform device while dp->bridge is still attached to an
encoder cause use of destroyed mutexes and freed devm resources?

Because dp is allocated with devm_drm_bridge_alloc(), struct cix_dp
outlives platform device unbind until the encoder detaches the bridge.
However, devres runs cix_dp_deinit() on unbind, destroying
dp->session_lock and dp->aux_lock while dp->aux is still registered and
before cix_dp_bridge_detach() -> cix_dp_quiesce_hpd() locks
dp->session_lock; and if cix_dp_prepare() runs in the meantime, it sees
!(dp->state & DPTX_STATE_INITIALIZED) without checking
DPTX_STATE_CONFIGURED and calls cix_dp_host_init(), accessing freed devm
clocks, reset, PHY, and unmapped dp_iomem.

> +
> +static void cix_dptx_dev_release(struct device *dev, void *res)
> +{
> +	struct cix_dp *dp =3D res;
> +
> +	cix_dp_deinit(dp);
> +}
[ ... ]
> +	ret =3D cix_dp_init(dp);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, cix_dptx_dev_release, dp);
> +	if (ret)
> +		return ret;

[Severity: High]
Does cix_dptx_dev_release() have the wrong function signature for
devm_add_action_or_reset()?

devm_add_action_or_reset() expects void (*action)(void *), so this fails to
build with -Werror=3Dincompatible-pointer-types, and when invoked by devres
with a single argument (dp), cix_dptx_dev_release() reads the second
parameter (res) and passes an uninitialized register value to
cix_dp_deinit().

> diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c b/drivers/gpu/drm/ci=
x/dptx/cix_dptx_drm.c
> new file mode 100644
> index 0000000000000..5fc350daebfdd
> --- /dev/null
> +++ b/drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
[ ... ]
> +static enum drm_connector_status
> +cix_dp_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	struct cix_dp *dp =3D connector_to_dp(connector);
> +	enum drm_connector_status status;
> +
> +	if (dp->ops->detect(dp))
> +		status =3D connector_status_disconnected;
> +	else
> +		status =3D connector_status_connected;
> +
> +	dp->ops->session_lock(dp);
> +	dp->status =3D status;
> +	dp->ops->session_unlock(dp);
> +	drm_dp_set_subconnector_property(connector, status, dp->dpcd,
> +					 dp->downstream_ports);
> +
> +	return status;
> +}

[Severity: Medium]
Can updating dp->status in cix_dp_connector_detect() suppress hotplug
uevents in cix_dp_hpd_event_work_func(), and what protects dp->caps and
dp->link_config in cix_dp_bridge_atomic_check() and
cix_dp_connector_mode_valid()?

If userspace probes the connector after hpd_event_work is queued but before
cix_dp_hpd_event_work_func() samples old_status =3D dp->status, old_status
will already equal status and drm_helper_hpd_irq_event() will be skipped
(and because __cix_dp_detect() does not clear DPTX_STATE_CONNECTED on
disconnect, a subsequent reconnect will also skip reading the new sink's
DPCD). Additionally, cix_dp_bridge_atomic_check() and
cix_dp_connector_mode_valid() read dp->caps and dp->link_config without
holding dp->session_lock, racing with cix_dp_panel_read_sink_caps() zeroing
dp->caps before AUX reads complete.

> +
> +static void cix_dp_oob_hotplug_event(struct drm_connector *connector,
> +				     enum drm_connector_status hpd_state)
> +{
> +	struct cix_dp *dp =3D connector_to_dp(connector);
> +
> +	dp->ops->session_lock(dp);
> +	if (READ_ONCE(dp->hpd_stopped)) {
> +		dp->ops->session_unlock(dp);
> +		return;
> +	}
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		dp->force_hpd =3D connector_status_disconnected;
> +		dp->ops->session_unlock(dp);
> +		return;
> +	}

[Severity: Medium]
If an out-of-band Type-C connect event arrives while DPTX_STATE_SUSPENDED
is set, doesn't setting dp->force_hpd =3D connector_status_disconnected lose
the hotplug event across resume?

On cix,sky1-usbdp where the hardware HPD pin is unwired,
cix_dp_get_hpd_state() relies on dp->force_hpd; clobbering it with
connector_status_disconnected instead of recording hpd_state causes the
hpd_event_work scheduled by cix_dp_pm_complete() to see the connected USB-C
monitor as disconnected after resume.

[ ... ]
> +static enum drm_mode_status
> +cix_dp_connector_mode_valid(struct drm_connector *connector,
> +			    const struct drm_display_mode *mode)
> +{
> +	const struct drm_display_info *info =3D &connector->display_info;
> +	struct cix_dp *dp =3D connector_to_dp(connector);
> +	int max_lanes =3D dp->link_config.max_lanes;
> +	int max_rate =3D dp->link_config.max_rate;
> +	int clock =3D mode->clock;
> +	u32 pixel_per_cycle =3D cix_dp_pick_ppc(mode, CIX_DP_FORMAT_RGB);
> +	int minbpp =3D CIX_DP_MIN_BPP;
> +
> +	if (drm_mode_is_420_only(info, mode)) {
> +		if (!connector->ycbcr_420_allowed || !dp->caps.vsc_supported)
> +			return MODE_NO_420;
> +
> +		minbpp =3D 8 * 3 / 2;
> +		pixel_per_cycle =3D 1;
> +	}
> +
> +	if (pixel_per_cycle =3D=3D 1 && clock > CIX_DP_MAX_FREQ) {
> +		drm_mode_debug_printmodeline(mode);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	if (clock > CIX_DP_MAX_RATE(max_rate, max_lanes, minbpp)) {
> +		drm_mode_debug_printmodeline(mode);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	return MODE_OK;
> +}

[Severity: Medium]
Does cix_dp_connector_mode_valid() reject modes that would fit on the link
via the 8-bpc YCbCr 4:2:0 (420-also) or 8-bpc YCbCr 4:2:2 fallbacks in
fmt_prio[]?

minbpp defaults to CIX_DP_MIN_BPP (18) and is only lowered to 12 for
drm_mode_is_420_only(), so any 420-also mode (12 bpp) or YCbCr 4:2:2 mode
(16 bpp) whose clock exceeds the 18-bpp link rate limit is rejected with
MODE_CLOCK_HIGH before cix_dp_pick_format_bpc() can select those fallback
formats.

[ ... ]
> +static void cix_dp_adjust_mode(struct drm_display_mode *mode,
> +			       struct drm_display_mode *adjusted_mode)
> +{
> +	int diff =3D mode->htotal - mode->hsync_end;
> +
> +	/*
> +	 * Cix DP requires horizontal backporch to be greater than 12.
> +	 * This limitation may not be compatible with the sink device.
> +	 *
> +	 * Everything below is derived from @mode instead of accumulating on
> +	 * @adjusted_mode, so that repeated atomic checks of the same state
> +	 * produce the same result.
> +	 */
> +	if (diff < CIX_DPTX_MIN_H_BACKPORCH) {
> +		adjusted_mode->htotal =3D mode->htotal +
> +					CIX_DPTX_MIN_H_BACKPORCH - diff;
> +		adjusted_mode->clock =3D
> +			div_u64(mul_u32_u32(mode->clock, adjusted_mode->htotal),
> +				mode->htotal);
> +	}
> +
> +	/* The sync polarities are inverted with respect to the source mode. */
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +		adjusted_mode->flags &=3D ~DRM_MODE_FLAG_PVSYNC;
> +	else
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> +
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +		adjusted_mode->flags &=3D ~DRM_MODE_FLAG_PHSYNC;
> +	else
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> +}

[Severity: Medium]
Doesn't toggling only DRM_MODE_FLAG_PVSYNC and DRM_MODE_FLAG_PHSYNC leave
adjusted_mode->flags with either both positive and negative sync flags set
or neither set?

DRM_MODE_FLAG_NVSYNC and DRM_MODE_FLAG_NHSYNC need to be updated alongside
PVSYNC and PHSYNC. Also, when cix_dp_adjust_mode() increases
adjusted_mode->clock (or when a mode has clock >=3D CIX_DP_MAX_FREQ * 2 so
cix_dp_pick_ppc() returns 1), cix_dp_format_ok() only checks
adjusted_mode->clock against CIX_DP_MAX_FREQ for YCbCr 4:2:0 and never
validates the increased pixel clock for RGB or YCbCr 4:4:4/4:2:2.

[ ... ]
> +static int cix_dp_bridge_atomic_check(struct drm_bridge *bridge,
> +				      struct drm_bridge_state *bridge_state,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state)
> +{
[ ... ]
> +	/*
> +	 * The colour space is programmed through a VSC SDP, so a change of
> +	 * the requested colour space requires a full modeset.
> +	 */
> +	if (dp->caps.vsc_supported) {
> +		const struct drm_connector_state *old_conn_state;
> +
> +		old_conn_state =3D
> +			drm_atomic_get_old_connector_state(bridge_state->base.state,
> +							   conn_state->connector);
> +		if (old_conn_state &&
> +		    old_conn_state->colorspace !=3D conn_state->colorspace)
> +			crtc_state->mode_changed =3D true;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Should this also check old_conn_state->content_type !=3D
conn_state->content_type (and enable VSC SDP in cix_dp_needs_vsc_sdp() when
content_type is non-zero)?

content_type is packed into the VSC SDP in dptx_setup_vsc_sdp() during
cix_dp_bridge_atomic_enable(), so changing the connector content type
property alone on an active stream will not update the hardware VSC SDP
unless a modeset is triggered.

[ ... ]
> +static int cix_dp_connector_atomic_check(struct drm_connector *conn,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct drm_connector_state *new_con_state =3D
> +		drm_atomic_get_new_connector_state(state, conn);
> +
> +	if (!new_con_state)
> +		return 0;
> +
> +	/* PSR is not implemented, so never advertise self refresh support. */
> +	new_con_state->self_refresh_aware =3D false;
> +
> +	return 0;
> +}

[Severity: Medium]
Should the colorspace modeset check in cix_dp_bridge_atomic_check() live in
cix_dp_connector_atomic_check() instead?

cix_dp_bridge_atomic_check() runs from mode_fixup() at the end of
drm_atomic_helper_check_modeset(), after drm_atomic_crtc_needs_modeset()
has already decided whether to add affected connectors and planes, run
mode_valid(), and reset adjusted_mode from mode. Setting
crtc_state->mode_changed or connectors_changed here in
cix_dp_connector_atomic_check() ensures those modeset preparation steps are
not skipped when colorspace changes.

[ ... ]
> +static int cix_dp_connector_create(struct cix_dp *dp,
> +				   struct drm_encoder *encoder)
> +{
> +	struct cix_connector *conn =3D &dp->connector;
> +	struct drm_connector *connector =3D &conn->base;
> +	int ret;
> +
> +	conn->dp =3D dp;
> +
> +	connector->polled =3D DRM_CONNECTOR_POLL_HPD;
> +	connector->ycbcr_420_allowed =3D true;
> +
> +	ret =3D drm_connector_init_with_ddc(encoder->dev, connector,
> +					  &cix_dp_connector_funcs,
> +					  DRM_MODE_CONNECTOR_DisplayPort,
> +					  &dp->aux.ddc);
> +	if (ret)
> +		return ret;

[Severity: High]
Does cix_dp_connector_create() need to set connector->fwnode so
drm_connector_oob_hotplug_event() can find this connector?

drm_connector_oob_hotplug_event() looks up the target connector with
drm_connector_find_by_fwnode(connector_fwnode). Because connector->fwnode
is left NULL here, out-of-band hotplug notifications on cix,sky1-usbdp
ports always fail with -ENODEV and never reach cix_dp_oob_hotplug_event().

> +
> +	drm_connector_helper_add(connector, &cix_dp_connector_helper_funcs);
> +
> +	drm_atomic_helper_connector_reset(connector);
> +
> +	ret =3D drm_connector_attach_encoder(connector, encoder);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	cix_dp_add_properties(connector);

[Severity: Medium]
Can cix_dp_add_properties() dereference a NULL connector->state if the
allocation inside drm_atomic_helper_connector_reset() fails?

drm_connector_attach_max_bpc_property() unconditionally writes to
connector->state->max_requested_bpc and connector->state->max_bpc.

[ ... ]
> +static int cix_dp_bridge_attach(struct drm_bridge *bridge,
> +				struct drm_encoder *encoder,
> +				enum drm_bridge_attach_flags flags)
> +{
> +	struct cix_dp *dp =3D bridge_to_dp(bridge);
> +	int ret;
> +
> +	dp->drm =3D bridge->dev;
> +	WRITE_ONCE(dp->hpd_stopped, false);
> +
> +	ret =3D dp->ops->aux_register(dp);
> +	if (ret)
> +		goto err_clear_drm;
> +
> +	/*
> +	 * Komeda (ARM Mali DPU on Sky1, not in this series) calls
> +	 * drm_bridge_attach() with attach flags 0 and does not register a
> +	 * connector; create one here so userspace gets a DP output.
> +	 */
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> +		return 0;

[Severity: Medium]
Should cix_dp_bridge_attach() reject DRM_BRIDGE_ATTACH_NO_CONNECTOR with
-EINVAL before registering AUX?

The bridge does not implement drm_bridge_connector callbacks (.detect,
.edid_read, .get_modes, .hpd_enable/.hpd_disable), and returning 0 here
leaves dp->dp_panel.connector NULL, which causes cix_dp_set_misc() to fail
every stream enable with -EINVAL and cix_dp_hpd_event_work_func() to ignore
hotplug events.

[ ... ]
> +static void cix_dp_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct cix_dp *dp =3D bridge_to_dp(bridge);
> +
> +	/* Stop workers before the connector goes away. */
> +	dp->ops->quiesce_hpd(dp);
> +
> +	dp->dp_panel.connector =3D NULL;
> +
> +	if (dp->connector.base.dev)
> +		drm_connector_cleanup(&dp->connector.base);

[Severity: High]
Doesn't calling drm_connector_cleanup(&dp->connector.base) here while
cix_dp_connector_funcs.destroy is also set to drm_connector_cleanup()
corrupt connector refcounting during teardown?

In drm_mode_config_cleanup(), encoders (and their attached bridges) are
cleaned up before the connector list and CRTC states. Calling
drm_connector_cleanup() directly in cix_dp_bridge_detach() zeroes the
embedded struct drm_connector while references are still held, so the
subsequent drm_connector_put() underflows the zeroed refcount and
dereferences a NULL connector->funcs->destroy in drm_connector_free().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117064552.8525=
6-1-Luo.Liu@cixtech.com?part=3D2
