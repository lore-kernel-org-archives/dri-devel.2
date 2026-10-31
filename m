Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B79606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbRzizqi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA47110E043;
	Sat, 31 Oct 2026 16:06:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4FE10E043;
 Sat, 31 Oct 2026 16:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31BEF43659;
 Sat, 31 Oct 2026 16:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA11B1F000C1;
 Sat, 31 Oct 2026 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793462755;
 bh=EVssjK4HVyl17IFALm6vb8uyc2qDf4vCdvgSftIVCRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IbRzizqiTQRrEYLMo/Kwi+sYGWqblkHhjPpKuL2tJOWuN34zkGDjEP7QMf0t8T2/f
 dhKS5yEF9VJWkTFK3UJIY2LXzJ7Nz/KeEkdLLYFr7COemPxS5FL5I+xawuMRa5/lml
 oeXJkxs2f8iayN72hno/u8iRBTgrzzQ1nAoZJGrKongsPZjrT1CoZvKd5lT2S/X/2l
 v3O/fN1A3ckg3TkSrNrYzthEJ7Vic+MfNIKlVg1vG0Fk52k0mWj8EVCA/RyRX8KoGn
 tlmeIyXky5cgX/55PaDd1tY8kfAtRCb9G4reX49G0cS541z1ouPE5qgCbOfROPs0DI
 Y7fXO9VKNQI5A==
Message-ID: <sashiko-outbox-192030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 1/2] drm/dp_mst: Return whether
 drm_dp_remove_payload_part1() removed the payload
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031154456.465469-2-xiaolu.xie@intel.com>
References: <20261031154456.465469-1-xiaolu.xie@intel.com>
 <20261031154456.465469-2-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:05:54 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/dp_mst: drm_dp_remove_payload_part1() returns true when no p=
ayload removed
--

commit bd40c8f829b5d0efffbe970022942f5fcad0e46a
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp_mst: Return whether drm_dp_remove_payload_part1() removed the payload

This commit changes drm_dp_remove_payload_part1() to return a boolean
indicating whether the payload removal was sent to the branch devices,
allowing callers to skip generating and waiting for an ACT when nothing was
sent.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index b7fce0bf8acc5..82c9c53b3fa96 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3375,8 +3375,14 @@ EXPORT_SYMBOL(drm_dp_add_payload_part1);
>   * Removes a payload along the virtual channel if it was successfully al=
located.
>   * After calling this, the driver should set HW to generate ACT and then=
 switch to new
>   * payload allocation state.
> + *
> + * Returns:
> + * %true if the port of the payload is in the topology, so the removal w=
as
> + * sent to the branch devices and the driver should generate the ACT and=
 wait
> + * for it. %false if the port is not in the topology anymore, so nothing=
 was
> + * sent to the branch devices and there is no ACT to generate or wait fo=
r.
>   */
> -void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
> +bool drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_topology_state *mst_state,
>  				 struct drm_dp_mst_atomic_payload *payload)
>  {
> @@ -3394,6 +3400,8 @@ void drm_dp_remove_payload_part1(struct drm_dp_mst_=
topology_mgr *mgr,
>  			    payload->vcpi);
> =20
>  	payload->payload_allocation_status =3D DRM_DP_MST_PAYLOAD_ALLOCATION_LO=
CAL;
> +
> +	return send_remove;
>  }
>  EXPORT_SYMBOL(drm_dp_remove_payload_part1);

[Severity: Medium]
Can drm_dp_remove_payload_part1() return true here even when no payload
removal was sent to the branch devices or written to the DFP DPCD payload
table?

In drm_dp_remove_payload_part1(), send_remove is determined solely by
drm_dp_mst_port_downstream_of_branch(payload->port, mgr->mst_primary).
However, drm_dp_destroy_payload_at_remote_and_dfp() only sends sideband
removal and updates the DFP DPCD payload table when
payload->payload_allocation_status is DRM_DP_MST_PAYLOAD_ALLOCATION_REMOTE =
or
DRM_DP_MST_PAYLOAD_ALLOCATION_DFP:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_destroy_payload_at_rem=
ote_and_dfp() {
	/* it's okay for these to fail */
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

During stream enable in drm_dp_add_payload_part1(),
payload->payload_allocation_status is initialized to
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL. If
drm_dp_mst_topology_get_port_validated(mgr, payload->port) returns NULL (for
instance, when a downstream port or sub-branch was unlinked while
mgr->mst_primary remained connected) or if drm_dp_create_payload_at_dfp()
fails, drm_dp_add_payload_part1() returns early without programming the DFP
DPCD payload table, leaving payload->payload_allocation_status as
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL.

When the stream is later disabled, drm_dp_mst_port_downstream_of_branch()
walks the malloc-referenced port->parent and mstb->port_parent pointers and
returns true as long as mgr->mst_primary is still the same root branch
object:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_mst_port_downstream_of=
_branch() {
	while (port->parent) {
		if (port->parent =3D=3D branch)
			return true;

		if (port->parent->port_parent)
			port =3D port->parent->port_parent;
		else
			break;
	}
	return false;
}

Because payload->payload_allocation_status is still
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL,
drm_dp_destroy_payload_at_remote_and_dfp() does nothing, yet
drm_dp_remove_payload_part1() returns true and causes callers to generate an
ACT and poll DPCD 0x2c0 in drm_dp_check_act_status() until the 3 second
timeout expires.

Should drm_dp_remove_payload_part1() check payload->payload_allocation_stat=
us
(or whether the DFP payload table was actually updated) and update its
kernel-doc accordingly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031154456.4654=
69-1-xiaolu.xie@intel.com?part=3D1
