Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B04606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNgU5oTK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E634110E039;
	Sat, 31 Oct 2026 16:07:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446A410E039;
 Sat, 31 Oct 2026 16:07:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00F8E41B39;
 Sat, 31 Oct 2026 16:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B111F000C1;
 Sat, 31 Oct 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793462835;
 bh=AkMbROYXafW1HkB/TdVqmJvC/KAXVQWwPXchkK9YpiE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kNgU5oTKL9oiEtSz/MQuTqLXKmSU9EddQVwxeqJjp6Ut7CztJzch68s7XjZLBKd5y
 vGZPsk1fZH/7xcswLmMoEBnX4v/B1hSYEpPBJNXQe42oYwbvbKkgN8qjBy7S6wItPY
 TCp9/0TPNywUA69vXrWTVdz9MuMGV1OEaIchQ4JMt7ZXJSfULrtT7IgXt7kKxMlVfx
 LgCHmXGAuYWFNbpTIYot9SaYfarBZF/srHfw0BB58hee7c41lm64R3ghzdTcJhjf3m
 quO+6ebICNO8Ls+0HQ8z5MITj1br+vGI0Pv5GtGmjn9fpP6X+Er8YS35sX8S6PFG2O
 5hki8TV47h/6g==
Message-ID: <sashiko-outbox-192031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/i915/dp_mst: Skip link retrain and ACT for
 disconnected MST streams
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031153550.444676-3-xiaolu.xie@intel.com>
References: <20261031153550.444676-3-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:07:15 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/i915/dp_mst: VC payload left allocated in mst_stream_post_di=
sable()
- [Medium] drm/i915/dp_mst: broken retrain in intel_dp_retrain_link() on pa=
rtial unplug
- [Medium] drm/i915/dp_mst: race with delayed connector unregistration in m=
st_connector_stream_disconnected()
--

commit 25f773daa729bda6d48a9b3f730e6fd95cc19639
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp_mst: Skip link retrain and ACT for disconnected MST streams

