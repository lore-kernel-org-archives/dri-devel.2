Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC27C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA0E10EBFA;
	Tue,  8 Sep 2026 13:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KJpqqfFT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895BF10EBFA
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:45:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C87B42E7F;
 Tue,  8 Sep 2026 13:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E991D1F00A3A;
 Tue,  8 Sep 2026 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788875149;
 bh=CGg/2UkLfJeJ+k5jR9FOoTHDWlC07NhBd74Oy+A1F8I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KJpqqfFTQX/5Nf7nYF5YcIe6ezMnTaPqzmTopj0DSDk5RCARkSvGdw/wGl5m+k2MC
 Y4J24tb4kO+ylZssGplSj2l3fTRKlfDsQt/aH+gI+bGhHfEGwf1rrRCUkEzFXoO4dh
 EFU7p8eGRNl5tOhLzbxSIMXzluiNZ27XcYTdHenVFiVTiDm0DATPGcgDszW4IV0slG
 wvNovDW0eOThB5LSYZ+lQ56NabqxvfjGnAJKiX4kvPkN5yQ8sqwp2tQdv+r28o3zCW
 XfC1NtIWLgv5azgobksI17b53cD55NcnBKUW5PBKYbKjNYS/28pGxtck+kEqPAMncm
 RLY/E41ylhNpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD
 down-reply
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908132844.2309047-1-xiaolu.xie@intel.com>
References: <20260908132844.2309047-1-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:45:48 +0000
Message-Id: <20260908134548.E991D1F00A3A@smtp.kernel.org>
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
- [High] Data race and TOCTOU flaw on payload->allocated_pbn.
- [Medium] Stale allocated_pbn constraint leads to spurious -ENOSPC errors =
when reducing bandwidth.
--

commit 51837e7219143c6b9b0e48d938f61a3258bf06cd
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD down-reply

The DP MST ALLOCATE_PAYLOAD sideband message returns the payload bandwidth
actually allocated by the branch in the allocated_pbn field of the down-rep=
ly.
That value may differ from the requested PBN when an intermediate branch
applies its own constraints, so the source should keep track of it instead
of only relying on the local request.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 7ce9e212770ad..86a42c5e2debb 100644
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

[Severity: High]
Can this write to payload->allocated_pbn cause a data race with concurrent
atomic checks?

When a non-blocking mode commit runs atomic_commit_tail in a workqueue, it
writes to payload->allocated_pbn here. Concurrently, if userspace initiates=
 a
new atomic check, it calls drm_dp_mst_duplicate_state(), which synchronously
copies the active payload object:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_mst_duplicate_state() {
    ...
    list_for_each_entry(pos, &old_state->payloads, next) {
        ...
        payload =3D kmemdup(pos, sizeof(*payload), GFP_KERNEL);
    ...
}

This unsynchronized kmemdup() could result in a torn read of
payload->allocated_pbn, which is later evaluated during the atomic check in
drm_dp_mst_atomic_check_port_bw_limit().

>  			ret =3D 0;
> +		}
>  	}
>  	kfree(txmsg);
>  fail_put:
[ ... ]
> @@ -5352,7 +5359,7 @@ drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp=
_mst_port *port,
>  			return -EINVAL;
>  		}
> =20
> -		pbn_used =3D payload->pbn;
> +		pbn_used =3D max(payload->pbn, payload->allocated_pbn);

[Severity: Medium]
Will this stale payload->allocated_pbn constraint lead to spurious -ENOSPC
errors when reducing bandwidth?

If userspace initially sets a high resolution, payload->allocated_pbn is
populated with a high bandwidth value. Later, if userspace requests a lower
resolution, drm_dp_atomic_find_time_slots() updates payload->pbn but leaves
payload->allocated_pbn unchanged:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_atomic_find_time_slots=
() {
    ...
    payload->time_slots =3D req_slots;
    payload->pbn =3D pbn;
    return req_slots;
}

Because payload->allocated_pbn is not cleared or updated,
max(payload->pbn, payload->allocated_pbn) will resolve to the old, larger
bandwidth. This could falsely fail the bandwidth limit check and prevent
userspace from reclaiming bandwidth for other displays.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908132844.2309=
047-1-xiaolu.xie@intel.com?part=3D1
