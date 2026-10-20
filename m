Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBiXY6q/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CB310EF22;
	Tue, 20 Oct 2026 11:26:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719AF10ED2D;
 Tue, 20 Oct 2026 11:26:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1842140247;
 Tue, 20 Oct 2026 11:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28581F000C5;
 Tue, 20 Oct 2026 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792495604;
 bh=pknGrJ+5O/kK6eTDXc/Tvyy7hpUUaNAmdo2s5fK0kY0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=VBiXY6q/pY3oqh+/ffWLQneR74IB01dbwGeLSq2VDSZ71AGu+Og2CHRo3pboploTj
 +loL66Qk7hF5PW3O/eTrBJ5PhiyqoYuyqOlIjJFF/B5gqpZD3n4nlEV4tFFREuNFUt
 CZDOWeKSqBmDOzglnm7CziqlaaF0+hEkxAbM2PYQz8uRzZ4EVNpvOeipTUq1tbGr4G
 ZHIvqhq74UValWvSQsCi9aFo7OodBzuKwhQO8G8io3qwGqykJbos8tQi8sGdZSz+0+
 qpwXl3n4qYqsjTacxbBa5S85lKy/w+6UIaQGAZ00jrMdWz4EkuGf/yThFxHWT2chtl
 nBN9YsuMnwOmA==
Message-ID: <sashiko-outbox-178894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/i915/dp: clear and restore MSTM_CTRL around MST
 DPMS off/on
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261020110418.1272170-1-xiaolu.xie@intel.com>
References: <20261020021714.62573-1-xiaolu.xie@intel.com>
 <20261020110418.1272170-1-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 11:26:43 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/i915/dp: drm_dp_mst_topology_mgr_pause() breaks hotplug with 0=
 streams
- [High] drm/dp_mst: drm_dp_mst_topology_mgr_pause() breaks probe work and =
edid reads
- [Medium] drm/dp_mst: suspend and resume conflict with paused state in DP_=
MSTM_CTRL
--

commit b145319fb5344bbbdb4ae3ece1a54e6f33404fe1
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS off/on

This commit adds helpers to the DP MST topology manager to pause and
unpause MST mode in DP_MSTM_CTRL around powering the branch device down
to D3 on last stream disable and back up to D0 on first stream enable,
while tracking the paused state to avoid tearing down the topology during
connector detection and reprobing after unpausing.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index b7fce0bf8acc5..371cf88a2d1cf 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c

[ ... ]

> @@ -3759,6 +3762,104 @@ void drm_dp_mst_topology_queue_probe(struct drm_d=
p_mst_topology_mgr *mgr)
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_queue_probe);
> =20
> +/**
> + * drm_dp_mst_topology_mgr_pause() - disable the MST mode of the branch =
device
> + * @mgr: manager to pause
> + *
> + * Disable the MST mode of the branch device, while keeping the MST topo=
logy
> + * in the SW state. This is meant to be called when all the MST streams =
are
> + * disabled and the branch device is about to be powered down.
> + *
> + * The branch device may not send UP messages while it is powered down, =
so
> + * after the MST mode is enabled again by drm_dp_mst_topology_mgr_unpaus=
e(),
> + * the topology must be re-probed.
> + */
> +void drm_dp_mst_topology_mgr_pause(struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	mutex_lock(&mgr->lock);
> +
> +	if (!mgr->mst_state || !mgr->mst_primary || mgr->paused)
> +		goto out_unlock;
> +
> +	if (drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
> +				   DP_UPSTREAM_IS_SRC) =3D=3D 0)
> +		mgr->paused =3D true;
> +
> +out_unlock:
> +	mutex_unlock(&mgr->lock);
> +}
> +EXPORT_SYMBOL(drm_dp_mst_topology_mgr_pause);

[Severity: High]
Can clearing DP_MST_EN in drm_dp_mst_topology_mgr_pause() cause sideband
timeouts and wipe connector modes when mgr->work or EDID reads run while
paused?

