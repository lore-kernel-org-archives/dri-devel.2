Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2D606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxVS1Hl7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF00810E941;
	Sat, 31 Oct 2026 16:17:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF83E10E10E;
 Sat, 31 Oct 2026 16:17:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3ADC6061D;
 Sat, 31 Oct 2026 16:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C3F1F000C1;
 Sat, 31 Oct 2026 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793463456;
 bh=0P+ntoJlJbOBs0AlVfdq61KumYLqV2w3w6jx+UYS/gw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NxVS1Hl7tVib3xhKCmHCLhUJoTRjQU/Atshl8EGdA4bnlBrZp5BCAQza0GFID0tl/
 evzW1Q16LaFayLXPv4HCpMbNnvnpmQ8GyLordiAJn0nF6mVPfQnv5tMMaV7QD2xiat
 /XPXyN68NtlHPsiu5lswuIAWk87wBmxByZ3FJRc/JN38osAvweOGNEXG9UUtrp35p1
 0kdxbZUcoMEQs/LJa4RUYKD7pZ+XGYAkOcfyDsIvLf1eXOEN96oN7AxpuljRlm4YAz
 umtxg8Xe8TAflWqjwsYKaSh/OhueTbBvQZy6O2Gvrhil6MLnxXUws9g3KQXjDyiETj
 9MMUWClVpfMkA==
Message-ID: <sashiko-outbox-192037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2/2] drm/i915/dp_mst: Skip link retrain and ACT
 for disconnected MST streams
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031154456.465469-3-xiaolu.xie@intel.com>
References: <20261031154456.465469-1-xiaolu.xie@intel.com>
 <20261031154456.465469-3-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:17:35 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/i915/dp_mst: mst_stream_post_disable() skips VC payload deallo=
cation
- [High] drm/i915/dp_mst: skipped link training in intel_dp_retrain_link() =
on partial pipe_mask
- [Medium] drm/i915/dp_mst: unguarded ACT wait in mst_stream_enable() on fa=
iled payload
- [Medium] drm/i915/dp_mst: race with delayed connector unregister in mst_c=
onnector_stream_disconnected()
- [Medium] drm/i915/dp_mst: ACT wait not skipped when payload was only allo=
cated locally
--

commit 5ef32ca1205b405f34627fa195a565342452c430
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp_mst: Skip link retrain and ACT for disconnected MST streams

This commit filters out pipes driving disconnected MST streams in
intel_dp_retrain_link() and skips generating and waiting for an ACT in
mst_stream_post_disable() when drm_dp_remove_payload_part1() reports that t=
he
payload was not removed from the branch device.

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

[Severity: High]
What happens in intel_dp_retrain_link() when an MST topology has both a
connected active stream and a disconnected (unregistered) active stream on =
the
same intel_dp?

Masking out the disconnected pipe leaves only the connected pipe in pipe_ma=
sk,
so intel_modeset_commit_pipes_for_atomic_state() sets
crtc_state->uapi.connectors_changed =3D true only on the connected pipe.

During intel_atomic_check(), mst_connector_atomic_topology_check() pulls the
disconnected pipe into the atomic state with crtc_state->uapi.mode_changed =
=3D
true and crtc_state->uapi.connectors_changed =3D false:

drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_connector_atomic_topology_c=
heck() {
	...
		ret =3D drm_atomic_add_affected_planes(&state->base, &crtc->base);
		if (ret)
			break;
		crtc_state->uapi.mode_changed =3D true;
	...
}

In intel_link_bw_init_limits(), because intel_dp_mst_stream_disconnected() =
is
true for the disconnected pipe, its max_bpp_x16 limit is preserved from
crtc_state->max_link_bpp_x16. When link rate and lane count are unchanged,
intel_pipe_config_compare() succeeds and intel_crtc_check_fastset() downgra=
des
the disconnected pipe to a fastset by clearing uapi.mode_changed =3D false.

In the post-fastset dependency loop in intel_atomic_check(), only slave
transcoders check whether their mst_master_transcoder needs a modeset:

drivers/gpu/drm/i915/display/intel_display.c:intel_atomic_check() {
	...
		if (intel_dp_mst_is_slave_trans(new_crtc_state)) {
			enum transcoder master =3D new_crtc_state->mst_master_transcoder;

			if (intel_cpu_transcoders_need_modeset(state, BIT(master)))
				intel_crtc_flag_modeset(new_crtc_state);
		}
	...
}

