Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581F1C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8947B10EE51;
	Wed,  9 Sep 2026 02:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B3CapV3i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297B710EE51
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 02:19:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0C14601FD;
 Wed,  9 Sep 2026 02:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A91F00A3A;
 Wed,  9 Sep 2026 02:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788920379;
 bh=xqboQLYNpTQDU5jSB8KVvlv7LwXsg1SzZmXf1PNInVE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B3CapV3ifQn0uxfCfhiAb+CiVlieaAX0uGo11zlBqiJFOAIxqW52p3PsZYKFkLk5U
 tVnOkVmGB6eu45UsLsn4P1xUfGeBjLE+EWS2hoJVfjNEZMJkY5ONPDesbpd7iUlAAt
 Z/opKnKo/rAu0XPTVZFWfXAtFp1OtU/Su7QvpDAXTjb508WSPbG+ciktC824QKHjNn
 3hdk0FA+KHsp5smPy9wem0nTWwIVoIGt7rd9O1e3f6IxRP9nuJmgXkeOdmPMr6Jb6N
 8NlGHvXEvWztSl/9iJOxO/9l4M2yZbZ0wktQyPq4YfNNkBy+B27X+S6Fnnv4thsECC
 KUPQS55B0XLsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/dp_mst: Track allocated_pbn from
 ALLOCATE_PAYLOAD down-reply
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909020448.4014238-1-xiaolu.xie@intel.com>
References: <20260908132844.2309047-1-xiaolu.xie@intel.com>
 <20260909020448.4014238-1-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:19:38 +0000
Message-Id: <20260909021939.381A91F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and stale state usage for `allocated_pbn` between asynch=
ronous commit tail and synchronous atomic check.
--

commit 60c9feaab7e5f91e4bacf61ee648e76157adea65
Author: Xiao Lu <xiaolu.xie@intel.com>
drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD down-reply

This commit stores the allocated_pbn returned by the ALLOCATE_PAYLOAD
down-reply sideband message and uses it to perform bandwidth limit checks
based on the larger of the requested and allocated PBN.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 7ce9e212770ad..b0e4cf8458eda 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
[ ... ]
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
>  			ret =3D 0;
> +		}
>  	}
>  	kfree(txmsg);
>  fail_put:

[Severity: High]
Does modifying payload->allocated_pbn asynchronously here in
drm_dp_payload_send_msg() during the commit tail introduce a data race?

When a non-blocking atomic commit updates the topology, its asynchronous
commit tail waits for the ALLOCATE_PAYLOAD reply. If a subsequent atomic
commit ioctl triggers the atomic check phase concurrently, that check
phase duplicates the MST state without locks, which could capture a
partially updated or zeroed allocated_pbn.

[ ... ]
> @@ -4670,6 +4678,7 @@ void drm_dp_mst_atomic_wait_for_dependencies(struct=
 drm_atomic_commit *state)
>  			new_payload =3D drm_atomic_get_mst_payload_state(new_mst_state,
>  								       old_payload->port);
>  			new_payload->vc_start_slot =3D old_payload->vc_start_slot;
> +			new_payload->allocated_pbn =3D old_payload->allocated_pbn;
>  			new_payload->payload_allocation_status =3D
>  							old_payload->payload_allocation_status;
>  		}

[Severity: High]
Since drm_dp_mst_atomic_wait_for_dependencies() is executed in the commit
tail after dependencies resolve, does copying allocated_pbn here mean the
check phase of the current commit has already executed?

If so, the check phase would have already run using the un-updated, stale
value of allocated_pbn from the previous commit state before this
synchronization occurs.

[ ... ]
> @@ -5352,7 +5361,7 @@ drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp=
_mst_port *port,
>  			return -EINVAL;
>  		}
> =20
> -		pbn_used =3D payload->pbn;
> +		pbn_used =3D max(payload->pbn, payload->allocated_pbn);
>  	} else {
>  		pbn_used =3D drm_dp_mst_atomic_check_mstb_bw_limit(port->mstb,
>  								 state,

[Severity: High]
Does reading payload->allocated_pbn here in
drm_dp_mst_atomic_check_port_bw_limit() risk bypassing bandwidth validation
if the previous hardware reply hasn't arrived yet?

If unprivileged userspace (like a Wayland compositor) submits rapid
back-to-back atomic commits, the check phase here could evaluate
max(payload->pbn, payload->allocated_pbn) using a stale or zeroed value.
This might allow configurations that exceed link bandwidth because
intermediate branch constraints would be silently ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909020448.4014=
238-1-xiaolu.xie@intel.com?part=3D1