Unlike drm_dp_mst_topology_mgr_suspend(), drm_dp_mst_topology_mgr_pause()
does not flush mgr->work (drm_dp_mst_link_probe_work()) or
mgr->up_req_work, and drm_dp_mst_link_probe_work() only checks
mgr->mst_primary without checking mgr->paused:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_mst_link_probe_work() {
	mutex_lock(&mgr->lock);
	clear_payload_id_table =3D !mgr->payload_id_table_cleared;
	mgr->payload_id_table_cleared =3D true;

	mstb =3D mgr->mst_primary;
	if (mstb) {
		ret =3D drm_dp_mst_topology_try_get_mstb(mstb);
		if (!ret)
			mstb =3D NULL;
	}
	mutex_unlock(&mgr->lock);
}

Because mst_stream_pre_enable() queues mgr->work asynchronously via
intel_mst_reprobe_topology() -> drm_dp_mst_topology_queue_probe(), if the
stream is disabled before mgr->work finishes, DP_MST_EN is cleared
underneath drm_dp_mst_link_probe_work(). In-flight sideband messages then
time out in drm_dp_mst_wait_tx_reply(), which can leave
mstb->link_address_sent or port PBN state incomplete or unlink ports in
drm_dp_mst_handle_link_address_port().

Similarly, while mgr->paused is true during DPMS off, if userspace or
hotplug handling probes a connected physical MST port (port_num < 8, where
port->cached_edid is NULL):

  drm_helper_probe_single_connector_modes()
    -> mst_connector_get_modes()
      -> mst_connector_get_ddc_modes()
        -> drm_dp_mst_edid_read()
          -> drm_edid_read_ddc(connector, &port->aux.ddc)
            -> drm_dp_mst_i2c_xfer()

this sends DP_REMOTE_I2C_READ sideband requests while DP_MST_EN is 0 and
the branch device is in D3. Each attempt stalls for 4000 ms in
drm_dp_mst_wait_tx_reply() while holding mode_config.mutex and returns
NULL, causing mst_connector_get_ddc_modes() to pass NULL to
intel_connector_update_modes() and wipe the connector's EDID and native
modes.

