Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49203C61DCB
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615B410E162;
	Sat, 29 Aug 2026 17:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NtMkYzqb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB8C10E162
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 17:46:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 340BD4356D;
 Sat, 29 Aug 2026 17:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB95B1F000E9;
 Sat, 29 Aug 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788025608;
 bh=waW53V1e3MBaSA8J5yNzkXfKj00CxXtKPCEcEWec/js=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NtMkYzqbtWch8NPmuYbILl9WtM8U+o7wsXFBvPNkzKqc5ljYG66hR9y23fNranLAO
 MwYgGacszFiJhG+HO3p0a9/l3LI7MdxAyGuYkUfj6tuiWXZmyI1G2Mc87qjR8EjyDH
 to0jmDJn18jCjtqMNzAB2t46fDqWx7hxh+RSCWK30zlt/dMgMqXGdVWDKMP2y00Jeq
 MPHrnLsNuiDnCDSHfqonCtbxjXRZbJc3IUITsXcC5rbSBE+qoLqYQSuKbSRxNTg47v
 YKNzGfWUQBHQ9qCPDIwiVcGxihZbDjk1+SPQbewjEXCGRPU//ahTpPAX/z31WJ0VSc
 RVWzsarkahwEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: set remote MST sink power state on
 payload changes
To: "Maximilian Passarello" <git@0xMax42.io>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829-mst-remote-sink-power-v1-1-b9eab331e0d5@0xMax42.io>
References: <20260829-mst-remote-sink-power-v1-1-b9eab331e0d5@0xMax42.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 17:46:47 +0000
Message-Id: <20260829174647.EB95B1F000E9@smtp.kernel.org>
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
- [High] The patch introduces calls to sleeping functions (`usleep_range` a=
nd `mutex_lock`) within the display hardware sequencer path.
--

commit 407e2ac8f541eab206fd802accc0990f9bef0e0a
Author: Maximilian Passarello <git@0xMax42.io>

drm/amd/display: set remote MST sink power state on payload changes

This commit addresses downstream MST displays keeping their backlight on
after DPMS off by setting the remote sink to D0 before allocating its
payload and to D3 before removing it.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index ab15ceec4daa0..ce27024a95933 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
[ ... ]
> @@ -388,11 +389,23 @@ bool dm_helpers_dp_mst_write_payload_allocation_tab=
le(
>  	new_payload =3D drm_atomic_get_mst_payload_state(mst_state, aconnector-=
>mst_output_port);
> =20
>  	if (enable) {
> +		ret =3D drm_dp_link_power_up(&aconnector->mst_output_port->aux,
> +					   aconnector->mst_output_port->dpcd_rev);

[Severity: High]
Does calling drm_dp_link_power_up() here introduce a sleeping function into
an atomic hardware sequencer path?

The dm_helpers_dp_mst_write_payload_allocation_table() function is called by
the hardware sequencer during MST payload updates. Looking at
drm_dp_link_power_up() in drm_dp_helper.c, it internally uses usleep_range()
and takes a mutex via drm_dp_dpcd_readb() during DPCD auxiliary access.

Calling sleeping functions from atomic commit tail variants and hardware
sequencer paths can cause "scheduling while atomic" warnings, system
instability, and deadlocks.

> +		if (ret < 0)
> +			drm_dbg_dp(mst_mgr->dev,
> +				   "Failed to power up remote MST sink: %d\n", ret);
> +
>  		target_payload =3D new_payload;
> =20
>  		/* It's OK for this to fail */
>  		drm_dp_add_payload_part1(mst_mgr, mst_state, new_payload);
>  	} else {
> +		ret =3D drm_dp_link_power_down(&aconnector->mst_output_port->aux,
> +					     aconnector->mst_output_port->dpcd_rev);

[Severity: High]
Similarly, does drm_dp_link_power_down() introduce sleeping operations in
the atomic disable sequence?

Like the enable path, this introduces DPCD mutex locks into an atomic
hardware sequencer path where sleeping is forbidden.

> +		if (ret < 0)
> +			drm_dbg_dp(mst_mgr->dev,
> +				   "Failed to power down remote MST sink: %d\n", ret);
> +
>  		/* construct old payload by VCPI*/
>  		dm_helpers_construct_old_payload(mst_mgr, mst_state,
>  						 new_payload, &old_payload);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-mst-remote=
-sink-power-v1-1-b9eab331e0d5@0xMax42.io?part=3D1
