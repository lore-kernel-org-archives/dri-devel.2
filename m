Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D30CC6B29
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD4310FC2D;
	Wed, 14 Oct 2026 08:40:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB66D10FC28;
 Wed, 14 Oct 2026 08:40:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DEC960213;
 Wed, 14 Oct 2026 08:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B94C1F000FF;
 Wed, 14 Oct 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791967238;
 bh=SlXHMx6hon0Cj1iTj1cb6JD1sfElX9hEVQ51/FVZ7PA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KOb9fMnstYgOE3YuRjY8VkcxwnxUZys7B7iRdSquMBbw4sjjfiC0LQ+cVPvEK6bZx
 Z5r1FgYd968RE8xphsqZTRA1tTeXeG4gc/x5FH6r4TuouUGzMqL2uJ5rolis53FiMl
 +LJ5zpTzVqolNFm/4shb2KHu4N454L7Eeqq9fkmP/huwDSuMq0Xlvf/Z0LDyd9mz60
 pt+ShgLjfUPGeokXlmBIiYRTJviBnatOGkwbUJbX185fftO/0IpOhrl3xtD/pgxcI3
 vItNNPIfBXajBqAS7iarFAyKE7MDZJG/B3xQNqe5VooQ6mZZzOpXCCemHUFLnE1fiO
 IFiow1M8rvpSQ==
Message-ID: <sashiko-outbox-171030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp: clear and restore MSTM_CTRL around MST
 DPMS off/on
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014081448.2320363-1-xiaolu.xie@intel.com>
References: <20261014081448.2320363-1-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:40:38 +0000
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
- [High] drm/i915/dp: clearing DP_MSTM_CTRL on DPMS OFF breaks MST topology
--

commit 7efe593dfb9be6f1dddd0b7978cd417266811e58
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS off/on

This commit modifies the MST stream disable path to clear MSTM_CTRL before
sending D3, and restores it on re-enable. This is done so the hub is back
in MST mode before processing the PHY power-up and retraining downstream
links.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index a46ab5d3d70fc..7e4e18345ec17 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3163,6 +3163,8 @@ static void intel_ddi_post_disable_dp(struct intel_=
atomic_state *state,
>  	 * Power down sink before disabling the port, otherwise we end
>  	 * up getting interrupts from the sink on detecting link loss.
>  	 */
> +	if (is_mst)
> +		drm_dp_dpcd_write_byte(&intel_dp->aux, DP_MSTM_CTRL, 0);

[Severity: High]
Does clearing DP_MSTM_CTRL to 0 here cause the entire MST topology to be
torn down unexpectedly?

By wiping the MST hardware state on the hub without notifying the software
topology manager, if a user-space compositor or sysfs polls the connector
during DPMS OFF, intel_dp_detect() will read DP_MSTM_CTRL as 0.

In intel_dp_mst_verify_dpcd_state():
	ret =3D drm_dp_dpcd_read_byte(intel_dp->mst.mgr.aux, DP_MSTM_CTRL, &val);

	if (ret < 0 || val !=3D (DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC)) {
		...

This will return false, causing intel_dp_detect() to force a connector
disconnect:

	if (status !=3D connector_status_disconnected &&
	    !intel_dp_mst_verify_dpcd_state(intel_dp))
		...
		status =3D connector_status_disconnected;

>  	intel_dp_set_power(intel_dp, DP_SET_POWER_D3);
> =20
>  	if (DISPLAY_VER(display) >=3D 12) {

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 7023619aaaba9..4109bb9284fd0 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -1270,8 +1270,12 @@ static void mst_stream_pre_enable(struct intel_ato=
mic_state *state,
>  	drm_WARN_ON(display->drm, DISPLAY_VER(display) >=3D 12 && first_mst_str=
eam &&
>  		    !intel_dp_mst_is_master_trans(pipe_config));
> =20
> -	if (first_mst_stream)
> +	if (first_mst_stream) {
>  		intel_dp_set_power(intel_dp, DP_SET_POWER_D0);
> +		drm_dp_dpcd_write_byte(&intel_dp->aux, DP_MSTM_CTRL,
> +				       DP_MST_EN | DP_UP_REQ_EN |
> +				       DP_UPSTREAM_IS_SRC);
> +	}
> =20
>  	drm_dp_send_power_updown_phy(&intel_dp->mst.mgr, connector->mst.port, t=
rue);

[Severity: High]
Since DP_MSTM_CTRL is restored here on DPMS ON, the hardware returns to MST
mode, but the software manager (drm_dp_mst_topology_mgr) is unaware of the
reset and hasn't been prompted to send a LINK_ADDRESS broadcast.

Will the immediate drm_dp_send_power_updown_phy() sideband message fail
because the hub lacks downstream routing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014081448.2320=
363-1-xiaolu.xie@intel.com?part=3D1