> +
> +/**
> + * drm_dp_mst_topology_mgr_unpause() - re-enable the MST mode of the bra=
nch device
> + * @mgr: manager to unpause
> + *
> + * Re-enable the MST mode of the branch device disabled by
> + * drm_dp_mst_topology_mgr_pause(). Does nothing if the manager isn't pa=
used.
> + *
> + * Returns %true if the manager was paused. In this case the MST topology
> + * should be re-probed with drm_dp_mst_topology_queue_probe(), once the =
link
> + * parameters to the branch device are set up.
> + */
> +bool drm_dp_mst_topology_mgr_unpause(struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	bool was_paused =3D false;
> +
> +	mutex_lock(&mgr->lock);
> +
> +	if (!mgr->paused)
> +		goto out_unlock;
> +
> +	if (drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
> +				   DP_MST_EN | DP_UP_REQ_EN |
> +				   DP_UPSTREAM_IS_SRC) =3D=3D 0) {
> +		mgr->paused =3D false;
> +		was_paused =3D true;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&mgr->lock);
> +
> +	return was_paused;
> +}
> +EXPORT_SYMBOL(drm_dp_mst_topology_mgr_unpause);
> +
> +/**
> + * drm_dp_mst_topology_mgr_verify_ctrl() - verify the MST mode of the br=
anch device
> + * @mgr: manager to verify
> + *
> + * Verify that the MST mode enabled in the branch device matches the man=
ager's
> + * state. A long HPD pulse could've reset the branch device's MST mode, =
which
> + * requires tearing down and recreating the MST topology.
> + *
> + * Returns %true if the branch device's MST mode matches the manager's s=
tate,
> + * %false otherwise.
> + */
> +bool drm_dp_mst_topology_mgr_verify_ctrl(struct drm_dp_mst_topology_mgr =
*mgr)
> +{
> +	u8 expected, val =3D 0;
> +	int ret;
> +
> +	mutex_lock(&mgr->lock);
> +
> +	expected =3D mgr->paused ? DP_UPSTREAM_IS_SRC :
> +		   DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC;
> +
> +	ret =3D drm_dp_dpcd_read_byte(mgr->aux, DP_MSTM_CTRL, &val);
> +
> +	mutex_unlock(&mgr->lock);
> +
> +	if (ret < 0 || val !=3D expected) {
> +		drm_dbg_kms(mgr->dev,
> +			    "%s: MSTM_CTRL mismatch (ret=3D%d, ctrl=3D0x%02x, expected=3D0x%0=
2x)\n",
> +			    mgr->aux->name, ret, val, expected);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_dp_mst_topology_mgr_verify_ctrl);
> +
>  /**
>   * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
>   * @mgr: manager to suspend
> @@ -3828,6 +3929,8 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_ms=
t_topology_mgr *mgr,
>  		goto out_fail;
>  	}
> =20
> +	mgr->paused =3D false;
> +
>  	/* Some hubs forget their guids after they resume */
>  	ret =3D drm_dp_dpcd_read_data(mgr->aux, DP_GUID, buf, sizeof(buf));
>  	if (ret < 0) {

[Severity: Medium]
How do drm_dp_mst_topology_mgr_suspend() and
drm_dp_mst_topology_mgr_resume() interact with mgr->paused and the D3/D0
power state transitions during system suspend and resume?

During system suspend in __intel_display_driver_pm_suspend():

  drm_atomic_helper_suspend()
    -> intel_ddi_post_disable_dp()
      -> drm_dp_mst_topology_mgr_pause()
      -> intel_dp_set_power(intel_dp, DP_SET_POWER_D3)
  intel_dp_mst_suspend()
    -> drm_dp_mst_topology_mgr_suspend()

drm_dp_mst_topology_mgr_suspend() unconditionally writes
DP_MST_EN | DP_UPSTREAM_IS_SRC to DP_MSTM_CTRL after
intel_ddi_post_disable_dp() has already paused the manager and put the
branch device into D3, re-enabling DP_MST_EN in D3 and leaving
DP_MSTM_CTRL out of sync with mgr->paused =3D=3D true.

Then during system resume in intel_display_driver_pm_resume(),
intel_dp_mst_resume() -> drm_dp_mst_topology_mgr_resume() runs before
__intel_display_driver_resume() commits the restored modeset state.
drm_dp_mst_topology_mgr_resume() writes
DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC to DP_MSTM_CTRL, sets
mgr->paused =3D false, and runs mgr->work while the sink is still in D3
prior to intel_dp_set_power(intel_dp, DP_SET_POWER_D0) and link training.

When __intel_display_driver_resume() subsequently calls
mst_stream_pre_enable(), drm_dp_mst_topology_mgr_unpause() sees
mgr->paused =3D=3D false and returns was_paused =3D false, skipping both the
post-D0 DP_MSTM_CTRL write and the forced post-link-training reprobe in
intel_mst_reprobe_topology(). And if all MST streams were in DPMS off
before suspend, __intel_display_driver_resume() enables no streams,
leaving the branch device in D3 with DP_MST_EN set and
mgr->paused =3D=3D false.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index a46ab5d3d70fc..9d918f968617a 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3163,6 +3163,8 @@ static void intel_ddi_post_disable_dp(struct intel_=
atomic_state *state,
>  	 * Power down sink before disabling the port, otherwise we end
>  	 * up getting interrupts from the sink on detecting link loss.
>  	 */
> +	if (is_mst)
> +		drm_dp_mst_topology_mgr_pause(&intel_dp->mst.mgr);
>  	intel_dp_set_power(intel_dp, DP_SET_POWER_D3);
> =20
>  	if (DISPLAY_VER(display) >=3D 12) {
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 7023619aaaba9..2e3a2424d0e5a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -1232,9 +1232,11 @@ static void intel_mst_set_probed_link_params(struc=
t intel_dp *intel_dp,
>  }
> =20
>  static void intel_mst_reprobe_topology(struct intel_dp *intel_dp,
> -				       const struct intel_crtc_state *crtc_state)
> +				       const struct intel_crtc_state *crtc_state,
> +				       bool force)
>  {
> -	if (intel_mst_probed_link_params_valid(intel_dp,
> +	if (!force &&
> +	    intel_mst_probed_link_params_valid(intel_dp,
>  					       crtc_state->port_clock, crtc_state->lane_count))
>  		return;
> =20
> @@ -1259,6 +1261,7 @@ static void mst_stream_pre_enable(struct intel_atom=
ic_state *state,
>  		drm_atomic_get_new_mst_topology_state(&state->base, &intel_dp->mst.mgr=
);
>  	int ret;
>  	bool first_mst_stream;
> +	bool was_paused =3D false;
> =20
>  	/* MST encoders are bound to a crtc, not to a connector,
>  	 * force the mapping here for get_hw_state.
> @@ -1270,8 +1273,10 @@ static void mst_stream_pre_enable(struct intel_ato=
mic_state *state,
>  	drm_WARN_ON(display->drm, DISPLAY_VER(display) >=3D 12 && first_mst_str=
eam &&
>  		    !intel_dp_mst_is_master_trans(pipe_config));
> =20
> -	if (first_mst_stream)
> +	if (first_mst_stream) {
>  		intel_dp_set_power(intel_dp, DP_SET_POWER_D0);
> +		was_paused =3D drm_dp_mst_topology_mgr_unpause(&intel_dp->mst.mgr);
> +	}
> =20
>  	drm_dp_send_power_updown_phy(&intel_dp->mst.mgr, connector->mst.port, t=
rue);
> =20
> @@ -1281,7 +1286,11 @@ static void mst_stream_pre_enable(struct intel_ato=
mic_state *state,
>  		primary_encoder->pre_enable(state, primary_encoder,
>  					    pipe_config, NULL);
> =20
> -		intel_mst_reprobe_topology(intel_dp, pipe_config);
> +		/*
> +		 * The branch device may not have sent UP messages while it
> +		 * was powered down, re-probe the topology to sync it.
> +		 */
> +		intel_mst_reprobe_topology(intel_dp, pipe_config, was_paused);
>  	}

[Severity: High]
Does pausing the MST topology manager on last stream disable break
downstream monitor hotplug detection whenever zero MST streams are active?

When the last active MST stream is disabled (for example, when the user
unplugs the last monitor from an MST hub or dock, or disables all outputs
in userspace), mst_stream_post_disable() calls
primary_encoder->post_disable() -> intel_ddi_post_disable_dp(), which
calls drm_dp_mst_topology_mgr_pause(&intel_dp->mst.mgr) (clearing
DP_MST_EN and DP_UP_REQ_EN in DP_MSTM_CTRL) and puts the sink into D3.

If a monitor is later plugged into the MST hub while zero streams are
active:

1. Because DP_MST_EN and DP_UP_REQ_EN are cleared and the branch device is
   in D3, the branch device cannot send DP_CONNECTION_STATUS_NOTIFY UP
   requests.

2. If a short HPD pulse occurs, intel_dp_check_mst_status() ->
   drm_dp_mst_hpd_irq_handle_event() sees no DP_UP_REQ_MSG_RDY in ESI.

3. If a long HPD pulse or manual connector probe runs intel_dp_detect(),
   intel_dp_mst_verify_dpcd_state() ->
   drm_dp_mst_topology_mgr_verify_ctrl() sees
   DP_MSTM_CTRL =3D=3D DP_UPSTREAM_IS_SRC matching mgr->paused =3D=3D true =
and
   returns true, and intel_dp_mst_configure() ->
   drm_dp_mst_topology_mgr_set_mst(mgr, true) returns early because
   mgr->mst_state is already true.

4. On MST connector detection via mst_connector_detect_ctx() ->
   drm_dp_mst_detect_port(), port->ddps remains 0 for any port that was
   disconnected.

Because mst_stream_pre_enable() is the only caller of
drm_dp_mst_topology_mgr_unpause() and intel_mst_reprobe_topology(), and
userspace cannot commit a modeset when all MST connectors are disconnected
(or on any newly plugged port whose port->ddps is still 0), how can the
topology manager ever be unpaused and reprobed to detect the plugged-in
monitor without physically unplugging and replugging the MST hub itself?

> =20
>  	ret =3D drm_dp_add_payload_part1(&intel_dp->mst.mgr, mst_state,

[ ... ]

>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020110418.1272=
170-1-xiaolu.xie@intel.com?part=3D1