This commit skips disconnected MST streams when selecting pipes to modeset =
in
intel_dp_retrain_link() and skips generating and waiting for ACT in
mst_stream_post_disable() when drm_dp_remove_payload_part1() did not remove
the payload from the branch device.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index ac1aff6edf052..41bfb8b1ae0c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -2576,6 +2576,9 @@ static int intel_dp_retrain_link(struct intel_encod=
er *encoder,
>  	if (ret)
>  		return ret;
> =20
> +	/* Nothing to retrain for streams whose MST sink has left the topology =
*/
> +	pipe_mask &=3D ~intel_dp_mst_disconnected_pipes(intel_dp);
> +
>  	if (pipe_mask =3D=3D 0)
>  		return 0;

[Severity: Medium]
What happens in intel_dp_retrain_link() in
drivers/gpu/drm/i915/display/intel_dp_link_training.c when an MST hub has t=
wo
active streams and only one downstream sink is unplugged (leaving its CRTC
enabled until userspace disables it) while the other stream stays connected?

In drivers/gpu/drm/i915/display/intel_dp_mst.c, physical DP link teardown a=
nd
retraining only run when intel_dp->mst.active_streams transitions to 0 in
mst_stream_post_disable() and from 0 to 1 in mst_stream_pre_enable():

drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_stream_pre_enable() {
	...
	if (first_mst_stream) {
		primary_encoder->pre_enable(state, primary_encoder,
					    pipe_config, NULL);

		intel_mst_reprobe_topology(intel_dp, pipe_config);
	}

	ret =3D drm_dp_add_payload_part1(&intel_dp->mst.mgr, mst_state,
				       drm_atomic_get_mst_payload_state(mst_state, connector->mst.port)=
);
	if (ret < 0)
		intel_dp_queue_modeset_retry_for_link(state, primary_encoder, pipe_config=
);
	...
}

When pipe_mask masks out only the disconnected pipe while another pipe on t=
he
same MST topology remains connected, intel_modeset_commit_pipes_for_atomic_=
state()
only sets uapi.connectors_changed on the connected CRTC.

If the disconnected stream is on the MST master transcoder (or on
DISPLAY_VER < 12) and link parameters have not changed,
intel_crtc_check_fastset() in drivers/gpu/drm/i915/display/intel_display.c
clears uapi.mode_changed on the disconnected CRTC. Only the connected stream
then undergoes a modeset, so intel_dp->mst.active_streams transitions
2 -> 1 -> 2, first_mst_stream is false, primary_encoder->pre_enable() is
never called to retrain the link, and intel_dp_link_training_set_force_retr=
ain()
still clears force_retrain.

Conversely, if the connected stream is on the MST master transcoder and the
disconnected stream is on a slave transcoder on DISPLAY_VER >=3D 12 (or if =
link
parameters changed), intel_atomic_check() in
drivers/gpu/drm/i915/display/intel_display.c still forces a modeset on the
disconnected slave CRTC:

drivers/gpu/drm/i915/display/intel_display.c:intel_atomic_check() {
	...
		if (intel_dp_mst_is_slave_trans(new_crtc_state)) {
			enum transcoder master =3D new_crtc_state->mst_master_transcoder;

			if (intel_cpu_transcoders_need_modeset(state, BIT(master)))
				intel_crtc_flag_modeset(new_crtc_state);
		}
	...
}

Wouldn't that still run mst_stream_pre_enable() and mst_stream_enable() on
the disconnected stream, where drm_dp_add_payload_part1() fails (marking
link_status bad on the link via intel_dp_queue_modeset_retry_for_link()) and
drm_dp_check_act_status() in mst_stream_enable() still stalls for 3000 ms?

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 7023619aaaba9..a1d4c37d001ac 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -1109,6 +1109,7 @@ static void mst_stream_post_disable(struct intel_at=
omic_state *state,
>  		drm_atomic_get_mst_payload_state(new_mst_state, connector->mst.port);
>  	struct intel_crtc *pipe_crtc;
>  	bool last_mst_stream;
> +	bool payload_removed;
> =20
>  	last_mst_stream =3D intel_dp_mst_dec_active_streams(intel_dp);
> =20
> @@ -1124,16 +1125,20 @@ static void mst_stream_post_disable(struct intel_=
atomic_state *state,
> =20
>  	intel_disable_transcoder(old_crtc_state);
> =20
> -	drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new_mst_state, new_payl=
oad);
> +	payload_removed =3D drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new=
_mst_state,
> +						      new_payload);
> =20
> -	intel_ddi_clear_act_sent(encoder, old_crtc_state);
> +	/* No ACT is needed if the payload table of the branch wasn't changed */
> +	if (payload_removed) {
> +		intel_ddi_clear_act_sent(encoder, old_crtc_state);
> =20
> -	intel_de_rmw(display,
> -		     TRANS_DDI_FUNC_CTL(display, old_crtc_state->cpu_transcoder),
> -		     TRANS_DDI_DP_VC_PAYLOAD_ALLOC, 0);
> +		intel_de_rmw(display,
> +			     TRANS_DDI_FUNC_CTL(display, old_crtc_state->cpu_transcoder),
> +			     TRANS_DDI_DP_VC_PAYLOAD_ALLOC, 0);
> =20
> -	intel_ddi_wait_for_act_sent(encoder, old_crtc_state);
> -	drm_dp_check_act_status(&intel_dp->mst.mgr);
> +		intel_ddi_wait_for_act_sent(encoder, old_crtc_state);
> +		drm_dp_check_act_status(&intel_dp->mst.mgr);
> +	}

[Severity: Medium]
When payload_removed is false in mst_stream_post_disable() in
drivers/gpu/drm/i915/display/intel_dp_mst.c, does skipping the
TRANS_DDI_FUNC_CTL update leave TRANS_DDI_DP_VC_PAYLOAD_ALLOC set in
hardware?

In drivers/gpu/drm/i915/display/intel_ddi.c,
intel_ddi_disable_transcoder_func() performs a read-modify-write on
TRANS_DDI_FUNC_CTL without clearing TRANS_DDI_DP_VC_PAYLOAD_ALLOC:

drivers/gpu/drm/i915/display/intel_ddi.c:intel_ddi_disable_transcoder_func(=
) {
	...
	ctl =3D intel_de_read(display,
			    TRANS_DDI_FUNC_CTL(display, cpu_transcoder));

	drm_WARN_ON(crtc->base.dev, ctl & TRANS_DDI_HDCP_SIGNALLING);

	ctl &=3D ~TRANS_DDI_FUNC_ENABLE;

	if (IS_DISPLAY_VER(display, 8, 10))
		ctl &=3D ~(TRANS_DDI_PORT_SYNC_ENABLE |
			 TRANS_DDI_PORT_SYNC_MASTER_SELECT_MASK);

	if (DISPLAY_VER(display) >=3D 12) {
		if (!intel_dp_mst_is_master_trans(crtc_state)) {
			ctl &=3D ~(TGL_TRANS_DDI_PORT_MASK |
				 TRANS_DDI_MODE_SELECT_MASK);
		}
	} else {
		ctl &=3D ~(TRANS_DDI_PORT_MASK | TRANS_DDI_MODE_SELECT_MASK);
	}

	intel_de_write(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder),
		       ctl);
	...
}

