Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E7C55171
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 15:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2DA10E1F5;
	Sun,  2 Aug 2026 15:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jRZ2u5d7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B69A10E110
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:55:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0332141FB8;
 Sun,  2 Aug 2026 15:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561381F000E9;
 Sun,  2 Aug 2026 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785686136;
 bh=vRE7BqVz2iEojLrscidbyM2uoiEMjtUhNhmwCfvBL1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jRZ2u5d7puM8vhe2eaWsf1tyIKqLBF0lBCn43jc9a7z6stFfq9HfGIQa75cY8aKuM
 sl2B2RGZQ7kXks/ASNGsFPr+aQ1vLdAsHBlOf+lXDgTHVnwUx7iyqBcivVM3FgAzrU
 1XoaxKKAZHCO7NjwWmWK34dnFf/PVX1z5coW9tQPpFiYcKfhggKNWZOMJ9iqUIXF/u
 KItI0yB2bZtNALEpGnMVvLGKSR+LF8CYo8+8et/gomu3lxJFngs2ES3DN2pnkK9ywa
 5LuBPAwHV/iC3wDL0gti+YGAKwuvfrC4J23tzG1ngAgmEZ1Gx4Q2OkkVXHoTNwFOXd
 czAsfrTDg4eMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
To: "Yashas D" <y-d@ti.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260802153825.1570435-3-y-d@ti.com>
References: <20260802153825.1570435-1-y-d@ti.com>
 <20260802153825.1570435-3-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:55:35 +0000
Message-Id: <20260802155536.561381F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Polling `.detect()` breaks DPMS and wastes power by continuously r=
etraining the link after the display is disabled.
- [High] Skipping `cdns_mhdp_bridge_hpd_enable()` in no-hpd mode permanentl=
y masks SW event interrupts, breaking HDCP.

Pre-existing issues:
- [Critical] Accessing `bridge.base.state` outside of atomic commit context=
 without modeset locks leads to a Use-After-Free.
--

--- Patch [2]: [PATCH v6 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd proper=
ty ---
commit 33969e025e143110f913b15c51739edb9cc917f9
Author: Rahul T R <r-ravikumar@ti.com>
Subject: drm: bridge: cdns-mhdp8546: Add no-hpd property

Add a 'no-hpd' boolean property to support boards where the HPD line
cannot be used for hotplug detection due to hardware limitations.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 36c07b71fe04b..c81c742e56ac8 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c

[ ... ]

> @@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct firmwar=
e *fw,
>  	 * MHDP_HW_STOPPED happens only due to driver removal when
>  	 * bridge should already be detached.
>  	 */
> -	cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
> +
> +	if (!mhdp->no_hpd)
> +		cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);

[Severity: High]
Does skipping cdns_mhdp_bridge_hpd_enable() here and in cdns_mhdp_attach()
permanently mask software event interrupts?

The CDNS_APB_INT_MASK_SW_EVENT_INT interrupt is multiplexed for multiple
events, including HDCP status (CDNS_HDCP_TX_STATUS).

If it is never unmasked in no-hpd mode, it looks like HDCP initialization
and communication will timeout and fail completely.

[ ... ]

> @@ -2012,6 +2040,16 @@ static enum drm_connector_status
>  cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector =
*connector)
>  {
>  	struct cdns_mhdp_device *mhdp =3D bridge_to_mhdp(bridge);
> +	bool hw_ready;
> +
> +	if (mhdp->no_hpd) {
> +		spin_lock(&mhdp->start_lock);
> +		hw_ready =3D mhdp->hw_state =3D=3D MHDP_HW_READY;
> +		spin_unlock(&mhdp->start_lock);
> +
> +		if (hw_ready)
> +			cdns_mhdp_update_link_status(mhdp);
> +	}

[Severity: High]
Will this polling cause the link to be continuously retrained even when the
display is intentionally disabled?

When the display is disabled for power management (DPMS blanking),
cdns_mhdp_update_link_status() will see the link is down and execute
cdns_mhdp_link_up():

cdns_mhdp_update_link_status() {
    ...
    if (!mhdp->link_up) {
        ret =3D cdns_mhdp_link_up(mhdp);
        if (ret < 0)
            goto out;
    }
}

Since the .detect() callback is periodically invoked by the DRM core (every
10 seconds), does this unconditionally wake the monitor up from sleep and w=
aste
power by ignoring the mhdp->bridge_enabled state?

[Severity: Critical]
This is a pre-existing issue, but does exposing cdns_mhdp_update_link_statu=
s()
to periodic polling significantly expand a use-after-free race window?

Later in cdns_mhdp_update_link_status(), the code accesses the atomic state
holding only the link_mutex:

cdns_mhdp_update_link_status() {
    ...
    state =3D drm_priv_to_bridge_state(mhdp->bridge.base.state);
    ...
    cdns_bridge_state =3D to_cdns_mhdp_bridge_state(state);
    ...
    current_mode =3D cdns_bridge_state->current_mode;
}

Since drm_private_obj.state is managed by the DRM atomic framework, if a
concurrent non-blocking atomic commit completes during this poll, the old
state can be swapped and freed asynchronously by
drm_atomic_state_default_clear(), leaving this thread dereferencing freed
memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802153825.1570=
435-1-y-d@ti.com?part=3D2
