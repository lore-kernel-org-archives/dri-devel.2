Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E355FC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8857610E687;
	Tue, 22 Sep 2026 09:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxvQNSIZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0192210E67D;
 Tue, 22 Sep 2026 09:41:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6F3360200;
 Tue, 22 Sep 2026 09:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBE81F000FF;
 Tue, 22 Sep 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790070078;
 bh=LHya0/GglELncdNHSpFeYJAf3zXB1g9erRglCafdRiQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lxvQNSIZl0Lly7KOPC6/qq8P/rR5/8ZbT4n/ccsurLkCmhG6dGlLeGjofJrYxqqk5
 4ytur4Lob/YQD+z972zRZUNsWJmednq42ExB3ANWntsImReOMerHR9GqF007NcIU98
 xgu5zeWIX4mKn4jFec3YFA686e7KIa3GYuEy6y56AH3Bz9nRaXrPN1qo0hUBWlE9HK
 pBQav2epoEsY7zHT+rkyzD4ALoIgJu2hiAmUfzdz3Lb4mlnp2b2UknXKlVGmHi0S/T
 59LD4SldZ7Yfb9WGpzyBnammawiil3PLcLzAF0tSxjmeuVhfXGyCKyCBj1e927pwJw
 F2+06uBmXGpwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/dp_mst: Track allocated_pbn from
 ALLOCATE_PAYLOAD down-reply
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260922092647.2263962-3-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
 <20260922092647.2263962-3-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:41:17 +0000
Message-Id: <20260922094118.6DBE81F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/dp_mst: Data race and logical flaw in allocated_pbn causes spu=
rious -ENOSPC
- [High] drm/dp_mst: Unvalidated allocated_pbn from device causes permanent=
 DoS
--

commit 4a7c9a56c428ab20bf4027cd5c4e8a720688111a
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD down-reply

This commit stores the allocated_pbn returned by the ALLOCATE_PAYLOAD
down-reply sideband message. It uses the larger of requested PBN and
allocated PBN for the MST bandwidth limit checks, carrying the value across
dependent atomic commits.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 7ce9e212770ad..b0e4cf8458eda 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3166,10 +3167,14 @@ static int drm_dp_payload_send_msg(struct drm_dp_=
mst_topology_mgr *mgr,
>  	 */
>  	ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
>  	if (ret > 0) {
> -		if (txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK)
> +		if (txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK) {
>  			ret =3D -EINVAL;
> -		else
> +		} else {
> +			if (payload)
> +				payload->allocated_pbn =3D
> +					txmsg->reply.u.allocate_payload.allocated_pbn;

[Severity: High]
Is it safe to write to the active atomic state payload from an asynchronous
worker here without modeset locks?

If drm_dp_add_payload_part2() locklessly mutates allocated_pbn concurrently
with drm_dp_mst_duplicate_state(), could this result in a data race?

[Severity: High]
Is this untrusted 16-bit value from the branch device saved into the payload
state here without bounds checking?

If a malicious or malfunctioning branch device replies to the
ALLOCATE_PAYLOAD message with a spoofed allocated_pbn value (e.g., 65535),
could it be stored directly without validation?

>  			ret =3D 0;
> +		}
>  	}
>  	kfree(txmsg);
>  fail_put:
[ ... ]
> @@ -4670,6 +4678,7 @@ void drm_dp_mst_atomic_wait_for_dependencies(struct=
 drm_atomic_commit *state)
>  			new_payload =3D drm_atomic_get_mst_payload_state(new_mst_state,
>  								       old_payload->port);
>  			new_payload->vc_start_slot =3D old_payload->vc_start_slot;
> +			new_payload->allocated_pbn =3D old_payload->allocated_pbn;

[Severity: High]
Could this unconditional restore overwrite the 0 set by
drm_dp_atomic_find_time_slots() during the atomic check phase?

If it does, could it inflate the perceived bandwidth for concurrent checks?

>  			new_payload->payload_allocation_status =3D
>  							old_payload->payload_allocation_status;
>  		}
[ ... ]
> @@ -5352,7 +5361,7 @@ drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp=
_mst_port *port,
>  			return -EINVAL;
>  		}
> =20
> -		pbn_used =3D payload->pbn;
> +		pbn_used =3D max(payload->pbn, payload->allocated_pbn);

[Severity: High]
Does evaluating this max() with a potentially stale or artificially inflated
value concurrently produce incorrect bandwidth checks?

If so, could it cause spurious -ENOSPC failures in bandwidth validation,
causing display configurations to fail randomly?

Also, if a maliciously huge value was evaluated here, could it force
pbn_used > port->full_pbn, failing the check?

Since the topology check iterates over all payloads, could this permanently
prevent any future display configurations on this topology?

>  	} else {
>  		pbn_used =3D drm_dp_mst_atomic_check_mstb_bw_limit(port->mstb,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922092647.2263=
962-1-xiaolu.xie@intel.com?part=3D2