If a downstream branch or sink port was unplugged while other streams on the
MST hub remain active (or when the stale CRTC is later disabled by
userspace), skipping the clearing of TRANS_DDI_DP_VC_PAYLOAD_ALLOC leaves t=
he
VC payload allocated in the source transcoder while
drm_dp_remove_payload_part2() shifts the remaining payloads' start slots in
software, and violates the transcoder disable sequence requiring
TRANS_DDI_DP_VC_PAYLOAD_ALLOC to be cleared before TRANS_DDI_FUNC_ENABLE.

Should TRANS_DDI_DP_VC_PAYLOAD_ALLOC always be cleared in
mst_stream_post_disable() even when payload_removed is false, only gating t=
he
ACT status clear/wait on payload_removed?

[ ... ]

> @@ -2172,6 +2177,20 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_=
atomic_state *state,
>  	return false;
>  }
> =20
> +static bool mst_connector_stream_disconnected(struct intel_connector *co=
nnector)
> +{
> +	if (!connector->mst.dp)
> +		return false;
> +
> +	if (!connector->mst.dp->mst.mgr.mst_state)
> +		return true;
> +
> +	if (drm_connector_is_unregistered(&connector->base))
> +		return true;
> +
> +	return false;
> +}

[Severity: Medium]
Can mst_connector_stream_disconnected() in
drivers/gpu/drm/i915/display/intel_dp_mst.c miss a disconnected MST stream =
in
the scenario described by the commit message if intel_dp_retrain_link() runs
before drm_dp_delayed_destroy_work() finishes unregistering the old
connector?

When HPD drops and comes back in intel_ddi_hotplug() ->
intel_encoder_hotplug() -> intel_dp_detect(), tearing down the old topology
via drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst.mgr, false) queues
mgr->delayed_destroy_work to call drm_connector_unregister() asynchronously
in drm_dp_delayed_destroy_port():

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_delayed_destroy_port()=
 {
	drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE, port->mcs);

	if (port->connector) {
		drm_connector_unregister(port->connector);
		drm_connector_put(port->connector);
	}

	drm_dp_mst_put_port_malloc(port);
}

During the reconnect detection in intel_dp_detect(), intel_dp_mst_configure=
()
immediately calls drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst.mgr, true),
which sets mgr->mst_state =3D true again without flushing
mgr->delayed_destroy_work, and intel_ddi_hotplug() then schedules
intel_dp_retrain_link() via intel_dp_check_link_state(). (Similarly, if a
downstream branch device is unplugged via CSN while the primary hub stays
connected, mgr->mst_state remains true while delayed_destroy_work is queued=
.)

If intel_dp_retrain_link() runs before drm_dp_delayed_destroy_work() reaches
drm_connector_unregister(&connector->base), won't both
!connector->mst.dp->mst.mgr.mst_state and
drm_connector_is_unregistered(&connector->base) evaluate to false even thou=
gh
connector->mst.port is no longer in the topology?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031153550.4446=
76-1-xiaolu.xie@intel.com?part=3D2
