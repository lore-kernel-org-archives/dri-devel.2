Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39DEC98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6C210F406;
	Thu, 24 Sep 2026 09:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QjSloAa4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1323610F406;
 Thu, 24 Sep 2026 09:57:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE158406C2;
 Thu, 24 Sep 2026 09:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C261F000FF;
 Thu, 24 Sep 2026 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790243878;
 bh=bZz8JRI65c5HlFEfDtjm2kJXKznzd91PmpGvaasxK6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QjSloAa4axeUj8DJ9FXHtmOpUiC4Yy924v7cFHxOiw4HWwpySBz3Z3cQPtece3/Lb
 0yhuDIKnaOYbqKj6oh3dp2pAzwt5bmWt6E7LVMnuWe1orhLxOTZ7OMcP3NqMgW4Dbs
 St/mWseplxwdqIu30ueWWnDbZ5Oe4aKUDhchVQ0rtNS2ELF/9mB5LmpyBcuLKYAP+e
 C0gdH+s3sMuePJgySas327uedsMrWPgebkuHx+02WYKgpjn03jH67uurBeQGM3of+O
 rTQ1n7IcEOeFWmeY6K2XwLPHsHh81cO6lxvsFbR2ZMUOfsIUx3CUkDzUCKP0JeZa3j
 zxvANeesqCM3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/dp_mst: Track allocated_pbn from
 ALLOCATE_PAYLOAD down-reply
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260924094316.822211-3-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
 <20260924094316.822211-1-xiaolu.xie@intel.com>
 <20260924094316.822211-3-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:57:57 +0000
Message-Id: <20260924095758.50C261F000FF@smtp.kernel.org>
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
- [High] drm/dp_mst: data race on allocated_pbn can bypass bandwidth limits
- [Medium] drm/dp_mst: bandwidth check fails on shrinking payloads due to s=
tale allocated_pbn
--

commit d52065aed1fa389dfd394c9d3cae48a882973e04
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD down-reply

This commit stores the reported PBN from an ALLOCATE_PAYLOAD reply. It uses
the larger of the requested and allocated PBN for bandwidth checks to accou=
nt
for constraints applied by intermediate branches along the path.

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
Can this lockless write to payload->allocated_pbn race with an atomic check?

If a non-blocking atomic commit is executing asynchronously, it receives the
ALLOCATE_PAYLOAD reply and drm_dp_payload_send_msg() updates allocated_pbn
without locks. Concurrently, if userspace initiates a new atomic check,
drm_dp_mst_duplicate_state() will copy the payload struct via kmemdup().

Could this result in the atomic check reading a torn or stale value when
evaluating max(payload->pbn, payload->allocated_pbn) in
drm_dp_mst_atomic_check_port_bw_limit(), potentially bypassing bandwidth
constraints?

>  			ret =3D 0;
> +		}
>  	}
>  	kfree(txmsg);
>  fail_put:

[ ... ]

> @@ -4575,6 +4580,7 @@ int drm_dp_atomic_release_time_slots(struct drm_ato=
mic_commit *state,
>  	drm_dbg_atomic(mgr->dev, "[MST PORT:%p] TU %d -> 0\n", port, payload->t=
ime_slots);
>  	if (!payload->delete) {
>  		payload->pbn =3D 0;
> +		payload->allocated_pbn =3D 0;

[Severity: Medium]
Does this properly handle payloads that shrink in size?

Since payload->allocated_pbn is only cleared here when releasing the payload
entirely (during a full deletion), what happens if a commit simply shrinks =
an
existing payload (for example, switching to a smaller display mode on the
same CRTC)?

In that scenario, drm_dp_atomic_release_time_slots() skips active CRTCs,
meaning allocated_pbn remains at its old, larger value. When the new
bandwidth is checked, max(payload->pbn, payload->allocated_pbn) in
drm_dp_mst_atomic_check_port_bw_limit() would yield the old larger value,
which could falsely prevent the freed bandwidth from being reallocated to
other displays.

>  		payload->delete =3D true;
>  		if (payload->vcpi > 0)
>  			topology_state->payload_mask &=3D ~BIT(payload->vcpi - 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924094316.8222=
11-1-xiaolu.xie@intel.com?part=3D2