If the disconnected stream is on the MST master transcoder (or on any pipe =
on
DISPLAY_VER < 12), the disconnected pipe remains a fastset and is not disab=
led
during the commit. In mst_stream_post_disable() and mst_stream_pre_enable()
for the connected pipe, intel_dp->mst.active_streams transitions 2 -> 1 -> =
2,
so last_mst_stream and first_mst_stream are both false.

Since primary_encoder->pre_enable() (which runs intel_dp_start_link_train())
is only called when first_mst_stream is true in mst_stream_pre_enable(), wo=
n't
this skip link training completely while still clearing force_retrain in
intel_dp_retrain_link()?

[Severity: Medium]
In addition, can mst_stream_enable() still hit the 3000 ms ACT timeout when=
 a
disconnected MST stream is forced into a full modeset through other paths?

While mst_stream_post_disable() is updated to skip the ACT wait,
mst_stream_enable() still unconditionally triggers ACT and calls
drm_dp_check_act_status() even when drm_dp_add_payload_part1() in
mst_stream_pre_enable() failed to allocate the payload at the branch device:

drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_stream_pre_enable() {
	...
	ret =3D drm_dp_add_payload_part1(&intel_dp->mst.mgr, mst_state,
				       drm_atomic_get_mst_payload_state(mst_state, connector->mst.port)=
);
	if (ret < 0)
		intel_dp_queue_modeset_retry_for_link(state, primary_encoder, pipe_config=
);
	...
}

drivers/gpu/drm/i915/display/intel_dp_mst.c:mst_stream_enable() {
	...
	intel_de_rmw(display, TRANS_DDI_FUNC_CTL(display, trans), 0,
		     TRANS_DDI_DP_VC_PAYLOAD_ALLOC);

	intel_ddi_wait_for_act_sent(encoder, pipe_config);
	drm_dp_check_act_status(&intel_dp->mst.mgr);
	...
}

A disconnected MST stream can still undergo a full modeset in several cases:

1. When two or more MST streams are active when HPD drops and userspace
   disables the CRTC on mst_master_transcoder first:
   mst_connector_atomic_topology_check() pulls the remaining disconnected
   CRTCs on the same intel_dp into the commit with uapi.mode_changed =3D tr=
ue,
   mst_stream_compute_config_late() assigns a new mst_master_transcoder, and
   intel_pipe_config_compare() rejects fastset because mst_master_transcoder
   changed.

2. When intel_dp_retrain_link() runs with a connected stream on the MST mas=
ter
   transcoder and a disconnected stream on a slave transcoder (or when link=
 or
   DSC parameters change), forcing a full modeset on the disconnected slave
   pipe.

3. When reset_link_commit() in drivers/gpu/drm/i915/display/intel_tc.c comm=
its
   a modeset on all active pipes returned by intel_dp_get_active_pipes()
   without filtering disconnected MST pipes.

In all of these cases, drm_dp_add_payload_part1() fails with -EIO without
writing to DPCD 0x1c0-0x1c2, and mst_stream_enable() will still poll
drm_dp_check_act_status() for 3000 ms. Should mst_stream_enable() also avoid
waiting for ACT when the payload was not allocated on the branch device?

[ ... ]

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

[Severity: High]
Is it safe to skip clearing TRANS_DDI_DP_VC_PAYLOAD_ALLOC in
TRANS_DDI_FUNC_CTL when payload_removed is false in mst_stream_post_disable=
()?

When an MST stream is enabled in mst_stream_enable(), the driver sets
TRANS_DDI_DP_VC_PAYLOAD_ALLOC in TRANS_DDI_FUNC_CTL. Neither
intel_ddi_disable_transcoder_func() nor intel_ddi_post_disable_dp() clears
TRANS_DDI_DP_VC_PAYLOAD_ALLOC:

drivers/gpu/drm/i915/display/intel_ddi.c:intel_ddi_disable_transcoder_func(=
) {
	...
	ctl =3D intel_de_read(display,
			    TRANS_DDI_FUNC_CTL(display, cpu_transcoder));

	drm_WARN_ON(crtc->base.dev, ctl & TRANS_DDI_HDCP_SIGNALLING);

	ctl &=3D ~TRANS_DDI_FUNC_ENABLE;
	...
}

When payload_removed is false, skipping the intel_de_rmw() call leaves
TRANS_DDI_DP_VC_PAYLOAD_ALLOC set when intel_ddi_disable_transcoder_func()
disables TRANS_DDI_FUNC_ENABLE, and if another stream remains active on the
same MST link (!last_mst_stream), the source hardware's MST packetizer never
deallocates this transcoder's VC payload slots even though
drm_dp_remove_payload_part2() shifts the remaining payload slots in softwar=
e.

