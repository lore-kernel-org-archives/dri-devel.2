Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4B606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It+/Af8o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9502A10E02C;
	Sat, 31 Oct 2026 16:00:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7391310E02C;
 Sat, 31 Oct 2026 16:00:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C64A6020F;
 Sat, 31 Oct 2026 16:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832F1F000C1;
 Sat, 31 Oct 2026 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793462405;
 bh=Am5dz7IkSBTLv3uNFYp+aKuq1pWq0I4xFwyosv1rbBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=It+/Af8oVv/XhbLwpeM99HvbxW7Y3P6+2nS+jImv3UqYhbgme8JXNyJ3HSNRnM6p1
 S9avMV00d4TyNbeDFiUOgvUcUrkMMudtSOq2Jv4mav0+Os6TLROl/CJWxYv4/1lnzp
 s/vyC/DW+6ytkgVxV6NT/8Zq3CXYxLbP/s5NRpwSpJ4bE7aEPNIFfZTgor8yu/9moW
 7+grfTGUqmhv8J+ENDKpKknwhKughgjkFrbn6T8BeR4yRGs5oxw0q4Juo69l+8+M0f
 JmfTlKCqv/Yzin/hsT/lWPqw0BXOEwkDKWnNnB2uqGjSahKnIhNcDVNKC1M9FLvGD2
 U0GISq/y9Of8A==
Message-ID: <sashiko-outbox-192029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/dp_mst: Return whether
 drm_dp_remove_payload_part1() removed the payload
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031153550.444676-2-xiaolu.xie@intel.com>
References: <20261031153550.444676-2-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:00:04 +0000
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
- [Medium] drm/dp_mst: drm_dp_remove_payload_part1() returns true when no r=
emoval is sent
--

commit c8db41e1060632039b0824f7c27d83352d6e3bba
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp_mst: Return whether drm_dp_remove_payload_part1() removed the payload

This commit changes drm_dp_remove_payload_part1() to return a boolean
indicating whether the payload removal was sent to the branch devices so
drivers can skip generating and waiting for an ACT when the port is no
longer in the topology.

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

[Severity: Medium]
Can drm_dp_remove_payload_part1() return true here even when no removal was
sent to the branch devices or written to the DFP DPCD payload table?

In drivers/gpu/drm/display/drm_dp_mst_topology.c, drm_dp_add_payload_part1()
initializes payload->payload_allocation_status to
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL before validating the port and writing
the DFP payload table:

	payload->payload_allocation_status =3D DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL;

	/* Allocate payload to immediate downstream facing port */
	port =3D drm_dp_mst_topology_get_port_validated(mgr, payload->port);
	if (!port) {
		drm_dbg_kms(mgr->dev,
			    "VCPI %d for port %p not in topology, not creating a payload to remo=
te\n",
			    payload->vcpi, payload->port);
		return -EIO;
	}

	ret =3D drm_dp_create_payload_at_dfp(mgr, payload);
	if (ret < 0) {
		drm_dbg_kms(mgr->dev, "Failed to create MST payload for port %p: %d\n",
			    payload->port, ret);
		goto put_port;
	}

If drm_dp_mst_topology_get_port_validated() returns NULL because a
downstream port or sub-branch was unlinked while mgr->mst_primary remained
connected, or if drm_dp_create_payload_at_dfp() fails,
payload->payload_allocation_status stays DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL
and DPCD 0x1c0-0x1c2 is not updated.

When the stream is subsequently disabled, drm_dp_remove_payload_part1()
computes send_remove via:

	send_remove =3D drm_dp_mst_port_downstream_of_branch(payload->port, mgr->m=
st_primary);

Because drm_dp_mst_port_downstream_of_branch() only walks port->parent and
port->parent->port_parent (which remain set until malloc_kref release),
send_remove evaluates to true as long as mgr->mst_primary has not been
replaced.

It then calls drm_dp_destroy_payload_at_remote_and_dfp():

	if (payload->payload_allocation_status =3D=3D DRM_DP_MST_PAYLOAD_ALLOCATIO=
N_REMOTE) {
		drm_dp_payload_send_msg(mgr, payload->port, payload->vcpi, 0);
		payload->payload_allocation_status =3D DRM_DP_MST_PAYLOAD_ALLOCATION_DFP;
	}

	if (payload->payload_allocation_status =3D=3D DRM_DP_MST_PAYLOAD_ALLOCATIO=
N_DFP)
		drm_dp_dpcd_write_payload(mgr->aux, payload->vcpi, payload->vc_start_slot=
, 0);

When payload->payload_allocation_status is
DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL (or DRM_DP_MST_PAYLOAD_ALLOCATION_NONE),
drm_dp_destroy_payload_at_remote_and_dfp() does nothing at all.

Returning send_remove unconditionally in that state will tell callers to
generate an ACT and poll DPCD 0x2c0 for up to 3 seconds even though the DFP
payload table was never modified. Should the return value also check whether
payload->payload_allocation_status was DFP or REMOTE (or whether the DFP
payload table was actually updated)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031153550.4446=
76-1-xiaolu.xie@intel.com?part=3D1