Since clearing TRANS_DDI_DP_VC_PAYLOAD_ALLOC and waiting for
DP_TP_STATUS_ACT_SENT via intel_ddi_wait_for_act_sent() is a local source M=
MIO
operation (with a 1 ms timeout), shouldn't TRANS_DDI_DP_VC_PAYLOAD_ALLOC st=
ill
be cleared unconditionally, or only the DPCD poll in drm_dp_check_act_statu=
s()
be skipped when the branch payload table wasn't updated?

[Severity: Medium]
Also in mst_stream_post_disable(), does the return value of
drm_dp_remove_payload_part1() accurately reflect whether the branch device's
payload table was modified?

Looking at drm_dp_remove_payload_part1() and
drm_dp_destroy_payload_at_remote_and_dfp() in
drivers/gpu/drm/display/drm_dp_mst_topology.c:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_remove_payload_part1()=
 {
	bool send_remove =3D false;

	mutex_lock(&mgr->lock);
	send_remove =3D drm_dp_mst_port_downstream_of_branch(payload->port, mgr->m=
st_primary);
	mutex_unlock(&mgr->lock);

	if (send_remove)
		drm_dp_destroy_payload_at_remote_and_dfp(mgr, mst_state, payload);
	...
	payload->payload_allocation_status =3D DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL;

	return send_remove;
}

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_destroy_payload_at_rem=
ote_and_dfp() {
	if (payload->payload_allocation_status =3D=3D DRM_DP_MST_PAYLOAD_ALLOCATIO=
N_REMOTE) {
		drm_dp_payload_send_msg(mgr, payload->port, payload->vcpi, 0);
		payload->payload_allocation_status =3D DRM_DP_MST_PAYLOAD_ALLOCATION_DFP;
	}

	if (payload->payload_allocation_status =3D=3D DRM_DP_MST_PAYLOAD_ALLOCATIO=
N_DFP)
		drm_dp_dpcd_write_payload(mgr->aux, payload->vcpi, payload->vc_start_slot=
, 0);
}

If an earlier modeset on this stream failed in drm_dp_add_payload_part1() (=
for
example due to a DPCD AUX failure in drm_dp_create_payload_at_dfp(), or
because a downstream port or secondary branch device was unlinked while
mgr->mst_primary remained the same root branch),
payload->payload_allocation_status is left as
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL and nothing was written to DPCD
0x1c0-0x1c2.

Because port->parent and mstb->port_parent are not cleared when a port or
secondary branch is unlinked, drm_dp_mst_port_downstream_of_branch() still
returns true as long as mgr->mst_primary has not been replaced. When the
stream is later disabled, drm_dp_destroy_payload_at_remote_and_dfp() does n=
ot
write to DPCD 0x1c0-0x1c2 because payload_allocation_status is LOCAL, yet
drm_dp_remove_payload_part1() still returns true, causing
mst_stream_post_disable() to wait 3000 ms for an ACT in
drm_dp_check_act_status().

> =20
>  	drm_dp_remove_payload_part2(&intel_dp->mst.mgr, new_mst_state,
>  				    old_payload, new_payload);
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
Can mst_connector_stream_disconnected() miss a disconnected stream if
intel_dp_retrain_link() runs before mgr->delayed_destroy_work finishes
unregistering the connector?

When an MST topology is torn down in drm_dp_mst_topology_mgr_set_mst(mgr,
false) or when a downstream branch is disconnected in
drm_dp_mst_handle_conn_stat(), mgr->mst_primary (or the parent port->mstb) =
is
cleared under mgr->lock, and drm_dp_destroy_mst_branch_device() queues
mgr->delayed_destroy_work to call drm_connector_unregister() asynchronously=
 in
drm_dp_delayed_destroy_port().

When the HPD comes back and intel_dp_detect() calls
drm_dp_mst_topology_mgr_set_mst(mgr, true) (or on a downstream branch unplug
where mgr->mst_state remains true throughout), mgr->mst_state is true while
mgr->delayed_destroy_work may not yet have run drm_connector_unregister() on
the old connector.

If intel_dp_retrain_link() -> intel_dp_mst_disconnected_pipes() runs during
that window, mst_connector_stream_disconnected() sees mgr.mst_state =3D=3D =
true
and drm_connector_is_unregistered(&connector->base) =3D=3D false, so it ret=
urns
false even though connector->mst.port is no longer in the topology, allowing
intel_dp_retrain_link() to select the stale pipe and trigger the 3000 ms ACT
timeout in mst_stream_enable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031154456.4654=
69-1-xiaolu.xie@intel.com?part=3D2
